unit URExtracto;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, grimgctrl;

type
  TRExtracto = class(TQuickRep)
    BandaTitulo: TQRBand;
    lblTitulo: TQRLabel;
    QRGrupoCliente: TQRGroup;
    qrEmpresa: TQRDBText;
    qrFechaCobro: TQRDBText;
    QRDetalle: TQRBand;
    lbl2: TQRLabel;
    lbl3: TQRLabel;
    lbl4: TQRLabel;
    qrCodRec: TQRDBText;
    qrTotRec: TQRDBText;
    QRHRule1: TQRHRule;
    QRPieCliente: TQRBand;
    QRHRule2: TQRHRule;
    lbImporteTotal: TQRLabel;
    lbTextTotal: TQRLabel;
    lbPerRec: TQRLabel;
    qrCodZon: TQRDBText;
    lbl1: TQRLabel;
    qrCodCli: TQRDBText;
    qrTitCli: TQRDBText;
    qrDomcli: TQRDBText;
    qs30: TQRShape;
    procedure QRDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGrupoClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRPieClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    rImporteTotal: real;

  public

  end;

var
  RExtracto: TRExtracto;

implementation

uses UFPrincipal, CVariables;
{$R *.DFM}

procedure TRExtracto.QRDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
  var sPeriodo: String;
begin
  if ((gsAlias = 'MUCHAVISTA') and (DataSet.FieldByName('ano_rec').AsInteger >= 2013)) or
      ((gsAlias = 'SILIM') and (DataSet.FieldByName('ano_rec').AsInteger >= 2016)) then
  begin
    if DataSet.FieldByName('per_rec').AsInteger = 1 then
      sPeriodo := IntToStr(DataSet.FieldByName('per_rec').AsInteger) + ' 1º TRIM. ' +
                  IntToStr(DataSet.FieldByName('ano_rec').AsInteger)
    else if DataSet.FieldByName('per_rec').AsInteger = 2 then
      sPeriodo := IntToStr(DataSet.FieldByName('per_rec').AsInteger) + ' 2º TRIM. ' +
                  IntToStr(DataSet.FieldByName('ano_rec').AsInteger)
    else if DataSet.FieldByName('per_rec').AsInteger = 3 then
      sPeriodo := IntToStr(DataSet.FieldByName('per_rec').AsInteger) + ' 3º TRIM. ' +
                  IntToStr(DataSet.FieldByName('ano_rec').AsInteger)
    else if DataSet.FieldByName('per_rec').AsInteger = 4 then
      sPeriodo := IntToStr(DataSet.FieldByName('per_rec').AsInteger) + ' 4º TRIM. ' +
                  IntToStr(DataSet.FieldByName('ano_rec').AsInteger);
  end
  else
  begin
    if DataSet.FieldByName('per_rec').AsInteger = 1 then
      sPeriodo := IntToStr(DataSet.FieldByName('per_rec').AsInteger) + ' 1º BIMES.' +
                  IntToStr(DataSet.FieldByName('ano_rec').AsInteger)
    else if DataSet.FieldByName('per_rec').AsInteger = 2 then
      sPeriodo := IntToStr(DataSet.FieldByName('per_rec').AsInteger) + ' 2º BIMES.' +
                  IntToStr(DataSet.FieldByName('ano_rec').AsInteger)
    else if DataSet.FieldByName('per_rec').AsInteger = 3 then
      sPeriodo := IntToStr(DataSet.FieldByName('per_rec').AsInteger) + ' 3º BIMES.' +
                  IntToStr(DataSet.FieldByName('ano_rec').AsInteger)
    else if DataSet.FieldByName('per_rec').AsInteger = 4 then
      sPeriodo := IntToStr(DataSet.FieldByName('per_rec').AsInteger) + ' 4º BIMES.' +
                  IntToStr(DataSet.FieldByName('ano_rec').AsInteger)
    else if DataSet.FieldByName('per_rec').AsInteger = 5 then
      sPeriodo := IntToStr(DataSet.FieldByName('per_rec').AsInteger) + ' 5º BIMES.' +
                  IntToStr(DataSet.FieldByName('ano_rec').AsInteger)
    else if DataSet.FieldByName('per_rec').AsInteger = 6 then
      sPeriodo := IntToStr(DataSet.FieldByName('per_rec').AsInteger) + ' 6º BIMES.' +
                  IntToStr(DataSet.FieldByName('ano_rec').AsInteger);
  end;

  lbPerRec.Caption := sPeriodo;

  rImporteTotal := rImporteTotal + DataSet.FieldByName('tot_rec').AsFloat;
end;

procedure TRExtracto.QRGrupoClienteBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rImporteTotal := 0;
end;

procedure TRExtracto.QRPieClienteBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbImporteTotal.Caption := FormatFloat('#,##0.00', rImporteTotal); 
end;

end.
