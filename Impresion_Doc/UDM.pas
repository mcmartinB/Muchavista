unit UDM;

interface

uses
  SysUtils, Classes, DB, DBTables, Forms, ImgList, Controls, cxGraphics, Dialogs;

type
  TDM = class(TDataModule)
    BDProyecto: TDatabase;
    ilImagenes: TcxImageList;
    QUsuario: TQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CargarParametrosBaseDatos(NombreBaseDatos: string);
  end;

var
  DM: TDM;

function AbrirBaseDatos: boolean;
function ConectarBaseDatos: boolean;
function GetComputerNetName: string;

implementation

uses UFAcceso, CVariables, Windows, IniFiles;
{$R *.dfm}

function AbrirBaseDatos: boolean;
var FAcceso: TFAcceso;
begin
  result := false;
  FAcceso := TFAcceso.Create(Application);
  try
//    FAcceso.txUsuario.Text := GetComputerNetName;
    FAcceso.txUsuario.Text := gsUsuario;
    FAcceso.txClave.Text := gsClave;
    if FAcceso.ShowModal = mrOK then
    begin
      gsUsuario := FAcceso.txUsuario.Text;
      gsClave := FAcceso.txClave.Text;
      gsAlias := FAcceso.cbAlias.Properties.Items[FAcceso.cbAlias.ItemIndex];
      gsAlias := UpperCase(gsAlias);
      if ConectarBaseDatos then
      begin
        DM.QUsuario.Databasename := DM.BDProyecto.DatabaseName;
        if DM.QUsuario.Active then
          DM.QUsuario.Close;
        DM.QUsuario.SQL.Clear;
        DM.QUsuario.SQL.Add(' select * from usuario ');
        DM.QUsuario.SQL.Add('  where nombre = :usuario ');
        DM.QUsuario.ParamByName('usuario').AsString := gsUsuario;
        DM.QUsuario.Open;
        if DM.QUsuario.Isempty then
        begin
          ShowMessage(' ATENCION! Usuario INCORRECTO para la Base de Datos.');
          if DM.BDProyecto.Connected then
            DM.BDProyecto.Connected := false; //Close;
          gsAlias := 'NO CONECTADO';
        end
        else
         Result := true;
        end;
      end;
  finally
    FreeAndNil(FAcceso);
  end;

end;

function ConectarBaseDatos: boolean;
begin
  Result := false;

  if DM.BDProyecto.Connected then
    DM.BDProyecto.Connected := false; //Close;
  try
    DM.CargarParametrosBaseDatos(gsAlias);
    DM.BDProyecto.DatabaseName := gsAlias;
    DM.BDProyecto.Connected := true; //Open;

    Result := true;
  except
    on e: Exception do
    begin
      showmessage('Error al conectar con la Base de Datos ' + gsAlias + #13 + #10 +
                  'Por favor, intente de nuevo la conexión. ' + #13 + #10 +
                  e.Message);
    end;
  end;
end;

function GetComputerNetName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;

{ TDM }

procedure TDM.CargarParametrosBaseDatos(NombreBaseDatos: string);
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\aguas.ini') ;
  try
    iniFile.ReadSectionValues(NombreBaseDatos, BDProyecto.Params);
  finally
    iniFile.Free;
  end;
end;

initialization
  DM := TDM.Create(nil);

finalization
    DM.Free;

end.
