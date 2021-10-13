unit BaseDatos;

interface

uses
  SysUtils, Classes, DB, DBTables, ImgList, Controls;

type
  TMBaseDatos = class(TDataModule)
    imgEnabledx32: TImageList;
    imgDisabledx32: TImageList;
    imgEnabledx16: TImageList;
    imgDisabledx16: TImageList;
    QryDatabase: TQuery;
    DSDatabase: TDataSource;
    DSObservaciones: TDataSource;
    QryObservaciones: TQuery;
    Database1: TDatabase;
    TableObservaciones: TTable;
  private
    { Private declarations }
    FBaseDatos: TDatabase;
    procedure SetBaseDatos(const Value: TDatabase);
  public
    { Public declarations }
    property BaseDatos: TDatabase read FBaseDatos write SetBaseDatos;
    function GetAllDatabasesToStringList: TStringList;
  end;

var
  MBaseDatos: TMBaseDatos;

implementation

{$R *.dfm}

uses
  forms,
  inifiles,
  ClasesOtras;
  
procedure TMBaseDatos.SetBaseDatos(const Value: TDatabase);
begin
  if Assigned(FBaseDatos) then
    FBaseDatos.Connected := False;
  FBaseDatos := Value;
  QryDatabase.DatabaseName := FBaseDatos.DatabaseName;
  TableObservaciones.DatabaseName := FBaseDatos.DatabaseName;
  DSObservaciones.DataSet := TableObservaciones;
  DSDatabase.DataSet := QryDatabase;
  FBaseDatos.Connected := true;
end;

function TMBaseDatos.GetAllDatabasesToStringList: TStringList;
var
  EnumItem: TEnumItem;
  iniFile: TIniFile;
  databaseIterator: Integer;
  sections: TStringList;
  params: TStringList;
begin
  iniFile := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\aguas.ini') ;
  sections := TStringList.Create;
  params := TStringList.Create;
  Result := TStringList.Create;
  iniFile.ReadSections(sections);
  try
    for databaseIterator := 0 to sections.Count - 1 do
    begin
      EnumItem := TEnumItem.Create;
      EnumItem.IDFieldValue := databaseIterator;
      EnumItem.TitleField   := iniFile.ReadString(sections[databaseIterator],'DATABASE NAME','');
      EnumItem.FieldObject  := TDatabase.Create(self);
      TDatabase(EnumItem.FieldObject).DatabaseName := iniFile.ReadString(sections[databaseIterator],'DATABASE NAME','');
      TDatabase(EnumItem.FieldObject).DriverName := 'INFORMIX';
      iniFile.ReadSectionValues(sections[databaseIterator], TDatabase(EnumItem.FieldObject).Params);
      TDatabase(EnumItem.FieldObject).LoginPrompt := False;
      // TDatabase(EnumItem.FieldObject).SessionName := 'Default';
      TDatabase(EnumItem.FieldObject).Connected := True;
      Result.AddObject(FormatFloat(EnumItem.TitleField, EnumItem.IDFieldValue), EnumItem);
    end;
  finally
    params.Free;
    sections.Free;
    iniFile.Free;
  end;
end;

end.
