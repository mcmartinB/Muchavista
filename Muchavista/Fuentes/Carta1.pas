unit Carta1;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TQRCarta1 = class(TQuickRep)
    Query1: TQuery;
    QRBand1: TQRBand;
    QRMemo1: TQRMemo;
    QRLabel2: TQRLabel;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRBand3: TQRBand;
    QRShape1: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape2: TQRShape;
    QRShape4: TQRShape;
    QRDBText1: TQRDBText;
    QRShape3: TQRShape;
    Periodo: TQRLabel;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    Referencia: TQRLabel;
    NomCliente: TQRLabel;
    Direccion1: TQRLabel;
    Importe: TQRLabel;
    Query1cod_rec: TIntegerField;
    Query1cod_zon: TSmallintField;
    Query1cod_cli: TIntegerField;
    Query1ano_rec: TSmallintField;
    Query1fco_rec: TDateField;
    Query1tot_rec: TFloatField;
    Query1per_rec: TSmallintField;
    QRBand4: TQRBand;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRLabel6: TQRLabel;
    QRShape12: TQRShape;
    TotalImporte: TQRLabel;
    Hojas: TQRLabel;
    QRMemo2: TQRMemo;
    tEmpresa: TQRLabel;
    procedure QRBand3AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
         NumDetalles: Integer;   //Para controlar el numero de detalles y que me salte bien de pagina
         ImporteTotal: Real;
  public
        NumPaginas: Integer
  end;

var
  QRCarta1: TQRCarta1;

implementation

uses BaseDatos, Global, Informes;

{$R *.DFM}

procedure TQRCarta1.QRBand3AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
     NumDetalles:=NumDetalles + 1;  //Para controlar el numero de detalles y que me salte bien de pagina
end;

procedure TQRCarta1.QRBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
     Var
        ImporteRec: Real;
        ImpEnt: Integer;
        ImpDec: String;
begin
     //Para controlar el numero de detalles y que me salte bien de pagina
     if NumDetalles=31 then
     begin
          Self.NewPage;
          NumDetalles:=0;
     end;

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


procedure TQRCarta1.QuickRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
     NumDetalles:=0;
     ImporteTotal:=0;
end;

procedure TQRCarta1.QRBand4BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  Var
     ImpEnt: Integer;
     ImpDec: String;
begin
     ImpEnt:=ParteEntera(ImporteTotal);
     ImpDec:=ParteDecimal(ImporteTotal);
     TotalImporte.Caption:=IntToStr(ImpEnt) + ',' + RellenarCeros(ImpDec,2,'D');
end;

procedure TQRCarta1.QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     Hojas.Caption:='Hoja ' + IntToStr(Self.PageNumber) + ' de ' + IntToStr(NumPaginas);
     if (FInformes.cEmpresa.ItemIndex=0) or (FInformes.cEmpresa.ItemIndex=2) then
        tEmpresa.Caption:='AGUAS DE MUCHAVISTA, S.L.'
     else
         tEmpresa.Caption:='AGUAS DEL SILIM, S.A.';
end;

end.
