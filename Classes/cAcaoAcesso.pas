unit cAcaoAcesso;

interface

uses System.Classes,
     Vcl.Controls,
     Vcl.Dialogs,
     ZAbstractConnection,
     ZConnection,
     ZAbstractRODataset,
     ZDataset,
     System.SysUtils,
     Vcl.Forms,
     Vcl.Buttons,
     RxToolEdit,
     RxCurrEdit,
     uFrmAtualizaDB;

type
  TAcaoAcesso = class
  private
    ConexaoDB: TZConnection;
    F_acaoAcessoId:Integer;
    F_descricao: String;
    F_Chave: string;
    class procedure PreencherAcoes(aForm:TForm; aConexao:TZConnection); static;
    class procedure VerificarUsuarioAcao(aUsuarioId, aAcaoAcessoId: Integer;
      aConexao: TZConnection); static;


  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:Integer):Boolean;
    function ChaveExiste(aChave:string; aId:Integer=0):Boolean;
    class function CriarAcoes(aNomeForm:TFormClass; aConexao:TZConnection): Boolean; static;
    class procedure PreencherUsuariosVsAcoes(aConexao: TZConnection); static;
    class function SistemaAtualizou(const Forms: array of TFormClass; aConexao: TZConnection): Boolean; static;
  published
    property codigo     :Integer   read F_acaoAcessoId  write F_acaoAcessoId;
    property descricao  :string    read F_descricao     write F_descricao;
    property chave      :string    read F_chave         write F_chave;
  end;


implementation
uses cAtualizacaoBancoDeDados;

{ TAcaoAcesso }
{$region 'constructor and destructor'}


constructor TAcaoAcesso.Create(aConexao: TZConnection);
begin
   ConexaoDB:= aConexao;
end;


destructor TAcaoAcesso.Destroy;
begin

  inherited;
end;
{$endregion}


{$Region 'CRUD'}
function TAcaoAcesso.Apagar: Boolean;
var Qry:TZQuery;
begin
  if MessageDlg('Apagar o registro: ' +#13+#13+
                'Código: '+ IntToStr(F_acaoAcessoId)+#13+
                'Descrição: '+ F_descricao,mtConfirmation,[mbYes,mbNo],0)=mrNo then begin
     Result:=False;
     Abort;
  end;

  try
    result:=True;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM acaoAcesso ' +
                ' WHERE acaoAcessoId=:acaoAcessoId ');
    Qry.ParamByName('acaoAcessoId').AsInteger:=F_acaoAcessoId;
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      on E: Exception do
        begin
          ConexaoDB.Rollback;
          Result:=false;
          MessageDlg('Ocorreu um Erro na Exclusão: '+ E.Message,mtError,[mbOk],0)
        end;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TAcaoAcesso.Atualizar: Boolean;
var Qry:TZQuery;
begin
  try
    result:=True;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE acaoAcesso '+
                'SET ' +
                '   descricao        = :descricao' +
                '   ,chave            =:chave' +
                ' WHERE acaoAcessoId=:acaoAcessoId');

  Qry.ParamByName('acaoAcessoId').AsInteger := Self.F_acaoAcessoId;
  Qry.ParamByName('descricao').AsString    := Self.F_descricao;
  Qry.ParamByName('chave').AsString        := Self.F_chave;
  try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
  except
  on E: Exception do
        begin
          ConexaoDB.Rollback;
          Result:=false;
          MessageDlg('Ocorreu um Erro na Atualização: '+ E.Message,mtError,[mbOk],0)
        end;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;


function TAcaoAcesso.Inserir: Boolean;
var Qry: TZQuery;
begin
  try
    result:=True;
    Qry:= TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO acaoAcesso (descricao,' +
                                      ' chave) ' +
                ' VALUES              (:descricao, ' +
                                      ' :chave) ' );
    Qry.ParamByName('descricao').AsString    :=Self.F_descricao;
    Qry.ParamByName('chave').AsString        :=Self.F_chave;
   try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
   except
   on E: Exception do
        begin
          ConexaoDB.Rollback;
          Result:=false;
          MessageDlg('Ocorreu um Erro na Gravação: '+ E.Message,mtError,[mbOk],0)
        end;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
    end;
  end;



function TAcaoAcesso.Selecionar(id: Integer): Boolean;
var Qry:TZQuery;
begin
  try
    result:=True;
    Qry:= TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT acaoAcessoId, descricao, chave ' +
                ' FROM acaoAcesso ' +
                ' WHERE acaoAcessoId=:acaoAcessoId');
    Qry.ParamByName('acaoAcessoId').AsInteger:= id;
    try
      Qry.Open;

      Self.F_acaoAcessoId        := Qry.FieldByName('acaoAcessoId').AsInteger;
      Self.F_descricao   := Qry.FieldByName('descricao').AsString;
      Self.F_chave       := Qry.FieldByName('chave').AsString;
      except
      on E: Exception do
        begin
          result:= False;
          MessageDlg('Ocorreu um Erro ao Selecionar do banco:'+E.Message,mtError,[mbOK],0);
        end;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;


{$endregion}

function TAcaoAcesso.ChaveExiste(aChave: string; aId:Integer): Boolean;
var Qry:TZQuery;
begin
  try
    Qry:= TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT Count(acaoAcessoId) As Qtde ' +
                ' FROM acaoAcesso ' +
                ' WHERE chave=:chave');
    if aId>0 then
      begin
        Qry.SQL.Add(' AND acaoAcessoId<>:acaoAcessoId');
        Qry.ParamByName('acaoAcessoId').AsInteger :=aId
      end;
    Qry.ParamByName('chave').AsString:= aChave;
    try
      Qry.Open;

      if Qry.FieldByName('Qtde').AsInteger>0 then
        result := true
      else
        result := False;

    except
    on E: Exception do
    begin
      result:= False;
      MessageDlg('Ocorreu um Erro:'+E.Message,mtError,[mbOK],0);
    end;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

class procedure TAcaoAcesso.PreencherAcoes(aForm: TForm;
  aConexao: TZConnection);
var i: integer; oAcaoAcesso:TAcaoAcesso;
begin
  try
    oAcaoAcesso:=TAcaoAcesso.Create(aConexao);
    oAcaoAcesso.descricao := aForm.Caption;
    oAcaoAcesso.chave := aForm.Name;
    if not oAcaoAcesso.ChaveExiste(oAcaoAcesso.chave) then
      oAcaoAcesso.Inserir;

    for i:= 0 to aForm.ComponentCount-1 do
    begin
      if aForm.Components[i] is TBitbtn then
      begin
        if Tbitbtn(aForm.Components[i]).Tag = 99 then
        begin
          oAcaoAcesso.chave     := aForm.Name+'_'+TBitBtn(aForm.Components[i]).Name;
          if not oAcaoAcesso.ChaveExiste(oAcaoAcesso.chave) then begin
            oAcaoAcesso.descricao := '    - BOTÃO '+StringReplace(TBitbtn(aForm.Components[i]).Caption,'&','',[rfReplaceAll]);
            oAcaoAcesso.Inserir;
          end;
        end;
      end

      else if aForm.Components[i] is TSpeedButton then
      begin
        if TSpeedButton(aForm.Components[i]).Tag = 99 then
        begin
          oAcaoAcesso.chave     := aForm.Name+'_'+TSpeedButton(aForm.Components[i]).Name;
          if not oAcaoAcesso.ChaveExiste(oAcaoAcesso.chave) then begin
            oAcaoAcesso.descricao := '    - BOTÃO '+StringReplace(TSpeedButton(aForm.Components[i]).Name,'&','',[rfReplaceAll]);
            oAcaoAcesso.Inserir;
          end;
        end;
      end

      else if aForm.Components[i] is TCurrencyEdit then
      begin
        if TCurrencyEdit(aForm.Components[i]).Tag = 99 then
        begin
          oAcaoAcesso.chave     := aForm.Name+'_'+TCurrencyEdit(aForm.Components[i]).Name;
          if not oAcaoAcesso.ChaveExiste(oAcaoAcesso.chave) then begin
            oAcaoAcesso.descricao := '    - BOTÃO '+StringReplace(TCurrencyEdit(aForm.Components[i]).Name,'&','',[rfReplaceAll]);
            oAcaoAcesso.Inserir;
          end;
        end;
      end;
    end;
  finally
    if assigned(oAcaoAcesso) then
      FreeAndNil(oAcaoAcesso);
  end;
end;

class function TAcaoAcesso.CriarAcoes(aNomeForm: TFormClass;
  aConexao: TZConnection): Boolean;
var form:TForm;
begin
  try
    form := aNomeForm.Create(Application);
    if TAtualizaBancoDados.AtualizouComponentesForm(form, aConexao) then begin
      PreencherAcoes(form,aConexao);
      result:= True;
    end
    else
      result:= False;
  finally
    if assigned(form) then
      form.Release;

  end;

end;



class procedure TAcaoAcesso.VerificarUsuarioAcao(aUsuarioId: Integer;
  aAcaoAcessoId: Integer; aConexao: TZConnection);
var Qry:TZQuery;
begin
  try
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=aConexao;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT usuarioId '+
                '  FROM usuariosAcaoAcesso '+
                ' WHERE usuarioId=:usuarioId '+
                '   AND acaoAcessoId=:acaoAcessoId ');
    Qry.ParamByName('usuarioId').AsInteger:=aUsuarioId;
    Qry.ParamByName('acaoAcessoId').AsInteger:= aAcaoAcessoId;
    Qry.Open;

    if Qry.IsEmpty then
    begin
       Qry.Close;
       Qry.SQL.Clear;
       Qry.SQL.Add('INSERT INTO usuariosAcaoAcesso (usuarioId, acaoAcessoId, ativo) '+
                   '     VALUES (:usuarioId, :acaoAcessoId, :ativo) ');
       Qry.ParamByName('usuarioId').AsInteger:=aUsuarioId;
       Qry.ParamByName('acaoAcessoId').AsInteger:=aAcaoAcessoId;
       Qry.ParamByName('ativo').AsBoolean:=true;
       Try
         aConexao.StartTransaction;
         Qry.ExecSQL;
         aConexao.Commit;
       Except
       on E:Exception do begin
       MessageDlg('Deu erro:'+E.Message, mtError, [mbok], 0);
       aConexao.Rollback;
       end;
       End;
    end;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;

end;




class procedure TAcaoAcesso.PreencherUsuariosVsAcoes(aConexao: TZConnection);
var Qry: TZQuery;
    QryAcaoAcesso: TZQUery;
begin
  try
    Qry:= TZQuery.Create(nil);
    Qry.Connection:=aConexao;
    Qry.SQL.Clear;

    QryAcaoAcesso:=TZQuery.Create(nil);
    QryAcaoAcesso.Connection:= aConexao;
    QryAcaoAcesso.SQL.Clear;

    Qry.SQL.Add('SELECT usuarioId FROM usuarios ');
    Qry.Open;

    QryAcaoAcesso.SQL.Add('SELECT acaoAcessoId FROM acaoAcesso ');
    QryAcaoAcesso.Open;
    Qry.First;
    while not Qry.Eof do
    begin
      QryAcaoAcesso.First;
      while not QryAcaoAcesso.Eof do
      begin
        VerificarUsuarioAcao(Qry.FieldByName('usuarioId').AsInteger,
        QryAcaoAcesso.FieldByName('acaoAcessoId').AsInteger, aConexao);
        QryAcaoAcesso.Next;
      end;
      Qry.Next;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
    if Assigned(QryAcaoAcesso) then
      FreeAndNil(QryAcaoAcesso);
  end;
end;

class function TAcaoAcesso.SistemaAtualizou(const Forms: array of TFormClass; aConexao: TZConnection): Boolean;
var i: Integer;
begin
  Result := False;
  for i:=Low(Forms) to High(Forms) do begin
   if CriarAcoes(Forms[i],aConexao) then
      Result := True;
   frmAtualizaDB.CarregaPgb(7);
  end;
end;

end.
