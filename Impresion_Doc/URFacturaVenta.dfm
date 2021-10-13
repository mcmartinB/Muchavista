object RFacturaVenta: TRFacturaVenta
  Left = 0
  Top = 0
  Width = 794
  Height = 1123
  Frame.Color = clBlack
  Frame.DrawTop = False
  Frame.DrawBottom = False
  Frame.DrawLeft = False
  Frame.DrawRight = False
  BeforePrint = QuickRepBeforePrint
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  Functions.Strings = (
    'PAGENUMBER'
    'COLUMNNUMBER'
    'REPORTTITLE')
  Functions.DATA = (
    '0'
    '0'
    #39#39)
  Options = [FirstPageHeader, LastPageFooter]
  Page.Columns = 1
  Page.Orientation = poPortrait
  Page.PaperSize = A4
  Page.Values = (
    100.000000000000000000
    2970.000000000000000000
    100.000000000000000000
    2100.000000000000000000
    100.000000000000000000
    100.000000000000000000
    0.000000000000000000)
  PrinterSettings.Copies = 1
  PrinterSettings.OutputBin = Auto
  PrinterSettings.Duplex = False
  PrinterSettings.FirstPage = 0
  PrinterSettings.LastPage = 0
  PrinterSettings.UseStandardprinter = False
  PrinterSettings.UseCustomBinCode = False
  PrinterSettings.CustomBinCode = 0
  PrinterSettings.ExtendedDuplex = 0
  PrinterSettings.UseCustomPaperCode = False
  PrinterSettings.CustomPaperCode = 0
  PrinterSettings.PrintMetaFile = False
  PrinterSettings.PrintQuality = 0
  PrinterSettings.Collate = 0
  PrinterSettings.ColorOption = 0
  PrintIfEmpty = True
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsNormal
  PrevInitialZoom = qrZoomToFit
  object qrCabecera: TQRBand
    Left = 38
    Top = 38
    Width = 718
    Height = 104
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = True
    Size.Values = (
      275.166666666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageHeader
    object QRImageLogo: TQRImage
      Left = 13
      Top = 6
      Width = 87
      Height = 92
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        243.416666666666700000
        34.395833333333330000
        15.875000000000000000
        230.187500000000000000)
      Stretch = True
    end
    object qrRazSoc: TQRDBText
      Left = 118
      Top = 5
      Width = 429
      Height = 39
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        103.187500000000000000
        312.208333333333300000
        13.229166666666670000
        1135.062500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'raz_soc'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 16
    end
    object qrNifEmp: TQRDBText
      Left = 118
      Top = 45
      Width = 112
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        312.208333333333300000
        119.062500000000000000
        296.333333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'nif_empr'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrDirEmp: TQRDBText
      Left = 118
      Top = 63
      Width = 245
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        312.208333333333300000
        166.687500000000000000
        648.229166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'dir_empr'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrCpoEmp: TQRDBText
      Left = 118
      Top = 82
      Width = 48
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        312.208333333333300000
        216.958333333333300000
        127.000000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'cpo_empr'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrTitPob: TQRDBText
      Left = 168
      Top = 82
      Width = 70
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        444.500000000000000000
        216.958333333333300000
        185.208333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'tit_pob'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrTitPro: TQRDBText
      Left = 241
      Top = 82
      Width = 122
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        637.645833333333300000
        216.958333333333300000
        322.791666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'tit_pro'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRLabel1: TQRLabel
      Left = 367
      Top = 63
      Width = 161
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        971.020833333333300000
        166.687500000000000000
        425.979166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Tel'#233'fono:  965 69 83 59'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRLabel2: TQRLabel
      Left = 367
      Top = 82
      Width = 215
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        971.020833333333300000
        216.958333333333300000
        568.854166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'clientes@aguasdemuchavista.es'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object qrGruFactura: TQRGroup
    Left = 38
    Top = 142
    Width = 718
    Height = 465
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = qrGruFacturaBeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = True
    Size.Values = (
      1230.312500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = 'str(cod_rec)  + '#39'/'#39' + str(clave_lin) '
    Master = Owner
    ReprintOnNewPage = False
    object lb1: TQRLabel
      Left = 12
      Top = 37
      Width = 98
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        31.750000000000000000
        97.895833333333330000
        259.291666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Datos Cliente'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object qrTitCli: TQRDBText
      Left = 69
      Top = 80
      Width = 259
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        182.562500000000000000
        211.666666666666700000
        685.270833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'tit_cli'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrNifCli: TQRDBText
      Left = 69
      Top = 98
      Width = 131
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        182.562500000000000000
        259.291666666666700000
        346.604166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'nif_cli'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qs1: TQRShape
      Left = 11
      Top = 53
      Width = 190
      Height = 6
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        15.875000000000000000
        29.104166666666670000
        140.229166666666700000
        502.708333333333300000)
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object lb2: TQRLabel
      Left = 14
      Top = 80
      Width = 54
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        211.666666666666700000
        142.875000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Titular: '
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb3: TQRLabel
      Left = 14
      Top = 98
      Width = 45
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        259.291666666666700000
        119.062500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'D.N.I: '
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb4: TQRLabel
      Left = 341
      Top = 149
      Width = 135
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        902.229166666666700000
        394.229166666666700000
        357.187500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Datos Facturaci'#243'n'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object qs2: TQRShape
      Left = 340
      Top = 165
      Width = 190
      Height = 6
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        15.875000000000000000
        899.583333333333300000
        436.562500000000000000
        502.708333333333300000)
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object lb5: TQRLabel
      Left = 342
      Top = 174
      Width = 91
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        904.875000000000000000
        460.375000000000000000
        240.770833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'N'#186' Contrato: '
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrLetCli: TQRDBText
      Left = 436
      Top = 174
      Width = 76
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1153.583333333333000000
        460.375000000000000000
        201.083333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'let_cli'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb6: TQRLabel
      Left = 342
      Top = 192
      Width = 56
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        904.875000000000000000
        508.000000000000000000
        148.166666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Calibre: '
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrCalTip: TQRDBText
      Left = 436
      Top = 192
      Width = 76
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1153.583333333333000000
        508.000000000000000000
        201.083333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'cal_tip'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb7: TQRLabel
      Left = 342
      Top = 210
      Width = 93
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        904.875000000000000000
        555.625000000000000000
        246.062500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'N'#186' Contador: '
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrCntCli: TQRDBText
      Left = 436
      Top = 210
      Width = 82
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1153.583333333333000000
        555.625000000000000000
        216.958333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'cnt_cli'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb8: TQRLabel
      Left = 519
      Top = 174
      Width = 84
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1373.187500000000000000
        460.375000000000000000
        222.250000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'N'#186' Factura: '
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrCodRec: TQRDBText
      Left = 628
      Top = 174
      Width = 88
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1661.583333333333000000
        460.375000000000000000
        232.833333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'cod_rec'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb9: TQRLabel
      Left = 519
      Top = 192
      Width = 108
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1373.187500000000000000
        508.000000000000000000
        285.750000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Fecha Factura: '
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrFfaRec: TQRDBText
      Left = 628
      Top = 192
      Width = 88
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1661.583333333333000000
        508.000000000000000000
        232.833333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'ffa_rec'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb10: TQRLabel
      Left = 519
      Top = 210
      Width = 108
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1373.187500000000000000
        555.625000000000000000
        285.750000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Period. Factur.'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb11: TQRLabel
      Left = 12
      Top = 149
      Width = 151
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        31.750000000000000000
        394.229166666666700000
        399.520833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Direcci'#243'n Suministro'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object qs3: TQRShape
      Left = 11
      Top = 165
      Width = 190
      Height = 6
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        15.875000000000000000
        29.104166666666670000
        436.562500000000000000
        502.708333333333300000)
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object qrCDomCli: TQRDBText
      Left = 14
      Top = 174
      Width = 252
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        460.375000000000000000
        666.750000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'cdom_cli'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrCCodPob: TQRDBText
      Left = 14
      Top = 192
      Width = 48
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        508.000000000000000000
        127.000000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'ccod_pob'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrCTitPob: TQRDBText
      Left = 69
      Top = 192
      Width = 142
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        182.562500000000000000
        508.000000000000000000
        375.708333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'ctit_pob'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrCTitPro: TQRDBText
      Left = 13
      Top = 210
      Width = 142
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        34.395833333333330000
        555.625000000000000000
        375.708333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'ctit_pro'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb12: TQRLabel
      Left = 340
      Top = 37
      Width = 123
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        899.583333333333300000
        97.895833333333330000
        325.437500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Direcci'#243'n Correo'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object qs4: TQRShape
      Left = 339
      Top = 53
      Width = 190
      Height = 6
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        15.875000000000000000
        896.937500000000000000
        140.229166666666700000
        502.708333333333300000)
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object lb13: TQRLabel
      Left = 12
      Top = 360
      Width = 162
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        31.750000000000000000
        952.500000000000000000
        428.625000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'DETALLE DE FACTURA'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object qs5: TQRShape
      Left = 11
      Top = 376
      Width = 677
      Height = 6
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        15.875000000000000000
        29.104166666666670000
        994.833333333333300000
        1791.229166666667000000)
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object lb14: TQRLabel
      Left = 396
      Top = 386
      Width = 86
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1047.750000000000000000
        1021.291666666667000000
        227.541666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Cantidad'
      Color = cl3DLight
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb15: TQRLabel
      Left = 12
      Top = 149
      Width = 151
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        31.750000000000000000
        394.229166666666700000
        399.520833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Direcci'#243'n Suministro'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object qs6: TQRShape
      Left = 11
      Top = 165
      Width = 190
      Height = 6
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        15.875000000000000000
        29.104166666666670000
        436.562500000000000000
        502.708333333333300000)
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object lb16: TQRLabel
      Left = 500
      Top = 386
      Width = 96
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1322.916666666667000000
        1021.291666666667000000
        254.000000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Precio Unitario'
      Color = cl3DLight
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb17: TQRLabel
      Left = 602
      Top = 386
      Width = 86
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1592.791666666667000000
        1021.291666666667000000
        227.541666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Importe'
      Color = cl3DLight
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb19: TQRLabel
      Left = 14
      Top = 386
      Width = 364
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        1021.291666666667000000
        963.083333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Conceptos'
      Color = cl3DLight
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb20: TQRLabel
      Left = 14
      Top = 408
      Width = 118
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        1079.500000000000000000
        312.208333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Cuota de Servicio'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrConRec: TQRDBText
      Left = 600
      Top = 408
      Width = 86
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1587.500000000000000000
        1079.500000000000000000
        227.541666666666700000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'con_rec'
      Mask = '#,##0.00'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb21: TQRLabel
      Left = 14
      Top = 426
      Width = 154
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        1127.125000000000000000
        407.458333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Cuota de Conservaci'#243'n'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrManRec: TQRDBText
      Left = 600
      Top = 426
      Width = 86
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1587.500000000000000000
        1127.125000000000000000
        227.541666666666700000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'man_rec'
      Mask = '#,##0.00'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb22: TQRLabel
      Left = 14
      Top = 449
      Width = 77
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        37.041666666666670000
        1187.979166666667000000
        203.729166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'CONSUMOS'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsUnderline]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object lb28: TQRLabel
      Left = 12
      Top = 261
      Width = 152
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        31.750000000000000000
        690.562500000000000000
        402.166666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'DATOS DE CONSUMO'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object qs8: TQRShape
      Left = 11
      Top = 277
      Width = 677
      Height = 6
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        15.875000000000000000
        29.104166666666670000
        732.895833333333300000
        1791.229166666667000000)
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object lb29: TQRLabel
      Left = 14
      Top = 287
      Width = 114
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        37.041666666666670000
        759.354166666666700000
        301.625000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'CONSUMO / M3: '
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object qrM3Rec: TQRDBText
      Left = 130
      Top = 287
      Width = 62
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        343.958333333333300000
        759.354166666666700000
        164.041666666666700000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'm3_rec'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb30: TQRLabel
      Left = 239
      Top = 287
      Width = 119
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        632.354166666666700000
        759.354166666666700000
        314.854166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Lectura Anterior: '
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object qrFanRec: TQRDBText
      Left = 359
      Top = 287
      Width = 90
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        949.854166666666700000
        759.354166666666700000
        238.125000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'fan_rec'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrLanRec: TQRDBText
      Left = 359
      Top = 307
      Width = 90
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        949.854166666666700000
        812.270833333333300000
        238.125000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'lan_rec'
      Mask = '#,##0'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb31: TQRLabel
      Left = 488
      Top = 287
      Width = 109
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        1291.166666666667000000
        759.354166666666700000
        288.395833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Lectura Actual: '
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object qrFacRec: TQRDBText
      Left = 598
      Top = 287
      Width = 90
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        1582.208333333333000000
        759.354166666666700000
        238.125000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'fac_rec'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrLacRec: TQRDBText
      Left = 598
      Top = 307
      Width = 90
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        1582.208333333333000000
        812.270833333333300000
        238.125000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'lac_rec'
      Mask = '#,##0'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb32: TQRLabel
      Left = 193
      Top = 287
      Width = 20
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        510.645833333333300000
        759.354166666666700000
        52.916666666666670000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'm3'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object lb35: TQRLabel
      Left = 14
      Top = 62
      Width = 131
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        164.041666666666700000
        346.604166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Referencia Cliente: '
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrReferencia: TQRDBText
      Left = 146
      Top = 62
      Width = 182
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        386.291666666666700000
        164.041666666666700000
        481.541666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'referencia'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lbPeriodo: TQRLabel
      Left = 628
      Top = 210
      Width = 88
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1661.583333333333000000
        555.625000000000000000
        232.833333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'Periodo'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb18: TQRLabel
      Left = 342
      Top = 62
      Width = 54
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        904.875000000000000000
        164.041666666666700000
        142.875000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Titular: '
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrTitCli2: TQRDBText
      Left = 397
      Top = 62
      Width = 253
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1050.395833333333000000
        164.041666666666700000
        669.395833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'tit_cli'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lbddom_cli: TQRLabel
      Left = 342
      Top = 80
      Width = 252
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        904.875000000000000000
        211.666666666666700000
        666.750000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lbddom_cli'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lbdcod_p: TQRLabel
      Left = 342
      Top = 98
      Width = 48
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        904.875000000000000000
        259.291666666666700000
        127.000000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lbdcod_p'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lbdtit_pob: TQRLabel
      Left = 397
      Top = 98
      Width = 142
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1050.395833333333000000
        259.291666666666700000
        375.708333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lbdtit_pob'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lbdtit_pro: TQRLabel
      Left = 342
      Top = 117
      Width = 142
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        904.875000000000000000
        309.562500000000000000
        375.708333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lbdtit_pro'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object qrm3: TQRDBText
    Left = 364
    Top = 6
    Width = 52
    Height = 17
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Size.Values = (
      44.979166666666670000
      963.083333333333300000
      15.875000000000000000
      137.583333333333300000)
    Alignment = taLeftJustify
    AlignToBand = False
    AutoSize = False
    AutoStretch = False
    Color = clWhite
    DataField = 'm3'
    Transparent = False
    WordWrap = True
    FontSize = 10
  end
  object qrConsumos: TQRSubDetail
    Left = 38
    Top = 607
    Width = 718
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = qrConsumosBeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    PrintBefore = False
    PrintIfEmpty = True
    object qrConTexto: TQRDBText
      Left = 14
      Top = 0
      Width = 309
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        0.000000000000000000
        817.562500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'texto'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrConM3: TQRDBText
      Left = 396
      Top = 0
      Width = 84
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1047.750000000000000000
        0.000000000000000000
        222.250000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'm3'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrConPrecio: TQRDBText
      Left = 500
      Top = 0
      Width = 84
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1322.916666666667000000
        0.000000000000000000
        222.250000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'precio'
      Mask = '#,##0.0000'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrConImporte: TQRDBText
      Left = 600
      Top = 0
      Width = 86
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1587.500000000000000000
        0.000000000000000000
        227.541666666666700000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'importe'
      Mask = '#,##0.00'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object QRSubDetail1: TQRSubDetail
    Left = 38
    Top = 625
    Width = 718
    Height = 20
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      52.916666666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    PrintBefore = False
    PrintIfEmpty = True
  end
  object qrBases: TQRSubDetail
    Left = 38
    Top = 645
    Width = 718
    Height = 19
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = qrBasesBeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      50.270833333333330000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    PrintBefore = False
    PrintIfEmpty = True
    object lbTextoIVA: TQRLabel
      Left = 14
      Top = 1
      Width = 131
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        2.645833333333333000
        346.604166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'I.V.A. al %'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb24: TQRLabel
      Left = 146
      Top = 1
      Width = 110
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        386.291666666666700000
        2.645833333333333000
        291.041666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Base Imponible: '
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrBasBase: TQRDBText
      Left = 257
      Top = 1
      Width = 71
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        679.979166666666700000
        2.645833333333333000
        187.854166666666700000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'base'
      Mask = '#,##0.00'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrBasImporte: TQRDBText
      Left = 600
      Top = 0
      Width = 86
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1587.500000000000000000
        0.000000000000000000
        227.541666666666700000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'importe'
      Mask = '#,##0.00'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object qrTotal: TQRSubDetail
    Left = 38
    Top = 664
    Width = 718
    Height = 250
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AfterPrint = qrTotalAfterPrint
    AlignToBottom = False
    BeforePrint = qrTotalBeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      661.458333333333300000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    PrintBefore = False
    PrintIfEmpty = True
    object lb23: TQRLabel
      Left = 14
      Top = 8
      Width = 331
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        37.041666666666670000
        21.166666666666670000
        875.770833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'CANON SANEAMIENTO GENERALITAT VALENCIANA'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsUnderline]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object lb25: TQRLabel
      Left = 14
      Top = 27
      Width = 118
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        71.437500000000000000
        312.208333333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Cuota de Servicio'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lb26: TQRLabel
      Left = 14
      Top = 45
      Width = 125
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        119.062500000000000000
        330.729166666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Cuota de Consumo'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrCM3Rec: TQRDBText
      Left = 396
      Top = 45
      Width = 84
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1047.750000000000000000
        119.062500000000000000
        222.250000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'm3_rec'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrCseRec: TQRDBText
      Left = 600
      Top = 27
      Width = 86
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1587.500000000000000000
        71.437500000000000000
        227.541666666666700000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'cse_rec'
      Mask = '#,##0.00'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrCtaCco: TQRDBText
      Left = 500
      Top = 45
      Width = 84
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1322.916666666667000000
        119.062500000000000000
        222.250000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'cta_cco'
      Mask = '#,##0.0000'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrCcoRec: TQRDBText
      Left = 600
      Top = 45
      Width = 86
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1587.500000000000000000
        119.062500000000000000
        227.541666666666700000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'cco_rec'
      Mask = '#,##0.00'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrTotRec: TQRDBText
      Left = 600
      Top = 114
      Width = 84
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        66.145833333333330000
        1587.500000000000000000
        301.625000000000000000
        222.250000000000000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'tot_rec'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      Mask = '#,##0.00'
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 12
    end
    object lb27: TQRLabel
      Left = 448
      Top = 114
      Width = 150
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        66.145833333333330000
        1185.333333333333000000
        301.625000000000000000
        396.875000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'TOTAL FACTURA'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 12
    end
    object lbCoef: TQRLabel
      Left = 14
      Top = 63
      Width = 200
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        166.687500000000000000
        529.166666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Coeficiente corrector aplicado'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qs7: TQRShape
      Left = 448
      Top = 137
      Width = 236
      Height = 5
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        13.229166666666670000
        1185.333333333333000000
        362.479166666666700000
        624.416666666666700000)
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object qs9: TQRShape
      Left = 448
      Top = 110
      Width = 236
      Height = 5
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        13.229166666666670000
        1185.333333333333000000
        291.041666666666700000
        624.416666666666700000)
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object lb36: TQRLabel
      Left = 11
      Top = 196
      Width = 657
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        29.104166666666670000
        518.583333333333300000
        1738.312500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 
        'El pago de esta factura se acreditar'#225' mediante el correspondient' +
        'e adeudo bancario o recib'#237' de caja.'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 9
    end
    object lb37: TQRLabel
      Left = 14
      Top = 148
      Width = 79
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        50.270833333333330000
        37.041666666666670000
        391.583333333333300000
        209.020833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'CONCEPTO'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      FontSize = 10
    end
    object qs10: TQRShape
      Left = 14
      Top = 161
      Width = 326
      Height = 7
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        18.520833333333330000
        37.041666666666670000
        425.979166666666700000
        862.541666666666700000)
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object lb38: TQRLabel
      Left = 14
      Top = 171
      Width = 254
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        452.437500000000000000
        672.041666666666700000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Agua para riego y limpieza no potable.'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lbAplazamiento1: TQRLabel
      Left = 11
      Top = 219
      Width = 703
      Height = 27
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        71.437500000000000000
        29.104166666666670000
        579.437500000000000000
        1860.020833333333000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 
        '(*) Importe aplazado por Decreto Ley 4/2020 del Consell, de medi' +
        'das extraordinarias de gesti'#243'n econ'#243'mico-financiera para hacer f' +
        'rente a la crisis producida por la COVID-19.'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 7
    end
    object lbApla: TQRLabel
      Left = 14
      Top = 81
      Width = 271
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        37.041666666666670000
        214.312500000000000000
        717.020833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'Aplazamiento Canon de Saneamiento (*)'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object qrAplazamiento: TQRDBText
      Left = 600
      Top = 81
      Width = 86
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1587.500000000000000000
        214.312500000000000000
        227.541666666666700000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataField = 'apl_c19'
      Mask = '#,##0.00'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object qrPie: TQRBand
    Left = 38
    Top = 914
    Width = 718
    Height = 40
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    BeforePrint = qrPieBeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      105.833333333333300000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageFooter
    object lb33: TQRLabel
      Left = 6
      Top = 2
      Width = 708
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        15.875000000000000000
        5.291666666666667000
        1873.250000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 
        'Inscrita en el Registro Mercantil de Alicante, Tomo1423, Folio 2' +
        '11, Hoja A-12519, Inscrip. 1'#170'. C.I.F.: B03020369'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 7
    end
    object lb34: TQRLabel
      Left = 6
      Top = 20
      Width = 708
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        15.875000000000000000
        52.916666666666670000
        1873.250000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'AGUA POTABLE REG. SANITARIO 27.01604/R'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 7
    end
  end
end
