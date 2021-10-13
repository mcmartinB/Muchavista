unit ClienteAnadirModificar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Menus, ExtCtrls, StdCtrls, Mask,

  FormularioBase,
  ClasesCliente,
  AplicacionConstantes,
  AplicacionProcedimientosFunciones, Grids, DBGrids, DB
  ;

type
  TfrmClienteAnadirModificar = class(TfrmFormBase)
    MainMenu1: TMainMenu;
    Fichero1: TMenuItem;
    GuardarySalir1: TMenuItem;
    N1: TMenuItem;
    Salir1: TMenuItem;
    ToolBar1: TToolBar;
    tbtnSave: TToolButton;
    ToolButton3: TToolButton;
    tbtnExit: TToolButton;
    pnlAnadirModificar: TPanel;
    PageControl1: TPageControl;
    Datos: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbxCod_Zon: TComboBox;
    txtCod_Cli: TLabeledEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    txtDom_Cli: TLabeledEdit;
    txtTit_Cli: TLabeledEdit;
    cbxCod_Pob: TComboBox;
    txtPob_Cli: TLabeledEdit;
    txtPro_Cli: TLabeledEdit;
    cbxJoF_Cli: TComboBox;
    txtNif_Cli: TLabeledEdit;
    txtTel_Cli: TLabeledEdit;
    txtCod_Pro: TLabeledEdit;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    txtDom_Dom: TLabeledEdit;
    cbxCod_Pobd: TComboBox;
    txtTit_Pobd: TLabeledEdit;
    txtPro_Clid: TLabeledEdit;
    txtTel_Dom: TLabeledEdit;
    txtCod_Prod: TLabeledEdit;
    GroupBox4: TGroupBox;
    Label8: TLabel;
    txtDom_Postal: TLabeledEdit;
    txtNom_Postal: TLabeledEdit;
    cbxCp_Postal: TComboBox;
    txtPob_Postal: TLabeledEdit;
    txtPro_Postal: TLabeledEdit;
    txtEmail: TLabeledEdit;
    txtCod_ProP: TLabeledEdit;
    GroupBox5: TGroupBox;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lblCod_Sit: TLabel;
    cbxDom_Ind: TComboBox;
    cbxM3_Ano: TComboBox;
    cbxSin_Efe: TComboBox;
    txtCoe_Cor: TLabeledEdit;
    cbxLet_Cli: TComboBox;
    txtCon_Cli: TLabeledEdit;
    mtxtFco_Cli: TMaskEdit;
    cbxCod_Tip: TComboBox;
    txtCnt_Cli: TLabeledEdit;
    txtImp_Cli: TLabeledEdit;
    txtIva_Cli: TLabeledEdit;
    GroupBox7: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    txtLan_Cli: TLabeledEdit;
    txtLac_Cli: TLabeledEdit;
    mtxtFan_Cli: TMaskEdit;
    mtxtFac_Cli: TMaskEdit;
    cbxCod_Sit: TComboBox;
    GroupBox6: TGroupBox;
    txtBan_Cli: TLabeledEdit;
    txtCod_Bic: TLabeledEdit;
    txtCod_Iban: TLabeledEdit;
    txtCod_Ban: TLabeledEdit;
    txtCod_Suc: TLabeledEdit;
    txtDig_Con: TLabeledEdit;
    txtCta_Cli: TLabeledEdit;
    TabSheet1: TTabSheet;
    DBGridObservaciones: TDBGrid;
    btAdd: TButton;
    Panel1: TPanel;
    btDelete: TButton;

    procedure InicializarCommon;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure MainMenu1Change(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
    procedure GuardarySalir1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);

    procedure cbxCod_ZonChange(Sender: TObject);
    procedure txtCod_CliChange(Sender: TObject);
    procedure txtCod_CliExit(Sender: TObject);
    procedure txtTit_CliChange(Sender: TObject);
    procedure txtDom_CliChange(Sender: TObject);
    procedure cbxCod_PobChange(Sender: TObject);
    procedure cbxJoF_CliChange(Sender: TObject);
    procedure txtNif_CliChange(Sender: TObject);
    procedure txtTel_CliChange(Sender: TObject);

    procedure txtDom_DomChange(Sender: TObject);
    procedure cbxCod_PobdChange(Sender: TObject);
    procedure txtTit_PobdChange(Sender: TObject);
    procedure txtTel_DomChange(Sender: TObject);

    procedure txtNom_PostalChange(Sender: TObject);
    procedure txtDom_PostalChange(Sender: TObject);
    procedure cbxCp_PostalChange(Sender: TObject);
    procedure txtPob_PostalChange(Sender: TObject);
    procedure txtEmailChange(Sender: TObject);

    procedure cbxDom_IndChange(Sender: TObject);
    procedure cbxM3_AnoChange(Sender: TObject);
    procedure cbxSin_EfeChange(Sender: TObject);
    procedure txtCoe_CorChange(Sender: TObject);
    procedure cbxLet_CliChange(Sender: TObject);
    procedure txtCon_CliChange(Sender: TObject);
    procedure mtxtFco_CliExit(Sender: TObject);
    procedure cbxCod_TipChange(Sender: TObject);
    procedure txtCnt_CliChange(Sender: TObject);
    procedure cbxCod_SitChange(Sender: TObject);
    procedure txtImp_CliChange(Sender: TObject);
    procedure txtIva_CliChange(Sender: TObject);

    procedure txtLan_CliChange(Sender: TObject);
    procedure mtxtFan_CliExit(Sender: TObject);
    procedure txtLac_CliChange(Sender: TObject);
    procedure mtxtFac_CliExit(Sender: TObject);

    procedure txtCod_BanChange(Sender: TObject);
    procedure txtCod_BanExit(Sender: TObject);
    procedure txtCod_SucChange(Sender: TObject);
    procedure txtDig_ConChange(Sender: TObject);
    procedure txtCta_CliChange(Sender: TObject);
    procedure txtCta_CliExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
  private
    { Private declarations }
    objNewModify: TCliente;
    procedure CheckAllButtonsApplication;
  public
    { Public declarations }
    procedure AnadirCliente(var obj: TCliente);
    procedure ModificarCliente(var obj: TCliente);
    procedure UpdateGridObservaciones;
  end;

var
  frmClienteAnadirModificar: TfrmClienteAnadirModificar;

implementation

uses
  BaseDatos,
  ClasesOtras,
  DBTables
  ;

{$R *.dfm}

procedure TfrmClienteAnadirModificar.InicializarCommon;
var
  objTmp: TStringList;
begin
  with cbxCod_Zon do
    with TEnumTiposZonas.Create(objNewModify.Database) do
      try
        objTmp := GetTiposZonasToListString;
        TEnumItem(nil).SetEnumItemDelete(objTmp, 0);
        Items.Assign(objTmp);
        ItemIndex := 1;
      finally
        FreeAndNil(objTmp);
        Free;
      end;

  with cbxCod_Pob do
    with TEnumPoblaciones.Create(objNewModify.Database) do
      try
        objTmp := GetPoblacionesToListString;
        Items.Assign(objTmp);
        ItemIndex := 0;
      finally
        FreeAndNil(objTmp);
        Free;
      end;

  with cbxJoF_Cli do
    with TEnumJuridicoFisico.Create(objNewModify.Database) do
      try
        objTmp := GetJuridicoFisicoToListString;
        Items.Assign(objTmp);
        ItemIndex := 0;
      finally
        FreeAndNil(objTmp);
        Free;
      end;

  with cbxCod_Pobd do
    with TEnumPoblaciones.Create(objNewModify.Database) do
      try
        objTmp := GetPoblacionesToListString;
        Items.Assign(objTmp);
        ItemIndex := 0;
      finally
        FreeAndNil(objTmp);
        Free;
      end;

  with cbxCp_Postal do
    with TEnumPoblaciones.Create(objNewModify.Database) do
      try
        objTmp := GetPoblacionesToListString;
        Items.Assign(objTmp);
        ItemIndex := 0;
      finally
        FreeAndNil(objTmp);
        Free;
      end;

  with cbxDom_Ind do
    with TEnumTiposSuministros(nil) do
      try
        objTmp := GetTiposSuministrosToListString;
        Items.Assign(objTmp);
        ItemIndex := 0;
      finally
        FreeAndNil(objTmp);
        Free;
      end;

  with cbxLet_Cli do
    with TEnumLetra.Create(objNewModify.Database) do
      try
        objTmp := GetLetrasToListString;
        Items.Assign(objTmp);
        ItemIndex := 0;
      finally
        FreeAndNil(objTmp);
        Free;
      end;

  with cbxCod_Tip do
    with TEnumTipoContador.Create(objNewModify.Database) do
      try
        objTmp := GetTiposContadoresToListString;
        Items.Assign(objTmp);
        ItemIndex := 0;
      finally
        FreeAndNil(objTmp);
        Free;
      end;

  with cbxCod_Sit do
    with TEnumSituacion.Create(objNewModify.Database) do
      try
        objTmp := GetSituacionToListString;
        Items.Assign(objTmp);
        ItemIndex := 0;
      finally
        FreeAndNil(objTmp);
        Free;
      end;
end;

procedure TfrmClienteAnadirModificar.FormCreate(Sender: TObject);
begin
  with cbxM3_Ano do
  begin
    Items.AddObject('N', TEnumItem.Create('N', 'NO', 0));
    Items.AddObject('S', TEnumItem.Create('S', 'SI', 0));
    ItemIndex := 1;
  end;

  with cbxSin_Efe do
  begin
    Items.AddObject('N', TEnumItem.Create('N', 'NO', 0));
    Items.AddObject('S', TEnumItem.Create('S', 'SI', 0));
    ItemIndex := 1;
  end;
end;

procedure TfrmClienteAnadirModificar.FormDestroy(Sender: TObject);
begin
  TEnumItem(nil).SetEnumItemFreeAndNil(cbxCod_Zon);
  TEnumItem(nil).SetEnumItemFreeAndNil(cbxCod_Pob);
  TEnumItem(nil).SetEnumItemFreeAndNil(cbxJoF_Cli);
  TEnumItem(nil).SetEnumItemFreeAndNil(cbxCod_Pobd);
  TEnumItem(nil).SetEnumItemFreeAndNil(cbxCp_Postal);
  TEnumItem(nil).SetEnumItemFreeAndNil(cbxDom_Ind);
  TEnumItem(nil).SetEnumItemFreeAndNil(cbxM3_Ano);
  TEnumItem(nil).SetEnumItemFreeAndNil(cbxSin_Efe);
  TEnumItem(nil).SetEnumItemFreeAndNil(cbxLet_Cli);
  TEnumItem(nil).SetEnumItemFreeAndNil(cbxCod_Tip);
  TEnumItem(nil).SetEnumItemFreeAndNil(cbxCod_Sit);
end;

procedure TfrmClienteAnadirModificar.FormShow(Sender: TObject);
begin
  inherited;
  UpdateGridObservaciones;
end;

procedure TfrmClienteAnadirModificar.MainMenu1Change(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
begin
  tbtnSave.Enabled := GuardarySalir1.Enabled;
  tbtnExit.Enabled := Salir1.Enabled;
end;

procedure TfrmClienteAnadirModificar.GuardarySalir1Click(Sender: TObject);
begin
  objNewModify.Post;
  CheckAllButtonsApplication;
  Close;
end;

procedure TfrmClienteAnadirModificar.Salir1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmClienteAnadirModificar.cbxCod_ZonChange(Sender: TObject);
begin
  with objNewModify, cbxCod_Zon do
    Cod_Zon := TEnumItem(nil).GetEnumItem(cbxCod_Zon).IDFieldValue;

  txtCod_Cli.Text := IntToStr(objNewModify.Cod_Cli_Auto);

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtCod_CliChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtCod_Cli, objNewModify do
    if (Length(Text) > 0) then
      Cod_Cli_Manu := StrToInt(Text)
    else
      Cod_Cli_Manu := 0;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtCod_CliExit(Sender: TObject);
var
  ExistValue: Boolean;
begin
  frmFormBase.OnEventExit(Sender);

  with objNewModify do
    ExistValue := GetExistName(['COD_ZON', 'COD_CLI'], [Cod_Zon, Cod_Cli_Manu], 'Clientes', 'COD_CLI', -1);

  with txtCod_Cli do
  begin
    Font.Color := COLOR_EXIST_VALUE_IN_TABLE[ExistValue];
    Tag := Integer(ExistValue);
  end;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtTit_CliChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtTit_Cli, objNewModify do
    Tit_Cli := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtDom_CliChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtDom_Cli, objNewModify do
    Dom_Cli := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.btAddClick(Sender: TObject);
var
  observacion: string;
begin
  inherited;
  observacion := inputbox('Clientes', 'Inserte el texto de la nueva observación', '');
  if observacion<> '' then
    objNewModify.NuevaObservacion(observacion);
  UpdateGridObservaciones;
end;

procedure TfrmClienteAnadirModificar.btDeleteClick(Sender: TObject);
begin
  inherited;
  DBGridObservaciones.DataSource.DataSet.Delete;
end;

procedure TfrmClienteAnadirModificar.cbxCod_PobChange(Sender: TObject);
var
  objPob: TEnumPoblaciones;
  objPro: TEnumProvincias;
begin
  objNewModify.Cod_Pob := TEnumItem(nil).GetEnumItem(cbxCod_Pob).IDFieldValue;

  objPob := TEnumPoblaciones.Create(objNewModify.Database);
    objPob.Cod_Pob := objNewModify.Cod_Pob;

  objPro := TEnumProvincias.Create(objNewModify.Database);
    objPro.Cod_Pro := objPob.Cod_Pro;

  txtPob_Cli.Text := objPob.Tit_Pob;
  txtCod_Pro.Text := IntToStr(objPro.Cod_Pro);
  txtPro_Cli.Text := objPro.Tit_Pro;

  FreeAndNil(objPob);
  FreeAndNil(objPro);

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.cbxJoF_CliChange(Sender: TObject);
begin
  objNewModify.JoF_Cli := TEnumItem(nil).GetEnumItem(cbxJoF_Cli).IDFieldValue2[1];

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtNif_CliChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtNif_Cli, objNewModify do
    Nif_Cli := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtTel_CliChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtTel_Cli, objNewModify do
    Tel_Cli := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtDom_DomChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtDom_Dom, objNewModify.Domicilio do
    Dom_Dom := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.cbxCod_PobdChange(Sender: TObject);
var
  objPob: TEnumPoblaciones;
  objPro: TEnumProvincias;
begin
  with objNewModify.Domicilio do
    Cod_Pobd := TEnumItem(nil).GetEnumItem(cbxCod_Pobd).IDFieldValue;

  objPob := TEnumPoblaciones.Create(objNewModify.Database);
    objPob.Cod_Pob := objNewModify.Domicilio.Cod_Pobd;

  objPro := TEnumProvincias.Create(objNewModify.Database);
    objPro.Cod_Pro := objPob.Cod_Pro;

  txtTit_Pobd.Text := objPob.Tit_Pob;
  txtCod_Prod.Text := IntToStr(objPro.Cod_Pro);
  txtPro_Clid.Text := objPro.Tit_Pro;

  FreeAndNil(objPob);
  FreeAndNil(objPro);

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtTit_PobdChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtTit_Pobd, objNewModify.Domicilio do
    Tit_Pobd := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.UpdateGridObservaciones;
var
  filtro : string;
begin
    filtro := 'COD_ZON = '+IntToStr(objNewModify.Cod_Zon) +
    ' AND COD_CLI = '+IntToStr(objNewModify.Cod_Cli);
    if MBaseDatos.TableObservaciones.Active then
      MBaseDatos.TableObservaciones.Active := False;
    MBaseDatos.TableObservaciones.DatabaseName := MBaseDatos.BaseDatos.DatabaseName;
    MBaseDatos.TableObservaciones.TableName := 'Observaciones';
    MBaseDatos.TableObservaciones.Filter := filtro;
    MBaseDatos.TableObservaciones.Filtered := true;
    MBaseDatos.TableObservaciones.Active := True;
    DBGridObservaciones.Update;

end;

procedure TfrmClienteAnadirModificar.txtTel_DomChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtTel_Dom, objNewModify.Domicilio do
    Tel_Dom := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtNom_PostalChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtNom_Postal, objNewModify.Domicilio do
    Nom_Postal := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtDom_PostalChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtDom_Postal, objNewModify.Domicilio do
    Dom_Postal := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.cbxCp_PostalChange(Sender: TObject);
var
  objPob: TEnumPoblaciones;
  objPro: TEnumProvincias;
begin
  objNewModify.Domicilio.Cp_Postal := IntToStr(TEnumItem(nil).GetEnumItem(cbxCp_Postal).IDFieldValue);

  objPob := TEnumPoblaciones.Create(objNewModify.Database);
    objPob.Cod_Pob := StrToInt(objNewModify.Domicilio.Cp_Postal);

  objPro := TEnumProvincias.Create(objNewModify.Database);
    objPro.Cod_Pro := objPob.Cod_Pro;

  txtPob_Cli.Text := objPob.Tit_Pob;
  txtCod_Pro.Text := IntToStr(objPro.Cod_Pro);
  txtPro_Cli.Text := objPro.Tit_Pro;

  FreeAndNil(objPob);
  FreeAndNil(objPro);

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtPob_PostalChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtPob_Postal, objNewModify.Domicilio do
    Pob_Postal := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtEmailChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtEmail, objNewModify.Domicilio do
    Email := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.cbxDom_IndChange(Sender: TObject);
begin
  objNewModify.Dom_Ind := TEnumItem(nil).GetEnumItem(cbxDom_Ind).IDFieldValue2[1];

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.cbxM3_AnoChange(Sender: TObject);
begin
  objNewModify.M3_Ano := TEnumItem(nil).GetEnumItem(cbxM3_Ano).IDFieldValue2[1];

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.cbxSin_EfeChange(Sender: TObject);
begin
  objNewModify.Sin_Efe := TEnumItem(nil).GetEnumItem(cbxSin_Efe).IDFieldValue2[1];

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtCoe_CorChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with objNewModify, txtCoe_Cor do
    if (Length(Text) > 0) then
      Coe_Cor := StrToFloat(Text)
    else
      Coe_Cor := 0.00;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.cbxLet_CliChange(Sender: TObject);
begin
  objNewModify.Let_Cli := TEnumItem(nil).GetEnumItem(cbxLet_Cli).IDFieldValue2[1];

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtCon_CliChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with objNewModify, txtCon_Cli do
    if (Length(Text) > 0) then
      Con_Cli := StrToInt(Text)
    else
      Con_Cli := 0;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.mtxtFco_CliExit(Sender: TObject);
begin
  EventColorBackgroundExit(Sender);

  with mtxtFco_Cli, objNewModify do
    if (Text <> '  /  /    ') then
      if not CheckingIsDate(Text) then
      begin
        ShowMessageErrorDate(Text);
        SetFocus;
        Exit;
      end
      else
        Fco_Cli := StrToDate(Text)
    else
      Fco_Cli := 0;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.cbxCod_TipChange(Sender: TObject);
begin
  objNewModify.Cod_Tip := TEnumItem(nil).GetEnumItem(cbxCod_Tip).IDFieldValue;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtCnt_CliChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtCnt_Cli, objNewModify do
    Cnt_Cli := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtImp_CliChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with objNewModify, txtImp_Cli do
    if (Length(Text) > 0) then
      Imp_Cli := StrToFloat(Text)
    else
      Imp_Cli := 0.00;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.cbxCod_SitChange(Sender: TObject);
begin
  objNewModify.Cod_Sit := TEnumItem(nil).GetEnumItem(cbxCod_Sit).IDFieldValue2[1];

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtIva_CliChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with objNewModify, txtIva_Cli do
    if (Length(Text) > 0) then
      Iva_Cli := StrToInt(Text)
    else
      Iva_Cli := 0;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtLan_CliChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with objNewModify, txtLan_Cli do
    if (Length(Text) > 0) then
      Lan_Cli := StrToInt(Text)
    else
      Lan_Cli := 0;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.mtxtFan_CliExit(Sender: TObject);
begin
  EventColorBackgroundExit(Sender);

  with mtxtFan_Cli, objNewModify do
    if (Text <> '  /  /    ') then
      if not CheckingIsDate(Text) then
      begin
        ShowMessageErrorDate(Text);
        SetFocus;
        Exit;
      end
      else
        Fan_Cli := StrToDate(Text)
    else
      Fan_Cli := 0;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtLac_CliChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with objNewModify, txtLac_Cli do
    if (Length(Text) > 0) then
      Lac_Cli := StrToInt(Text)
    else
      Lac_Cli := 0;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.mtxtFac_CliExit(Sender: TObject);
begin
  EventColorBackgroundExit(Sender);

  with mtxtFac_Cli, objNewModify do
    if (Text <> '  /  /    ') then
      if not CheckingIsDate(Text) then
      begin
        ShowMessageErrorDate(Text);
        SetFocus;
        Exit;
      end
      else
        Fac_Cli := StrToDate(Text)
    else
      Fac_Cli := 0;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtCod_BanChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  GuardarySalir1.Enabled := False;
  
  with objNewModify, txtCod_Ban do
    if (Length(Text) > 0) then
      Cod_Ban := StrToInt(Text)
    else
      Cod_Ban := 0;
end;

procedure TfrmClienteAnadirModificar.txtCod_BanExit(Sender: TObject);
var
  objBanco: TEnumBancos;
begin
  EventColorBackgroundExit(Sender);

  objBanco := TEnumBancos.Create(objNewModify.Database);
  objBanco.Cod_Ban := objNewModify.Cod_Ban;
  objNewModify.Cod_Bic := objBanco.Cod_Bic;

  txtBan_Cli.Text := objBanco.Tit_Ban;
  txtCod_Bic.Text := objBanco.Cod_Bic;
  
  FreeAndNil(objBanco);
  
  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtCod_SucChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  GuardarySalir1.Enabled := False;

  with objNewModify, txtCod_Suc do
    if (Length(Text) > 0) then
      Cod_Suc := StrToInt(Text)
    else
      Cod_Suc := 0;
end;

procedure TfrmClienteAnadirModificar.txtDig_ConChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with objNewModify, txtDig_Con do
    if (Length(Text) > 0) then
      Dig_Con := StrToInt(Text)
    else
      Dig_Con := 0;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtCta_CliChange(Sender: TObject);
begin
  if (not IsExecuteEventApplication) then
    Exit;

  with txtCta_Cli, objNewModify do
    Cta_Cli := Text;

  CheckAllButtonsApplication;
end;

procedure TfrmClienteAnadirModificar.txtCta_CliExit(Sender: TObject);
begin
  if (objNewModify.Cod_Ban > 0) and
     (objNewModify.Cod_Suc > 0) and
     (objNewModify.Dig_Con > 0) and
     (Length(objNewModify.Cta_Cli) = 10) then
    objNewModify.Cod_Iban := GetIbanBank('ES', objNewModify.CuentaBancaria)
  else
    objNewModify.Cod_Iban := '';

  txtCod_Iban.Text := objNewModify.Cod_Iban;

end;

procedure TfrmClienteAnadirModificar.AnadirCliente(var obj: TCliente);
begin
  objNewModify := obj;

  InicializarCommon;

  pnlAnadirModificar.Caption := Format('Añadir un nuevo cliente, EMPRESA: %s', [objNewModify.Database.DatabaseName]);

  cbxJoF_Cli.ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxJoF_Cli, objNewModify.JoF_Cli).FieldItemIndex;
  cbxDom_Ind.ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxDom_Ind, objNewModify.Dom_Ind).FieldItemIndex;
  cbxM3_Ano.ItemIndex  := TEnumItem(nil).GetSearchEnumItem(cbxM3_Ano, objNewModify.M3_Ano).FieldItemIndex;
  cbxSin_Efe.ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxSin_Efe, objNewModify.Sin_Efe).FieldItemIndex;
  cbxLet_Cli.ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxLet_Cli, objNewModify.Let_Cli).FieldItemIndex;
  cbxCod_Tip.ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxCod_Tip, objNewModify.Cod_Tip).FieldItemIndex;
  cbxCod_Sit.ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxCod_Sit, objNewModify.Cod_Sit).FieldItemIndex;

  IsExecuteEventApplication := True;

  CheckAllButtonsApplication;

  ShowModal;
end;

procedure TfrmClienteAnadirModificar.ModificarCliente(var obj: TCliente);
var
  objPoblacion: TEnumPoblaciones;
  objProvincia: TEnumProvincias;
  objBanco: TEnumBancos;
begin
  objNewModify := obj;

  InicializarCommon;

  pnlAnadirModificar.Caption := Format('Modificar cliente, EMPRESA: %s', [objNewModify.Database.DatabaseName]);

  IsExecuteEventApplication := False;

  cbxCod_Zon.ItemIndex  := TEnumItem(nil).GetSearchEnumItem(cbxCod_Zon, objNewModify.Cod_Zon).FieldItemIndex;
  txtCod_Cli.Text       := IntToStr(objNewModify.Cod_Cli);
  txtTit_Cli.Text       := objNewModify.Tit_Cli;
  txtDom_Cli.Text       := objNewModify.Dom_Cli;

  objPoblacion := TEnumPoblaciones.Create(objNewModify.Database);
    objPoblacion.Cod_Pob := objNewModify.Cod_Pob;

  objProvincia := TEnumProvincias.Create(objNewModify.Database);
    objProvincia.Cod_Pro := objPoblacion.Cod_Pro;

  cbxCod_Pob.ItemIndex  := TEnumItem(nil).GetSearchEnumItem(cbxCod_Pob, objNewModify.Cod_Pob).FieldItemIndex;
  txtPob_Cli.Text := objPoblacion.Tit_Pob;
  txtCod_Pro.Text := IntToStr(objProvincia.Cod_Pro);
  txtPro_Cli.Text := objProvincia.Tit_Pro;

  FreeAndNil(objPoblacion);
  FreeAndNil(objProvincia);

  cbxJoF_Cli.ItemIndex  := TEnumItem(nil).GetSearchEnumItem(cbxJoF_Cli, objNewModify.JoF_Cli).FieldItemIndex;
  txtNif_Cli.Text       := objNewModify.Nif_Cli;
  txtTel_Cli.Text       := objNewModify.Tel_Cli;

  objPoblacion := TEnumPoblaciones.Create(objNewModify.Database);
    objPoblacion.Cod_Pob := objNewModify.Domicilio.Cod_Pobd;

  objProvincia := TEnumProvincias.Create(objNewModify.Database);
    objProvincia.Cod_Pro := objPoblacion.Cod_Pro;

  txtDom_Dom.Text       := objNewModify.Domicilio.Dom_Dom;
  cbxCod_Pobd.ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxCod_Pobd, objNewModify.Domicilio.Cod_Pobd).FieldItemIndex;
  txtTit_Pobd.Text      := objNewModify.Domicilio.Tit_Pobd;
  txtCod_Prod.Text      := IntToStr(objProvincia.Cod_Pro);
  txtPro_Clid.Text      := objProvincia.Tit_Pro;
  txtTel_Dom.Text       := objNewModify.Domicilio.Tel_Dom;

  FreeAndNil(objPoblacion);
  FreeAndNil(objProvincia);

  objPoblacion := TEnumPoblaciones.Create(objNewModify.Database);
    objPoblacion.Cod_Pob := StrToIntDef(objNewModify.Domicilio.Cp_Postal, 0);

  objProvincia := TEnumProvincias.Create(objNewModify.Database);
    objProvincia.Cod_Pro := objPoblacion.Cod_Pro;

  txtNom_Postal.Text      := objNewModify.Domicilio.Nom_Postal;
  txtDom_Postal.Text      := objNewModify.Domicilio.Dom_Postal;
  cbxCp_Postal.ItemIndex  := TEnumItem(nil).GetSearchEnumItem(cbxCp_Postal, StrToIntDef(objNewModify.Domicilio.Cp_Postal, 0)).FieldItemIndex;
  txtPob_Postal.Text      := objNewModify.Domicilio.Pob_Postal;
  txtCod_ProP.Text        := IntToStr(objPoblacion.Cod_Pob);
  txtPro_Postal.Text      := objProvincia.Tit_Pro;
  txtEmail.Text           := objNewModify.Domicilio.Email;

  FreeAndNil(objPoblacion);
  FreeAndNil(objProvincia);

  cbxDom_Ind.ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxDom_Ind, objNewModify.Dom_Ind).FieldItemIndex;
  cbxM3_Ano.ItemIndex  := TEnumItem(nil).GetSearchEnumItem(cbxM3_Ano, objNewModify.M3_Ano).FieldItemIndex;
  cbxSin_Efe.ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxSin_Efe, objNewModify.Sin_Efe).FieldItemIndex;
  txtCoe_Cor.Text      := FormatFloat('0.00', objNewModify.Coe_Cor);
  cbxLet_Cli.ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxLet_Cli, objNewModify.Let_Cli).FieldItemIndex;
  txtCon_Cli.Text      := IntToStr(objNewModify.Con_Cli);
  mtxtFco_Cli.Text     := GetDateToStr(objNewModify.Fco_Cli);
  cbxCod_Tip.ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxCod_Tip, objNewModify.Cod_Tip).FieldItemIndex;
  txtCnt_Cli.Text      := objNewModify.Cnt_Cli;
  cbxCod_Sit.ItemIndex := TEnumItem(nil).GetSearchEnumItem(cbxCod_Sit, objNewModify.Cod_Sit).FieldItemIndex;
  txtImp_Cli.Text      := FormatFloat('0.00', objNewModify.Imp_Cli);
  txtIva_Cli.Text      := IntToStr(objNewModify.Iva_Cli);

  txtLan_Cli.Text  := IntToStr(objNewModify.Lan_Cli);
  mtxtFan_Cli.Text := GetDateToStr(objNewModify.Fan_Cli);
  txtLac_Cli.Text  := IntToStr(objNewModify.Lac_Cli);
  mtxtFac_Cli.Text := GetDateToStr(objNewModify.Fac_Cli);

  objBanco := TEnumBancos.Create(objNewModify.Database);
  objBanco.Cod_Ban := objNewModify.Cod_Ban;

  txtBan_Cli.Text   := objBanco.Tit_Ban;
  txtCod_Bic.Text   := objBanco.Cod_Bic;
  txtCod_Iban.Text  := objNewModify.Cod_Iban;

  txtCod_Ban.Text := IntToStr(objNewModify.Cod_Ban);
  txtCod_Suc.Text := IntToStr(objNewModify.Cod_Suc);
  txtDig_Con.Text := IntToStr(objNewModify.Dig_Con);
  txtCta_Cli.Text := objNewModify.Cta_Cli;

  FreeAndNil(objBanco);

  IsExecuteEventApplication := True;

  CheckAllButtonsApplication;

  ShowModal;
end;

procedure TfrmClienteAnadirModificar.CheckAllButtonsApplication;
var
  IsEnabled: Boolean;
begin
  with objNewModify do
    IsEnabled :=
      (Cod_Zon > 0) and
      (Cod_Cli_Manu > 0) and
      (Length(Tit_Cli) > 0) and
      (Length(Dom_Cli) > 0) and
      (Cod_Pob > 0) and
      (Length(JoF_Cli) > 0) and
      (Length(Dom_Ind) > 0) and
      (Length(Cod_Sit) > 0);

  Salir1.Enabled         := True;

  cbxCod_Zon.Enabled := (objNewModify.Cod_Cli = -1);
  txtCod_Cli.Enabled := (objNewModify.Cod_Cli = -1);

  IsModifiedForm := objNewModify.ModifiedAll;
end;

end.
