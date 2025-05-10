unit uDTMGrafico;

interface

uses
  System.SysUtils, System.Classes, uDTMConexao, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TDTMGrafico = class(TDataModule)
    QryProdutosEstoque: TZQuery;
    QryVendaValorPorCliente: TZQuery;
    Qry10ProdutoaMaisVendidos: TZQuery;
    QryVendasDataUltimaSemana: TZQuery;
    QryProdutosEstoqueLabel: TWideStringField;
    QryProdutosEstoqueValue: TFloatField;
    QryVendaValorPorClienteLabel: TWideStringField;
    QryVendaValorPorClienteValue: TFloatField;
    Qry10ProdutoaMaisVendidosLabel: TWideStringField;
    Qry10ProdutoaMaisVendidosValue: TFloatField;
    QryVendasDataUltimaSemanaLabel: TDateTimeField;
    QryVendasDataUltimaSemanaValue: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DTMGrafico: TDTMGrafico;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
