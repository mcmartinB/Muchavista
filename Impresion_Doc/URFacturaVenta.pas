unit URFacturaVenta;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, kbmMemTable, DB,
  Dialogs, DBTables;

type
  TRFacturaVenta = class(TQuickRep)
    qrCabecera: TQRBand;
    QRImageLogo: TQRImage;
    qrRazSoc: TQRDBText;
    qrGruFactura: TQRGroup;
    lb1: TQRLabel;
    qrTitCli: TQRDBText;
    qrNifCli: TQRDBText;
    qrNifEmp: TQRDBText;
    qrDirEmp: TQRDBText;
    qrCpoEmp: TQRDBText;
    qrTitPob: TQRDBText;
    qrTitPro: TQRDBText;
    qs1: TQRShape;
    lb2: TQRLabel;
    lb3: TQRLabel;
    lb4: TQRLabel;
    qs2: TQRShape;
    lb5: TQRLabel;
    qrLetCli: TQRDBText;
    lb6: TQRLabel;
    qrCalTip: TQRDBText;
    lb7: TQRLabel;
    qrCntCli: TQRDBText;
    lb8: TQRLabel;
    qrCodRec: TQRDBText;
    lb9: TQRLabel;
    qrFfaRec: TQRDBText;
    lb10: TQRLabel;
    lb11: TQRLabel;
    qs3: TQRShape;
    qrCDomCli: TQRDBText;
    qrCCodPob: TQRDBText;
    qrCTitPob: TQRDBText;
    qrCTitPro: TQRDBText;
    lb12: TQRLabel;
    qs4: TQRShape;
    lb13: TQRLabel;
    qs5: TQRShape;
    lb14: TQRLabel;
    lb15: TQRLabel;
    qs6: TQRShape;
    lb16: TQRLabel;
    lb17: TQRLabel;
    lb19: TQRLabel;
    lb20: TQRLabel;
    qrConRec: TQRDBText;
    lb21: TQRLabel;
    qrManRec: TQRDBText;
    lb22: TQRLabel;
    qrm3: TQRDBText;
    qrConsumos: TQRSubDetail;
    qrConTexto: TQRDBText;
    qrConM3: TQRDBText;
    qrConPrecio: TQRDBText;
    qrConImporte: TQRDBText;
    QRSubDetail1: TQRSubDetail;
    qrBases: TQRSubDetail;
    lbTextoIVA: TQRLabel;
    lb24: TQRLabel;
    qrBasBase: TQRDBText;
    qrBasImporte: TQRDBText;
    qrTotal: TQRSubDetail;
    lb23: TQRLabel;
    lb25: TQRLabel;
    lb26: TQRLabel;
    qrCM3Rec: TQRDBText;
    qrCseRec: TQRDBText;
    qrCtaCco: TQRDBText;
    qrCcoRec: TQRDBText;
    qrTotRec: TQRDBText;
    lb27: TQRLabel;
    lbCoef: TQRLabel;
    lb28: TQRLabel;
    qs8: TQRShape;
    lb29: TQRLabel;
    qrM3Rec: TQRDBText;
    lb30: TQRLabel;
    qrFanRec: TQRDBText;
    qrLanRec: TQRDBText;
    lb31: TQRLabel;
    qrFacRec: TQRDBText;
    qrLacRec: TQRDBText;
    lb32: TQRLabel;
    qs7: TQRShape;
    qs9: TQRShape;
    qrPie: TQRBand;
    lb33: TQRLabel;
    lb34: TQRLabel;
    lb35: TQRLabel;
    qrReferencia: TQRDBText;
    lbPeriodo: TQRLabel;
    lb18: TQRLabel;
    qrTitCli2: TQRDBText;
    lb36: TQRLabel;
    lbddom_cli: TQRLabel;
    lbdcod_p: TQRLabel;
    lbdtit_pob: TQRLabel;
    lbdtit_pro: TQRLabel;
    lb37: TQRLabel;
    qs10: TQRShape;
    lb38: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    lbAplazamiento1: TQRLabel;
    lbApla: TQRLabel;
    qrAplazamiento: TQRDBText;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrBasesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrTotalBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrGruFacturaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrTotalAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure qrConsumosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrPieBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    mtConsumos, mtBases: TkbmMemTable;
    QRotura: TQuery;


    procedure CargaEmpresa;
    procedure CargaTiposHis;

    procedure CreaTemporales;
    procedure CargaConsumos;
    procedure CargaBases;
    procedure CargaPeriodo;
    function ExisteRotura: boolean;
    procedure CreaQRotura;
    function EjecutaQRotura: boolean;


  public

  end;

var
  RFacturaVenta: TRFacturaVenta;

implementation

uses CVariables, UDM, UFPrincipal;
{$R *.DFM}


procedure TRFacturaVenta.CargaEmpresa;
begin
  with FPrincipal.QEmpresa do
  begin
    if Active then
      Close;

    Open;
  end;
end;

procedure TRFacturaVenta.CargaTiposHis;
begin
  with FPrincipal.QTiposHis do
  begin
    if Active then
      Close;
    ParamByName('anotip').AsInteger := DataSet.FieldByName('ano_rec').AsInteger;
    ParamByName('pertip').AsInteger := DataSet.FieldByName('per_rec').AsInteger;
    ParamByName('codtip').AsInteger := DataSet.FieldByName('cod_tip').AsInteger;

    Open;
  end;
end;

procedure TRFacturaVenta.CreaTemporales;
begin
  mtConsumos := TkbmMemTable.Create(Self);
  with mtConsumos do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('texto', ftString, 40, False);
    FieldDefs.Add('m3', ftFloat, 0, False);
    FieldDefs.Add('precio', ftFloat, 0, False);
    FieldDefs.Add('importe', ftFloat, 0, False);

    CreateTable;
  end;

  mtBases := TkbmMemTable.Create(Self);
  with mtBases do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('porc', ftFloat, 0, False);
    FieldDefs.Add('base', ftFloat, 0, False);
    FieldDefs.Add('importe', ftFloat, 0, False);

    CreateTable;
  end;
end;

procedure TRFacturaVenta.CargaConsumos;
var bSalir : boolean;
    iConParcial, ConsumoDesde: Integer;
begin
  iConParcial := 0;

  mtConsumos.Open;
  if DataSet.FieldByName('m3_rec').AsInteger = 0 then exit;
  bSalir := false;
  mtConsumos.Append;
  if FPrincipal.QTiposHis.FieldByName('m31_tip').AsInteger <> 0 then
  begin
    mtConsumos.FieldByName('texto').AsString := 'Consumo de ' + FPrincipal.QTiposHis.FieldByName('m3m_tip').AsString +
                                                ' a ' + FPrincipal.QTiposHis.FieldByName('m31_tip').AsString + ' m3.';
  end
  else
  begin
    bSalir := true;
    mtConsumos.FieldByName('texto').AsString := 'Consumo sobre ' + FPrincipal.QTiposHis.FieldByName('m3m_tip').AsString + ' m3.';
  end;
  if FPrincipal.QTiposHis.FieldByName('m31_tip').AsInteger > DataSet.FieldByName('m3_rec').AsInteger then
    mtConsumos.FieldByName('m3').AsInteger := DataSet.FieldByName('m3_rec').AsInteger - FPrincipal.QTiposHis.FieldByName('m3m_tip').AsInteger
  else
    mtConsumos.FieldByName('m3').AsInteger := FPrincipal.QTiposHis.FieldByName('m31_tip').AsInteger - FPrincipal.QTiposHis.FieldByName('m3m_tip').AsInteger;
  mtConsumos.FieldByName('precio').AsFloat := FPrincipal.QTiposHis.FieldByName('pt1_tip').AsFloat;
  mtConsumos.FieldByName('importe').AsFloat := mtConsumos.FieldByName('m3').AsInteger *
                                               FPrincipal.QTiposHis.FieldByName('pt1_tip').AsFloat;
  mtConsumos.Post;
  iConParcial := iConParcial + mtConsumos.FieldByName('m3').AsInteger;

  if (bSalir) or (iConParcial >= DataSet.FieldByName('m3_rec').AsInteger) then
    exit;

  mtConsumos.Append;
  if FPrincipal.QTiposHis.FieldByName('m32_tip').AsInteger <> 0 then
  begin
    mtConsumos.FieldByName('texto').AsString := 'Consumo de ' + FPrincipal.QTiposHis.FieldByName('m31_tip').AsString +
                                                ' a ' + FPrincipal.QTiposHis.FieldByName('m32_tip').AsString + ' m3.';
  end
  else
  begin
    bSalir := true;
    mtConsumos.FieldByName('texto').AsString := 'Consumo sobre ' + FPrincipal.QTiposHis.FieldByName('m31_tip').AsString + ' m3.';
  end;
  if FPrincipal.QTiposHis.FieldByName('m32_tip').AsInteger > DataSet.FieldByName('m3_rec').AsInteger then
    mtConsumos.FieldByName('m3').AsInteger := DataSet.FieldByName('m3_rec').AsInteger - FPrincipal.QTiposHis.FieldByName('m31_tip').AsInteger
  else
    mtConsumos.FieldByName('m3').AsInteger := FPrincipal.QTiposHis.FieldByName('m32_tip').AsInteger - FPrincipal.QTiposHis.FieldByName('m31_tip').AsInteger;
  mtConsumos.FieldByName('precio').AsFloat := FPrincipal.QTiposHis.FieldByName('pt2_tip').AsFloat;
  mtConsumos.FieldByName('importe').AsFloat := mtConsumos.FieldByName('m3').AsInteger *
                                               FPrincipal.QTiposHis.FieldByName('pt2_tip').AsFloat;
  mtConsumos.Post;
  iConParcial := iConParcial + mtConsumos.FieldByName('m3').AsInteger;

  if (bSalir) or (iConParcial >= DataSet.FieldByName('m3_rec').AsInteger) then
    exit;

  if gsAlias <> 'JIJONA' then
  begin
    mtConsumos.Append;
    if FPrincipal.QTiposHis.FieldByName('m33_tip').AsInteger <> 0 then
    begin
      mtConsumos.FieldByName('texto').AsString := 'Consumo de ' + FPrincipal.QTiposHis.FieldByName('m32_tip').AsString +
                                                  ' a ' + FPrincipal.QTiposHis.FieldByName('m33_tip').AsString + ' m3.';
    end
    else
    begin
      bSalir := true;
      mtConsumos.FieldByName('texto').AsString := 'Consumo sobre ' + FPrincipal.QTiposHis.FieldByName('m32_tip').AsString + ' m3.';
    end;
    if FPrincipal.QTiposHis.FieldByName('m33_tip').AsInteger > DataSet.FieldByName('m3_rec').AsInteger then
      mtConsumos.FieldByName('m3').AsInteger := DataSet.FieldByName('m3_rec').AsInteger - FPrincipal.QTiposHis.FieldByName('m32_tip').AsInteger
    else
      mtConsumos.FieldByName('m3').AsInteger := FPrincipal.QTiposHis.FieldByName('m33_tip').AsInteger - FPrincipal.QTiposHis.FieldByName('m32_tip').AsInteger;
    mtConsumos.FieldByName('precio').AsFloat := FPrincipal.QTiposHis.FieldByName('pt3_tip').AsFloat;
    mtConsumos.FieldByName('importe').AsFloat := mtConsumos.FieldByName('m3').AsInteger *
                                                 FPrincipal.QTiposHis.FieldByName('pt3_tip').AsFloat;
    mtConsumos.Post;
    iConParcial := iConParcial + mtConsumos.FieldByName('m3').AsInteger;

    if (bSalir) or (iConParcial >= DataSet.FieldByName('m3_rec').AsInteger) then
      exit;
  end;

  if gsAlias <> 'JIJONA' then
    ConsumoDesde := FPrincipal.QTiposHis.FieldByName('m33_tip').AsInteger
  else
    ConsumoDesde := FPrincipal.QTiposHis.FieldByName('m32_tip').AsInteger;
  mtConsumos.Append;
  mtConsumos.FieldByName('texto').AsString := 'Consumo sobre ' + IntToStr(ConsumoDesde) + ' m3.';
  mtConsumos.FieldByName('m3').AsInteger := DataSet.FieldByName('m3_rec').AsInteger - ConsumoDesde;
  if ExisteRotura then              //Solo para Muchavista
  begin
    mtConsumos.FieldByName('precio').AsFloat := FPrincipal.QTiposHis.FieldByName('pt3_tip').AsFloat;
    mtConsumos.FieldByName('importe').AsFloat := mtConsumos.FieldByName('m3').AsInteger *
                                                 FPrincipal.QTiposHis.FieldByName('pt3_tip').AsFloat;
  end
  else
  begin
    mtConsumos.FieldByName('precio').AsFloat := FPrincipal.QTiposHis.FieldByName('ptr_tip').AsFloat;
    mtConsumos.FieldByName('importe').AsFloat := mtConsumos.FieldByName('m3').AsInteger *
                                                 FPrincipal.QTiposHis.FieldByName('ptr_tip').AsFloat;
  end;
  mtConsumos.Post;
end;

procedure TRFacturaVenta.CargaBases;
begin
  mtBases.Open;
  if DataSet.FieldByName('con_rec').AsFloat <> 0 then
  begin
    mtBases.Append;
    mtBases.FieldByName('porc').AsFloat := DataSet.FieldByName('porc_ico').AsFloat;
    mtBases.FieldByName('base').AsFloat := DataSet.FieldByName('con_rec').AsFloat;
    mtBases.FieldByName('importe').AsFloat := DataSet.FieldByName('ico_rec').AsFloat;
    mtBases.Post;
  end;

  if DataSet.FieldByName('man_rec').AsFloat <> 0 then
  begin
    mtBases.Filter := ' porc = ' + DataSet.FieldByName('porc_ima').AsString;
    mtBases.Filtered := true;
    if mtBases.RecordCount >= 1 then
    begin
      mtBases.Edit;
      mtBases.FieldByName('base').AsFloat := mtBases.FieldByName('base').AsFloat +
                                             DataSet.FieldByName('man_rec').AsFloat;
      mtBases.FieldByName('importe').AsFloat := mtBases.FieldByName('importe').AsFloat +
                                                DataSet.FieldByName('ima_rec').AsFloat;
      mtBases.Post;
    end
    else
    begin
      mtBases.Append;
      mtBases.FieldByName('porc').AsFloat := DataSet.FieldByName('porc_ima').AsFloat;
      mtBases.FieldByName('base').AsFloat := DataSet.FieldByName('man_rec').AsFloat;
      mtBases.FieldByName('importe').AsFloat := DataSet.FieldByName('ima_rec').AsFloat;
      mtBases.Post;
    end;
    mtBases.Filter := '';
    mtBases.Filtered := false;
  end;

  if DataSet.FieldByName('pm3_rec').AsFloat <> 0 then
  begin
    mtBases.Filter := ' porc = ' + DataSet.FieldByName('porc_im3').AsString;
    mtBases.Filtered := true;
    if mtBases.RecordCount >= 1 then
    begin
      mtBases.Edit;
      mtBases.FieldByName('base').AsFloat := mtBases.FieldByName('base').AsFloat +
                                             DataSet.FieldByName('pm3_rec').AsFloat;
      mtBases.FieldByName('importe').AsFloat := mtBases.FieldByName('importe').AsFloat +
                                                DataSet.FieldByName('im3_rec').AsFloat;
      mtBases.Post;
    end
    else
    begin
      mtBases.Append;
      mtBases.FieldByName('porc').AsFloat := DataSet.FieldByName('porc_im3').AsFloat;
      mtBases.FieldByName('base').AsFloat := DataSet.FieldByName('pm3_rec').AsFloat;
      mtBases.FieldByName('importe').AsFloat := DataSet.FieldByName('im3_rec').AsFloat;
      mtBases.Post;
    end;
    mtBases.Filter := '';
    mtBases.Filtered := false;
  end;

  mtBases.SortFields:= 'porc';
  mtBases.Sort([]);

end;

procedure TRFacturaVenta.CargaPeriodo;
begin
  if ((gsAlias = 'MUCHAVISTA') and (DataSet.FieldByName('ano_rec').AsInteger >= 2013)) or
     ((gsAlias = 'SILIM') and (DataSet.FieldByName('ano_rec').AsInteger >= 2016)) then
  begin
    if DataSet.FieldByName('per_rec').AsInteger = 1 then
      lbPeriodo.Caption := '1º Trimestre'
    else if DataSet.FieldByName('per_rec').AsInteger = 2 then
      lbPeriodo.Caption := '2º Trimestre'
    else if DataSet.FieldByName('per_rec').AsInteger = 3 then
      lbPeriodo.Caption := '3º Trimestre'
    else if DataSet.FieldByName('per_rec').AsInteger = 4 then
      lbPeriodo.Caption := '4º Trimestre';
  end
  else
  begin
    if DataSet.FieldByName('per_rec').AsInteger = 1 then
      lbPeriodo.Caption := '1º Bimestre'
    else if DataSet.FieldByName('per_rec').AsInteger = 2 then
      lbPeriodo.Caption := '2º Bimestre'
    else if DataSet.FieldByName('per_rec').AsInteger = 3 then
      lbPeriodo.Caption := '3º Bimestre'
    else if DataSet.FieldByName('per_rec').AsInteger = 4 then
      lbPeriodo.Caption := '4º Bimestre'
    else if DataSet.FieldByName('per_rec').AsInteger = 5 then
      lbPeriodo.Caption := '5º Bimestre'
    else if DataSet.FieldByName('per_rec').AsInteger = 6 then
      lbPeriodo.Caption := '6º Bimestre';
  end;
end;
function TRFacturaVenta.ExisteRotura: boolean;
begin
  if gsAlias <> 'MUCHAVISTA' then
    Result := false
  else
    Result := EjecutaQRotura;
end;

procedure TRFacturaVenta.CreaQRotura;
begin
  QRotura := TQuery.Create(Self);
  with QRotura do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select * from rotura ');
    SQL.Add('  where cod_rec = :cod_rec ');

    Prepare;
  end;
end;

function TRFacturaVenta.EjecutaQRotura: Boolean;
begin
  with QRotura do
  begin
    if Active then
      Close;
    ParamByName('cod_rec').AsInteger := DataSet.FieldbyName('cod_rec').AsInteger;

    Open;

    Result := not IsEmpty;
  end;
end;

procedure TRFacturaVenta.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  if (gsAlias = 'MUCHAVISTA') or (gsAlias = 'JIJONA') then
    if FileExists(gsDirActual + '\Recursos\Logo_Aguas_Muchavista.jpg') then
      QRImageLogo.Picture.LoadFromFile(gsDirActual + '\Recursos\Logo_Aguas_Muchavista.jpg');

  CreaTemporales;
  CargaEmpresa;
  if gsAlias = 'MUCHAVISTA' then
    CreaQRotura;

  qrRazSoc.DataSet := FPrincipal.QEmpresa;
  qrNifEmp.DataSet := FPrincipal.QEmpresa;
  qrDirEmp.DataSet := FPrincipal.QEmpresa;
  qrCpoEmp.DataSet := FPrincipal.QEmpresa;
  qrTitPob.DataSet := FPrincipal.QEmpresa;
  qrTitPro.DataSet := FPrincipal.QEmpresa;

  qrConsumos.DataSet := mtConsumos;
  qrConTexto.DataSet := mtConsumos;
  qrConM3.DataSet := mtConsumos;
  qrConPrecio.DataSet := mtConsumos;
  qrConImporte.DataSet := mtConsumos;

  qrBases.DataSet := mtBases;
  qrBasBase.DataSet := mtBases;
  qrBasImporte.DataSet := mtBases;
      
end;

procedure TRFacturaVenta.qrBasesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbTextoIVA.Caption := 'I.V.A. al ' + mtBases.FieldByName('porc').AsString + '%';
end;

procedure TRFacturaVenta.qrTotalBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbCoef.Enabled := false;
  if DataSet.FieldByName('coe_cor').AsFloat <> 0 then
  begin
    lbCoef.Enabled := true;
    lbCoef.Caption := 'Coeficiente corrector aplicado: ' +
                       FormatFloat('#0.00', DataSet.FieldByName('coe_cor').AsFloat);
  end;
  if gsAlias = 'SILIM' then
  begin
    lb37.Enabled := true;
    qs10.Enabled := true;
    lb38.Enabled := true;
  end
  else
  begin
    lb37.Enabled := false;
    qs10.Enabled := false;
    lb38.Enabled := false;
  end;
  //Aplazamiento Canon de Saneamiento
  //SOLO para Muchavista y Silim
  if gsAlias = 'JIJONA' then
  begin
    lbApla.Enabled := false;
    qrAplazamiento.Enabled := false;
    lbAplazamiento1.Enabled := false;
  end
  else
  begin
    if DataSet.FieldByName('apl_c19').AsFloat <> 0 then
    begin
      if (DataSet.FieldByname('ffa_rec').AsString >= '01/04/2020') and  (DataSet.FieldByName('ffa_rec').AsString <= '30/06/2020') then
      begin
        lbApla.Enabled := true;
        lbApla.Caption := 'Aplazamiento Canon de Saneamiento (*)';
        qrAplazamiento.Enabled := true;
        lbAplazamiento1.Enabled := True;
      end
      else
      begin
        lbApla.Enabled := true;
        lbApla.Caption := 'Regularización aplazamiento Canon de Saneamiento';
        qrAplazamiento.Enabled := true;
        lbAplazamiento1.Enabled := false;
      end;
    end
    else
    begin
      lbApla.Enabled := false;
      qrAplazamiento.Enabled := false;
      lbAplazamiento1.Enabled := false;
    end;
  end;
end;

procedure TRFacturaVenta.qrGruFacturaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  CargaTiposHis;
  CargaConsumos;
  CargaBases;
  CargaPeriodo;

  //Si no existen datos en Domicilio, pondremos los datos de Suministro
  if DataSet.FieldByName('ddom_cli').AsString = '' then
  begin
    lbddom_cli.Caption := DataSet.FieldByName('cdom_cli').AsString;
    lbdcod_p.Caption := DataSet.FieldByName('ccod_pob').AsString;
    lbdtit_pob.Caption := DataSet.FieldByName('ctit_pob').AsString;
    lbdtit_pro.Caption := DataSet.FieldByName('ctit_pro').AsString;
  end
  else
  begin
    lbddom_cli.Caption := DataSet.FieldByName('ddom_cli').AsString;
    lbdcod_p.Caption := DataSet.FieldByName('dcod_pob').AsString;
    lbdtit_pob.Caption := DataSet.FieldByName('dtit_pob').AsString;
    lbdtit_pro.Caption := DataSet.FieldByName('dtit_pro').AsString;
  end;
end;

procedure TRFacturaVenta.qrTotalAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  mtConsumos.Close;
  mtBases.Close;
//  mtConsumos.DeleteTable;
//  mtBases.DeleteTable;
end;

procedure TRFacturaVenta.qrConsumosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if mtConsumos.RecordCount = 0 then
    qrConPrecio.Enabled := false
  else
    qrConPrecio.Enabled := true;
end;

procedure TRFacturaVenta.qrPieBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if gsAlias = 'SILIM' then
    lb33.Caption := 'Inscrita en el Registro Mercantil de Alicante, Tomo 1305, Folio 169, Hoja A-6793, Inscrip. 11. C.I.F.:B03133881'
//    lb33.Caption := 'Inscrita en el Registro Mercantil de Alicante, Tomo 607, Folio 120, Libro 242, Sección 3ª, Hoja 3.907 C.I.F.:A03133881'
  else
    lb33.Caption := 'Inscrita en el Registro Mercantil de Alicante, Tomo 1423, Folio 211, Hoja A-12519, Inscrip. 1ª. C.I.F.: B03020369';

  if gsAlias = 'MUCHAVISTA' then
    lb34.Caption := 'AGUA POTABLE REG. SANITARIO 27.01604/R'
  else if gsAlias = 'JIJONA' then
    lb34.Caption := 'AGUA DE RIEGO'
  else
    lb34.Caption := '';
end;

end.
