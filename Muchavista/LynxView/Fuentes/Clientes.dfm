object frmClientes: TfrmClientes
  Left = 244
  Top = 0
  ActiveControl = dbgGrid
  Caption = 'Mantenimiento de Clientes'
  ClientHeight = 492
  ClientWidth = 1370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1370
    Height = 38
    AutoSize = True
    ButtonHeight = 38
    ButtonWidth = 39
    Caption = 'ToolBar1'
    DisabledImages = MBaseDatos.imgDisabledx32
    Images = MBaseDatos.imgEnabledx32
    TabOrder = 0
    object tbtnAdd: TToolButton
      Left = 0
      Top = 0
      Hint = 'A'#241'adir'
      Caption = 'A'#241'adir'
      ImageIndex = 0
      MenuItem = Anadir1
      ParentShowHint = False
      ShowHint = True
    end
    object tbtnModify: TToolButton
      Left = 39
      Top = 0
      Hint = 'Modificar'
      Caption = 'Modfiicar'
      ImageIndex = 1
      MenuItem = Modificar1
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton3: TToolButton
      Left = 78
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object tbtnDelete: TToolButton
      Left = 86
      Top = 0
      Hint = 'Eliminar'
      Caption = 'Eliminar'
      ImageIndex = 2
      MenuItem = Eliminar1
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton5: TToolButton
      Left = 125
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object tbtnUpdate: TToolButton
      Left = 133
      Top = 0
      Hint = 'Actualizar'
      Caption = 'Actualizar'
      ImageIndex = 4
      MenuItem = Actualizar1
      ParentShowHint = False
      ShowHint = True
    end
    object tbtnViewPrinter: TToolButton
      Left = 172
      Top = 0
      Hint = 'Vista Previa de Impresi'#243'n'
      Caption = 'Vista Previa de Impresi'#243'n'
      ImageIndex = 5
      MenuItem = VistaPreviadeImpresion1
      ParentShowHint = False
      ShowHint = True
    end
    object tbtnPrinter: TToolButton
      Left = 211
      Top = 0
      Hint = 'Imprimir'
      Caption = 'Imprimir'
      ImageIndex = 6
      MenuItem = Imprimir1
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton10: TToolButton
      Left = 250
      Top = 0
      Width = 8
      Caption = 'ToolButton10'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object tbtnExit: TToolButton
      Left = 258
      Top = 0
      Hint = 'Salir'
      Caption = 'Salir'
      ImageIndex = 7
      MenuItem = Salir1
      ParentShowHint = False
      ShowHint = True
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 38
    Width = 1370
    Height = 41
    Align = alTop
    Caption = 'Mantenimiento de Clientes - [ EMPRESA ]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 79
    Width = 1370
    Height = 141
    Align = alTop
    Caption = 
      'Filtro de b'#250'squeda por:  (C'#243'digo zona, C'#243'digo cliente, Nombre de' +
      'l cliente, Direcci'#243'n del cliente, NIF o Fragmentos pulsando un e' +
      'spacio al principio'
    TabOrder = 2
    object Label1: TLabel
      Left = 21
      Top = 77
      Width = 68
      Height = 13
      Caption = 'Base de datos'
    end
    object Label2: TLabel
      Left = 250
      Top = 77
      Width = 62
      Height = 13
      Caption = 'Tipo de Zona'
    end
    object Label3: TLabel
      Left = 401
      Top = 77
      Width = 72
      Height = 13
      Caption = 'Tipo Suministro'
    end
    object Label4: TLabel
      Left = 552
      Top = 77
      Width = 43
      Height = 13
      Caption = 'Situaci'#243'n'
    end
    object txtBuscar: TLabeledEdit
      Left = 21
      Top = 39
      Width = 358
      Height = 21
      EditLabel.Width = 97
      EditLabel.Height = 13
      EditLabel.Caption = 'Patr'#243'n de b'#250'squeda'
      TabOrder = 0
      OnChange = txtBuscarChange
      OnEnter = OnEventEnter
      OnExit = OnEventExit
      OnKeyUp = OnEventKeyUp
    end
    object cbxBaseDatos: TComboBox
      Left = 21
      Top = 96
      Width = 223
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = cbxBaseDatosChange
      OnEnter = OnEventEnter
      OnExit = OnEventExit
      OnKeyUp = OnEventKeyUp
    end
    object cbxTiposZonas: TComboBox
      Left = 250
      Top = 96
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = cbxTiposZonasChange
      OnEnter = OnEventEnter
      OnExit = OnEventExit
      OnKeyUp = OnEventKeyUp
    end
    object cbxTiposSuministros: TComboBox
      Left = 401
      Top = 96
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = cbxTiposSuministrosChange
      OnEnter = OnEventEnter
      OnExit = OnEventExit
      OnKeyUp = OnEventKeyUp
    end
    object cbxSituacion: TComboBox
      Left = 552
      Top = 96
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      OnChange = cbxSituacionChange
      OnEnter = OnEventEnter
      OnExit = OnEventExit
      OnKeyUp = OnEventKeyUp
    end
    object rgEfecto: TRadioGroup
      Left = 726
      Top = 12
      Width = 115
      Height = 123
      Caption = 'Sin Efecto'
      ItemIndex = 2
      Items.Strings = (
        'Todos'
        'Si'
        'No')
      TabOrder = 5
      OnClick = rgEfectoClick
    end
    object rgTipoCliente: TRadioGroup
      Left = 847
      Top = 12
      Width = 106
      Height = 123
      Caption = 'Tipo de cliente'
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'F'#237'sico'
        'Jur'#237'dico')
      TabOrder = 6
      OnClick = rgTipoClienteClick
    end
  end
  object gbxResultadosBusqueda: TGroupBox
    Left = 0
    Top = 220
    Width = 1370
    Height = 272
    Align = alClient
    Caption = ' Resultado de b'#250'squeda  [] '
    TabOrder = 3
    object dbgGrid: TDBGrid
      Left = 2
      Top = 15
      Width = 1366
      Height = 255
      Align = alClient
      DataSource = MBaseDatos.DSDatabase
      Options = [dgTitles, dgIndicator, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = dbgGridDrawColumnCell
      OnDblClick = OnEventDblClickGrid
      OnEnter = OnEventEnter
      OnExit = OnEventExit
      OnKeyPress = OnEventKeyPressGrid
      OnKeyUp = OnEventKeyUp
      OnTitleClick = dbgGridTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'cod_zon'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo Zona'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cod_cli'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo Cliente'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tit_cli'
          Title.Alignment = taCenter
          Title.Caption = 'T'#237'tulo / Cliente'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dom_cli'
          Title.Alignment = taCenter
          Title.Caption = 'Domicilio Cliente'
          Width = 200
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'cod_pob'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo Postal'
          Width = 75
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'jof_cli'
          Title.Alignment = taCenter
          Title.Caption = 'J/F'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nif_cli'
          Title.Alignment = taCenter
          Title.Caption = 'NIF'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tel_cli'
          Title.Alignment = taCenter
          Title.Caption = 'Tel'#233'fono'
          Width = 100
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'email'
          Title.Alignment = taCenter
          Title.Caption = 'Email'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'con_cli'
          Title.Alignment = taCenter
          Title.Caption = 'Contrato'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fco_cli'
          Title.Alignment = taCenter
          Title.Caption = 'F. Contrato'
          Width = 65
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'cod_tip'
          Title.Alignment = taCenter
          Title.Caption = 'Tipo'
          Visible = False
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'cnt_cli'
          Title.Alignment = taCenter
          Title.Caption = 'Contador'
          Width = 92
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'dom_ind'
          Title.Alignment = taCenter
          Title.Caption = 'T. Sum.'
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'imp_cli'
          Title.Alignment = taCenter
          Title.Caption = 'Importe '#8364
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lan_cli'
          Title.Alignment = taCenter
          Title.Caption = 'Lectura Ant.'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lac_cli'
          Title.Alignment = taCenter
          Title.Caption = 'Lectura Act.'
          Width = 65
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'fan_cli'
          Title.Alignment = taCenter
          Title.Caption = 'F. Lec. Ant.'
          Width = 65
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'fac_cli'
          Title.Alignment = taCenter
          Title.Caption = 'F. Lec. Act.'
          Width = 65
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'cod_sit'
          Title.Alignment = taCenter
          Title.Caption = 'Situaci'#243'n'
          Width = 65
          Visible = True
        end>
    end
  end
  object MainMenu1: TMainMenu
    OnChange = MainMenu1Change
    Left = 423
    object Fichero1: TMenuItem
      Caption = 'Fichero'
      object Anadir1: TMenuItem
        Caption = 'A'#241'adir'
        Hint = 'A'#241'adir'
        ImageIndex = 0
        ShortCut = 45
        OnClick = Anadir1Click
      end
      object Modificar1: TMenuItem
        Caption = 'Modfiicar'
        Hint = 'Modificar'
        ImageIndex = 1
        ShortCut = 113
        OnClick = Modificar1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Eliminar1: TMenuItem
        Caption = 'Eliminar'
        Hint = 'Eliminar'
        ImageIndex = 2
        OnClick = Eliminar1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Buscar1: TMenuItem
        Caption = 'Buscar'
        Hint = 'Buscar'
        ImageIndex = 3
        ShortCut = 114
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Actualizar1: TMenuItem
        Caption = 'Actualizar'
        Hint = 'Actualizar'
        ImageIndex = 4
        ShortCut = 116
        OnClick = Actualizar1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Seleccionar1: TMenuItem
        Caption = 'Seleccionar'
        OnClick = Seleccionar1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object VistaPreviadeImpresion1: TMenuItem
        Caption = 'Vista Previa de Impresi'#243'n'
        Hint = 'Vista Previa de Impresi'#243'n'
        ImageIndex = 5
        ShortCut = 16464
        OnClick = VistaPreviadeImpresion1Click
      end
      object Imprimir1: TMenuItem
        Caption = 'Imprimir'
        Hint = 'Imprimir'
        ImageIndex = 6
        ShortCut = 16457
        OnClick = Imprimir1Click
      end
      object N5: TMenuItem
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
