unit URParteTrabajo;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, dxGDIPlusClasses;

type
  TRParteTrabajo = class(TQuickRep)
    QRBand1: TQRBand;
    qs1: TQRShape;
    lbFec: TQRLabel;
    qs2: TQRShape;
    lbHor: TQRLabel;
    qs3: TQRShape;
    lbUsuario: TQRLabel;
    qrTitCli: TQRDBText;
    qs4: TQRShape;
    lbContador: TQRLabel;
    qs5: TQRShape;
    lbMetros: TQRLabel;
    qrCntCli: TQRDBText;
    qrCalTip: TQRDBText;
    qs6: TQRShape;
    lb1: TQRLabel;
    qrCodZon: TQRDBText;
    lb35: TQRLabel;
    qrCodCli: TQRDBText;
    qs7: TQRShape;
    lb2: TQRLabel;
    qrTelCli: TQRDBText;
    qs8: TQRShape;
    lb3: TQRLabel;
    qrDomCli: TQRDBText;
    qrCodPob: TQRDBText;
    qrTitPro: TQRDBText;
    qrTitPob: TQRDBText;
    qs9: TQRShape;
    lb4: TQRLabel;
    qrTexto1: TQRDBText;
    qrTexto2: TQRDBText;
    qrTexto3: TQRDBText;
    qs10: TQRShape;
    lb5: TQRLabel;
    qs11: TQRShape;
    lb6: TQRLabel;
    qrTexto4: TQRDBText;
    qrTexto5: TQRDBText;
    qrTexto6: TQRDBText;
    lbFecha: TQRLabel;
    lbHora: TQRLabel;
    qs12: TQRShape;
    qs13: TQRShape;
    lb7: TQRLabel;
    lb8: TQRLabel;
    lb9: TQRLabel;
    lb10: TQRLabel;
    lb11: TQRLabel;
    lb12: TQRLabel;
    lb13: TQRLabel;
    lb14: TQRLabel;
    lb15: TQRLabel;
    lb16: TQRLabel;
    lb17: TQRLabel;
    lb18: TQRLabel;
    lb19: TQRLabel;
    lb20: TQRLabel;
    lb21: TQRLabel;
    lb22: TQRLabel;
    lb23: TQRLabel;
    lb24: TQRLabel;
    qs14: TQRShape;
    lb25: TQRLabel;
    qs15: TQRShape;
    lb26: TQRLabel;
    qrEmpresa: TQRDBText;
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

var
  RParteTrabajo: TRParteTrabajo;

implementation

{$R *.DFM}

procedure TRParteTrabajo.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbFecha.Caption := FormatDatetime('dd/mm/yyyy', Now);
  lbHora.Caption := FormatDateTime('HH:MM',Now);
end;

end.
