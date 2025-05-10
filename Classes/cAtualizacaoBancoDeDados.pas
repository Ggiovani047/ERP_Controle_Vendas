unit cAtualizacaoBancoDeDados;

interface

uses System.Classes,
     Vcl.Controls,
     Vcl.ExtCtrls,
     Vcl.Dialogs,
     ZAbstractConnection,
     ZConnection,
     ZAbstractRODataset,
     ZAbstractDataset,
     Data.DB,
     ZDataset,
     System.SysUtils,
     Vcl.Forms;

type
  TAtualizaBancoDados = class
  private
  public
    ConexaoDB: TZConnection;
    constructor Create(aConexao:TZConnection);
    procedure ExecutaDiretoBancoDeDados(aScript: String);
    class function AtualizouComponentesForm(const aForm: TForm; aConexao:TZConnection): Boolean; static;
    class function TabelaVazia(aTabela: String; aConexao: TZConnection): Boolean;  static;
  end;



type
  TAtualizaBancosDadosMSSQL= class

  private


  public
    ConexaoDB: TZConnection;
    function AtualizarBancoDeDadosMSSQL: Boolean;
    constructor Create(aConexao: TZConnection);
  end;



implementation

uses cAtualizacaoTabelaMSSQL, cAtualizacaoCamposMSSQL;

{ TAtualizaBancoDeDados }


constructor TAtualizaBancoDados.Create(aConexao: TZConnection);
begin
   ConexaoDB:= aConexao;
end;

procedure TAtualizaBancoDados.ExecutaDiretoBancoDeDados(aScript: String);
var Qry: TZQuery;
begin
  try
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(aScript);
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      on E: Exception do
        begin
          ConexaoDB.Rollback;
          MessageDlg('Ocorreu um Erro na criação de uma Tabela: '+ E.Message,mtError,[mbOk],0)
        end;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;






{ TAtualizaBancosDadosADO }

function TAtualizaBancosDadosMSSQL.AtualizarBancoDeDadosMSSQL: Boolean;
var oAtualizarDB: TAtualizaBancoDados;
    oTabela: TAtualizacaoTabelaMSSQL;
    oCampo: TAtualizaCampoMSSQL;
begin
  try
   //Classe principal da Atualização
    oAtualizarDB := TAtualizaBancoDados.Create(ConexaoDB);

    //Classe filha de atualização
    oTabela := TAtualizacaoTabelaMSSQL.Create(ConexaoDB);
    oCampo  := TAtualizaCampoMSSQL.Create(ConexaoDB);
  finally
    if Assigned(oAtualizarDB) then
      FreeandNil(oAtualizarDB);

    if Assigned(oTabela) then
      FreeandNil(oTabela)
  end;

end;

constructor TAtualizaBancosDadosMSSQL.Create(aConexao: TZConnection);
begin
   ConexaoDB:= aConexao;
end;


class function TAtualizaBancoDados.AtualizouComponentesForm(const aForm: TForm; aConexao:TZConnection): Boolean;
var
  ContadorDeComponentes, i: Integer;
  Qry: TZQuery;
begin
  ContadordeComponentes := 0;
  try
    for i:=0 to aform.ComponentCount-1 do begin
      if aForm.Components[i].Tag = 99 then
        ContadorDeComponentes := ContadorDeComponentes + 1;
    end;

    Qry:= TZQuery.Create(nil);
    Qry.Connection := aConexao;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COUNT(formId) AS Qtde, quantidadeComponents FROM componentsForm WHERE nomeForm = :nomeForm ' +
                ' GROUP BY quantidadeComponents ' );
    Qry.ParamByName('nomeForm').AsString := aform.Name;
    Qry.Open;
    if Qry.FieldByName('quantidadeComponents').AsInteger <> ContadorDeComponentes then begin
      Result := True;
      if Qry.FieldByName('Qtde').AsInteger > 0 then begin
        Qry.Close;
        Qry.SQL.Clear;
        Qry.SQL.Add('UPDATE componentsForm SET quantidadeComponents ' +
                    ' = :quantidadeComponents WHERE nomeForm = :nomeForm ');
        Qry.ParamByName('quantidadeComponents').asInteger := ContadorDeComponentes;
        Qry.ParamByName('nomeForm').AsString := aform.Name;
        Qry.ExecSQL;
      end
      else begin
        Qry.Close;
        Qry.SQL.Clear;
        Qry.SQL.Add('INSERT INTO componentsForm (nomeForm, quantidadeComponents) ' +
                    ' VALUES (:nomeForm, :quantidadeComponents) ');
        Qry.ParamByName('quantidadeComponents').asInteger := ContadorDeComponentes;
        Qry.ParamByName('nomeForm').AsString := aform.Name;
        Qry.ExecSQL;
      end
    end
    else
      Result:= False;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;





class function TAtualizaBancoDados.TabelaVazia(aTabela: String; aConexao: TZConnection): Boolean;
var
  Qry: TZQuery;
begin
  try
    Qry:= TZQuery.Create(nil);
    Qry.Connection := aConexao;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COUNT(*) AS Qtde FROM '+aTabela);
    try
      Qry.Open;

      if Qry.FieldByName('Qtde').AsInteger > 0 then
        result:= False
      else
        Result:= True;
    except
    on E: Exception do
      MessageDlg('Deu Erro: '+ E.Message, mtError,[mbOK], 0)

    end;
  finally
    if Assigned(Qry) then
      freeAndNil(Qry);
  end;
end;

end.
