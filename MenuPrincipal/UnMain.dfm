object FrmMenu: TFrmMenu
  Left = 0
  Top = 0
  Caption = 'Menu Aguas'
  ClientHeight = 336
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btImpresionDocumentos: TButton
    Left = 24
    Top = 16
    Width = 300
    Height = 70
    Caption = 'Impresi'#243'n de documentos'
    TabOrder = 0
    OnClick = btImpresionDocumentosClick
  end
  object btGestionInformes: TButton
    Left = 24
    Top = 91
    Width = 300
    Height = 70
    Caption = 'Gesti'#243'n de informes'
    TabOrder = 1
    OnClick = btGestionInformesClick
  end
  object btSEPA: TButton
    Left = 24
    Top = 167
    Width = 300
    Height = 70
    Caption = 'SEPA'
    TabOrder = 2
    OnClick = btSEPAClick
  end
  object btGestionClientes: TButton
    Left = 24
    Top = 243
    Width = 300
    Height = 70
    Caption = 'Gesti'#243'n de clientes'
    TabOrder = 3
    OnClick = btGestionClientesClick
  end
end
