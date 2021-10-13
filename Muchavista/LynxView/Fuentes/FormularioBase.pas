unit FormularioBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, DBGrids, Grids, ExtCtrls, CheckLst, Mask, STdCtrls, Menus,

  AplicacionProcedimientosFunciones,
  AplicacionConstantes
  ;

type
  TfrmFormBase = class(TForm)
    procedure OnEventFormClose(Sender: TObject; var Action: TCloseAction);
    procedure OnEventDblClickGrid(Sender: TObject);
    procedure OnEventDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure OnEventEnter(Sender: TObject);
    procedure OnEventExit(Sender: TObject);
    procedure OnEventKeyPressOnlyNumberAndDecimals(Sender: TObject; var Key: Char);
    procedure OnEventKeyPressOnlyNumber(Sender: TObject; var Key: Char);
    procedure OnEventKeyPressGrid(Sender: TObject; var Key: Char);
    procedure OnEventKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    __IsExecuteEventApplication__: Boolean;
    FIsModifiedForm: Boolean;
  private
    function GetSelfSourceToForm(const obj: TControl): TControl;

    function GetIsModifiedForm: Boolean;
    procedure SetIsModifiedForm(const Value: Boolean);

    procedure SetExecuteEventApplication(Value: Boolean);
    function GetExecuteEventApplication: Boolean;
  public
    { Public declarations }
  public
    property IsModifiedForm: Boolean read GetIsModifiedForm write SetIsModifiedForm;
    property IsExecuteEventApplication: Boolean read GetExecuteEventApplication write SetExecuteEventApplication;
  end;

var
  frmFormBase: TfrmFormBase;

implementation

{$R *.dfm}

procedure TfrmFormBase.OnEventFormClose(Sender: TObject; var Action: TCloseAction);
var
  GuardarySalir1: TMenuItem;
  frmSelfSource: TControl;
begin
  Action := caFree;

  frmSelfSource := GetSelfSourceToForm((Sender as TControl));

  GuardarySalir1 := TMenuItem(frmSelfSource.FindComponent('GuardarySalir1'));

  if Assigned(GuardarySalir1) then
  begin
    Action := GetActionBeforeCloseForm(IsModifiedForm, GuardarySalir1.Enabled);

    if (Action in [caHide]) then
      GuardarySalir1.Click;
  end;
end;

procedure TfrmFormBase.OnEventDblClickGrid(Sender: TObject);
var
  Seleccionar1, Modificar1: TMenuItem;
  frmSelfSource: TControl;
begin
  frmSelfSource := GetSelfSourceToForm((Sender as TControl));
  // Si encuentra la opcion del menu buscar1, significa que estamos en algún formulario principal para buscar y filtrar
  Seleccionar1 := TMenuItem(frmSelfSource.FindComponent('Seleccionar1'));
  Modificar1  := TMenuItem(frmSelfSource.FindComponent('Modificar1'));

  if Assigned(Seleccionar1) and Assigned(Modificar1) then
    if Seleccionar1.Enabled then
      Seleccionar1.Click
    else
      Modificar1.Click;
end;

procedure TfrmFormBase.OnEventDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
// En desarrollo.
end;

procedure TfrmFormBase.OnEventEnter(Sender: TObject);
var
  indice, ancho, anchoMayor: Integer;
begin
  EventColorBackgroundEnter(Sender);

  if (Sender is TCombobox) then
  begin
    ancho := 0;

    for indice := 0 to ((Sender as TComboBox).Items.Count -1) do
    begin
      anchoMayor := (Sender as TComboBox).Canvas.TextWidth((Sender as TComboBox).Items.Strings[indice]);
      if (anchoMayor > ancho) then
        ancho := anchoMayor;
    end;

    (Sender as TComboBox).Perform(CB_SETDROPPEDWIDTH, ancho +16, 0);
  end;
end;

procedure TfrmFormBase.OnEventExit(Sender: TObject);
begin
  EventColorBackgroundExit(Sender);
end;

procedure TfrmFormBase.OnEventKeyPressGrid(Sender: TObject; var Key: Char);
var
  txtBuscar: TLabeledEdit;
  frmSelfSource: TControl;
begin
  frmSelfSource := GetSelfSourceToForm((Sender as TControl));
  txtBuscar := TLabeledEdit(frmSelfSource.FindComponent('txtBuscar'));

  if (Key in [' ', 'A'..'Z', 'a'..'z', '0'..'9']) then
  begin
    txtBuscar.SetFocus;
    txtBuscar.Text := Key;
    txtBuscar.SelStart := 1;
  end;
end;

procedure TfrmFormBase.OnEventKeyPressOnlyNumberAndDecimals(Sender: TObject; var Key: Char);
begin
  if (Key = WVK_POINT) then
    Key := WVK_COMMA;

  if (Key = WVK_COMMA) and (CountChar(',', (Sender as TLabeledEdit).Text) > 0) then
    Key := WVK_NULL;

  if (not (Key in ['0'..'9', WVK_BACKDELETE, WVK_COMMA])) then
    Key := WVK_NULL;
end;

procedure TfrmFormBase.OnEventKeyPressOnlyNumber(Sender: TObject; var Key: Char);
begin
  if (not (Key in ['0'..'9', WVK_BACKDELETE])) then
    Key := WVK_NULL;
end;

procedure TfrmFormBase.OnEventKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  dbgGrid: TDBGrid;
  Modificar1, Eliminar1, Buscar1, Seleccionar1 : TMenuItem;
  GroupBoxSituacion: TGroupBox;
  frmSelfSource: TControl;
begin
  frmSelfSource := GetSelfSourceToForm((Sender as TControl));
  dbgGrid := nil;

  Modificar1    := TMenuItem(frmSelfSource.FindComponent('Modificar1'));
  Eliminar1     := TMenuItem(frmSelfSource.FindComponent('Eliminar1'));
  Buscar1       := TMenuItem(frmSelfSource.FindComponent('Buscar1'));
  Seleccionar1  := TMenuItem(frmSelfSource.FindComponent('Seleccionar1'));

  GroupBoxSituacion := TGroupBox(frmSelfSource.FindComponent('gbxSituacion'));

  if Assigned(Buscar1) then
    dbgGrid := TDBGrid(frmSelfSource.FindComponent('dbgGrid'));

  if (Key in [VK_UP, VK_DOWN, VK_RETURN]) then
  begin
    if (Sender is TLabeledEdit) and ((Sender as TLabeledEdit).Name = 'txtBuscar') then
      if (Key in [VK_DOWN, VK_RETURN]) then
      begin
        if (Key = VK_DOWN) then
          if Assigned(dbgGrid) then
          begin
            dbgGrid.SetFocus;
            Exit;
          end
          else
        else begin
          if Assigned(Buscar1) then
            Buscar1.Click;
          if Assigned(dbgGrid) and dbgGrid.DataSource.DataSet.Active and (dbgGrid.DataSource.DataSet.RecordCount > 0) then
            dbgGrid.SetFocus;
        end;
        Exit;
      end;

    if (Sender is TRadioButton) and Assigned(GroupBoxSituacion) and (Pos('rbtnSituacion', (Sender as TRadioButton).Name) > 0) then
      if (Key = VK_RETURN) then
      begin
        if Assigned(Buscar1) then
          Buscar1.Click;
        if Assigned(dbgGrid) and dbgGrid.DataSource.DataSet.Active and (dbgGrid.DataSource.DataSet.RecordCount > 0) then
          dbgGrid.SetFocus;
        Exit;
      end;

    if (Key in [VK_DOWN, VK_RETURN]) then
    begin
      if (Key = VK_DOWN) and (Sender is TComboBox) then
        with (Sender as TComboBox) do
          if (not DroppedDown) then
          begin
            DroppedDown := True;
            Exit;
          end;

      if (Key = VK_DOWN) and (not (Sender is TComboBox)) and (not (Sender is TDBGrid)) and (not (Sender is TRadioButton)) and (not (Sender is TCheckBox)) then
      begin
        frmSelfSource.Perform(WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;

      if (Key = VK_RETURN) and (not (Sender is TDBGrid)) then
      begin
        frmSelfSource.Perform(WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;

      if (Key = VK_RETURN) and (Sender is TDBGrid) then
        if Assigned(Seleccionar1) then
          if (Seleccionar1.Tag = 1) then
            Seleccionar1.Click
          else
            Modificar1.Click;
    end;

    if (Key = VK_UP) and (not (Sender is TComboBox)) and (not (Sender is TDBGrid)) and (not (Sender is TRadioButton)) and (not (Sender is TCheckBox)) then
    begin
      frmSelfSource.Perform(WM_NEXTDLGCTL, VK_UP, 0);
      Exit;
    end;
  end;

  if (Key = VK_DELETE) and Assigned(Eliminar1) then
    Eliminar1.Click;
end;

function TfrmFormBase.GetSelfSourceToForm(const obj: TControl): TControl;
begin
  Result := obj;
  while (not (Result is TForm)) do
    Result := Result.Parent;
end;

function TfrmFormBase.GetIsModifiedForm: Boolean;
begin
  Result := FIsModifiedForm;
end;

procedure TfrmFormBase.SetIsModifiedForm(const Value: Boolean);
begin
  FIsModifiedForm := Value;
end;

procedure TfrmFormBase.SetExecuteEventApplication(Value: Boolean);
begin
  __IsExecuteEventApplication__ := Value;
end;

function TfrmFormBase.GetExecuteEventApplication: Boolean;
begin
  Result := __IsExecuteEventApplication__;
end;

//initialization
//finalization
end.
