object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 186
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btEnviar: TButton
    Left = 16
    Top = 24
    Width = 75
    Height = 25
    Caption = 'btEnviar'
    TabOrder = 0
    OnClick = btEnviarClick
  end
  object Memo1: TMemo
    Left = 16
    Top = 56
    Width = 394
    Height = 122
    Lines.Strings = (
      '')
    TabOrder = 1
  end
end
