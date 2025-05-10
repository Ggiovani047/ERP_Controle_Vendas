object dtmVenda: TdtmVenda
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 406
  Width = 856
  object QryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select produtoId, nome, valor, quantidade'
      'from produtos')
    Params = <>
    Left = 266
    Top = 48
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 444
    Top = 51
    object cdsItensVendaprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
    end
    object cdsItensVendaNomeProduto: TStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'NomeProduto'
      Size = 60
    end
    object cdsItensVendaquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
      DisplayFormat = '#0'
    end
    object cdsItensVendavalorUnitario: TFloatField
      DisplayLabel = 'Valor Unitario'
      FieldName = 'valorUnitario'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object cdsItensVendavalorTotalProduto: TFloatField
      DisplayLabel = 'Total do Produto'
      FieldName = 'valorTotalProduto'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object cdsItensVendavalorTotalvenda: TAggregateField
      FieldName = 'valorTotalvenda'
      DisplayName = ''
      Expression = 'SUM(valorTotalProduto)'
    end
  end
  object dtsCliente: TDataSource
    DataSet = QryCliente
    Left = 134
    Top = 173
  end
  object dtsProdutos: TDataSource
    DataSet = QryProdutos
    Left = 281
    Top = 173
  end
  object dtsItensVendas: TDataSource
    DataSet = cdsItensVenda
    Left = 434
    Top = 176
  end
  object QryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select clienteId, '
      '  nome'
      'from clientes')
    Params = <>
    Left = 158
    Top = 56
  end
end
