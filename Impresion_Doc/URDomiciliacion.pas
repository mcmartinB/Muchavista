unit URDomiciliacion;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRDomiciliacion = class(TQuickRep)
    QRGroup1: TQRGroup;
    lb1: TQRLabel;
    lb2: TQRLabel;
    qrReferencia: TQRDBText;
    lbNombre: TQRLabel;
    lbDireccion: TQRLabel;
    lbPoblacion: TQRLabel;
    lbCif: TQRLabel;
    lbTelefono: TQRLabel;
    lbTexto1: TQRLabel;
    lb3: TQRLabel;
    qrTexto1: TQRDBText;
    qs1: TQRShape;
    lb4: TQRLabel;
    lb5: TQRLabel;
    qrTexto2: TQRDBText;
    qs2: TQRShape;
    lb6: TQRLabel;
    qrCodPob: TQRDBText;
    qs3: TQRShape;
    lb7: TQRLabel;
    qrTitPob: TQRDBText;
    qs4: TQRShape;
    lb8: TQRLabel;
    lb9: TQRLabel;
    qs5: TQRShape;
    lb10: TQRLabel;
    lb11: TQRLabel;
    qs6: TQRShape;
    lb12: TQRLabel;
    qs11: TQRShape;
    lb13: TQRLabel;
    qs12: TQRShape;
    lb14: TQRLabel;
    lb15: TQRLabel;
    qs13: TQRShape;
    lb16: TQRLabel;
    lbNombre2: TQRLabel;
    lbIBAN: TQRLabel;
    qs14: TQRShape;
    lb19: TQRLabel;
    lbDireccion2: TQRLabel;
    qs15: TQRShape;
    lb21: TQRLabel;
    lbPoblacion2: TQRLabel;
    qs16: TQRShape;
    lb23: TQRLabel;
    lb24: TQRLabel;
    qs17: TQRShape;
    lb25: TQRLabel;
    lb17: TQRLabel;
    lb18: TQRLabel;
    lb22: TQRLabel;
    lb20: TQRLabel;
    lb26: TQRLabel;
    lb27: TQRLabel;
    qrDetalle: TQRBand;
    lbTexto2: TQRLabel;
    lbTexto3: TQRLabel;
    qrIBAN: TQRDBText;
    qrBIC: TQRDBText;
    qrDesBic: TQRDBText;
    lb28: TQRLabel;
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    procedure CargaEmpresa;

  public

  end;

var
  RDomiciliacion: TRDomiciliacion;

implementation

uses CVariables, UDM, UFPrincipal;

{$R *.DFM}

procedure TRDomiciliacion.CargaEmpresa;
begin
  with FPrincipal.QEmpresa do
  begin
    if Active then
      Close;

    Open;
  end;
end;

procedure TRDomiciliacion.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lb28.Caption := FormatDatetime('dd/mm/yyyy', Now);

  if (gsAlias = 'MUCHAVISTA') OR (gsAlias = 'JIJONA') then
  begin
    lbNombre.Caption := 'AGUAS DE MUCHAVISTA, S.L.';
    lbDireccion.Caption := 'MAYOR, 4 BAJO';
    lbPoblacion.Caption := '03110 BUSOT (ALICANTE)';
    lbCif.Caption := 'CIF: B-03020369';
    lbTelefono.Caption := 'TELF: 965698359';

    lbNombre2.Caption := 'AGUAS DE MUCHAVISTA, S.L.';
    lbIBAN.Caption := 'ES55000B03020369';
    lbDireccion2.Caption := 'MAYOR, 4 BAJO';
    lbPoblacion2.Caption := '03110 BUSOT (ALICANTE)';


  end;
  if gsAlias = 'SILIM' then
  begin
    lbNombre.Caption := 'AGUAS DEL SILIM, S.L.';
    lbDireccion.Caption := 'LA FONT DEL POUET, 1';
    lbPoblacion.Caption := '03550 SAN JUAN (ALICANTE)';
    lbCif.Caption := 'CIF: B-03133881';
    lbTelefono.Caption := '';//'TELF: 965698359';

    lbNombre2.Caption := 'AGUAS DEL SILIM, S.L.';
    lbIBAN.Caption := '';//'ES55000B03020369';
    lbDireccion2.Caption := 'LA FONT DEL POUET, 1';
    lbPoblacion2.Caption := '03550 SAN JUAN (ALICANTE)';

  end;

  //Texto1
  lbTexto1.Caption := 'Mediante la firma de este formulario de Orden de Domiciliación, Usted autoriza ' +
                     'a (A) ' + FPrincipal.QEmpresa.FieldByName('raz_soc').AsString + ' a enviar ordenes a su entidad ' +
                     'financiera para adeudar su cuenta y (B) a su entidad financiera para adeudar los importes ' +
                     'correspondientes en su cuenta de acuerdo con las ordenes ' + FPrincipal.QEmpresa.FieldByName('raz_soc').AsString +  #13 + #10 +
                     'Como parte de sus derechos, tiene derecho a ser reembolsado por su banco en virtud de los terminos y ' +
                     'condiciones del acuerdo suscrito con su banco. Dicho reembolso, debería reclamarse en un plazo de 8 ' +
                     'semanas a partir de la fecha de cargo en su cuenta.';
  //Texto2
  lbTexto2.Caption := 'Una vez firmada, esta orden de domiciliación debe ser enviada al acreedor para su custodia.';

  //Texto3
  lbTexto3.Caption := 'En cumplimiento de la Ley Orgánica 15/1999, de 13 de diciembre, de Protección de Datos de Carácter ' +
                      'Personal (LOPD), le informamos que los datos personales que nos facilita en el siguiente formulario ' +
                      'tienen como finalidad la domiciliación bancaria de los recibos de los servicios contratados. Dichos ' +
                      'datos pasarán a formar parte de un fichero titularidad de ' + FPrincipal.QEmpresa.FieldByName('raz_soc').AsString +  #13 + #10 +
                      'Ud. autoriza a ' + FPrincipal.QEmpresa.FieldByName('raz_soc').AsString + ' al tratamiento de los datos '+
                      ' con la anterior finalidad y a la comunicación de los ' +
                      'mismos a las entidades bancarias necesarias para poder realizar el cargo bancario de los recibos.. ' + #13 + #10 +
                      'Podrá ejercitar sus derechos en los términos que indica la Ley dirigiéndose a ' +
                      FPrincipal.QEmpresa.FieldByName('raz_soc').AsString + ' ' +
                      FPrincipal.QEmpresa.FieldByName('dir_empr').AsString + ' (' +
                      FPrincipal.QEmpresa.FieldByName('cpo_empr').AsString + ') ' +
                      FPrincipal.QEmpresa.FieldByName('tit_pob').AsString + ' - '+
                      FPrincipal.QEmpresa.FieldByName('tit_pro').AsString;
end;

procedure TRDomiciliacion.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  CargaEmpresa;
end;

end.
