unit cControleEstoque;

interface

uses
System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZAbstractConnection,
ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset, Data.DB, Datasnap.DBClient, System.SysUtils;

type
  TControleEstoque = class

private
  ConexaoDB: TZConnection;
  F_produtoId: Integer;
  F_quantidade: Double;

public
  constructor Create(aConexao: TZConnection);
  destructor Destroy; override;
  function BaixarEstoque: Boolean;
  function RetornarEstoque: Boolean;

published
  property produtoId: Integer read F_produtoId write F_produtoId;
  property quantidade: Double read F_quantidade write F_quantidade;
end;

implementation

{$REGION 'Constructor and Destructor'}
constructor TControleEstoque.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TControleEstoque.Destroy;
begin

  inherited;
end;

{$ENDREGION}

function TControleEstoque.BaixarEstoque: Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;

    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE produtos SET quantidade = quantidade - :qtdeBaixa WHERE produtoId = :produtoId');
    Qry.ParamByName('produtoId').AsInteger := produtoId;
    Qry.ParamByName('qtdeBaixa').AsFloat := quantidade;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      on E: Exception do
        begin
          ConexaoDB.Rollback;
          Result:=false;
          MessageDlg('Ocorreu um Erro: '+ E.Message,mtError,[mbOk],0)
        end;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);

  end;
end;

function TControleEstoque.RetornarEstoque: Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;

    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE produtos SET quantidade = quantidade + :qtdeRetorno WHERE produtoId = :produtoId');
    Qry.ParamByName('produtoId').AsInteger := produtoId;
    Qry.ParamByName('qtdeRetorno').AsFloat := quantidade;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      on E: Exception do
        begin
          ConexaoDB.Rollback;
          Result:=false;
          MessageDlg('Ocorreu um Erro: '+ E.Message,mtError,[mbOk],0)
        end;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);

  end;
end;

end.
