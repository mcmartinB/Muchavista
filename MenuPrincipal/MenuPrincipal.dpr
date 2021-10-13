program MenuPrincipal;

uses
  Forms,
  UnMain in 'UnMain.pas' {FrmMenu};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.Run;
end.
