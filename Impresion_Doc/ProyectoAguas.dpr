program ProyectoAguas;

uses
  Forms,
  UFPrincipal in 'UFPrincipal.pas' {FPrincipal},
  UDM in 'UDM.pas' {DM: TDataModule},
  URExtracto in 'URExtracto.pas' {RExtracto: TQuickRep},
  UFAcceso in 'UFAcceso.pas' {FAcceso},
  CVariables in 'CVariables.pas',
  URParteTrabajo in 'URParteTrabajo.pas' {RParteTrabajo: TQuickRep},
  URFacturaVenta in 'URFacturaVenta.pas' {RFacturaVenta: TQuickRep},
  URDomiciliacion in 'URDomiciliacion.pas' {RDomiciliacion: TQuickRep},
  UEnvioCorreo in 'UEnvioCorreo.pas',
  UConfig in 'UConfig.pas',
  URFichaLectura in 'URFichaLectura.pas' {RFichaLectura: TQuickRep};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
