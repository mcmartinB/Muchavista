unit UConfig;

interface

uses
  Dialogs,
  SysUtils,
  IniFiles;

type

  TConfig = class(TObject)
  private
    FIniFile: TIniFile;
    procedure SetClave(const Value: string);
    procedure SetlogFile(const Value: string);
    procedure SetPuerto(const Value: string);
    procedure SetServidor(const Value: string);
    procedure SettmpDir(const Value: string);
    procedure SetUsuario(const Value: string);
    function GetClave: string;
    function GetlogFile: string;
    function GetPuerto: string;
    function GetServidor: string;
    function GettmpDir: string;
    function GetUsuario: string;
  published
  public
    constructor Create();
    destructor Destroy(); override;
    property Usuario: string read GetUsuario write SetUsuario;
    property Clave: string read GetClave write SetClave;
    property Servidor: string read GetServidor write SetServidor;
    property Puerto: string read GetPuerto write SetPuerto;
    property logFile: string read GetlogFile write SetlogFile;
    property tmpDir: string read GettmpDir write SettmpDir;
  end;

implementation



{ TConfig }

constructor TConfig.Create;
begin
  inherited Create();
  try
    FIniFile := TIniFile.Create(ChangeFileExt( ParamStr(0), '.ini' ));
    if not FileExists(ChangeFileExt( ParamStr(0), '.ini' )) then
      begin
        Usuario := '';
        Clave := '';
        Servidor := '';
        Puerto := '';
        logFile := '';
        tmpDir := '';
      end;
  except
    on E: Exception do
      messagedlg(E.ClassName + ': ' + E.Message,mtError, mbOKCancel, 0);
  end;
end;

destructor TConfig.Destroy;
begin
  FreeAndNil(FIniFile);
end;

function TConfig.GetClave: string;
begin
 Result := FIniFile.ReadString('EMAIL','Clave','Lynx784512');
end;

function TConfig.GetlogFile: string;
begin
 Result := FIniFile.ReadString('EMAIL','Log','email.log');
end;

function TConfig.GetPuerto: string;
begin
 Result := FIniFile.ReadString('EMAIL','Puerto','465');
end;

function TConfig.GetServidor: string;
begin
 Result := FIniFile.ReadString('EMAIL','Servidor','smtp.serviciodecorreo.es');
end;

function TConfig.GettmpDir: string;
begin
 Result := FIniFile.ReadString('EMAIL','Temporal','c:\tmp');
end;

function TConfig.GetUsuario: string;
begin
 Result := FIniFile.ReadString('EMAIL','Usuario','lynxview@bonnysa.es');
end;

procedure TConfig.SetClave(const Value: string);
begin
 FIniFile.WriteString('EMAIL','Clave',Value);
end;

procedure TConfig.SetlogFile(const Value: string);
begin
 FIniFile.WriteString('EMAIL','Log',Value);
end;

procedure TConfig.SetPuerto(const Value: string);
begin
 FIniFile.WriteString('EMAIL','Puerto',Value);
end;

procedure TConfig.SetServidor(const Value: string);
begin
 FIniFile.WriteString('EMAIL','Servidor',Value);
end;

procedure TConfig.SettmpDir(const Value: string);
begin
 FIniFile.WriteString('EMAIL','Temporal',Value);
end;

procedure TConfig.SetUsuario(const Value: string);
begin
 FIniFile.WriteString('EMAIL','Usuario',Value);
end;

end.
