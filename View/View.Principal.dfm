object ViewPrincipal: TViewPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'ViewPrincipal'
  ClientHeight = 459
  ClientWidth = 555
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 15
  object pnl_header: TPanel
    Left = 0
    Top = 0
    Width = 555
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbl_client: TLabel
      Left = 15
      Top = 13
      Width = 98
      Height = 15
      Caption = 'Selecione o cliente'
    end
    object cbb_client: TComboBox
      Left = 15
      Top = 34
      Width = 482
      Height = 23
      Style = csDropDownList
      TabOrder = 0
    end
    object btn_new_pedido: TButton
      Left = 503
      Top = 34
      Width = 35
      Height = 25
      Hint = 'Novo pedido de venda'
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btn_new_pedidoClick
    end
  end
  object pnl_body: TPanel
    Left = 0
    Top = 65
    Width = 555
    Height = 394
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lb_cod_produto: TLabel
      Left = 15
      Top = 135
      Width = 71
      Height = 15
      Caption = 'C'#243'd. Produto'
    end
    object lbl_descricao: TLabel
      Left = 87
      Top = 135
      Width = 46
      Height = 15
      Caption = 'Decri'#231#227'o'
    end
    object lbl_vl_unit: TLabel
      Left = 395
      Top = 135
      Width = 38
      Height = 15
      Caption = 'Vl. Unit'
    end
    object lbl_qtde: TLabel
      Left = 361
      Top = 135
      Width = 26
      Height = 15
      Caption = 'Qtde'
    end
    object lbl_total_pedido: TLabel
      Left = 321
      Top = 369
      Width = 103
      Height = 15
      Caption = 'Total do Pedido R$'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edt_produto: TEdit
      Left = 15
      Top = 156
      Width = 66
      Height = 23
      TabOrder = 1
      OnExit = edt_produtoExit
    end
    object edt_descricao_produto: TEdit
      Left = 87
      Top = 156
      Width = 242
      Height = 23
      Enabled = False
      TabOrder = 2
    end
    object edt_preco_venda: TEdit
      Left = 395
      Top = 156
      Width = 43
      Height = 23
      Alignment = taRightJustify
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 4
      Text = '0,00'
    end
    object edt_qtde: TEdit
      Left = 338
      Top = 156
      Width = 51
      Height = 23
      Alignment = taRightJustify
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 3
      Text = '1'
    end
    object btn_new_produto: TButton
      Left = 444
      Top = 155
      Width = 35
      Height = 25
      Hint = 'Salvar item'
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btn_new_produtoClick
    end
    object dbg_itens: TDBGrid
      Left = 15
      Top = 202
      Width = 528
      Height = 161
      DataSource = ds_itens
      Options = [dgTitles, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = dbg_itensDblClick
      OnKeyDown = dbg_itensKeyDown
      OnKeyPress = dbg_itensKeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'id_produto'
          Title.Caption = 'C'#243'd. Produto'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Caption = 'Descri'#231#227'o'
          Width = 230
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'qtd'
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtde'
          Width = 50
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'preco_venda'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vl.Unit'
          Width = 60
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'total'
          Title.Alignment = taRightJustify
          Title.Caption = 'Total'
          Visible = True
        end>
    end
    object dbg_pedidos: TDBGrid
      Left = 15
      Top = 6
      Width = 528
      Height = 109
      DataSource = ds_pedidos
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = dbg_pedidosCellClick
    end
    object btn_cancelar_acao_item: TButton
      Left = 485
      Top = 155
      Width = 35
      Height = 25
      Hint = 'Cancelar a'#231#227'o no item'
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Visible = False
      OnClick = btn_cancelar_acao_itemClick
    end
  end
  object ds_itens: TDataSource
    Left = 468
    Top = 304
  end
  object ds_pedidos: TDataSource
    Left = 468
    Top = 96
  end
end
