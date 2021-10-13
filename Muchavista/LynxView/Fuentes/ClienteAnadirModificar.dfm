object frmClienteAnadirModificar: TfrmClienteAnadirModificar
  Left = 0
  Top = 55
  BorderIcons = []
  Caption = 'Cliente'
  ClientHeight = 609
  ClientWidth = 1030
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = OnEventFormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1030
    Height = 38
    AutoSize = True
    ButtonHeight = 38
    ButtonWidth = 39
    Caption = 'ToolBar1'
    DisabledImages = MBaseDatos.imgDisabledx32
    Images = MBaseDatos.imgEnabledx32
    TabOrder = 0
    object tbtnSave: TToolButton
      Left = 0
      Top = 0
      Hint = 'Guardar y Salir'
      Caption = 'Guardar y Salir'
      ImageIndex = 8
      MenuItem = GuardarySalir1
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton3: TToolButton
      Left = 39
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object tbtnExit: TToolButton
      Left = 47
      Top = 0
      Hint = 'Salir'
      Caption = 'Salir'
      ImageIndex = 7
      MenuItem = Salir1
      ParentShowHint = False
      ShowHint = True
    end
  end
  object pnlAnadirModificar: TPanel
    Left = 0
    Top = 38
    Width = 1030
    Height = 41
    Align = alTop
    Caption = 'A'#241'adir - Modificar [ EMPRESA ]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 79
    Width = 1030
    Height = 530
    ActivePage = Datos
    Align = alClient
    TabOrder = 2
    object Datos: TTabSheet
      Caption = 'Datos'
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 1022
        Height = 502
        Align = alClient
        Caption = ' Identificaci'#243'n del cliente '
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 18
          Width = 68
          Height = 13
          Caption = 'C'#243'digo zona'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbxCod_Zon: TComboBox
          Left = 16
          Top = 34
          Width = 83
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = cbxCod_ZonChange
          OnEnter = OnEventEnter
          OnExit = OnEventExit
          OnKeyUp = OnEventKeyUp
        end
        object txtCod_Cli: TLabeledEdit
          Left = 105
          Top = 34
          Width = 82
          Height = 21
          EditLabel.Width = 79
          EditLabel.Height = 13
          EditLabel.Caption = 'C'#243'digo cliente'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -11
          EditLabel.Font.Name = 'Tahoma'
          EditLabel.Font.Style = [fsBold]
          EditLabel.ParentFont = False
          TabOrder = 1
          OnChange = txtCod_CliChange
          OnEnter = OnEventEnter
          OnExit = txtCod_CliExit
          OnKeyPress = OnEventKeyPressOnlyNumber
          OnKeyUp = OnEventKeyUp
        end
        object GroupBox2: TGroupBox
          Left = 16
          Top = 66
          Width = 324
          Height = 241
          Caption = ' Direcci'#243'n Suminstro '
          TabOrder = 2
          object Label2: TLabel
            Left = 16
            Top = 107
            Width = 76
            Height = 13
            Caption = 'C'#243'digo Postal'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label4: TLabel
            Left = 16
            Top = 191
            Width = 87
            Height = 13
            Caption = 'Jur'#237'dico / F'#237'sico'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object txtDom_Cli: TLabeledEdit
            Left = 16
            Top = 80
            Width = 285
            Height = 21
            EditLabel.Width = 51
            EditLabel.Height = 13
            EditLabel.Caption = 'Domicilio'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            TabOrder = 1
            OnChange = txtDom_CliChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtTit_Cli: TLabeledEdit
            Left = 16
            Top = 39
            Width = 285
            Height = 21
            EditLabel.Width = 88
            EditLabel.Height = 13
            EditLabel.Caption = 'T'#237'tulo / Nombre'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = [fsBold]
            EditLabel.ParentFont = False
            TabOrder = 0
            OnChange = txtTit_CliChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object cbxCod_Pob: TComboBox
            Left = 16
            Top = 123
            Width = 87
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 2
            OnChange = cbxCod_PobChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtPob_Cli: TLabeledEdit
            Left = 109
            Top = 123
            Width = 192
            Height = 21
            Color = clInactiveCaption
            EditLabel.Width = 45
            EditLabel.Height = 13
            EditLabel.Caption = 'Poblaci'#243'n'
            Enabled = False
            TabOrder = 6
          end
          object txtPro_Cli: TLabeledEdit
            Left = 109
            Top = 165
            Width = 192
            Height = 21
            Color = clInactiveCaption
            EditLabel.Width = 43
            EditLabel.Height = 13
            EditLabel.Caption = 'Provincia'
            Enabled = False
            TabOrder = 7
          end
          object cbxJoF_Cli: TComboBox
            Left = 16
            Top = 207
            Width = 87
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 3
            OnChange = cbxJoF_CliChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtNif_Cli: TLabeledEdit
            Left = 109
            Top = 207
            Width = 69
            Height = 21
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'N.I.F.'
            TabOrder = 4
            OnChange = txtNif_CliChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtTel_Cli: TLabeledEdit
            Left = 184
            Top = 207
            Width = 87
            Height = 21
            EditLabel.Width = 42
            EditLabel.Height = 13
            EditLabel.Caption = 'Tel'#233'fono'
            TabOrder = 5
            OnChange = txtTel_CliChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtCod_Pro: TLabeledEdit
            Left = 16
            Top = 165
            Width = 87
            Height = 21
            Color = clInactiveCaption
            EditLabel.Width = 79
            EditLabel.Height = 13
            EditLabel.Caption = 'C'#243'digo Provincia'
            Enabled = False
            TabOrder = 8
          end
        end
        object GroupBox3: TGroupBox
          Left = 352
          Top = 66
          Width = 324
          Height = 241
          Caption = ' Direcci'#243'n Fiscal '
          TabOrder = 3
          object Label5: TLabel
            Left = 16
            Top = 107
            Width = 65
            Height = 13
            Caption = 'C'#243'digo Postal'
          end
          object txtDom_Dom: TLabeledEdit
            Left = 16
            Top = 80
            Width = 285
            Height = 21
            EditLabel.Width = 40
            EditLabel.Height = 13
            EditLabel.Caption = 'Domicilio'
            TabOrder = 0
            OnChange = txtDom_DomChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object cbxCod_Pobd: TComboBox
            Left = 16
            Top = 123
            Width = 87
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 1
            OnChange = cbxCod_PobdChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtTit_Pobd: TLabeledEdit
            Left = 109
            Top = 123
            Width = 192
            Height = 21
            EditLabel.Width = 45
            EditLabel.Height = 13
            EditLabel.Caption = 'Poblaci'#243'n'
            TabOrder = 2
            OnChange = txtTit_PobdChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtPro_Clid: TLabeledEdit
            Left = 109
            Top = 165
            Width = 192
            Height = 21
            Color = clInactiveCaption
            EditLabel.Width = 43
            EditLabel.Height = 13
            EditLabel.Caption = 'Provincia'
            Enabled = False
            TabOrder = 4
          end
          object txtTel_Dom: TLabeledEdit
            Left = 19
            Top = 207
            Width = 87
            Height = 21
            EditLabel.Width = 42
            EditLabel.Height = 13
            EditLabel.Caption = 'Tel'#233'fono'
            TabOrder = 3
            OnChange = txtTel_DomChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtCod_Prod: TLabeledEdit
            Left = 16
            Top = 165
            Width = 87
            Height = 21
            Color = clInactiveCaption
            EditLabel.Width = 79
            EditLabel.Height = 13
            EditLabel.Caption = 'C'#243'digo Provincia'
            Enabled = False
            TabOrder = 5
          end
        end
        object GroupBox4: TGroupBox
          Left = 688
          Top = 66
          Width = 324
          Height = 241
          Caption = ' Direcci'#243'n Postal '
          TabOrder = 4
          object Label8: TLabel
            Left = 16
            Top = 107
            Width = 65
            Height = 13
            Caption = 'C'#243'digo Postal'
          end
          object txtDom_Postal: TLabeledEdit
            Left = 16
            Top = 80
            Width = 285
            Height = 21
            EditLabel.Width = 72
            EditLabel.Height = 13
            EditLabel.Caption = 'Domicilio Postal'
            TabOrder = 1
            OnChange = txtDom_PostalChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtNom_Postal: TLabeledEdit
            Left = 16
            Top = 39
            Width = 285
            Height = 21
            EditLabel.Width = 69
            EditLabel.Height = 13
            EditLabel.Caption = 'Nombre Postal'
            TabOrder = 0
            OnChange = txtNom_PostalChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object cbxCp_Postal: TComboBox
            Left = 16
            Top = 123
            Width = 87
            Height = 21
            ItemHeight = 13
            TabOrder = 2
            OnChange = cbxCp_PostalChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtPob_Postal: TLabeledEdit
            Left = 109
            Top = 123
            Width = 192
            Height = 21
            EditLabel.Width = 77
            EditLabel.Height = 13
            EditLabel.Caption = 'Poblaci'#243'n Postal'
            TabOrder = 3
            OnChange = txtPob_PostalChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtPro_Postal: TLabeledEdit
            Left = 109
            Top = 165
            Width = 192
            Height = 21
            Color = clInactiveCaption
            EditLabel.Width = 43
            EditLabel.Height = 13
            EditLabel.Caption = 'Provincia'
            Enabled = False
            TabOrder = 5
          end
          object txtEmail: TLabeledEdit
            Left = 16
            Top = 207
            Width = 285
            Height = 21
            EditLabel.Width = 24
            EditLabel.Height = 13
            EditLabel.Caption = 'Email'
            TabOrder = 4
            OnChange = txtEmailChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtCod_ProP: TLabeledEdit
            Left = 16
            Top = 165
            Width = 87
            Height = 21
            Color = clInactiveCaption
            EditLabel.Width = 79
            EditLabel.Height = 13
            EditLabel.Caption = 'C'#243'digo Provincia'
            Enabled = False
            TabOrder = 6
          end
        end
        object GroupBox5: TGroupBox
          Left = 352
          Top = 313
          Width = 660
          Height = 195
          Caption = ' Tipo de contador y otros... '
          TabOrder = 5
          object Label7: TLabel
            Left = 16
            Top = 24
            Width = 105
            Height = 13
            Caption = 'Tipo de Suministro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label10: TLabel
            Left = 142
            Top = 24
            Width = 103
            Height = 13
            Caption = 'Consumo > 3.000 m3'
          end
          object Label11: TLabel
            Left = 255
            Top = 24
            Width = 48
            Height = 13
            Caption = 'Sin Efecto'
          end
          object Label12: TLabel
            Left = 81
            Top = 65
            Width = 25
            Height = 13
            Caption = 'Letra'
          end
          object Label13: TLabel
            Left = 202
            Top = 65
            Width = 75
            Height = 13
            Caption = 'Fecha Contrato'
          end
          object Label14: TLabel
            Left = 16
            Top = 108
            Width = 68
            Height = 13
            Caption = 'Tipo Contador'
          end
          object lblCod_Sit: TLabel
            Left = 16
            Top = 147
            Width = 52
            Height = 13
            Caption = 'Situaci'#243'n'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cbxDom_Ind: TComboBox
            Left = 16
            Top = 40
            Width = 120
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            OnChange = cbxDom_IndChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object cbxM3_Ano: TComboBox
            Left = 142
            Top = 40
            Width = 107
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 1
            OnChange = cbxM3_AnoChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object cbxSin_Efe: TComboBox
            Left = 255
            Top = 39
            Width = 48
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 2
            OnChange = cbxSin_EfeChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtCoe_Cor: TLabeledEdit
            Left = 16
            Top = 81
            Width = 59
            Height = 21
            EditLabel.Width = 54
            EditLabel.Height = 13
            EditLabel.Caption = 'Coeficiente'
            TabOrder = 3
            OnChange = txtCoe_CorChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyPress = OnEventKeyPressOnlyNumberAndDecimals
            OnKeyUp = OnEventKeyUp
          end
          object cbxLet_Cli: TComboBox
            Left = 81
            Top = 81
            Width = 40
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 4
            OnChange = cbxLet_CliChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtCon_Cli: TLabeledEdit
            Left = 127
            Top = 81
            Width = 69
            Height = 21
            EditLabel.Width = 43
            EditLabel.Height = 13
            EditLabel.Caption = 'Contrato'
            TabOrder = 5
            OnChange = txtCon_CliChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyPress = OnEventKeyPressOnlyNumber
            OnKeyUp = OnEventKeyUp
          end
          object mtxtFco_Cli: TMaskEdit
            Left = 202
            Top = 81
            Width = 101
            Height = 21
            EditMask = '!99/99/9999;1;_'
            MaxLength = 10
            TabOrder = 6
            Text = '  /  /    '
            OnEnter = OnEventEnter
            OnExit = mtxtFco_CliExit
            OnKeyUp = OnEventKeyUp
          end
          object cbxCod_Tip: TComboBox
            Left = 16
            Top = 124
            Width = 68
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 7
            OnChange = cbxCod_TipChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtCnt_Cli: TLabeledEdit
            Left = 90
            Top = 124
            Width = 115
            Height = 21
            EditLabel.Width = 45
            EditLabel.Height = 13
            EditLabel.Caption = 'Contador'
            TabOrder = 8
            OnChange = txtCnt_CliChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
          object txtImp_Cli: TLabeledEdit
            Left = 132
            Top = 163
            Width = 112
            Height = 21
            EditLabel.Width = 38
            EditLabel.Height = 13
            EditLabel.Caption = 'Importe'
            TabOrder = 10
            OnChange = txtImp_CliChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyPress = OnEventKeyPressOnlyNumberAndDecimals
            OnKeyUp = OnEventKeyUp
          end
          object txtIva_Cli: TLabeledEdit
            Left = 250
            Top = 163
            Width = 53
            Height = 21
            EditLabel.Width = 17
            EditLabel.Height = 13
            EditLabel.Caption = 'IVA'
            TabOrder = 11
            OnChange = txtIva_CliChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyPress = OnEventKeyPressOnlyNumber
            OnKeyUp = OnEventKeyUp
          end
          object GroupBox7: TGroupBox
            Left = 336
            Top = 15
            Width = 322
            Height = 178
            Align = alRight
            Caption = ' Lectura Contador '
            TabOrder = 12
            object Label15: TLabel
              Left = 172
              Top = 47
              Width = 98
              Height = 13
              Caption = 'Fecha Lect. Anterior'
            end
            object Label16: TLabel
              Left = 172
              Top = 89
              Width = 89
              Height = 13
              Caption = 'Fecha Lect. Actual'
            end
            object txtLan_Cli: TLabeledEdit
              Left = 60
              Top = 63
              Width = 96
              Height = 21
              EditLabel.Width = 78
              EditLabel.Height = 13
              EditLabel.Caption = 'Lectura Anterior'
              TabOrder = 0
              OnChange = txtLan_CliChange
              OnEnter = OnEventEnter
              OnExit = OnEventExit
              OnKeyPress = OnEventKeyPressOnlyNumber
              OnKeyUp = OnEventKeyUp
            end
            object txtLac_Cli: TLabeledEdit
              Left = 60
              Top = 105
              Width = 96
              Height = 21
              EditLabel.Width = 69
              EditLabel.Height = 13
              EditLabel.Caption = 'Lectura Actual'
              TabOrder = 2
              OnChange = txtLac_CliChange
              OnEnter = OnEventEnter
              OnExit = OnEventExit
              OnKeyPress = OnEventKeyPressOnlyNumber
              OnKeyUp = OnEventKeyUp
            end
            object mtxtFan_Cli: TMaskEdit
              Left = 172
              Top = 63
              Width = 98
              Height = 21
              EditMask = '!99/99/9999;1;_'
              MaxLength = 10
              TabOrder = 1
              Text = '  /  /    '
              OnEnter = OnEventEnter
              OnExit = mtxtFan_CliExit
              OnKeyUp = OnEventKeyUp
            end
            object mtxtFac_Cli: TMaskEdit
              Left = 172
              Top = 105
              Width = 100
              Height = 21
              EditMask = '!99/99/9999;1;_'
              MaxLength = 10
              TabOrder = 3
              Text = '  /  /    '
              OnEnter = OnEventEnter
              OnExit = mtxtFac_CliExit
              OnKeyUp = OnEventKeyUp
            end
          end
          object cbxCod_Sit: TComboBox
            Left = 16
            Top = 163
            Width = 110
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 9
            OnChange = cbxCod_SitChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyUp = OnEventKeyUp
          end
        end
        object GroupBox6: TGroupBox
          Left = 16
          Top = 313
          Width = 324
          Height = 195
          Caption = ' Datos bancarios '
          TabOrder = 6
          object txtBan_Cli: TLabeledEdit
            Left = 15
            Top = 30
            Width = 295
            Height = 21
            Color = clInactiveCaption
            EditLabel.Width = 86
            EditLabel.Height = 13
            EditLabel.Caption = 'Nombre del Banco'
            Enabled = False
            TabOrder = 0
          end
          object txtCod_Bic: TLabeledEdit
            Left = 15
            Top = 111
            Width = 88
            Height = 21
            Color = clInactiveCaption
            EditLabel.Width = 53
            EditLabel.Height = 13
            EditLabel.Caption = 'SWIFT/BIC'
            Enabled = False
            TabOrder = 1
          end
          object txtCod_Iban: TLabeledEdit
            Left = 261
            Top = 111
            Width = 49
            Height = 21
            Color = clInactiveCaption
            EditLabel.Width = 24
            EditLabel.Height = 13
            EditLabel.Caption = 'IBAN'
            Enabled = False
            TabOrder = 2
          end
          object txtCod_Ban: TLabeledEdit
            Left = 15
            Top = 156
            Width = 40
            Height = 21
            EditLabel.Width = 36
            EditLabel.Height = 13
            EditLabel.Caption = 'Entidad'
            TabOrder = 3
            OnChange = txtCod_BanChange
            OnEnter = OnEventEnter
            OnExit = txtCod_BanExit
            OnKeyPress = OnEventKeyPressOnlyNumber
            OnKeyUp = OnEventKeyUp
          end
          object txtCod_Suc: TLabeledEdit
            Left = 82
            Top = 156
            Width = 40
            Height = 21
            EditLabel.Width = 33
            EditLabel.Height = 13
            EditLabel.Caption = 'Oficina'
            TabOrder = 4
            OnChange = txtCod_SucChange
            OnEnter = OnEventEnter
            OnKeyPress = OnEventKeyPressOnlyNumber
            OnKeyUp = OnEventKeyUp
          end
          object txtDig_Con: TLabeledEdit
            Left = 149
            Top = 156
            Width = 40
            Height = 21
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'D.C.'
            TabOrder = 5
            OnChange = txtDig_ConChange
            OnEnter = OnEventEnter
            OnExit = OnEventExit
            OnKeyPress = OnEventKeyPressOnlyNumber
            OnKeyUp = OnEventKeyUp
          end
          object txtCta_Cli: TLabeledEdit
            Left = 216
            Top = 156
            Width = 94
            Height = 21
            EditLabel.Width = 90
            EditLabel.Height = 13
            EditLabel.Caption = 'N'#250'mero de Cuenta'
            TabOrder = 6
            OnChange = txtCta_CliChange
            OnEnter = OnEventEnter
            OnExit = txtCta_CliExit
            OnKeyPress = OnEventKeyPressOnlyNumber
            OnKeyUp = OnEventKeyUp
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Observaciones'
      ImageIndex = 1
      object DBGridObservaciones: TDBGrid
        Left = 0
        Top = 41
        Width = 1022
        Height = 461
        Align = alClient
        DataSource = MBaseDatos.DSObservaciones
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'contador'
            Title.Caption = 'Contador'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'fecha'
            Title.Caption = 'Fecha'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'observacion'
            Width = 400
            Visible = True
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1022
        Height = 41
        Align = alTop
        TabOrder = 1
        object btAdd: TButton
          Left = 7
          Top = 4
          Width = 159
          Height = 25
          Caption = 'A'#241'adir observaci'#243'n'
          TabOrder = 0
          OnClick = btAddClick
        end
        object btDelete: TButton
          Left = 172
          Top = 4
          Width = 183
          Height = 25
          Caption = 'Borrar observaci'#243'n'
          TabOrder = 1
          OnClick = btDeleteClick
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Images = MBaseDatos.imgEnabledx32
    OnChange = MainMenu1Change
    Left = 189
    Top = 3
    object Fichero1: TMenuItem
      Caption = 'Fichero'
      object GuardarySalir1: TMenuItem
        Caption = 'Guardar y Salir'
        Hint = 'Guardar y Salir'
        ImageIndex = 8
        ShortCut = 112
        OnClick = GuardarySalir1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Salir1: TMenuItem
        Caption = 'Salir'
        Hint = 'Salir'
        ImageIndex = 7
        ShortCut = 27
        OnClick = Salir1Click
      end
    end
  end
end
