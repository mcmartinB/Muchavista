object FAcceso: TFAcceso
  Left = 499
  Top = 183
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Acceso Base de Datos'
  ClientHeight = 334
  ClientWidth = 344
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gb1: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    Style.LookAndFeel.NativeStyle = False
    Style.LookAndFeel.SkinName = 'Office2010Blue'
    Style.Shadow = False
    Style.TextColor = clWindow
    Style.TextStyle = []
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.SkinName = 'Office2010Blue'
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.SkinName = 'Office2010Blue'
    StyleHot.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.SkinName = 'Office2010Blue'
    TabOrder = 0
    Height = 334
    Width = 344
    object cbAlias: TcxComboBox
      Left = 79
      Top = 109
      Properties.ReadOnly = False
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      Style.Shadow = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
      TabOrder = 0
      Width = 221
    end
    object lbUsuario: TcxLabel
      Left = 35
      Top = 153
      AutoSize = False
      Caption = 'Usuario '
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clBtnFace
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 107
      AnchorX = 142
    end
    object txUsuario: TcxTextEdit
      Left = 143
      Top = 151
      TabOrder = 2
      Width = 157
    end
    object lbClave: TcxLabel
      Left = 35
      Top = 177
      AutoSize = False
      Caption = 'Clave '
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clBtnFace
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'Foggy'
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'Foggy'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'Foggy'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'Foggy'
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 107
      AnchorX = 142
    end
    object txClave: TcxTextEdit
      Left = 143
      Top = 175
      Properties.EchoMode = eemPassword
      TabOrder = 4
      Width = 157
    end
    object btAceptar: TcxButton
      Left = 126
      Top = 266
      Width = 88
      Height = 39
      Caption = 'Aceptar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btAceptarClick
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'LondonLiquidSky'
      OptionsImage.ImageIndex = 2
      OptionsImage.Images = DM.ilImagenes
    end
    object btCancelar: TcxButton
      Left = 214
      Top = 266
      Width = 88
      Height = 39
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = btCancelarClick
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'LondonLiquidSky'
      OptionsImage.ImageIndex = 3
      OptionsImage.Images = DM.ilImagenes
    end
    object lb1: TcxLabel
      Left = 35
      Top = 81
      AutoSize = False
      Caption = 'Iniciar Sesion....'
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clBtnFace
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = 'SevenClassic'
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = 'SevenClassic'
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = 'SevenClassic'
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = 'SevenClassic'
      Properties.Alignment.Horz = taRightJustify
      Height = 17
      Width = 107
      AnchorX = 142
    end
    object lbError: TcxLabel
      Left = 36
      Top = 222
      AutoSize = False
      Caption = 'lbError'
      Style.TextStyle = [fsBold]
      Properties.Alignment.Horz = taCenter
      Height = 17
      Width = 264
      AnchorX = 168
    end
  end
end
