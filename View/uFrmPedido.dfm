object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  Caption = 'Pedido'
  ClientHeight = 398
  ClientWidth = 578
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 66
    Width = 52
    Height = 13
    Caption = 'Refer'#234'ncia'
  end
  object Label2: TLabel
    Left = 337
    Top = 66
    Width = 33
    Height = 13
    Caption = 'N'#186' Ped'
  end
  object Label3: TLabel
    Left = 432
    Top = 66
    Width = 64
    Height = 13
    Caption = 'Data emiss'#227'o'
  end
  object Label4: TLabel
    Left = 25
    Top = 113
    Width = 33
    Height = 13
    Caption = 'Cliente'
  end
  object Label5: TLabel
    Left = 337
    Top = 113
    Width = 68
    Height = 13
    Caption = 'Tipo opera'#231#227'o'
  end
  object Label6: TLabel
    Left = 28
    Top = 155
    Width = 25
    Height = 13
    Caption = 'Itens'
  end
  object Label7: TLabel
    Left = 440
    Top = 281
    Width = 51
    Height = 13
    Caption = 'Valor Total'
  end
  object Label8: TLabel
    Left = 25
    Top = 16
    Width = 19
    Height = 13
    Caption = 'Cod'
  end
  object edtCodigoVenda: TDBEdit
    Left = 24
    Top = 32
    Width = 41
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 0
  end
  object edtNumeroPedido: TDBEdit
    Left = 336
    Top = 80
    Width = 57
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object edtTipoOperacao: TDBEdit
    Left = 336
    Top = 127
    Width = 209
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object edtTotalPedido: TDBEdit
    Left = 431
    Top = 300
    Width = 121
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 3
  end
  object btnSalvar: TButton
    Left = 108
    Top = 350
    Width = 85
    Height = 25
    Caption = 'Salvar'
    TabOrder = 4
    OnClick = btnSalvarClick
  end
  object btnNovo: TButton
    Left = 27
    Top = 350
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 5
    OnClick = btnNovoClick
  end
  object btnInsereProduto: TButton
    Left = 431
    Top = 171
    Width = 114
    Height = 25
    Caption = 'Novo item'
    Enabled = False
    TabOrder = 6
    OnClick = btnInsereProdutoClick
  end
  object btnRemoveItem: TButton
    Left = 431
    Top = 202
    Width = 114
    Height = 25
    Caption = 'Remover Item'
    Enabled = False
    TabOrder = 7
    OnClick = btnRemoveItemClick
  end
  object gridItens: TDBGrid
    Left = 25
    Top = 174
    Width = 368
    Height = 150
    Cursor = crHandPoint
    BorderStyle = bsNone
    Color = clBtnFace
    DataSource = dsItens
    DragCursor = crHandPoint
    Enabled = False
    GradientEndColor = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -9
    TitleFont.Name = 'Verdana'
    TitleFont.Style = []
    OnDrawColumnCell = gridItensDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'COD_PROD'
        Title.Alignment = taCenter
        Title.Caption = 'Produto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALORUNITARIO'
        Title.Alignment = taCenter
        Title.Caption = 'Valor'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QUANTIDADE'
        Title.Alignment = taCenter
        Title.Caption = 'Quantidade'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTALITEM'
        Title.Alignment = taCenter
        Title.Caption = 'Total'
        Width = 85
        Visible = True
      end>
  end
  object DBLClientes: TDBLookupComboBox
    Left = 24
    Top = 128
    Width = 289
    Height = 21
    DataSource = dsPedido
    Enabled = False
    ListSource = dsClientes
    TabOrder = 9
  end
  object edtDataEmi: TMaskEdit
    Left = 427
    Top = 80
    Width = 117
    Height = 21
    ReadOnly = True
    TabOrder = 10
    Text = ''
  end
  object edtReferencia: TEdit
    Left = 24
    Top = 80
    Width = 289
    Height = 21
    Enabled = False
    TabOrder = 11
  end
  object dsItens: TDataSource
    DataSet = dsTemporaria
    Left = 208
    Top = 240
  end
  object dsClientes: TDataSource
    DataSet = queryClientes
    Left = 272
    Top = 123
  end
  object dsPedido: TDataSource
    DataSet = dtTempPedido
    Left = 520
    Top = 16
  end
  object queryClientes: TFDQuery
    Left = 208
    Top = 120
  end
  object dtTempPedido: TClientDataSet
    PersistDataPacket.Data = {
      2A0000009619E0BD0100000018000000010000000000030000002A0007434F44
      5F434C4904000100000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 448
    Top = 16
    object dtTempPedidoCOD_CLI: TIntegerField
      FieldName = 'COD_CLI'
    end
  end
  object dsTemporaria: TClientDataSet
    PersistDataPacket.Data = {
      660000009619E0BD010000001800000004000000000003000000660008434F44
      5F50524F4404000100000000000D56414C4F52554E49544152494F0800040000
      0000000A5155414E544944414445080004000000000009544F54414C4954454D
      08000400000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 240
    object dsTemporariaCOD_PROD: TIntegerField
      FieldName = 'COD_PROD'
    end
    object dsTemporariaVALORUNITARIO: TFloatField
      FieldName = 'VALORUNITARIO'
      DisplayFormat = '0.00'
      EditFormat = '0.00'
    end
    object dsTemporariaQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object dsTemporariaTOTALITEM: TFloatField
      FieldName = 'TOTALITEM'
      DisplayFormat = '0.00'
      EditFormat = '0.00'
    end
  end
end
