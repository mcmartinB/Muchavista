unit URFichaLecturaEmail;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRFichaLecturaEmail = class(TQuickRep)
    lb9: TQRLabel;
    lb10: TQRLabel;
    lb11: TQRLabel;
    lb12: TQRLabel;
    lb13: TQRLabel;
    QRBand2: TQRBand;
    qs19: TQRShape;
    lb25: TQRLabel;
    lb26: TQRLabel;
    lb27: TQRLabel;
    qs20: TQRShape;
    qs21: TQRShape;
    lb28: TQRLabel;
    qs22: TQRShape;
    qs23: TQRShape;
    qs24: TQRShape;
    lb29: TQRLabel;
    qrAno1: TQRDBText;
    qs25: TQRShape;
    qs26: TQRShape;
    lb30: TQRLabel;
    qs27: TQRShape;
    lb31: TQRLabel;
    qs28: TQRShape;
    qs29: TQRShape;
    lb32: TQRLabel;
    qrLacCli: TQRDBText;
    qrFacCli: TQRDBText;
    qs30: TQRShape;
    lb33: TQRLabel;
    qs31: TQRShape;
    lb34: TQRLabel;
    qs32: TQRShape;
    qs33: TQRShape;
    qrCodZon: TQRDBText;
    lb35: TQRLabel;
    qrCodCli: TQRDBText;
    qrTitCli: TQRDBText;
    qrDomCli: TQRDBText;
    lb36: TQRLabel;
    qrCntCli: TQRDBText;
    qrTitPob: TQRDBText;
    qrTitPro: TQRDBText;
    lb37: TQRLabel;
    qrTelCli: TQRDBText;
    lb38: TQRLabel;
    lb39: TQRLabel;
    qrFcoCli: TQRDBText;
    lbNumero: TQRLabel;
    lbUso: TQRLabel;
    lb1: TQRLabel;
    qrAno2: TQRDBText;
    lb7: TQRLabel;
    qrAno3: TQRDBText;
    lb2: TQRLabel;
    lb3: TQRLabel;
    lb4: TQRLabel;
    qs1: TQRShape;
    qs2: TQRShape;
    lb5: TQRLabel;
    lb6: TQRLabel;
    lb8: TQRLabel;
    qs3: TQRShape;
    qs4: TQRShape;
    lb14: TQRLabel;
    lb15: TQRLabel;
    qrCodTip: TQRDBText;
    qrCalTip: TQRDBText;
    lb16: TQRLabel;
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

var
  RFichaLecturaEmail: TRFichaLecturaEmail;

implementation

{$R *.DFM}

procedure TRFichaLecturaEmail.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbNumero.Caption := DataSet.FieldByName('let_cli').AsString + ' - ' +
                      DataSet.FieldByName('con_cli').AsString;
  if DataSet.FieldByName('dom_ind').AsString = 'I' then
    lbUso.Caption := 'USO INDUSTRIAL'
  else
    lbUso.Caption := 'USO DOMESTICO';
end;

end.
