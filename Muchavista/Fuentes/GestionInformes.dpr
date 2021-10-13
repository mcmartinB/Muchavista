program GestionInformes;

uses
  Forms,
  Informes in 'Informes.pas' {FInformes},
  Global in 'Global.pas',
  Carta3 in 'Carta3.pas' {QRCarta3: TQuickRep},
  Carta1 in 'Carta1.pas' {QRCarta1: TQuickRep},
  BaseDatos in 'BaseDatos.pas' {MBaseDatos: TDataModule},
  Unit1 in 'Unit1.pas' {QuickReport1: TQuickRep},
  Carta2Bis in 'Carta2Bis.pas' {QRCarta2Bis: TQuickRep},
  Carta2 in 'Carta2.pas' {QRCarta2: TQuickRep};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMBaseDatos, MBaseDatos);
  Application.CreateForm(TFInformes, FInformes);
  Application.CreateForm(TQRCarta3, QRCarta3);
  Application.CreateForm(TQuickReport1, QuickReport1);
  Application.CreateForm(TQRCarta2Bis, QRCarta2Bis);
  Application.CreateForm(TQRCarta2, QRCarta2);
  Application.Run;
end.
