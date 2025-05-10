unit uSelecionarData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls,System.DateUtils, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, uRelVendaPorData;

type
  TfrmSelecionarData = class(TForm)
    edtDataInicio: TDateEdit;
    Label2: TLabel;
    Label1: TLabel;
    edtDataFinal: TDateEdit;
    btnOk: TBitBtn;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelecionarData: TfrmSelecionarData;

implementation

{$R *.dfm}

procedure TfrmSelecionarData.btnOkClick(Sender: TObject);
begin
   if edtDataInicio.Date > edtDataFinal.Date then begin
     MessageDlg('Data Final não pode ser maior que a data de inicio',mtInformation,[mbOK],0);
     edtDataInicio.SetFocus;
     Abort;
   end;

   if (edtDataInicio.Date=0) or (edtDataFinal.Date=0) then begin
     MessageDlg('data inicio e Final são campos obrigatórios',mtInformation,[mbOK],0);
     edtDataInicio.SetFocus;
     Abort;
   end;

   frmRelProVendaPorData:= TfrmrelVendaPorData.Create(Self);
   frmRelProVendaPorData.QryVenda.Close;
   frmRelProVendaPorData.QryVenda.Parambyname('DataInicio').AsDate:= frmSelecionarData.edtDataInicio.Date;
   frmRelProVendaPorData.QryVenda.Parambyname('DataFim').AsDate:= frmSelecionarData.edtDataFinal.Date;
   frmRelProVendaPorData.QryVenda.Open;
   frmRelProVendaPorData.Relatorio.PreviewModal;

   Close;
end;

procedure TfrmSelecionarData.FormShow(Sender: TObject);
begin
  edtDataInicio.Date:= StartOfThemonth(Date);
  edtDataFinal.Date:= EndOfTheMonth(Date);
end;

end.
