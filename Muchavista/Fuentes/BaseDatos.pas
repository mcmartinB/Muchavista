unit BaseDatos;

interface

uses
  SysUtils, Classes, DB, DBTables, Dialogs;

type
  TMBaseDatos = class(TDataModule)
    BaseDatos: TDatabase;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CargarParametrosBaseDatos(NombreBaseDatos: string);
  end;

var
  MBaseDatos: TMBaseDatos;

implementation

{$R *.dfm}

uses
  IniFiles, Forms;

procedure TMBaseDatos.CargarParametrosBaseDatos(NombreBaseDatos: string);
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\aguas.ini') ;
  try
    iniFile.ReadSectionValues(NombreBaseDatos, BaseDatos.Params);
    BaseDatos.DatabaseName := NombreBaseDatos;
    Basedatos.Connected := true;
  finally
    iniFile.Free;
  end;
end;

procedure TMBaseDatos.DataModuleCreate(Sender: TObject);
begin
     MBaseDatos:=Self;
end;

end.
