unit UFPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, Menus, xmldom,
  XMLIntf, msxmldom, XMLDoc, StdCtrls, cxButtons, cxGroupBox, DBTables,
  cxTextEdit, cxLabel, FileCtrl, dxGDIPlusClasses, cxImage, Gauges;

type

  TCamposTabla = record
    sLetra: String;
    iNumero: integer;
  end;

  TTabla = record
    ACampos: array of TCamposTabla;
  end;

  TFPrincipal = class(TForm)
    gb1: TcxGroupBox;
    btGenerarXML: TcxButton;
    XMLDocument: TXMLDocument;
    lb6: TcxLabel;
    txRuta: TcxTextEdit;
    btnRuta: TcxButton;
    btnSalir: TcxButton;
    cxImage1: TcxImage;
    btCambioEmp: TcxButton;
    lb1: TcxLabel;
    lbEmpresa: TcxLabel;
    lb2: TcxLabel;
    lbUsuario: TcxLabel;
    Gauge1: TGauge;
    lb7: TcxLabel;
    lbFacturas: TcxLabel;
    procedure btGenerarXMLClick(Sender: TObject);
    procedure btnRutaClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure btCambioEmpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    QEmpresa, QNumOper, QNumRemesa, QRecibos, QClientes, QIBAN, QBIC: TQuery;
    Tabla: TTabla;

    procedure CreaQEmpresa;
    function EjecutaQEmpresa: boolean;
    procedure CreaQIBAN;
    function EjecutaQIBAN: boolean;
    procedure CreaQBIC;
    function EjecutaQBIC: boolean;
    procedure CreaQNumOper;
    procedure CreaQNumRemesa;
    procedure CreaQRecibos;
    function EjecutaQRecibos: boolean;
    procedure CreaQClientes;
    function EjecutaQClientes: boolean;
    function NumeroOper: Integer;
    function CantidadTotal: real;

    procedure GenerarFichero;
    procedure GrabarFichero;
    function AsignarN2MsgId: String;
    function AsignarN2CreDtTm: String;
    function AsignarN2NbOfTxs: String;
    function AsignarN2CtrlSum: String;
    function AsignarN3Nm: String;
    function AsignarN6Id: String;
    function AsignarN7Cd: String;
    function AsignarN2PmtInfId: String;
    function AsignarN2PmtMtd: String;
    function AsignarN4Cd: String;
    function AsignarN4CdB: String;
    function AsignarN3SeqTp: String;
    function AsignarN4CdC: String;
    function AsignarN2ReqdColltnDt: String;
    function AsignarN3NmB: String;
    function AsignarN4IBAN: String;
    function AsignarN4BIC: String;
    function AsignarN2ChrgBr: String;
    function AsignarN6Id2 :String;
    function AsignarN4InstrId: String;
    function AsignarN4EndToEndId: String;
    function AsignarN3InstdAmt: String;
    function AsignarN5MndtId: String;
    function AsignarN5DtOfSgntr: String;
    function AsignarN5AmdmntInd: String;
    function AsignarN8Id: String;
    function AsignarN9Prtry: String;
    function AsignarN5BIC: String;
    function AsignarN4Nm: String;
    function AsignarN6BICOrBEI: String;
    function AsignarN5IBAN: String;



    function NumOperaciones: Integer;
    function SumaTotal: String;
    function CalcDigitoControl: String;
    function TablaNum(ALetra: String): String;
    function NumRemesa: Integer;
    function FechaCobro: String;
    procedure AccesoBD;
    procedure CargaTabla;
    procedure CerrarTablas;

  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses UDM, CVariables;

{$R *.dfm}

procedure TFPrincipal.btGenerarXMLClick(Sender: TObject);
var iFacturas: integer;
begin
  if gsAlias = 'NO CONECTADO' then
  begin
    showmessage(' ATENCION! No está conectado a ninguna Base de Datos. ');
    exit;
  end;

  gsCodRemesa := NumRemesa;
  if gsCodRemesa = 0 then
  begin
    ShowMessage('ATENCION! No existen datos para generar el fichero SEPA_XML.');
    exit;
  end;

  iFacturas := NumOperaciones;
  lbFacturas.Caption := 'Total facturas: '+formatfloat(',0',iFacturas);
  Gauge1.maxvalue := iFacturas;

  GenerarFichero;
  GrabarFichero;
  XMLDocument.Active := false;
  ShowMessage('Proceso finalizado correctamente.');

  Gauge1.progress:=0;
  Gauge1.maxvalue:=0;
  lbFacturas.Caption := 'Total Facturas: 0';

end;

procedure TFPrincipal.CreaQEmpresa;
begin
  QEmpresa := TQuery.Create(Self);
  with QEmpresa do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select nombre[1,2] codigo, raz_soc, nif_empr from empresa ');

    Prepare;
  end;
end;

function TFPrincipal.EjecutaQEmpresa: boolean;
begin
  with QEmpresa do
  begin
    if Active then
      Close;
    Open;

    Result := not isEmpty;
  end;
end;

procedure TFPrincipal.CreaQIBAN;
begin
  QIBAN := TQuery.Create(Self);
  with QIBAN do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select des_con from contadores ');
    SQL.Add('  where tip_con = "IBAN" ');

    Prepare;
  end;
end;

function TFPrincipal.EjecutaQIBAN: boolean;
begin
  with QIBAN do
  begin
    if Active then
      Close;
    Open;

    Result := not isEmpty;
  end;
end;

procedure TFPrincipal.CreaQBIC;
begin
  QBIC := TQuery.Create(Self);
  with QBIC do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select des_con from contadores ');
    SQL.Add('  where tip_con = "SWIF" ');

    Prepare;
  end;
end;

function TFPrincipal.EjecutaQBIC: boolean;
begin
  with QBIC do
  begin
    if Active then
      Close;
    Open;

    Result := not isEmpty;
  end;
end;

procedure TFPrincipal.CreaQNumOper;
begin
  QNumOper := TQuery.Create(Self);
  with QNumOper do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select count(*) cantidad, SUM(tot_rec) total from recibos ');
    SQL.Add('  where cod_rem  <> 0 ');

    Prepare;
  end;
end;

procedure TFPrincipal.CreaQNumRemesa;
begin
  QNumRemesa := TQuery.Create(Self);
  with QNumRemesa do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select DISTINCT cod_rem, ffa_rec from recibos ');
    SQL.Add('  where cod_rem <> 0 ');

    Prepare;
  end;
end;

procedure TFPrincipal.CreaQRecibos;
begin
  QRecibos := TQuery.Create(Self);
  with QRecibos do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select * from recibos ');
    SQL.Add('  where cod_rem <> 0 ');

    Prepare;
  end;
end;

function TFPrincipal.EjecutaQRecibos: Boolean;
begin
  with QRecibos do
  begin
    if Active then
      Close;

    Open;
    Result := not Isempty;
  end;
end;

procedure TFPrincipal.CreaQClientes;
begin
  QClientes := TQuery.Create(Self);
  with QClientes do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select cod_zon, cod_cli, tit_cli, dom_cli, cod_pob, jof_cli, nif_cli, ');
    SQL.Add('        tel_cli, cod_bic, fco_cli,                                     ');
    SQL.Add('        lpad(cod_iban, 4, "0") || lpad(cod_ban, 4, "0") || lpad(cod_suc, 4, "0") || lpad(dig_con, 2, "0") || lpad(cta_cli, 10, "0") iban ');
    SQL.Add('  from clientes    ');
    SQL.Add('  where cod_zon = :zona    ');
    SQL.Add('    and cod_cli = :cliente ');

    Prepare;
  end;
end;

function TFPrincipal.EjecutaQClientes: boolean;
begin
  with QClientes do
  begin
    if Active then
      Close;

    ParamByName('zona').AsString := QRecibos.Fieldbyname('cod_zon').AsString;
    ParambyName('cliente').AsString := QRecibos.FieldByName('cod_cli').AsString;

    Open;
    Result := not Isempty;
  end;
end;

function TFPrincipal.NumeroOper: integer;
begin
  with QNumOper do
  begin
    if Active then
      Close;
    Open;
    Result := FieldByName('cantidad').AsInteger;
  end;
end;

function TFPrincipal.CantidadTotal: real;
begin
  with QNumOper do
  begin
    if Active then
      Close;
    Open;
    Result := FieldByName('total').AsFloat;
  end;
end;

procedure TFPrincipal.GenerarFichero;
var NodoRaiz, NodoRaiz2, N1GrpHdr, N1PmtInf,
    N2MsgId, N2CreDtTm, N2NbOfTxs, N2CtrlSum, N2InitgPty,
    N2PmtInfId, N2PmtMtd, N2PmtTpInf, N2ReqdColltnDt, N2Cdtr, N2CdtrAcct,
    N2CdtrAgt, N2ChrgBr, N2CdtrSchmeId, N2DrctDbtTxInf,
    N3Nm, N3Id, N3SvcLvl, N3LclInstrm, N3SeqTp, N3CtgyPurp, N3NmB, N3IdB,
    N3FinInstnId, N3IdC, N3PmtId, N3InstdAmt, N3DrctDbtTx, N3DbtrAgt, N3Dbtr,
    N3DbtrAcct,
    N4OrgId, N4Cd, N4CdB, N4CdC, N4IBAN, N4BIC, N4PrvtId, N4InstrId, N4EndToEndId,
    N4MndtRltdInf, N4CdtrSchmeId, N4FinInstnId, N4Nm, N4Id, N4IdB,
    N5Othr,N5MndtId, N5DtOfSgntr, N5AmdmntInd, N5Id, N5BIC, N5OrgId, N5IBAN,
    N6Id, N6Id2, N6PrvtId, N6BICOrBEI, N6SchmeNm,
    N7Othr, N7Cd,
    N8Id, N8SchmeNm,
    N9Prtry: IXMLNode;
begin
  //Activamos el documento
  XMLDocument.Active := true;
  XMLDocument.Version := '1.0';
  XMLDocument.Encoding := 'UTF-8';
//  XMLDocument.StandAlone := 'yes';


  //creamos el nodo raiz
  NodoRaiz := XMLDocument.AddChild('Document');

  NodoRaiz.Attributes['xmlns'] := 'urn:iso:std:iso:20022:tech:xsd:pain.008.001.02';
  NodoRaiz.Attributes['xmlns:xsi'] := 'http://www.w3.org/2001/XMLSchema-instance';

  NodoRaiz2 := NodoRaiz.AddChild('CstmrDrctDbtInitn');

  //CABECERA
  //Nivel 1
  N1GrpHdr := NodoRaiz2.AddChild('GrpHdr');

  //Nivel 2
  //Identificacion Del Mensaje
  N2MsgId := N1GrpHdr.AddChild('MsgId');
  N2MsgId.NodeValue := AsignarN2MsgId;

  //Fecha y Hora de Creacion
  N2CreDtTm := N1GrpHdr.AddChild('CreDtTm');
  N2CreDtTm.NodeValue := AsignarN2CreDtTm;

  //Numero de Operaciones
  N2NbOfTxs := N1GrpHdr.AddChild('NbOfTxs');
  N2NbOfTxs.NodeValue := AsignarN2NbOfTxs;

  //Control de Suma
  N2CtrlSum := N1GrpHdr.AddChild('CtrlSum');
  N2CtrlSum.NodeValue := AsignarN2CtrlSum;

  //Parte Iniciadora
  N2InitgPty := N1GrpHdr.AddChild('InitgPty');

  //Nombre
  N3Nm := N2InitgPty.AddChild('Nm');
  N3Nm.NodeValue := AsignarN3Nm;

  //Identificacion
  N3Id := N2InitgPty.AddChild('Id');

  //Persona Juridica
  N4OrgId := N3Id.AddChild('OrgId');

  //Otra
  N5Othr := N4OrgId.AddChild('Othr');

  //Identificacion
  N6Id := N5Othr.AddChild('Id');
  N6Id.NodeValue := AsignarN6Id;

  //Nombre del esquema
  N6SchmeNm := N5Othr.AddChild('SchmeNm');

  //Codigo
  N7Cd := N6SchmeNm.AddChild('Cd');
  N7Cd.NodeValue := AsignarN7Cd;


  //INFORMACION DEL PAGO
  //Nivel 1
  N1PmtInf := NodoRaiz2.AddChild('PmtInf');

  //Nivel 2
  //Indentificacion de la informacion del pago
  N2PmtInfId := N1PmtInf.AddChild('PmtInfId');
  N2PmtInfId.NodeValue := AsignarN2PmtInfId;

  //Metodo de Pago
  N2PmtMtd := N1PmtInf.AddChild('PmtMtd');
  N2PmtMtd.NodeValue := AsignarN2PmtMtd;

  //Informacion del tipo de pago
  N2PmtTpInf := N1PmtInf.AddChild('PmtTpInf');

  //Nivel de Servicio
  N3SvcLvl := N2PmtTpInf.AddChild('SvcLvl');

  //Codigo
  N4Cd := N3SvcLvl.AddChild('Cd');
  N4Cd.NodeValue := AsignarN4Cd;

  //Instrumento Local
  N3LclInstrm := N2PmtTpInf.AddChild('LclInstrm');

  //Codigo
  N4CdB := N3LclInstrm.AddChild('Cd');
  N4CdB.NodeValue := AsignarN4CdB;

  //Tipo de Secuencia
  N3SeqTp := N2PmtTpInf.AddChild('SeqTp');
  N3SeqTp.NodeValue := AsignarN3SeqTp;

  //Categoria del Proposito
  N3CtgyPurp := N2PmtTpInf.AddChild('CtgyPurp');

  //Codigo
  N4CdC := N3CtgyPurp.AddChild('Cd');
  N4CdC.NodeValue := AsignarN4CdC;

  //Fecha de Cobro
  N2ReqdColltnDt := N1PmtInf.AddChild('ReqdColltnDt');
  N2ReqdColltnDt.NodeValue := AsignarN2ReqdColltnDt;

  //Acreedor
  N2Cdtr := N1PmtInf.AddChild('Cdtr');

  //Nombre
  N3NmB := N2Cdtr.AddChild('Nm');
  N3NmB.NodeValue := AsignarN3NmB;

  //Cuenta del Acreedor
  N2CdtrAcct := N1PmtInf.AddChild('CdtrAcct');

  //Identificacion
  N3IdB := N2CdtrAcct.AddChild('Id');

  //IBAN
  N4IBAN := N3IdB.AddChild('IBAN');
  N4IBAN.NodeValue := AsignarN4IBAN;

  //Entidad del Acreedor
  N2CdtrAgt := N1PmtInf.AddChild('CdtrAgt');

  //Identificacion de la entidad
  N3FinInstnId := N2CdtrAgt.AddChild('FinInstnId');

  //BIC
  N4BIC := N3FinInstnId.AddChild('BIC');
  N4BIC.NodeValue := AsignarN4BIC;

  //Clausula de Gastos
  N2ChrgBr := N1PmtInf.AddChild('ChrgBr');
  N2ChrgBr.NodeValue := AsignarN2ChrgBr;

  //Identificacion del Acreedor
  N2CdtrSchmeId := N1PmtInf.AddChild('CdtrSchmeId');

  //ID
  N3IdC := N2CdtrSchmeId.AddChild('Id');

  //Identificacion Privada
  N4PrvtId := N3IdC.AddChild('PrvtId');

  //Otra
  N5Othr := N4PrvtId.AddChild('Othr');

  //ID
  N6Id2 := N5Othr.Addchild('Id');
  N6Id2.NodeValue := AsignarN6Id2;


  //ADEUDOS DIRECTOS
  QRecibos.First;
  while not QRecibos.Eof do
  begin
    EjecutaQClientes;

    //Informacion de la operación de adeudo directo
    N2DrctDbtTxInf := N1PmtInf.AddChild('DrctDbtTxInf');

    //Identificacion del Pago
    N3PmtId := N2DrctDbtTxInf.AddChild('PmtId');

    //Identificacion de la instruccion
    N4InstrId := N3PmtId.AddChild('InstrId');
    N4InstrId.NodeValue := AsignarN4InstrId;

    //Identificacion de Extremo a Extremo
    N4EndToEndId := N3PmtId.AddChild('EndToEndId');
    N4EndToEndId.NodeValue := AsignarN4EndToEndId;

    //Importe Ordenado
    N3InstdAmt := N2DrctDbtTxInf.AddChild('InstdAmt');
    N3InstdAmt.Attributes['Ccy'] := 'EUR';
    N3InstdAmt.NodeValue := AsignarN3InstdAmt;

    //Operacion de adeudo directo
    N3DrctDbtTx := N2DrctDbtTxInf.AddChild('DrctDbtTx');

    //Informacion del mandato
    N4MndtRltdInf := N3DrctDbtTx.AddChild('MndtRltdInf');

    //Identificacion del mandato
    N5MndtId := N4MndtRltdInf.AddChild('MndtId');
    N5MndtId.NodeValue := AsignarN5MndtId;

    //Fecha de firma
    N5DtOfSgntr := N4MndtRltdInf.AddChild('DtOfSgntr');
    N5DtOfSgntr.NodeValue := AsignarN5DtOfSgntr;

    //Indicador de modificaciones
    N5AmdmntInd := N4MndtRltdInf.AddChild('AmdmntInd');
    N5AmdmntInd.NodeValue := AsignarN5AmdmntInd;

{ El identificador del acreedor se deja solo en la cabecera del fichero.
    //Identificacion del acreedor
    N4CdtrSchmeId := N3DrctDbtTx.AddChild('CdtrSchmeId');

    //ID
    N5Id := N4CdtrSchmeId.AddChild('Id');

    //Identificacion Privada
    N6PrvtId := N5Id.AddChild('PrvtId');

    //Otra
    N7Othr := N6PrvtId.AddChild('Othr');

    //Id
    N8Id := N7Othr.AddChild('Id');
    N8Id.NodeValue := AsignarN8Id;

    //Nombre del Esquema
    N8SchmeNm := N7Othr.AddChild('SchmeNm');

    //Propietario
    N9Prtry := N8SchmeNm.AddChild('Prtry');
    N9Prtry.NodeValue := AsignarN9Prtry;
}
    //Entidad del deudor
    N3DbtrAgt := N2DrctDbtTxInf.AddChild('DbtrAgt');

    //Identificacion de la entidad
    N4FinInstnId := N3DbtrAgt.AddChild('FinInstnId');

    //BIC
    N5BIC := N4FinInstnId.AddChild('BIC');
    N5BIC.NodeValue := AsignarN5BIC;

    //Deudor
    N3Dbtr := N2DrctDbtTxInf.AddChild('Dbtr');

    //Nombre
    N4Nm := N3Dbtr.AddChild('Nm');
    N4Nm.NodeValue := AsignarN4Nm;

    //Id
    N4Id := N3Dbtr.AddChild('Id');

    //Persona Juridica
    N5OrgId := N4Id.AddChild('OrgId');

    //BIC o BEI
    N6BICOrBEI := N5OrgId.AddChild('BICOrBEI');
    N6BICOrBEI.NodeValue := AsignarN6BICOrBEI;

    //Cuenta del deudor
    N3DbtrAcct := N2DrctDbtTxInf.AddChild('DbtrAcct');

    //Identificacion
    N4IdB := N3DbtrAcct.AddChild('Id');

    //IBAN
    N5IBAN := N4IdB.AddChild('IBAN');
    N5IBAN.NodeValue := AsignarN5IBAN;

    Gauge1.progress:=Gauge1.progress+1;
    QRecibos.Next;
  end;
end;

procedure TFPrincipal.GrabarFichero;
begin
  XMLDocument.SaveToFile(txRuta.Text + gsAlias + '_SEPAXML_' + IntToStr(gsCodRemesa) + '.XML');
end;

function TFPrincipal.AsignarN2MsgId: String;
var sMsgId: String;
begin
  sMsgId := 'PRE' + FormatDateTime('yyyymmddhhnnsszz', now) +
            'ES' + CalcDigitoControl + QEmpresa.FieldByName('nif_empr').AsString;

  Result := sMsgId;
end;

function TFPrincipal.AsignarN2CreDtTm: String;
var sCreDtTm: String;
begin
  sCreDtTm := FormatDateTime('yyyy-mm-dd', now) + 'T' +
              FormatDateTime('hh:nn:ss', now);
  Result := sCreDtTm;
end;

function TFPrincipal.AsignarN2NbOfTxs: String;
var sNbOfTxs: String;                                                        
begin
   sNbOfTxs := IntToStr(NumOperaciones);
   Result := sNbOfTxs;
end;

function TFPrincipal.AsignarN2CtrlSum: String;
var sCtrlSum: String;
begin
   sCtrlSum := SumaTotal;
   Result := sCtrlSum;
end;

function TFPrincipal.AsignarN3Nm: String;
begin
  Result := QEmpresa.FieldByName('raz_soc').AsString;
end;

function TFPrincipal.AsignarN6Id: String;
begin
  //Para Empresa Jijona asignamos un sufijo distinto
//  if QEmpresa.fieldbyname('codigo').AsString = '04' then
//    Result := 'ES' + CalcDigitoControl + '001' + QEmpresa.FieldByName('nif_empr').AsString
//  else
    Result := 'ES' + CalcDigitoControl + '000' + QEmpresa.FieldByName('nif_empr').AsString;
end;

function TFPrincipal.AsignarN7Cd: String;
begin
  Result := 'CORE';
end;
function TFPrincipal.AsignarN2PmtInfId: String;
begin
  Result := FormatDateTime('yyyymmddhhnnsszz', now) + IntToStr(NumRemesa);
end;

function TFPrincipal.AsignarN2PmtMtd: String;
begin
  Result := 'DD';
end;

function TFPrincipal.AsignarN4Cd: String;
begin
  Result := 'SEPA';
end;

function TFPrincipal.AsignarN4CdB: String;
begin
  Result := 'CORE';
end;

function TFPrincipal.AsignarN3SeqTp: String;
begin
  Result := 'RCUR';
end;

function TFPrincipal.AsignarN4CdC: String;
begin
  Result := 'TRAD';
end;

function TFPrincipal.AsignarN2ReqdColltnDt: String;
begin
  Result := FechaCobro;
end;

function TFPrincipal.AsignarN3NmB: String;
begin
  Result := QEmpresa.FieldByName('raz_soc').AsString;
end;

function TFPrincipal.AsignarN4IBAN: String;
begin
  Result := QIBAN.Fieldbyname('des_con').AsString;
end;

function TFPrincipal.AsignarN4BIC: String;
begin
  Result := QBIC.Fieldbyname('des_con').AsString;
end;

function TFPrincipal.AsignarN2ChrgBr: String;
begin
  Result := 'SLEV';
end;

function TFPrincipal.AsignarN6Id2: String;
begin
  //Para Empresa Jijona asignamos un sufijo distinto
//  if QEmpresa.fieldbyname('codigo').AsString = '04' then
//    Result := 'ES' + CalcDigitoControl + '001' + QEmpresa.FieldByName('nif_empr').AsString
//  else
    Result := 'ES' + CalcDigitoControl + '000' + QEmpresa.FieldByName('nif_empr').AsString;
end;

function TFPrincipal.AsignarN4InstrId: String;
begin
  Result := 'FACTURA:' + QRecibos.FieldByName('cod_rec').AsString +
            'FECHA:' + QRecibos.FieldByName('ffa_rec').AsString;
end;

function TFPrincipal.AsignarN4EndToEndId: String;
begin
  Result := 'FACTURA:' + QRecibos.FieldByName('cod_rec').AsString +
            'FECHA:' + QRecibos.FieldByName('ffa_rec').AsString;
end;

function TFPrincipal.AsignarN3InstdAmt: String;
var sImporte: String;
begin
  sImporte := FormatFloat('0.00', QRecibos.Fieldbyname('tot_rec').AsFloat);
  Result := StringReplace(sImporte, ',', '.', [rfReplaceAll]);
end;

function TFPrincipal.AsignarN5MndtId: String;
begin
  Result := QEmpresa.fieldbyname('codigo').AsString +
            QRecibos.Fieldbyname('cod_zon').AsString +
            QRecibos.Fieldbyname('cod_cli').AsString;
end;

function TFPrincipal.AsignarN5DtOfSgntr: String;
begin
  if DateTimeToStr(Now) <= '31/12/2015' then
    Result := '2009-10-31'
  else
    Result := FormatDateTime(' yyyy-mm-dd', QClientes.Fieldbyname('fco_cli').AsDateTime);
end;

function TFPrincipal.AsignarN5AmdmntInd: String;
begin
  Result := 'FALSE';
end;

function TFPrincipal.AsignarN8Id: String;
begin
  //Para Empresa Jijona asignamos un sufijo distinto
//  if QEmpresa.fieldbyname('codigo').AsString = '04' then
//    Result := 'ES' + CalcDigitoControl + '001' + QEmpresa.FieldByName('nif_empr').AsString
//  else
    Result := 'ES' + CalcDigitoControl + '000' + QEmpresa.FieldByName('nif_empr').AsString;
end;

function TFPrincipal.AsignarN9Prtry: String;
begin
  Result := 'SEPA';
end;

function TFPrincipal.AsignarN5BIC: String;
begin
  Result := QClientes.FieldByName('cod_bic').AsString;
end;

function TFPrincipal.AsignarN4Nm: String;
begin
  Result := QClientes.FieldByName('tit_cli').AsString;
end;

function TFPrincipal.AsignarN6BICOrBEI: String;
begin
  Result := QClientes.FieldByName('cod_bic').AsString;
end;

function TFPrincipal.AsignarN5IBAN: String;
begin
  Result := QClientes.FieldByName('iban').AsString;
end;

function TFPrincipal.NumOperaciones;
begin
  with QNumOper do
  begin
    if Active then
      Close;

    Open;

    Result := QNumOper.Fieldbyname('cantidad').AsInteger;
  end;
end;

function TFPrincipal.SumaTotal:String;
var sImporte: String;
begin
  with QNumOper do
  begin
    if Active then
      Close;

    Open;

    sImporte := FormatFloat('0.00', QNumOper.Fieldbyname('total').AsFloat);
    Result := StringReplace(sImporte, ',', '.', [rfReplaceAll]);
  end;
end;

function TFPrincipal.CalcDigitoControl: String;
var sCadena, sNumero: String;
    iLong, i, icc, iResto: integer;
    dNum, dCociente: Extended;
begin
  sCadena := QEmpresa.FieldByName('nif_empr').AsString + 'ES00';
  iLong := Length(sCadena);

  sNumero := '';
  for i:= 1 to iLong do
  begin
    sNumero := sNumero + TablaNum(sCadena[i]);
  end;

  dNum := StrToFloat(sNumero);
  dCociente := dNum / 97;
  icc := Trunc(dCociente);
  iResto := trunc(dNum - (icc*97));
  Result := FloatToStr(98 - iResto);
end;

function TFPrincipal.TablaNum(ALetra: String): String;
var i: integer;
begin
  i:= 1;
  while i <= Length(Tabla.ACampos) -1 do
  begin
    if Tabla.ACampos[i].sLetra = ALetra then
    begin
      Result := IntToStr(Tabla.ACampos[i].iNumero);
      exit;
    end;

    inc(i);
  end;
  Result := ALetra;
end;

function TFPrincipal.NumRemesa: Integer;
begin
  with QNumRemesa do
  begin
    if Active then
      Close;
    Open;

    Result := FieldByName('cod_rem').AsInteger;
  end;
end;

function TFPrincipal.FechaCobro: String;
begin
  with QNumRemesa do
  begin
    if Active then
      Close;
    Open;

    Result := FormatDateTime('yyyy-mm-dd',  Now());
  end;

end;

procedure TFPrincipal.AccesoBD;
begin
  AbrirBaseDatos;

  lbEmpresa.Caption := gsAlias;
  lbUsuario.Caption := gsUsuario;

  if gsAlias <> 'NO CONECTADO' then
  begin
    CreaQEmpresa;
    CreaQIBAN;
    CreaQBIC;
    CreaQNumOper;
    CreaQNumRemesa;
    CreaQRecibos;
    CreaQClientes;

    EjecutaQEmpresa;
    EjecutaQIBAN;
    EjecutaQBIC;
    EjecutaQRecibos;
  end;

end;

procedure TFPrincipal.CargaTabla;
begin
  SetLength( Tabla.ACampos, 27);

  Tabla.ACampos[1].sLetra := 'A';
  Tabla.ACampos[1].iNumero := 10;
  Tabla.ACampos[2].sLetra := 'B';
  Tabla.ACampos[2].iNumero := 11;
  Tabla.ACampos[3].sLetra := 'C';
  Tabla.ACampos[3].iNumero := 12;
  Tabla.ACampos[4].sLetra := 'D';
  Tabla.ACampos[4].iNumero := 13;
  Tabla.ACampos[5].sLetra := 'E';
  Tabla.ACampos[5].iNumero := 14;
  Tabla.ACampos[6].sLetra := 'F';
  Tabla.ACampos[6].iNumero := 15;
  Tabla.ACampos[7].sLetra := 'G';
  Tabla.ACampos[7].iNumero := 16;
  Tabla.ACampos[8].sLetra := 'H';
  Tabla.ACampos[8].iNumero := 17;
  Tabla.ACampos[9].sLetra := 'I';
  Tabla.ACampos[9].iNumero := 18;
  Tabla.ACampos[10].sLetra := 'J';
  Tabla.ACampos[10].iNumero := 19;
  Tabla.ACampos[11].sLetra := 'K';
  Tabla.ACampos[11].iNumero := 20;
  Tabla.ACampos[12].sLetra := 'L';
  Tabla.ACampos[12].iNumero := 21;
  Tabla.ACampos[13].sLetra := 'M';
  Tabla.ACampos[13].iNumero := 22;
  Tabla.ACampos[14].sLetra := 'N';
  Tabla.ACampos[14].iNumero := 23;
  Tabla.ACampos[15].sLetra := 'O';
  Tabla.ACampos[15].iNumero := 24;
  Tabla.ACampos[16].sLetra := 'P';
  Tabla.ACampos[16].iNumero := 25;
  Tabla.ACampos[17].sLetra := 'Q';
  Tabla.ACampos[17].iNumero := 26;
  Tabla.ACampos[18].sLetra := 'R';
  Tabla.ACampos[18].iNumero := 27;
  Tabla.ACampos[19].sLetra := 'S';
  Tabla.ACampos[19].iNumero := 28;
  Tabla.ACampos[20].sLetra := 'T';
  Tabla.ACampos[20].iNumero := 29;
  Tabla.ACampos[21].sLetra := 'U';
  Tabla.ACampos[21].iNumero := 30;
  Tabla.ACampos[22].sLetra := 'V';
  Tabla.ACampos[22].iNumero := 31;
  Tabla.ACampos[23].sLetra := 'W';
  Tabla.ACampos[23].iNumero := 32;
  Tabla.ACampos[24].sLetra := 'X';
  Tabla.ACampos[24].iNumero := 33;
  Tabla.ACampos[25].sLetra := 'Y';
  Tabla.ACampos[25].iNumero := 34;
  Tabla.ACampos[26].sLetra := 'Z';
  Tabla.ACampos[26].iNumero := 35;

end;

procedure TFPrincipal.CerrarTablas;
begin
  if QEmpresa.Active then
  begin
    QEmpresa.Cancel;
    QEmpresa.Close;
  end;
  if QIBAN.Active then
  begin
    QIBAN.Cancel;
    QIBAN.Close;
  end;
  if QBIC.Active then
  begin
    QBIC.Cancel;
    QBIC.Close;
  end;
  if QNumOper.Active then
  begin
    QNumOper.Cancel;
    QNumOper.Close;
  end;
  if QNumRemesa.Active then
  begin
    QNumRemesa.Cancel;
    QNumRemesa.Close;
  end;
  if QRecibos.Active then
  begin
    QRecibos.Cancel;
    QRecibos.Close;
  end;
  if QClientes.Active then
  begin
    QClientes.Cancel;
    QClientes.Close;
  end;


end;

procedure TFPrincipal.btnRutaClick(Sender: TObject);
var dir: String;
begin
  dir := txRuta.Text;
  if SelectDirectory(' Selecciona directorio destino.', 'c:\', dir) then
  begin
    if copy(dir, length(dir) - 1, length(dir)) <> '\' then
    begin
      txRuta.Text := dir + '\';
      txRuta.Hint:= txRuta.Text;
    end
    else
    begin
      txRuta.Text := dir;
    end;
  end;
  Application.BringToFront;
end;

procedure TFPrincipal.btnSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TFPrincipal.btCambioEmpClick(Sender: TObject);
begin
  if gsAlias <> 'NO CONECTADO' then
    CerrarTablas;
  AccesoBD;
end;

procedure TFPrincipal.FormShow(Sender: TObject);
begin
  AccesoBD;
  CargaTabla;
end;

end.
