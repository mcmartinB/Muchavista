unit UnMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles;

type
  TFrmMenu = class(TForm)
    btImpresionDocumentos: TButton;
    btGestionInformes: TButton;
    btSEPA: TButton;
    btGestionClientes: TButton;
    procedure btImpresionDocumentosClick(Sender: TObject);
    procedure btGestionInformesClick(Sender: TObject);
    procedure btSEPAClick(Sender: TObject);
    procedure btGestionClientesClick(Sender: TObject);
  private
    { Private declarations }
    FIniFile: TIniFile;
    procedure EjecutaAplicacion(const PNombreAplicacion: string);
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses
  ShellAPI;

procedure TFrmMenu.btGestionClientesClick(Sender: TObject);
begin
  EjecutaAplicacion('GestionClientes');
end;

procedure TFrmMenu.btGestionInformesClick(Sender: TObject);
begin
  EjecutaAplicacion('GestionInformes');
end;

procedure TFrmMenu.btImpresionDocumentosClick(Sender: TObject);
begin
  Ejecutaaplicacion('ImpresionDocumentos');
end;

procedure TFrmMenu.btSEPAClick(Sender: TObject);
begin
  EjecutaAplicacion('Sepa');
end;

procedure TFrmMenu.EjecutaAplicacion(const PNombreAplicacion: string);
var
  Command: string;
  Parameters: string;
begin
  try
    FIniFile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
    try
      Command := FIniFile.ReadString('APLICACIONES',PNombreAplicacion,'');
      ShellExecute(Handle, 'open', PChar(Command), nil, nil, SW_SHOW);
    except
      on E: Exception do
        MessageDlg('Error al ejecutar '+ PNombreAplicacion ,mtError, mbOKCancel, 0)
    end;
  finally
    FIniFile.Free;
  end;
end;

end.
