unit Carta2Bis;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TQRCarta2Bis = class(TQuickRep)
    BandaTitulo: TQRBand;
    QRMemo6: TQRMemo;
    QRLabel1: TQRLabel;
    NomCliente: TQRLabel;
    QRLabel4: TQRLabel;
    LetraContrato: TQRLabel;
    QRLabel5: TQRLabel;
    Referencia: TQRLabel;
    Direccion1: TQRLabel;
    Direccion2: TQRLabel;
    DirSuministro: TQRLabel;
    QRMemo7: TQRMemo;
    BandaDetalle: TQRBand;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    Importe: TQRLabel;
    QRShape6: TQRShape;
    Periodo: TQRLabel;
    QRDBText2: TQRDBText;
    BandaSumary: TQRBand;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRLabel2: TQRLabel;
    TotalImporte: TQRLabel;
    QRShape12: TQRShape;
    ChildBand1: TQRChildBand;
    QRMemo1: TQRMemo;
    QRMemo5: TQRMemo;
    tEmpresa2: TQRLabel;
    QRLabel25: TQRLabel;
    BandaColumHeader: TQRBand;
    QRShape11: TQRShape;
    QRLabel8: TQRLabel;
    QRShape1: TQRShape;
    QRLabel12: TQRLabel;
    QRShape10: TQRShape;
    QRLabel13: TQRLabel;
    Query1: TQuery;
    Query1cod_rec: TIntegerField;
    Query1cod_zon: TSmallintField;
    Query1cod_cli: TIntegerField;
    Query1ano_rec: TSmallintField;
    Query1fco_rec: TDateField;
    Query1per_rec: TSmallintField;
    Query1tot_rec: TFloatField;
    tEmpresa: TQRLabel;
    procedure BandaDetalleBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure BandaDetalleAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure BandaSumaryBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure BandaColumHeaderBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
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
   QRCarta2Bis: TQRCarta2Bis;

implementation

uses BaseDatos, Global, Informes;
{$R *.DFM}

//---------------------------- ANTES DE IMPRIMIR DETALLE -----------------------
procedure TQRCarta2Bis.BandaDetalleBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
Var
   ImporteRec: Real;
   ImpEnt: Integer;
   ImpDec: String;
begin
      if (Query1.FieldByName('ano_rec').AsFloat<2009) or (FInformes.cEmpresa.ItemIndex=3) or ((Query1.FieldByName('ano_rec').AsFloat<2016) and (FInformes.cEmpresa.ItemIndex=1)) then
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

//--------------------------- ANTES DE IMPRIMIR REPORT -------------------------
procedure TQRCarta2Bis.QuickRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
     NumDetalle:=0;
     ImporteTotal:=0;
end;

//------------------------ DESPUES DE IMPRIMIR EL DETALLE ----------------------
procedure TQRCarta2Bis.BandaDetalleAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
     NumDetalle:=NumDetalle + 1;
end;

//------------------------ ANTES DE IMPRIMIR EL SUMATORIO ----------------------
procedure TQRCarta2Bis.BandaSumaryBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
Var
   ImpEnt: Integer;
   ImpDec: String;
begin
     ImpEnt:=ParteEntera(ImporteTotal);
     ImpDec:=ParteDecimal(ImporteTotal);
     TotalImporte.Caption:=IntToStr(ImpEnt) + ',' + RellenarCeros(ImpDec,2,'D');
end;

//-------------------------- ANTES DE IMPRIMIR COLUM HEADER --------------------
procedure TQRCarta2Bis.BandaColumHeaderBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     if NumDetalle=NumTotalDetalles then     //En la ultima pagina si no hay detalles no tiene que salir
        PrintBand:=False;
end;

procedure TQRCarta2Bis.BandaTituloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     if (FInformes.cEmpresa.ItemIndex=0) or (FInformes.cEmpresa.ItemIndex=2) then
        tEmpresa.Caption:='AGUAS DE MUCHAVISTA, S.L.'
     else
          tEmpresa.Caption:='AGUAS DEL SILIM, S.A.';
end;

procedure TQRCarta2Bis.ChildBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
     if (FInformes.cEmpresa.ItemIndex=0) or (FInformes.cEmpresa.ItemIndex=2) then
        tEmpresa2.Caption:='AGUAS DE MUCHAVISTA, S.L.'
     else
         tEmpresa2.Caption:='AGUAS DEL SILIM, S.A.';
end;

end.
