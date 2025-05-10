inherited frmCadProduto: TfrmCadProduto
  Caption = 'Cadastro de Produto'
  ClientHeight = 413
  ClientWidth = 890
  ExplicitWidth = 896
  ExplicitHeight = 442
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 890
    Height = 366
    ActivePage = tabManutencao
    ExplicitWidth = 890
    ExplicitHeight = 366
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 882
      ExplicitHeight = 338
      inherited pnlListagemTopo: TPanel
        Width = 882
        ExplicitWidth = 882
      end
      inherited grdListagem: TDBGrid
        Width = 882
        Height = 272
        Columns = <
          item
            Expanded = False
            FieldName = 'produtoId'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 87
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade'
            Width = 126
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DescricaoCategoria'
            Width = 156
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 882
      ExplicitHeight = 338
      object Label1: TLabel
        Left = 3
        Top = 112
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object Label2: TLabel
        Left = 3
        Top = 237
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      object Label3: TLabel
        Left = 146
        Top = 237
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object Label4: TLabel
        Left = 361
        Top = 57
        Width = 47
        Height = 13
        Caption = 'Categoria'
      end
      object btnConsultaCliente: TSpeedButton
        Tag = 99
        Left = 615
        Top = 72
        Width = 23
        Height = 21
        Hint = 'Consulta de Produtos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FF4A667C
          BE9596FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF6B9CC31E89E84B7AA3C89693FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4BB4FE51B5FF
          2089E94B7AA2C69592FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF51B7FE51B3FF1D87E64E7AA0CA9792FF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          51B7FE4EB2FF1F89E64E7BA2B99497FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF52B8FE4BB1FF2787D95F6A76FF
          00FFB0857FC09F94C09F96BC988EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF55BDFFB5D6EDBF9D92BB9B8CE7DAC2FFFFE3FFFFE5FDFADAD8C3
          B3B58D85FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEA795FD
          EEBEFFFFD8FFFFDAFFFFDBFFFFE6FFFFFBEADDDCAE837FFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFC1A091FBDCA8FEF7D0FFFFDBFFFFE3FFFFF8FFFF
          FDFFFFFDC6A99CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC1A091FEE3ACF1
          C491FCF2CAFFFFDDFFFFE4FFFFF7FFFFF7FFFFE9EEE5CBB9948CFF00FFFF00FF
          FF00FFFF00FFFF00FFC2A191FFE6AEEEB581F7DCAEFEFDD8FFFFDFFFFFE3FFFF
          E4FFFFE0F3ECD2BB968EFF00FFFF00FFFF00FFFF00FFFF00FFBC978CFBE7B7F4
          C791F2C994F8E5B9FEFCD8FFFFDDFFFFDCFFFFE0E2D2BAB68E86FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFD9C3A9FFFEE5F7DCB8F2C994F5D4A5FAE8BDFDF4
          C9FDFBD6B69089FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB58D85E8
          DEDDFFFEF2F9D8A3F4C48CF9D49FFDEAB8D0B49FB89086FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFAD827FC9AA9EEFE0B7EFDFB2E7CEACB890
          86B89086FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFBA968ABB988CB79188FF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        OnClick = btnConsultaClienteClick
      end
      object btnCadCliente: TSpeedButton
        Tag = 99
        Left = 586
        Top = 71
        Width = 23
        Height = 22
        Hint = 'Consulta de Produtos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FF0A6B0A0A6B0A0A6B0A0A6B0AFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFB25D130A6B0A42D37331B85A0A6B0AA8
          4E0FA54A0EA4480DA1440DA0420C9F3F0C9D3E0BFF00FFFF00FFFF00FFFF00FF
          B561140A6B0A78F3A440D1710A6B0AFBF0DEFBEFDAFBEDD5FBEBD1FBE9CDFBE7
          C89E400BFF00FFFF00FF0A6B0A0A6B0A0A6B0A0A6B0A78F3A444D5740A6B0A0A
          6B0A0A6B0A0A6B0AFCEDD6FBEBD1FBEACEA1430CFF00FFFF00FF0A6B0A78F3A4
          53E4844FE1804CDD7C48D97845D67541D27231B85A0A6B0AFBEFDBFCEDD6FBEB
          D1A3470DFF00FFFF00FF0A6B0A78F3A478F3A478F3A478F3A44DDE7D78F3A478
          F3A442D3730A6B0AFCF1E0FBEFDBFBEDD7A64B0EFF00FFFF00FF0A6B0A0A6B0A
          0A6B0A0A6B0A78F3A450E2810A6B0A0A6B0A0A6B0A0A6B0AFCF4E4FBF1E1FCEF
          DCA94F0FFF00FFFF00FFFF00FFFF00FFC375190A6B0A78F3A454E5850A6B0AFC
          F9F5FCF7F1FCF7EEFCF5E9FBF3E4FCF2E2AC5110FF00FFFF00FFFF00FFFF00FF
          C579190A6B0A78F3A478F3A40A6B0AFCFAF7FCF9F5FCF7F2FCF7EEFBF6E9FBF3
          E5AD5611FF00FFFF00FFFF00FFFF00FFC77C1A0A6B0A0A6B0A0A6B0A0A6B0AFC
          FBFBFCFAF8FCF9F5FBF8F2FCF7EEFBF6EAB05A12FF00FFFF00FFFF00FFFF00FF
          C97F1CFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFAFCFBF8FCF9F6FCF8F2FCF7
          EFB35E13FF00FFFF00FFFF00FFFF00FFCC821CFCFCFCFCFCFCFCFCFCFCFCFCFC
          FCFCFCFCFCFCFCFAFCFBF9FCFAF6FCF8F3B66214FF00FFFF00FFFF00FFFF00FF
          CE851DFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFBFBFCFBF9FCFA
          F7B96615FF00FFFF00FFFF00FFFF00FFCF861DFCFCFCFCFCFCFCFCFCFCFCFCFC
          FCFCFCFCFCFCFCFCFCFCFCFCFCFBFCFBF8BC6A16FF00FFFF00FFFF00FFFF00FF
          CF871DCF871DCE861DCC831CCC821CCA801BC87D1BC67A1AC47719C37419C172
          17BF6F17FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        OnClick = btnCadClienteClick
      end
      object btnCarregar: TSpeedButton
        Tag = 99
        Left = 672
        Top = 207
        Width = 64
        Height = 22
        Cursor = crHandPoint
        Caption = 'CARREGAR'
        Flat = True
        Transparent = False
        OnClick = btnCarregarClick
      end
      object btnLimpar: TSpeedButton
        Tag = 99
        Left = 762
        Top = 207
        Width = 61
        Height = 22
        Cursor = crHandPoint
        Caption = 'LIMPAR'
        Flat = True
        Transparent = False
        OnClick = btnLimparClick
      end
      object Label5: TLabel
        Left = 699
        Top = 188
        Width = 110
        Height = 13
        Caption = 'IMAGEM DO PRODUTO'
      end
      object edtProdutoId: TLabeledEdit
        Tag = 1
        Left = 3
        Top = 24
        Width = 121
        Height = 21
        Cursor = crNo
        DoubleBuffered = False
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        ParentDoubleBuffered = False
        TabOrder = 1
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 72
        Width = 334
        Height = 21
        EditLabel.Width = 44
        EditLabel.Height = 13
        EditLabel.Caption = 'Produto*'
        MaxLength = 60
        TabOrder = 2
      end
      object edtDescricao: TMemo
        Left = 3
        Top = 131
        Width = 635
        Height = 89
        Lines.Strings = (
          'edtDescricao')
        MaxLength = 255
        TabOrder = 4
      end
      object edtValor: TCurrencyEdit
        Tag = 2
        Left = 3
        Top = 256
        Width = 121
        Height = 21
        DecimalPlaceRound = True
        TabOrder = 5
      end
      object edtQuantidade: TCurrencyEdit
        Tag = 2
        Left = 146
        Top = 256
        Width = 121
        Height = 21
        DisplayFormat = ' ,0.00;- ,0.00'
        TabOrder = 6
      end
      object lkpCategoria: TDBLookupComboBox
        Tag = 2
        Left = 361
        Top = 72
        Width = 219
        Height = 21
        Hint = 'Categoria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        KeyField = 'categoriaId'
        ListField = 'descricao'
        ListSource = dtsCategoria
        ParentFont = False
        TabOrder = 3
      end
      object pnlImagem: TPanel
        Left = 657
        Top = 10
        Width = 185
        Height = 175
        BorderStyle = bsSingle
        TabOrder = 0
        object imgImagem: TImage
          Left = 1
          Top = 1
          Width = 179
          Height = 169
          Align = alClient
          PopupMenu = ppmImagem
          ExplicitLeft = -13
          ExplicitTop = 0
          ExplicitWidth = 198
          ExplicitHeight = 215
        end
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 366
    Width = 890
    ExplicitTop = 366
    ExplicitWidth = 890
    inherited btnAlterar: TBitBtn
      Left = 104
      ExplicitLeft = 104
    end
    inherited btnCancelar: TBitBtn
      TabOrder = 2
    end
    inherited btnGravar: TBitBtn
      TabOrder = 3
    end
    inherited btnFechar: TBitBtn
      Left = 800
      TabOrder = 6
      ExplicitLeft = 800
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
      TabOrder = 5
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT p.produtoId,'
      '       p.nome,'
      '       p.descricao,'
      '       p.valor,'
      '       p.quantidade,'
      '       p.categoriaId,'
      '       c.descricao As DescricaoCategoria'
      'FROM produtos as p'
      'LEFT JOIN categorias as c on c.categoriaId = p.categoriaId')
    DataSource = dtsCategoria
    Left = 700
    Top = 8
    object QryListagemprodutoId: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object QryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 255
    end
    object QryListagemvalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
      currency = True
    end
    object QryListagemquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
      DisplayFormat = '#0'
    end
    object QryListagemcategoriaId: TIntegerField
      FieldName = 'categoriaId'
    end
    object QryListagemDescricaoCategoria: TWideStringField
      DisplayLabel = 'Categoria'
      FieldName = 'DescricaoCategoria'
      Size = 30
    end
  end
  inherited dtsListagem: TDataSource
    Left = 676
    Top = 40
  end
  object QryCategoria: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'Select categoriaId, descricao from categorias')
    Params = <>
    Left = 540
    Top = 24
    object QryCategoriacategoriaId: TIntegerField
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object QryCategoriadescricao: TWideStringField
      FieldName = 'descricao'
      Size = 30
    end
  end
  object dtsCategoria: TDataSource
    DataSet = QryCategoria
    Left = 588
    Top = 48
  end
  object ppmImagem: TPopupMenu
    Left = 733
    Top = 74
    object CarregarImagem1: TMenuItem
      Caption = 'Carregar Imagem'
      OnClick = CarregarImagem1Click
    end
    object LimparImagem1: TMenuItem
      Caption = 'Limpar Imagem'
      OnClick = LimparImagem1Click
    end
  end
end
