unit UDM;

interface

uses
  SysUtils, Classes, DB, DBTables, ImgList, Controls, cxGraphics, Forms, Dialogs;

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

function AbrirBaseDatos:boolean;
function ConectarBaseDatos: boolean;



implementation

uses UFAcceso, CVariables, Windows, IniFiles;
{$R *.dfm}

{ TDM }

function AbrirBaseDatos: boolean;
var FAcceso: TFAcceso;
begin
  result := false;
  FAcceso := TFAcceso.Create(Application);
  try
    FAcceso.txUsuario.Text := gsUsuario;
    FAcceso.txClave.Text := gsClave;
    if FAcceso.ShowModal = mrOK then
    begin
      gsUsuario := FAcceso.txUsuario.Text;
      gsClave := FAcceso.txClave.Text;
      gsAlias := FAcceso.cbAlias.Properties.Items[FAcceso.cbAlias.ItemIndex];
      if ConectarBaseDatos then
      begin
        with DM.QUsuario do
        begin
          if Active then
            Close;
          DataBaseName := DM.BDProyecto.DatabaseName;
          SQL.Clear;
          SQL.Add(' select * from usuario ');
          SQL.Add('  where nombre = :usuario ');

          ParamByName('usuario').AsString := gsUsuario;

          Open;

          if Isempty then
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
