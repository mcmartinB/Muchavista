unit Carta3;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TQRCarta3 = class(TQuickRep)
    BandaTitulo: TQRBand;
    Texto: TQRMemo;
    QRLabel1: TQRLabel;
    BandaDetalle: TQRBand;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    Importe: TQRLabel;
    QRShape6: TQRShape;
    Periodo: TQRLabel;
    QRDBText2: TQRDBText;
    BandaSumary: TQRBand;
    BandaColumHeader: TQRBand;
    QRShape1: TQRShape;
    QRLabel9: TQRLabel;
    QRShape2: TQRShape;
    QRLabel10: TQRLabel;
    QRShape3: TQRShape;
    QRLabel11: TQRLabel;
    Query1: TQuery;
    QRMemo2: TQRMemo;
    Query1cod_rec: TIntegerField;
    Query1cod_zon: TSmallintField;
    Query1cod_cli: TIntegerField;
    Query1ano_rec: TSmallintField;
    Query1fco_rec: TDateField;
    Query1per_rec: TSmallintField;
    Query1tot_rec: TFloatField;
    ChildBand1: TQRChildBand;
    Texto2: TQRMemo;
    QRMemo3: TQRMemo;
    QRMemo5: TQRMemo;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRLabel2: TQRLabel;
    TotalImporte: TQRLabel;
    QRMemo7: TQRMemo;
    tEmpresa2: TQRLabel;
    QRLabel25: TQRLabel;
    tEmpresa: TQRLabel;
    procedure BandaColumHeaderBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure BandaDetalleAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BandaDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaSumaryBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaTituloBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
         NumDetalle: Integer;
         ImporteTotal: Real;
  public
        NumTotalDetalles: Integer;
  end;

var
  QRCarta3: TQRCarta3;

implementation

uses Global, Informes;

{$R *.DFM}

procedure TQRCarta3.BandaColumHeaderBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     if NumDetalle=NumTotalDetalles then
        PrintBand:=False;
end;

procedure TQRCarta3.QuickRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
     NumDetalle:=0;
     ImporteTotal:=0;
end;

procedure TQRCarta3.BandaDetalleAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
     NumDetalle:=NumDetalle + 1;
end;

procedure TQRCarta3.BandaDetalleBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
     Var
        ImporteRec: Real;
        ImpEnt: Integer;
        ImpDec: String;
begin

     //Periodo
      if (Query1.FieldByName('ano_rec').AsFloat<2009) or (FInformes.cEmpresa.ItemIndex>1) or ((Query1.FieldByName('ano_rec').AsFloat<2016) and (FInformes.cEmpresa.ItemIndex=1)) then
      begin
       // si es anterior a 2009 o es jijona la facturacion es bimensual (Silim y Jijona)
       /// si es anterior a 2016 y la empresa es aguas del silim es bimensual
       if Query1.FieldByName('per_rec').AsString='1' then
          Periodo.Caption:='ENE/FEB. ' + Query1.FieldByName('ano_rec').AsString
       else if Query1.FieldByName('per_rec').AsString='2' then
             Periodo.Caption:='MAR/ABR. ' + Query1.FieldByName('ano_rec').AsString
          else if Query1.FieldByName('per_rec').AsString='3' then
                  Periodo.Caption:='MAY/JUN. ' + Query1.FieldByName('ano_rec').AsString
               else if Query1.FieldByName('per_rec').AsString='4' then
                       Periodo.Caption:='JUL/AGO. ' + Query1.FieldByName('ano_rec').AsString
                    else if Query1.FieldByName('per_rec').AsString='5' then
                            Periodo.Caption:='SEP/OCT. ' + Query1.FieldByName('ano_rec').AsString
                         else if Query1.FieldByName('per_rec').AsString='6' then
                                 Periodo.Caption:='NOV/DIC. ' + Query1.FieldByName('ano_rec').AsString
        end
      else
        // si es 2009 o posterior y la empresa es Aguas de Muchavista la facturacion es trimestral
        // si es 2016 o posterior y la empresa es Aguas de Silim la facturacion es trimestral
        if Query1.FieldByName('per_rec').AsString='1' then
          Periodo.Caption:='ENE/MAR. ' + Query1.FieldByName('ano_rec').AsString
        else if Query1.FieldByName('per_rec').AsString='2' then
             Periodo.Caption:='ABR/JUN. ' + Query1.FieldByName('ano_rec').AsString
          else if Query1.FieldByName('per_rec').AsString='3' then
                  Periodo.Caption:='JUL/SEP. ' + Query1.FieldByName('ano_rec').AsString
               else if Query1.FieldByName('per_rec').AsString='4' then
                       Periodo.Caption:='OCT/DIC. ' + Query1.FieldByName('ano_rec').AsString;


     //Importe
     if ((Query1.FieldByName('ano_rec').AsFloat = 2001) and (Query1.FieldByName('Per_rec').AsFloat <= 5)) or
        (Query1.FieldByName('ano_rec').AsFloat < 2001) then
           ImporteRec:=Redondear(Query1.FieldByName('tot_rec').AsFloat/166.386,2)
     else
         ImporteRec:=Query1.FieldByName('tot_rec').AsFloat;

     ImporteTotal:=Redondear(ImporteTotal + ImporteRec,2);

     ImpEnt:=ParteEntera(ImporteRec);
     ImpDec:=ParteDecimal(ImporteRec);
     Importe.Caption:=IntToStr(ImpEnt) + ',' + RellenarCeros(ImpDec,2,'D');
end;

//----------------------- ANTES DE IMPRIMIR EL SUMARY --------------------------
procedure TQRCarta3.BandaSumaryBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
     Var
        ImpEnt: Integer;
        ImpDec: String;
begin
     ImpEnt:=ParteEntera(ImporteTotal);
     ImpDec:=ParteDecimal(ImporteTotal);
     TotalImporte.Caption:=IntToStr(ImpEnt) + ',' + RellenarCeros(ImpDec,2,'D');
end;

procedure TQRCarta3.BandaTituloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     if (FInformes.cEmpresa.ItemIndex=0) or (FInformes.cEmpresa.ItemIndex=2) then
        tEmpresa.Caption:='AGUAS DE MUCHAVISTA, S.L.'
     else
         tEmpresa.Caption:='AGUAS DEL SILIM, S.A.';
end;

procedure TQRCarta3.ChildBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     if (FInformes.cEmpresa.ItemIndex=0) or (FInformes.cEmpresa.ItemIndex=2) then
        tEmpresa2.Caption:='AGUAS DE MUCHAVISTA, S.L.'
     else
         tEmpresa2.Caption:='AGUAS DEL SILIM, S.A.';
end;

end.
