unit UFAcceso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxTextEdit, cxLabel,
  cxMaskEdit, cxDropDownEdit, cxGroupBox, Menus, StdCtrls, cxButtons, DB,
  DBTables;

type
  TFAcceso = class(TForm)
    gb1: TcxGroupBox;
    cbAlias: TcxComboBox;
    lbUsuario: TcxLabel;
    txUsuario: TcxTextEdit;
    lbClave: TcxLabel;
    txClave: TcxTextEdit;
    btAceptar: TcxButton;
    btCancelar: TcxButton;
    lb1: TcxLabel;
    lbError: TcxLabel;
    procedure btAceptarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

    function ValidarCampos: boolean;
  public
    { Public declarations }
  end;

var
  FAcceso: TFAcceso;

implementation

uses UDM, CVariables, IniFiles;

{$R *.dfm}

procedure TFAcceso.btAceptarClick(Sender: TObject);
begin
  if not ValidarCampos then exit;
  ModalResult:= mrOk;
end;

procedure TFAcceso.btCancelarClick(Sender: TObject);
begin
  gsAlias := 'NO CONECTADO';
  ModalResult:= mrCancel;
end;

procedure TFAcceso.FormCreate(Sender: TObject);
var
  iniFile: TIniFile;
  sections: TStringList;
  databaseIterator: Integer;
begin
  iniFile := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\aguas.ini') ;
  sections := TStringList.Create;
  iniFile.ReadSections(sections);
  try
    for databaseIterator := 0 to sections.Count - 1 do
    begin
      cbalias.Properties.Items.add(iniFile.ReadString(sections[databaseIterator],'DATABASE NAME',''));
    end;
  finally
    sections.Free;
    iniFile.Free;
  end;
end;

procedure TFAcceso.FormShow(Sender: TObject);
begin
  cbAlias.ItemIndex := 0;
  lbError.Visible := false;
  txUsuario.SetFocus;
end;

function TFAcceso.ValidarCampos:boolean;
begin
  result := true;
  if txUsuario.Text = '' then
  begin
    lbError.Visible := true;
    lbError.Caption := ' ATENCION! Debe introducir un Usuario.';
    result := false;
    exit
  end;
  if txclave.Text = '' then
  begin
    lbError.Visible := true;
    lbError.Caption := ' ATENCION! Debe introducir una Contraseña.';
    result := false;
    exit
  end;
end;

end.
