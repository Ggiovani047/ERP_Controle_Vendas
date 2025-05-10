inherited frmConCategorias: TfrmConCategorias
  Caption = 'Consulta de Categorias'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    inherited tabListagem: TTabSheet
      inherited pnlListagemTopo: TPanel
        Height = 41
        Color = clMenu
        ParentBackground = False
        ExplicitHeight = 41
        inherited lblIndice: TLabel
          Left = 0
          Top = 3
          ExplicitLeft = 0
          ExplicitTop = 3
        end
        inherited mskPesquisar: TMaskEdit
          Left = 3
          Top = 19
          Width = 799
          Color = 13882323
          ExplicitLeft = 3
          ExplicitTop = 19
          ExplicitWidth = 799
        end
        inherited btnPesquisar: TBitBtn
          Left = 803
          Top = 19
          Width = 88
          ExplicitLeft = 803
          ExplicitTop = 19
          ExplicitWidth = 88
        end
      end
      inherited grdListagem: TDBGrid
        Top = 41
        Height = 313
        Columns = <
          item
            Expanded = False
            FieldName = 'categoriaId'
            Width = 79
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 206
            Visible = True
          end>
      end
    end
  end
  inherited pnlRodape: TPanel
    inherited btnNovo: TBitBtn
      Left = 810
      Top = 6
      TabOrder = 5
      Visible = False
      ExplicitLeft = 810
      ExplicitTop = 6
    end
    object btnSelecionar: TBitBtn [1]
      Left = 13
      Top = 11
      Width = 75
      Height = 25
      Caption = 'SELECIONAR'
      TabOrder = 6
      OnClick = btnSelecionarClick
    end
    inherited btnAlterar: TBitBtn
      Left = 810
      Top = 6
      TabOrder = 4
      Visible = False
      ExplicitLeft = 810
      ExplicitTop = 6
    end
    inherited btnCancelar: TBitBtn
      Left = 810
      Top = 6
      TabOrder = 3
      Visible = False
      ExplicitLeft = 810
      ExplicitTop = 6
    end
    inherited btnGravar: TBitBtn
      Left = 810
      Top = 6
      TabOrder = 0
      Visible = False
      ExplicitLeft = 810
      ExplicitTop = 6
    end
    inherited btnApagar: TBitBtn
      Left = 810
      Top = 6
      TabOrder = 1
      Visible = False
      ExplicitLeft = 810
      ExplicitTop = 6
    end
    inherited btnFechar: TBitBtn
      Left = 810
      Top = 6
      Width = 81
      TabOrder = 2
      ExplicitLeft = 810
      ExplicitTop = 6
      ExplicitWidth = 81
    end
    inherited btnNavigator: TDBNavigator
      Left = 321
      Hints.Strings = ()
      TabOrder = 7
      ExplicitLeft = 321
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'Select categoriaId, descricao FROM categorias')
    Left = 572
    Top = 0
    object QryListagemcategoriaId: TIntegerField
      DisplayLabel = 'C'#243'd. Categoria'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object QryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
  inherited dtsListagem: TDataSource
    Left = 620
    Top = 8
  end
end
