inherited frmCadAcaoAcesso: TfrmCadAcaoAcesso
  Caption = 'Cadastro de A'#231#227'o de acesso'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    ExplicitWidth = 902
    ExplicitHeight = 382
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 894
      ExplicitHeight = 354
      inherited pnlListagemTopo: TPanel
        ExplicitWidth = 894
      end
      inherited grdListagem: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'AcaoAcessoId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 368
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'chave'
            Width = 64
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 894
      ExplicitHeight = 354
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 88
        Width = 806
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o*'
        MaxLength = 100
        TabOrder = 1
      end
      object edtAcaoAcessoId: TLabeledEdit
        Tag = 1
        Left = 3
        Top = 40
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtChave: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 136
        Width = 390
        Height = 21
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'Chave*'
        MaxLength = 60
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    inherited btnFechar: TBitBtn
      ExplicitLeft = 818
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT AcaoAcessoId, descricao, chave from acaoAcesso')
    object QryListagemAcaoAcessoId: TIntegerField
      FieldName = 'AcaoAcessoId'
      ReadOnly = True
    end
    object QryListagemdescricao: TWideStringField
      FieldName = 'descricao'
      Required = True
      Size = 100
    end
    object QryListagemchave: TWideStringField
      FieldName = 'chave'
      Required = True
      Size = 60
    end
  end
end
