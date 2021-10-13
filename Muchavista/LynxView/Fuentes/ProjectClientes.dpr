program ProjectClientes;

uses
  FastMM4,
  Forms,
  Clientes in 'Clientes.pas' {frmClientes},
  BaseDatos in 'BaseDatos.pas' {MBaseDatos: TDataModule},
  ClasesCliente in 'ClasesCliente.pas',
  ClasesOtras in 'ClasesOtras.pas',
  AplicacionProcedimientosFunciones in 'AplicacionProcedimientosFunciones.pas',
  AplicacionConstantes in 'AplicacionConstantes.pas',
  AplicacionVariables in 'AplicacionVariables.pas',
  FormularioBase in 'FormularioBase.pas' {frmFormBase},
  ClienteAnadirModificar in 'ClienteAnadirModificar.pas' {frmClienteAnadirModificar},
  Busqueda in 'Busqueda.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmClientes, frmClientes);
  Application.Run;
end.
