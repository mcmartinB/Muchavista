unit Clientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, Grids, DB, DBTables, DBGrids, StdCtrls, ExtCtrls,

  Busqueda,
  FormularioBase,
  ClasesCliente
  ;

type
  TfrmClientes = class(TfrmFormBase)
    MainMenu1: TMainMenu;
    Fichero1: TMenuItem;
    Anadir1: TMenuItem;
    Modificar1: TMenuItem;
    N1: TMenuItem;
    Eliminar1: TMenuItem;
    N2: TMenuItem;
    Buscar1: TMenuItem;
    N3: TMenuItem;
    Actualizar1: TMenuItem;
    N4: TMenuItem;
    VistaPreviadeImpresion1: TMenuItem;
    Imprimir1: TMenuItem;
    N5: TMenuItem;
    Salir1: TMenuItem;
    ToolBar1: TToolBar;
    tbtnAdd: TToolButton;
    tbtnModify: TToolButton;
    ToolButton3: TToolButton;
    tbtnDelete: TToolButton;
    ToolButton5: TToolButton;
    tbtnUpdate: TToolButton;
    tbtnViewPrinter: TToolButton;
    tbtnPrinter: TToolButton;
    ToolButton10: TToolButton;
    tbtnExit: TToolButton;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    txtBuscar: TLabeledEdit;
    cbxBaseDatos: TComboBox;
    Label1: TLabel;
    cbxTiposZonas: TComboBox;
    Label2: TLabel;
    gbxResultadosBusqueda: TGroupBox;
    dbgGrid: TDBGrid;
    N6: TMenuItem;
    Seleccionar1: TMenuItem;
    cbxTiposSuministros: TComboBox;
    Label3: TLabel;
    cbxSituacion: TComboBox;
    Label4: TLabel;
    rgEfecto: TRadioGroup;
    rgTipoCliente: TRadioGroup;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure MainMenu1Change(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
    procedure Anadir1Click(Sender: TObject);
    procedure Modificar1Click(Sender: TObject);
    procedure Eliminar1Click(Sender: TObject);
    procedure Actualizar1Click(Sender: TObject);
    procedure VistaPreviadeImpresion1Click(Sender: TObject);
    procedure Imprimir1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);

    procedure cbxBaseDatosChange(Sender: TObject);

    procedure dbgGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgGridTitleClick(Column: TColumn);
    procedure Seleccionar1Click(Sender: TObject);
    procedure txtBuscarChange(Sender: TObject);
    procedure cbxTiposZonasChange(Sender: TObject);
    procedure cbxTiposSuministrosChange(Sender: TObject);
    procedure cbxSituacionChange(Sender: TObject);
    procedure gbxSinEfectoClick(Sender: TObject);
    procedure gbxTipoClienteClick(Sender: TObject);
    procedure rbtnSinEfectoSiClick(Sender: TObject);
    procedure rgEfectoClick(Sender: TObject);
    procedure rgTipoClienteClick(Sender: TObject);
  private
    { Private declarations }
    objSQLInitDB: TStrings;
    objSQLWhere: TStrings;
    objSQLWhereAnd: TStrings;
    objBusqueda: TBusqueda;

    function GetCod_Zon: SmallInt;
    function GetCod_Cli: Integer;

    procedure UpdateGrid;
    procedure CheckAllButtonsApplication;
  public
    { Public declarations }
    function SeleccionarCliente: TCliente;
    procedure Buscar(pTextoBusqueda: string);
  end;

var
  frmClientes: TfrmClientes;

implementation

uses
  BaseDatos,
  ClasesOtras,
  AplicacionConstantes,
  AplicacionProcedimientosFunciones,
  ClienteAnadirModificar;

{$R *.dfm}

procedure TfrmClientes.FormCreate(Sender: TObject);
var
  ItemsDatabase: TStrings;
begin
  MBaseDatos := TMBaseDatos.Create(Self);

  objSQLInitDB := TStringList.Create;

  with objSQLInitDB do
  begin
    Add('SELECT ');
    Add(' C.COD_ZON AS COD_ZON,');
    Add(' C.COD_CLI AS COD_CLI,');
    Add(' C.TIT_CLI AS TIT_CLI,');
    Add(' C.DOM_CLI AS DOM_CLI,');
    Add(' C.COD_POB AS COD_POB,');
    Add(' C.JOF_CLI AS JOF_CLI,');
    Add(' C.NIF_CLI AS NIF,');
    Add(' C.TEL_CLI AS TEL_CLI,');
    Add(' D.EMAIL AS EMAIL,');
    Add(' C.CON_CLI AS CON_CLI,');
    Add(' C.FCO_CLI AS FCO_CLI,');
    Add(' C.COD_TIP AS COD_TIP,');
    Add(' C.CNT_CLI AS CNT_CLI,');
    Add(' C.DOM_IND AS DOM_IND,');
    Add(' C.IMP_CLI AS IMP_CLI,');
    Add(' C.LAN_CLI AS LAN_CLI,');
    Add(' C.FAN_CLI AS FAN_CLI,');
    Add(' C.LAC_CLI AS LAC_CLI,');
    Add(' C.FAC_CLI AS FAC_CLI,');
    Add(' C.COD_SIT AS COD_SIT');
    Add(' FROM Clientes C');
    Add(' LEFT JOIN  Domicilios D');
    Add(' ON C.COD_ZON = D.COD_ZON AND C.COD_CLI = D.COD_CLI ');
  end;

  objSQLWhere := TStringList.Create;
  objSQLWhereAnd := TStringList.Create;
  objBusqueda := TBusqueda.Create;

  ItemsDatabase := MBaseDatos.GetAllDatabasesToStringList;
  cbxBaseDatos.Items.Assign(ItemsDatabase);
  cbxBaseDatos.ItemIndex := 0;
  FreeAndNil(ItemsDatabase);

  // Evitamos carga al iniciar la aplicación
  // cbxBaseDatos.OnChange(self);

end;

procedure TfrmClientes.FormDestroy(Sender: TObject);
begin
  if MBaseDatos.BaseDatos <> nil then
    MBaseDatos.BaseDatos.Connected := False;

  with TEnumItem(nil) do
  begin
    SetEnumItemFreeAndNil(cbxBaseDatos);
    SetEnumItemFreeAndNil(cbxTiposZonas);
    SetEnumItemFreeAndNil(cbxTiposSuministros);
    SetEnumItemFreeAndNil(cbxSituacion);
  end;

  FreeAndNil(objSQLInitDB);
  FreeAndNil(objSQLWhere);
  FreeAndNil(objSQLWhereAnd);
  FreeAndNil(objBusqueda);

  MBaseDatos.Free;
end;

procedure TfrmClientes.gbxSinEfectoClick(Sender: TObject);
begin
  inherited;
  Buscar(txtBuscar.Text);
end;

procedure TfrmClientes.gbxTipoClienteClick(Sender: TObject);
begin
  inherited;
  Buscar(txtBuscar.Text);
end;

procedure TfrmClientes.MainMenu1Change(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
begin
  tbtnAdd.Enabled               := Anadir1.Enabled;
  tbtnModify.Enabled            := Modificar1.Enabled;
  tbtnDelete.Enabled            := Eliminar1.Enabled;
  tbtnUpdate.Enabled            := Actualizar1.Enabled;
  tbtnViewPrinter.Enabled       := Vistapreviadeimpresion1.Enabled;
  tbtnPrinter.Enabled           := Imprimir1.Enabled;
  tbtnExit.Enabled              := Salir1.Enabled;
end;

procedure TfrmClientes.Anadir1Click(Sender: TObject);
var
  ObjCliente: TCliente;
begin
  objCliente := TCliente.Create(MBaseDatos.BaseDatos);

  with TfrmClienteAnadirModificar.Create(Self) do
  begin
    AnadirCliente(ObjCliente);
    Free;
  end;

  UpdateGrid;

  FreeAndNil(ObjCliente);
end;

procedure TfrmClientes.Modificar1Click(Sender: TObject);
var
  objCliente: TCliente;
begin
  objCliente := TCliente.Create(MBaseDatos.BaseDatos);
    objCliente.Cod_Zon := GetCod_Zon;
    objCliente.Cod_Cli := GetCod_Cli;

  with TfrmClienteAnadirModificar.Create(Self) do
  begin
    ModificarCliente(ObjCliente);
    Free;
  end;

  UpdateGrid;

  FreeAndNil(ObjCliente);
end;

procedure TfrmClientes.rbtnSinEfectoSiClick(Sender: TObject);
begin
  inherited;
  Buscar(txtBuscar.Text);
end;

procedure TfrmClientes.rgEfectoClick(Sender: TObject);
begin
  inherited;
  Buscar(txtBuscar.Text);
end;

procedure TfrmClientes.rgTipoClienteClick(Sender: TObject);
begin
  inherited;
  Buscar(txtBuscar.Text);
end;

procedure TfrmClientes.Eliminar1Click(Sender: TObject);
var
  objCliente: TCliente;
  TextMsg: Array[0..3] of String;
  wResult: Word;
begin
  objCliente := TCliente.Create(MBaseDatos.BaseDatos);
    objCliente.Cod_Zon := GetCod_Zon;
    objCliente.Cod_Cli := GetCod_Cli;

  TextMsg[0] := 'Información' + CR_LF +
    '__________________________________________________' + DCR_LF +
    '[Código de Zona: %d, Código Cliente: %d, Cliente: %s]' + DCR_LF +
    'Ha seleccionado borrar este Cliente, ¿Está seguro?';

  TextMsg[1] := 'Confirmación' + CR_LF +
    '__________________________________________________' + DCR_LF +
    '[Código de Zona: %d, Código Cliente: %d, Cliente: %s]' + DCR_LF +
    'Borrar el Cliente, ¿Está seguro?';

  TextMsg[2] := 'Atención' + CR_LF +
    '__________________________________________________' + DCR_LF +
    '[Código de Zona: %d, Código Cliente: %d, Cliente: %s]' + DCR_LF +
    'Recuperar este Cliente, ¿Está seguro?';

  TextMsg[3] := 'Atención' + CR_LF +
    '__________________________________________________' + DCR_LF +
    '[Código de Zona: %d, Código Cliente: %d, Cliente: %s, Importe Deuda: %s]' + DCR_LF +
    'No se puede borrar este Cliente por tener una deuda, ' + CR_LF +
    'liquide la deuda y podrá borrarlo.';

  if objCliente.Cod_Sit = 'B' then
  begin
    wResult := MessageDlg(Format(TextMsg[2],[objCliente.Cod_Zon, objCliente.Cod_Cli, objCliente.Tit_Cli]), mtInformation, [mbNo, mbYes], 0);

    if (wResult = mrYes) then
      objCliente.Delete;
  end
  else begin
    wResult := MessageDlg(Format(TextMsg[0], [objCliente.Cod_Zon, objCliente.Cod_Cli, objCliente.Tit_Cli]), mtConfirmation, [mbNo, mbYes], 0);

    if wResult = mrYes then
    begin
      wResult := MessageDlg(Format(TextMsg[1], [objCliente.Cod_Zon, objCliente.Cod_Cli, objCliente.Tit_Cli]), mtWarning, [mbNo, mbYes], 0);

      if wResult = mrYes then
        objCliente.Delete;
    end;
  end;

  FreeAndNil(objCliente);

  UpdateGrid;
end;

procedure TfrmClientes.Buscar( pTextoBusqueda: string);
var
  numeroBusqueda: Integer;
  textoBusqueda: string;
  contadorLineas: Integer;
  itemZonas: TEnumItem;
begin
  if MBaseDatos.BaseDatos = nil then
    exit;
  textoBusqueda := UpperCase(pTextoBusqueda);
  objSQLWhere.Clear;

  if Length(textoBusqueda) > 0 then
    begin

    // Búsqueda por código de cliente
    if TryStrToInt(textoBusqueda, numeroBusqueda) then
      objSQLWhere.Add('TO_CHAR(C.COD_CLI)LIKE ''%' + IntToStr(numeroBusqueda) + '%''');

    // Busqueda por nombre de cliente
    objSQLWhere.Add('UPPER(C.TIT_CLI) LIKE ''%'+textoBusqueda+'%''');

    // Búsqueda por domicilio de cliente
    objSQLWhere.Add('UPPER(C.DOM_CLI) LIKE ''%'+textoBusqueda+'%''');

    // Búsqueda por NIF
    if TryStrToInt(textoBusqueda, numeroBusqueda) then
      objSQLWhere.Add('C.NIF_CLI LIKE ''%' + IntToStr(numeroBusqueda) + '%''');

    // Búsqueda por número de contador
    if TryStrToInt(textoBusqueda, numeroBusqueda) then
      objSQLWhere.Add('UPPER(C.CNT_CLI) LIKE ''%' + IntToStr(numeroBusqueda) + '%''');

    // Búsqueda por cuenta bancaria
    if TryStrToInt(textoBusqueda, numeroBusqueda) then
      objSQLWhere.Add('UPPER(C.CTA_CLI) LIKE ''%' + IntToStr(numeroBusqueda) + '%''');

    // Recorremos objSQLWhere añadiendo OR
    for contadorLineas:= 1 to objSQLWhere.Count - 1 do
      begin
      objSQLWhere[contadorLineas] := ' OR ' + objSQLWhere[contadorLineas];
      end;

  end;

  objSQLWhereAnd.Clear;
  // Tipo zona
  itemZonas := TEnumItem(TStringList(cbxTiposZonas.items).Objects[cbxTiposZonas.ItemIndex]);
  if (cbxTiposZonas.ItemIndex = 0) then
     objSQLWhereAnd.Add('C.COD_ZON >= 5 AND C.COD_ZON <=7')
  else
    if itemZonas.IDFieldValue <> 100 then
      objSQLWhereAnd.Add('C.COD_ZON = ' + IntToStr(TEnumItem(nil).GetEnumItem(cbxTiposZonas).IDFieldValue));

  // Tipos suministros
  if (cbxTiposSuministros.ItemIndex > 0) then
     objSQLWhereAnd.Add('C.DOM_IND = ' + QuotedStr(TEnumItem(nil).GetEnumItem(cbxTiposSuministros).IDFieldValue2));

  // Tipo situación
  if (cbxSituacion.ItemIndex > 0) then
    objSQLWhereAnd.Add('C.COD_SIT = ' + QuotedStr(TEnumItem(nil).GetEnumItem(cbxSituacion).IDFieldValue2));

  // Sin efecto
  if (rgEfecto.ItemIndex > 0) then
    if rgEfecto.ItemIndex = 1 then
     objSQLWhereAnd.Add('C.SIN_EFE = ''S''')
    else
     objSQLWhereAnd.Add('C.SIN_EFE = ''N''');

  // Tipo cliente
  if (rgTipoCliente.ItemIndex > 0) then
    if rgTipoCliente.ItemIndex = 1 then
      objSQLWhereAnd.Add('C.JOF_CLI = ''F''')
    else
      objSQLWhereAnd.Add('C.JOF_CLI = ''J''');

  // Recorremos objSQLWhereAnd añadiendo AND
  if objSQLWhereAnd.Count >= 2 then
    for contadorLineas:= 1 to objSQLWhereAnd.Count - 1 do
      begin
      objSQLWhereAnd[contadorLineas] := ' AND ' + objSQLWhereAnd[contadorLineas];
      end;

  if Trim(objSQLWhere.Text) <> '' then
    if Trim(objSQLWhereAnd.Text) <> '' then
     objSQLWhere.Text := 'WHERE (' + objSQLWhereAnd.Text + ') AND (' + objSQLWhere.Text + ')'
    else
      objSQLWhere.Text := 'WHERE (' + objSQLWhere.Text + ')'
  else
    if Trim(objSQLWhereAnd.Text) <> '' then
      objSQLWhere.Text := 'WHERE ' + objSQLWhereAnd.Text;

  UpdateGrid;
  CheckAllButtonsApplication;
end;

procedure TfrmClientes.Actualizar1Click(Sender: TObject);
begin
  UpdateGrid;
end;

procedure TfrmClientes.VistaPreviadeImpresion1Click(Sender: TObject);
begin
//
end;

procedure TfrmClientes.Imprimir1Click(Sender: TObject);
begin
//
end;

procedure TfrmClientes.Salir1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmClientes.cbxBaseDatosChange(Sender: TObject);
var
  ItemsTmp: TStringList;
begin
 MBaseDatos.BaseDatos := TDatabase(TEnumItem(nil).GetEnumItem(cbxBaseDatos).FieldObject);
 with TEnumItem(nil) do
  begin
    SetEnumItemFreeAndNil(cbxTiposZonas);
    SetEnumItemFreeAndNil(cbxTiposSuministros);
    SetEnumItemFreeAndNil(cbxSituacion);
  end;

  with cbxTiposZonas do
    with TEnumTiposZonas.Create(MBaseDatos.BaseDatos) do
    begin
      ItemsTmp := GetTiposZonasToListString;
      Items.Assign(ItemsTmp);
      if (MBaseDatos.BaseDatos.DatabaseName = 'muchavista') then
        ItemIndex := 0
      else
        ItemIndex := 1;
      FreeAndNil(ItemsTmp);
      Free;
    end;

  with cbxTiposSuministros do
    with TEnumTiposSuministros.Create do
    begin
      ItemsTmp := GetTiposSuministrosToListString;
      Items.Assign(ItemsTmp);
      ItemIndex := 0;
      FreeAndNil(ItemsTmp);
      Free;
    end;

  with cbxSituacion do
    with TEnumSituacion.Create(MBaseDatos.BaseDatos) do
    begin
      ItemsTmp := GetSituacionToListString;
      Items.Assign(ItemsTmp);
      ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxSituacion, 'A').FieldItemIndex;
      FreeAndNil(ItemsTmp);
      Free;
    end;

  Panel1.Caption := Format('Mantenimiento de Clientes - [ %s ]', [cbxBaseDatos.Text]);
  
  CheckAllButtonsApplication;
  Buscar(txtBuscar.Text);
end;

procedure TfrmClientes.cbxSituacionChange(Sender: TObject);
begin
  inherited;
  Buscar(txtBuscar.Text);
end;

procedure TfrmClientes.cbxTiposSuministrosChange(Sender: TObject);
begin
  inherited;
  Buscar(txtBuscar.Text);
end;

procedure TfrmClientes.cbxTiposZonasChange(Sender: TObject);
begin
  inherited;
  Buscar(txtBuscar.Text);
end;

procedure TfrmClientes.dbgGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  DS: TDataSet;
begin
  DS := (Sender as TDBGrid).DataSource.DataSet;

  with (Sender as TDBGrid) do
  begin
    Canvas.Font.Color := COLOR_DBGRID_LETTER_DEFAULT;
    Canvas.Font.Style := Canvas.Font.Style - [fsStrikeOut];

    if (UpperCase(Column.FieldName) = 'COD_ZON') then
      (DS.FieldByName('COD_ZON') as TNumericField).DisplayFormat := ',0';

    if (UpperCase(Column.FieldName) = 'COD_CLI') then
      (DS.FieldByName('COD_CLI') as TNumericField).DisplayFormat := ',0';

    if (UpperCase(Column.FieldName) = 'CON_CLI') then
      (DS.FieldByName('CON_CLI') as TNumericField).DisplayFormat := ',0';

    if (UpperCase(Column.FieldName) = 'FAN_CLI') then
      (DS.FieldByName('FCO_CLI') as TDateTimeField).DisplayFormat := 'dd/mm/yyyy';

    if (UpperCase(Column.FieldName) = 'IMP_CLI') then
      (DS.FieldByName('IMP_CLI') as TNumericField).DisplayFormat := ',0.00';

    if (UpperCase(Column.FieldName) = 'LAN_CLI') then
      (DS.FieldByName('LAN_CLI') as TNumericField).DisplayFormat := ',0';

    if (UpperCase(Column.FieldName) = 'FAN_CLI') then
      (DS.FieldByName('FAN_CLI') as TDateTimeField).DisplayFormat := 'dd/mm/yyyy';

    if (UpperCase(Column.FieldName) = 'LAC_CLI') then
      (DS.FieldByName('LAC_CLI') as TNumericField).DisplayFormat := ',0';

    if (UpperCase(Column.FieldName) = 'FAC_CLI') then
      (DS.FieldByName('FAC_CLI') as TDateTimeField).DisplayFormat := 'dd/mm/yyyy';

    if (DS.FieldByName('COD_SIT').AsString = 'B') then
    begin
      Canvas.Font.Color := COLOR_DBGRID_LETTER_DELETED;
      Canvas.Font.Style := Canvas.Font.Style + [fsStrikeOut];
    end;
    
    if (gdSelected in State) then
      begin
      Canvas.Font.Color := COLOR_DBGRID_LETTER_SELECTED;
      Canvas.Brush.Color := COLOR_EDIT_BACKGROUND_SELECTED;
      Canvas.FillRect(Rect);
      end;


    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TfrmClientes.dbgGridTitleClick(Column: TColumn);
var
  ordenCampo: TOrden;
begin
  inherited;
  
  ordenCampo := objBusqueda.devuelveOrdenCampo(Column.FieldName);
  if ordenCampo = SinEspecificar then
    begin
    objBusqueda.estableceOrden(Column.FieldName, Ascendente);
    Column.Title.Caption := Column.Title.Caption + ' ' + 'v';
    end
  else if ordenCampo = Ascendente then
    begin
    objBusqueda.estableceOrden(Column.FieldName, Descendente);
    Column.Title.Caption := Copy(Column.Title.Caption, 0, Length(Column.Title.Caption)-2)+' ' + '^';
    end
  else if ordenCampo = Descendente then
    begin
    objBusqueda.eliminaOrden(Column.FieldName);
    Column.Title.Caption := Copy(Column.Title.Caption, 0, Length(Column.Title.Caption)-2);
    end;

  Buscar(txtBuscar.Text);
end;

procedure TfrmClientes.Seleccionar1Click(Sender: TObject);
begin
  SetResultWnd(True);
  Close;
end;

function TfrmClientes.SeleccionarCliente: TCliente;
begin
  Seleccionar1.Tag := 1;
  CheckAllButtonsApplication;

  ShowModal;

  Result := nil;
  if GetResultWnd then
  begin
    Result := TCliente.Create;
      Result.Cod_Zon := GetCod_Zon;
      Result.Cod_Cli := GetCod_Cli;
  end;
end;

procedure TfrmClientes.txtBuscarChange(Sender: TObject);
begin
  inherited;
  Buscar(txtBuscar.Text);
end;

function TfrmClientes.GetCod_Zon: SmallInt;
begin
  Result := 0;
  with MBaseDatos.QryDatabase do
    if Active then
      Result := FieldByName('COD_ZON').AsInteger;
end;

function TfrmClientes.GetCod_Cli: Integer;
begin
  Result := 0;
  with MBaseDatos.QryDatabase do
    if Active then
      Result := FieldByName('COD_CLI').AsInteger;
end;

procedure TfrmClientes.UpdateGrid;
var
  FieldName: String;
  FieldValue: Integer;
begin
  with MBaseDatos.QryDatabase do
  begin
    if Active then
      FieldName := 'COD_CLI';

    FieldValue := GetCod_Cli;

    Active := False;

    SQL.Clear;
    SQL.Assign(objSQLInitDB);
    if (objSQLWhere.Count > 0) then
      SQL.Add(objSQLWhere.Text);

    SQL.Add(objBusqueda.devuelveClausulaOrder);  
    Active := True;

    if (FieldValue > 0) then
    begin
      dbgGrid.Update;
      Locate(FieldName, FieldValue, [loCaseInsensitive]);
    end;

    gbxResultadosBusqueda.Caption := FormatFloat(' Resultado de búsqueda: ,0', RecordCount); 
  end;
end;

procedure TfrmClientes.CheckAllButtonsApplication;
var
  IsEnabled: Boolean;
begin
  IsEnabled := False;

  with MBaseDatos.QryDatabase do
    if Active then
      IsEnabled := (RecordCount > 0);

//  Quitar esto cuando este en producción
//  Anadir1.Enabled                 := IsEnabled;
  Anadir1.Enabled                 := False;
  Modificar1.Enabled              := IsEnabled;
//  Quitar esto cuando este en producción
//  Eliminar1.Enabled               := IsEnabled;
  Eliminar1.Enabled               := False;
  Buscar1.Enabled                 := True;
  Actualizar1.Enabled             := True;
  Seleccionar1.Enabled            := IsEnabled and (Seleccionar1.Tag = 1);
  Vistapreviadeimpresion1.Enabled := IsEnabled;
  Imprimir1.Enabled               := IsEnabled;
  Salir1.Enabled                  := True;
end;

end.
