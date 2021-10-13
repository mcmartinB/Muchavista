program GeneradorSepa;

uses
  Forms,
  UFPrincipal in 'UFPrincipal.pas' {FPrincipal},
  UDM in 'UDM.pas' {DM: TDataModule},
  UFAcceso in 'UFAcceso.pas' {FAcceso};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFAcceso, FAcceso);
  Application.Run;
end.
