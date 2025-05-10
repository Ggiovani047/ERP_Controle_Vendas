unit uConCategorias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmConCategorias = class(TfrmTelaHeranca)
    btnSelecionar: TBitBtn;
    QryListagemcategoriaId: TIntegerField;
    QryListagemdescricao: TWideStringField;
    procedure btnSelecionarClick(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
  private
    idCategoriaSelecionado: Integer;

    { Private declarations }
  public
    { Public declarations }
    procedure colocarIdLkp(lkp: TDBLookupComboBox);
  end;

var
  frmConCategorias: TfrmConCategorias;

implementation

{$R *.dfm}

procedure TfrmConCategorias.btnSelecionarClick(Sender: TObject);
begin
   if QryListagem.FieldByName('categoriaId').AsInteger<>Null then
     idCategoriaSelecionado := QryListagem.FieldByName('categoriaId').AsInteger;
  Close;
end;

procedure TfrmConCategorias.colocarIdLkp(lkp:TDBLookupComboBox);
begin
   lkp.KeyValue := idCategoriaSelecionado;
end;

procedure TfrmConCategorias.grdListagemDblClick(Sender: TObject);
begin
  btnSelecionar.Click;
end;

end.
