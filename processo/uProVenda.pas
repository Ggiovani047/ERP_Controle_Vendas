unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, cFuncao, cUsuarioLogado, uCadCliente, uCadProduto,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, cProVenda, uDTMVenda, uConClientes, Datasnap.DBClient,
  uDTMConexao, Vcl.ExtCtrls, Vcl.ComCtrls,uEnum, RxToolEdit, RxCurrEdit, uConProdutos, uRelProVenda;

type
  TfrmProVenda = class(TfrmTelaHeranca)
    edtVendaId: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    Label1: TLabel;
    edtDataVenda: TDateEdit;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label3: TLabel;
    edtValorTotal: TCurrencyEdit;
    dbGridItensVenda: TDBGrid;
    lkpProduto: TDBLookupComboBox;
    Label4: TLabel;
    edtValorUnitario: TCurrencyEdit;
    edtTotalProduto: TCurrencyEdit;
    btnAdicionarItem: TBitBtn;
    btnApagarItem: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtQuantidade: TCurrencyEdit;
    btnEditar: TBitBtn;

    btnConsultaprodutos: TSpeedButton;
    btnConsultaCliente: TSpeedButton;
    btnCadCliente: TSpeedButton;
    btnCadProduto: TSpeedButton;
    QryListagemvendaId: TIntegerField;
    QryListagemclienteId: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemdataVenda: TDateTimeField;
    QryListagemtotalVenda: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbGridItensVendaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure lkpProdutoClick(Sender: TObject);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure edtValorUnitarioChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarItemClick(Sender: TObject);
    procedure dbGridItensVendaDblClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnConsultaprodutosClick(Sender: TObject);
    procedure btnConsultaClienteClick(Sender: TObject);
    procedure dbGridItensVendaCellClick(Column: TColumn);
    procedure dbGridItensVendaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCadClienteClick(Sender: TObject);
    procedure btnCadProdutoClick(Sender: TObject);
  private
    { Private declarations }
    uDTMVenda:TdtmVenda;
    oVenda:TVenda;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
    function TotalizarProduto(valorUnitario, Quantidade: Double): Double;
    procedure LimparCamponenteItem;
    procedure LimparCds;

    function TotalizarVenda: Double;
    procedure ExibirRelatorioVenda;
  public
    { Public declarations }
    procedure CarregarRegistroSelecionado;
  end;

var
  frmProVenda: TfrmProVenda;
  frmConProdutos: TfrmConProdutos;

implementation

uses uPrincipal;


{$R *.dfm}





procedure TfrmProVenda.ExibirRelatorioVenda;
begin
  if MessageDlg('Deseja ver o relatório desta venda?',mtConfirmation,[mbYes,mbNo],0)=mrYes then begin

    frmrelProVenda:=TfrmrelProVenda.Create(Self);
    frmrelProVenda.QryVenda.Close;
    frmrelProVenda.QryVenda.ParamByName('vendaId').AsInteger:=oVenda.VendaId;
    frmrelProVenda.QryVenda.Open;

    frmrelProVenda.QryVendasItens.Close;
    frmrelProVenda.QryVendasItens.ParamByName('vendaId').AsInteger:=oVenda.VendaId;
    frmrelProVenda.QryVendasItens.Open;

    frmrelProVenda.Relatorio.PreviewModal;
    frmrelProVenda.Release;
  end;
end;


{$REGION 'Override'}

function TfrmProVenda.Apagar: Boolean;
begin
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then begin
    Result:= oVenda.Apagar;
  end;
end;


function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtVendaId.Text<>EmptyStr then
      oVenda.VendaId:=StrToInt(edtVendaId.Text)
  else
      oVenda.VendaId:=0;

  oVenda.ClienteId       := lkpCliente.KeyValue;
  oVenda.DataVenda       := edtDataVenda.Date;
  oVenda.TotalVenda      := edtValorTotal.value;

  if EstadoDoCadastro=ecInserir then begin
    if not dtmVenda.cdsItensVenda.IsEmpty then begin
      oVenda.VendaId:=oVenda.Inserir(dtmVenda.cdsItensVenda);
      ExibirRelatorioVenda
    end
    else begin
      MessageDlg('Não é possivel gravar uma venda vazia',mtInformation,[mbOK],0);
      abort;
    end;
  end
  else if EstadoDoCadastro=ecAlterar then
    if  not dtmVenda.cdsItensVenda.IsEmpty then begin
       oVenda.Atualizar(dtmVenda.cdsItensVenda);
       ExibirRelatorioVenda
    end
    else
       Apagar;

  result:= True;
end;

procedure TfrmProVenda.lkpProdutoClick(Sender: TObject);
begin
  inherited;
  edtValorUnitario.Value := dtmVenda.QryProdutos.FieldByName('valor').AsFloat;
  edtQuantidade.Value :=  1;
  edtTotalProduto.Value :=TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
  edtQuantidade.SetFocus;
   if dtmVenda.cdsItensVenda.Locate('produtoId',lkpProduto.KeyValue,[]) then begin
    btnAdicionarItem.Visible:=False;
    btnEditar.Visible:=True;
    CarregarRegistroSelecionado;
   end
   else
     begin
     btnAdicionarItem.Visible:=True;
     btnEditar.Visible:=False
     end;

end;


procedure TfrmProVenda.btnConsultaClienteClick(Sender: TObject);
begin
  EstadoDoForm := efConsulta;
  frmConClientes := TfrmConClientes.Create(Self);
  frmConClientes.ShowModal;
  frmConClientes.Release;
  frmConClientes.colocarIdLkp(lkpCliente);
end;

procedure TfrmProVenda.btnConsultaprodutosClick(Sender: TObject);
begin
  inherited;
  EstadoDoForm := efConsulta;
  frmConProdutos:= TfrmConProdutos.Create(self);
  frmConProdutos.ShowModal;
  frmConProdutos.Release;
  frmConProdutos.colocarIdLkp(lkpProduto);
  if dtmVenda.cdsItensVenda.Locate('produtoId',lkpProduto.KeyValue,[]) then begin
    btnAdicionarItem.Visible:=False;
    btnEditar.Visible:=True;
    edtQuantidade.Value      := dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat;
    edtValorUnitario.Value   := dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat;
    edtTotalProduto.Value    := dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
  end
  else begin
    edtValorUnitario.Value := dtmVenda.QryProdutos.FieldByName('valor').AsFloat;
    edtQuantidade.Value :=  1;
    edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
    edtValorUnitario.SetFocus;
    btnEditar.Visible:=False;
    btnAdicionarItem.Visible:=True;
  end;
end;

{$ENDREGION}

procedure TfrmProVenda.btnAdicionarItemClick(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue=Null then begin
    MessageDlg('Produto é um campo obrigatório!',mtInformation,[mbOK],0);
    lkpProduto.SetFocus;
    Abort;
    end;

  if edtValorUnitario.Value<=0 then begin
    MessageDlg('Valor Unitário não pode ser Zero', mtInformation,[mbOK],0);
    edtValorUnitario.SetFocus;
    Abort;
  end;

  if edtQuantidade.value <=0 then begin
    MessageDlg('Quantidade não pode ser Zero', mtInformation,[mbOK],0);
    edtQuantidade.SetFocus;
    Abort;
  end;


  //Mudar este recurso e adicionar o botão editar no lugar
  if dtmVenda.cdsItensVenda.Locate('produtoId',lkpProduto.KeyValue,[]) then begin
    MessageDlg('este produto já foi selecionado', mtInformation,[mbOK],0);
    lkpProduto.SetFocus;
    Abort;
  end;

  edtTotalProduto.Value :=TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

  dtmVenda.cdsItensVenda.Append;
  dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString:=lkpProduto.KeyValue;
  dtmVenda.cdsItensVenda.FieldByName('nomeProduto').AsString:= dtmVenda.QryProdutos.FieldByName('nome').AsString;
  dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat:=edtQuantidade.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat:=edtValorUnitario.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat:=edtTotalProduto.Value;
  dtmVenda.cdsItensVenda.Post;
  edtValorTotal.Value:=TotalizarVenda;
  LimparCamponenteItem;

  lkpProduto.SetFocus;
end;


procedure TfrmProVenda.btnApagarItemClick(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue=Null then begin
    MessageDlg('Selecione o produto a ser excluído', mtInformation,[mbOK],0);
    dbGridItensVenda.SetFocus;
    Abort;
  end;

  if dtmVenda.cdsItensVenda.Locate('produtoId',lkpProduto.KeyValue,[]) then
  begin
    dtmVenda.cdsItensVenda.Delete;
    LimparCamponenteItem;
    edtValorTotal.Value:=TotalizarVenda;
  end;

end;


procedure TfrmProVenda.LimparCamponenteItem;
begin
  lkpProduto.keyValue    := Null;
  edtQuantidade.value    :=0;
  edtValorUnitario.Value :=0;
  edtTotalProduto.Value  :=0;
  btnAdicionarItem.Visible:=True;
  btnEditar.Visible:=False;
end;

function TfrmProVenda.TotalizarProduto(valorUnitario, Quantidade:Double):Double;
begin
  result:= valorUnitario * Quantidade;
end;

procedure TfrmProVenda.LimparCds;
begin
  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do
    dtmVenda.cdsItensVenda.Delete;

  btnEditar.Visible:=False;
  btnAdicionarItem.Visible:=True;
end;

procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then
  begin
    edtVendaId.Text     := IntToStr(oVenda.VendaId);
    lkpCliente.KeyValue := oVenda.ClienteId;
    edtDataVenda.Date   := oVenda.DataVenda;
    edtValorTotal.Value := oVenda.TotalVenda;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmProVenda.btnCadClienteClick(Sender: TObject);
begin
  EstadoDoForm := efCadastro;
  oUsuarioLogado.CriarForm(TFrmCadCliente, oUsuarioLogado, dtmPrincipal.ConexaoDB);
  EstadoDoForm := efConsulta;
end;

procedure TfrmProVenda.btnCadProdutoClick(Sender: TObject);
begin
  EstadoDoForm := efCadastro;
  oUsuarioLogado.CriarForm(TfrmCadProduto, oUsuarioLogado, dtmPrincipal.ConexaoDB);
  EstadoDoForm := efConsulta;
end;

procedure TfrmProVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnEditarClick(Sender: TObject);
begin
  if lkpProduto.KeyValue=Null then begin
    MessageDlg('Produto é um campo obrigatório!',mtInformation,[mbOK],0);
    lkpProduto.SetFocus;
    Abort;
  end;

  if edtValorUnitario.Value<=0 then begin
    MessageDlg('Valor Unitário não pode ser Zero', mtInformation,[mbOK],0);
    edtValorUnitario.SetFocus;
    Abort;
  end;

  if edtQuantidade.value <=0 then begin
    MessageDlg('Quantidade não pode ser Zero', mtInformation,[mbOK],0);
    edtQuantidade.SetFocus;
    Abort;
  end;


  dtmVenda.cdsItensVenda.Edit;
  dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat := edtQuantidade.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat := edtValorUnitario.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat:= edtTotalProduto.Value;
  dtmVenda.cdsItensVenda.Post;
  LimparCamponenteItem;
  edtValorTotal.Value:=TotalizarVenda;


end;

procedure TfrmProVenda.btnGravarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  LimparCds;
  edtDataVenda.Date:=Date;
  lkpCliente.SetFocus;
end;

procedure TfrmProVenda.dbGridItensVendaCellClick(Column: TColumn);
begin
  inherited;
  CarregarRegistroSelecionado;
  btnAdicionarItem.Visible:=False;
  btnEditar.Visible:=True;
end;


procedure TfrmProVenda.dbGridItensVendaDblClick(Sender: TObject);
begin
  inherited;
  CarregarRegistroSelecionado;
  btnAdicionarItem.Visible:=False;
  btnEditar.Visible:=True;
end;


procedure TfrmProVenda.dbGridItensVendaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  BloqueiaCRTL_DEL_DBGrid(Key, Shift);
end;



procedure TfrmProVenda.dbGridItensVendaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case (Key) of
  VK_DOWN: CarregarRegistroSelecionado;
  VK_UP: CarregarRegistroSelecionado;
  VK_DELETE: btnApagarItem.Click;
  end;
end;

procedure TfrmProVenda.edtQuantidadeChange(Sender: TObject);
begin
  inherited;
   edtTotalProduto.Value :=TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.edtValorUnitarioChange(Sender: TObject);
begin
  inherited;
   edtTotalProduto.Value :=TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmVenda) then
    FreeAndNil(dtmVenda);
  if Assigned(oVenda) then
    FreeAndNil(oVenda);
end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
begin
  inherited;
  dtmVenda:=TdtmVenda.Create(Self);
  ovenda:= TVenda.Create(dtmPrincipal.ConexaoDB);
//   edtValorTotal.Enabled:=False;
//   edtValorTotal.Font.Color := clBlack;
//   edtValorTotal.Color := clBtnFace;
//  edtTotalProduto.Enabled:=False;
  // IndiceAtual := 'clienteId';
end;





procedure TfrmProVenda.CarregarRegistroSelecionado;
begin
  lkpProduto.KeyValue      := dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString;
  edtQuantidade.Value      := dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat;
  edtValorUnitario.Value   := dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat;
  edtTotalProduto.Value    := dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
end;


function TfrmProVenda.TotalizarVenda: Double;
var Valor:Double;
begin
  valor:=0;
  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do
  begin
    Valor := Valor + dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
    dtmVenda.cdsItensVenda.Next;
  end;
  result:=Valor;
end;




end.
