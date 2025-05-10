unit cCadCategoria;

interface
uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
      ZAbstractConnection, ZConnection,ZAbstractRODataset,
      ZAbstractDataset, ZDataset,System.SysUtils, ZDbcIntfs; //lista de units

type
  TCategoria = class
  private
    ConexaoDB: TZConnection;
    F_categoriaId:Integer; //Int
    F_descricao:string; //VarChar
    function GetCodigo: Integer;
    function getDescricao: string;
    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: string);
  public
    constructor Create(aConexao:TZConnection);
    destructor Destroy; override;
    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar :Boolean;
    function Selecionar(id:Integer):Boolean;


  published
    property codigo:Integer    read GetCodigo   write setCodigo;
    property descricao:string read getDescricao write setDescricao;

  end;
implementation

{ TCategoria }

{$REGION 'Constructor and Destructor '}
constructor TCategoria.Create(aConexao:TZConnection);
begin
   ConexaoDB:=aConexao;
end;

destructor TCategoria.Destroy;
begin

  inherited;
end;
{$ENDREGION}

{$REGION 'Gets'}
function TCategoria.GetCodigo: Integer;
begin
   Result := Self.F_categoriaId;
end;

function TCategoria.getDescricao: string;
begin
   Result := Self.F_descricao
end;
{$ENDREGION}

{$REGION 'Sets'}
procedure TCategoria.setCodigo(const Value: Integer);
begin
   Self.F_categoriaId := Value
end;

procedure TCategoria.setDescricao(const Value: string);
begin
   Self.F_descricao := Value
end;
{$ENDREGION}

{$REGION 'CRUD'}
function TCategoria.Apagar: Boolean;
var Qry:TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+ #13+#13+
             'Código: '+IntToStr(F_categoriaId)+#13+
             'Descrição: ' +F_descricao,mtConfirmation,[mbYes, mbNo],0)=mrNo then begin
               result:=False;
               Abort;
  end;

  try
    Result:=True;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM categorias '+
                ' WHERE categoriaId=:categoriaId ');
    Qry.ParamByName('categoriaId').AsInteger := F_categoriaId;
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      on E: Exception do
        begin
          ConexaoDB.Rollback;
          Result:=false;
          if Pos('fk_', LowerCase(E.Message)) > 0 then
            MessageDlg('Você não pode excluir essa categoria pois ela está atrelada a um produto ',mtInformation,[mbOk],0)
          else
            MessageDlg('Ocorreu um Erro: '+ E.Message,mtError,[mbOk],0)
        end;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TCategoria.Atualizar: Boolean;
var Qry: TZQuery;
begin
  try
    Result:=True;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE categorias '+
                '    SET descricao=:descricao ' +
                ' WHERE categoriaId= :categoriaId ');
    Qry.ParamByName('categoriaId').AsInteger :=  Self.F_categoriaId;
    Qry.ParamByName('descricao').AsString    :=Self.F_descricao;

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


function TCategoria.Inserir: Boolean;
var Qry:TZQuery;
begin
   try
     Result:=True;
     Qry:=TZQuery.Create(nil);
     Qry.Connection:=ConexaoDB;
     Qry.SQL.Clear;
     Qry.SQL.Add('INSERT INTO categorias (descricao) values (:descricao)');
     Qry.ParamByName('descricao').AsString:=F_descricao;
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
        FreeAndnil(Qry);

   end;
end;

function TCategoria.Selecionar(id: Integer): Boolean;
var Qry:TZQuery;
begin
  try
    Result:=True;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT categoriaId, '+
                '      descricao' +
                ' FROM categorias'+
                ' WHERE categoriaId=:categoriaId ');
    Qry.ParamByName('categoriaId').AsInteger:=id;
    try
       Qry.Open;

       Self.F_categoriaId:= Qry.FieldByName('categoriaId').AsInteger;
       Self.F_descricao:= Qry.FieldByName('descricao').AsString;
    except
      on E: Exception do
        begin
        ShowMessage('Ocorreu um erro: ' + E.Message);
        Result:=false;
        end;
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;
{$ENDREGION}


end.
