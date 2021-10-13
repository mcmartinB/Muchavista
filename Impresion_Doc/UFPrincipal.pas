unit UFPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, StdCtrls, BonnyQuery, UConfig,
  QRPrntr, QRPDFFilt, QRCtrls, QuickRpt,
  cxButtons, cxGroupBox, 
  dxSkinsCore, dxSkinBlue, dxSkinFoggy, dxSkinLondonLiquidSky, DBTables,
  dxGDIPlusClasses, cxImage, cxLabel, Printers, dxSkinBlack, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TFPrincipal = class(TForm)
    gbPrincipal: TcxGroupBox;
    btnImpresion: TcxButton;
    cxImage1: TcxImage;
    btnSalir: TcxButton;
    btnConfigurar: TcxButton;
    dlgImpresion: TPrintDialog;
    lb1: TcxLabel;
    lbEmpresa: TcxLabel;
    lb2: TcxLabel;
    lbUsuario: TcxLabel;
    lb4: TcxLabel;
    lbImpresora: TcxLabel;
    btCambioEmp: TcxButton;
    btnCorreo: TcxButton;
    QRPDFFilter1: TQRPDFFilter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImpresionClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure btCambioEmpClick(Sender: TObject);
    procedure btnCorreoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    indice: integer;
    aSerial: Array[0..9999] of Integer;
    QImpresion, QueryEC, QueryFL, QueryPT, QueryFV, QueryDB: TQuery;
    QueryBorrar: TQuery;
    Config: TConfig;

    procedure CreaQEmpresa;
    procedure CreaQTiposHis;
    procedure CreaQImpresion;
    function EjecutaQImpresion: boolean;
    procedure CreaQueryEC;
    function EjecutaQueryEC: boolean;
    procedure ImpresionEC;
    procedure EmailEC;
    procedure CreaQueryFL;
    function EjecutaQueryFL: boolean;
    procedure ImpresionFL;
    procedure EmailFL;
    procedure CreaQueryPT;
    function EjecutaQueryPT: boolean;
    procedure ImpresionPT;
    procedure EmailPT;
    procedure CreaQueryFV;
    function EjecutaQueryFV: boolean;
    procedure ImpresionFV;
    procedure EmailFV;
    procedure CreaQueryDB;
    function EjecutaQueryDB: boolean;
    procedure ImpresionDB;
    procedure EmailDB;
    procedure IniciarSerial;
    procedure CargaSerial(ATipo: String);
    procedure CreaQueryBorrar;
    procedure BorrarImpresion;
    procedure BorrarRegistro(AClave: Integer);
    procedure AccesoBD;
    procedure CerrarTablas;
    procedure CambiaFuenteInforme(informe: TQuickRep; fuente: string);
    function GetEmail(zona: Integer; cliente:Integer): string;
    function emailValido(const Value: string): Boolean; 

  public
    QEmpresa, QTiposHis: TQuery;
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses URExtracto, UDM, CVariables, URFichaLectura, URParteTrabajo,
  URFacturaVenta, URDomiciliacion, UEnvioCorreo;

{$R *.dfm}

procedure TFPrincipal.CreaQEmpresa;
begin
  QEmpresa := TQuery.Create(Self);
  with QEmpresa do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select empresa.raz_soc raz_soc, empresa.nif_empr nif_empr, empresa.dir_empr dir_empr,     ');
    SQL.Add('        lpad(empresa.cpo_empr, 5, "0") cpo_empr, poblaciones.tit_pob tit_pob,              ');
    SQL.Add('        provincias.tit_pro tit_pro ');
    SQL.Add('   from empresa, poblaciones, provincias ');
    SQL.Add('  where poblaciones.cod_pob = empresa.cpo_empr   ');
    SQL.Add('    and provincias.cod_pro = poblaciones.cod_pro ');
  end;

end;

procedure TFprincipal.CreaQTiposHis;
begin
  QTiposHis := TQuery.Create(Self);
  with QTiposHis do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;

    SQL.Add(' select * from tipos_his  ');
    SQL.Add('  where ano_tip = :anotip ');
    SQL.Add('    and per_tip = :pertip ');
    SQL.Add('    and cod_tip = :codtip ');
  end;
end;

procedure TFPrincipal.CreaQImpresion;
begin
  QImpresion := TQuery.Create(Self);
  with QImpresion do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select distinct tipo_impresion tipo_impresion ');
    SQL.Add('   from impresion_tmp ');
    SQL.Add('  where usuario = :usuario ');

    Prepare;
  end;
end;

function TFPrincipal.EjecutaQImpresion: boolean;
begin
  with QImpresion do
  begin
    if Active then
      Close;
    ParamByName('usuario').AsString := gsUsuario;

    Open;

    Result := not IsEmpty;
  end;
end;


procedure TFPrincipal.CreaQueryEC;
begin
  QueryEC := TQuery.Create(Self);
  with QueryEC do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;

    SQL.Add(' select empresa.raz_soc empresa, impresion_tmp.fecha_cobro_ec fecha_cobro,  ');
    SQL.Add('        clientes.cod_zon cod_zon, clientes.cod_cli cod_cli, clientes.tit_cli tit_cli, clientes.dom_cli dom_cli, ');
    SQL.Add('        impresion_tmp.cod_rec cod_rec, impresion_tmp.contador_ec contador_ec, ');
    SQL.Add('        cartera.per_rec per_rec, cartera.ano_rec ano_rec, cartera.tot_rec tot_rec, impresion_tmp.clave_lin clave_lin ');
    SQL.Add(' from impresion_tmp, cartera, empresa, clientes  ');
    SQL.Add(' where tipo_impresion = :tipo_impresion          ');
    SQL.Add('   and usuario = :usuario                        ');

    SQL.Add('   and cartera.cod_rec = impresion_tmp.cod_rec      ');

    SQL.Add('   and clientes.cod_zon = cartera.cod_zon     ');
    SQL.Add('   and clientes.cod_cli = cartera.cod_cli     ');

    SQL.Add(' order by impresion_tmp.contador_ec, impresion_tmp.cod_rec ');

    Prepare;

  end;
end;

function TFPrincipal.EjecutaQueryEC: boolean;
begin
  with QueryEC do
  begin
    if Active then
      Close;

    ParamByName('tipo_impresion').AsString := QImpresion.fieldbyname('tipo_impresion').AsString;
    ParamByName('usuario').AsString := gsUsuario;

    Open;

    Result := not IsEmpty;
  end;
end;

procedure TFPrincipal.CreaQueryFL;
begin
  QueryFL := TQuery.Create(Self);
  with QueryFL do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;

    SQL.Add(' select impresion_tmp.ano1_fl ano1_fl, impresion_tmp.ano2_fl ano2_fl, impresion_tmp.ano3_fl ano3_fl, ');
    SQL.Add('        clientes.cod_zon cod_zon, lpad(clientes.cod_cli, 9,"0") cod_cli, clientes.lan_cli lan_cli,  ');
    SQL.Add('        clientes.fan_cli fan_cli,  ');
    SQL.Add('        clientes.cnt_cli cnt_cli, clientes.tit_cli tit_cli, clientes.dom_cli dom_cli, clientes.tel_cli tel_cli,   ');
    SQL.Add('        clientes.let_cli let_cli, clientes.con_cli con_cli, clientes.fco_cli fco_cli, clientes.cod_tip cod_tip,   ');
    SQL.Add('        clientes.dom_ind dom_ind, tipos.cal_tip cal_tip, poblaciones.tit_pob tit_pob, provincias.tit_pro tit_pro, ');
    SQL.Add('        impresion_tmp.clave_lin clave_lin ');
    SQL.Add(' from impresion_tmp, clientes, outer(tipos), poblaciones, provincias     ');
    SQL.Add(' where tipo_impresion = :tipo_impresion           ');
    SQL.Add('   and usuario = :usuario                         ');

    SQL.Add('   and clientes.cod_zon = impresion_tmp.cod_zon   ');
    SQL.Add('   and clientes.cod_cli = impresion_tmp.cod_cli   ');

    SQL.Add('   and tipos.cod_tip = clientes.cod_tip           ');

    SQL.Add('   and poblaciones.cod_pob = clientes.cod_pob     ');

    SQL.Add('   and provincias.cod_pro = poblaciones.cod_pro   ');

    SQL.Add(' order by clientes.cod_zon, clientes.cod_cli ');

    Prepare;

  end;
end;

function TFPrincipal.EjecutaQueryFL: boolean;
begin
  with QueryFL do
  begin
    if Active then
      Close;

    ParamByName('tipo_impresion').AsString := QImpresion.fieldbyname('tipo_impresion').AsString;
    ParamByName('usuario').AsString := gsUsuario;

    Open;

    Result := not IsEmpty;
  end;
end;

procedure TFPrincipal.CreaQueryPT;
begin
  QueryPT := TQuery.Create(Self);
  with QueryPT do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;

    SQL.Add(' select impresion_tmp.texto1_pt, impresion_tmp.texto2_pt, impresion_tmp.texto3_pt,    ');
    SQL.Add('        impresion_tmp.texto4_pt, impresion_tmp.texto5_pt, impresion_tmp.texto6_pt,    ');
    SQL.Add('        clientes.cod_zon cod_zon, clientes.cod_cli cod_cli,                           ');
    SQL.Add('        clientes.tit_cli tit_cli, clientes.cnt_cli cnt_cli, clientes.tel_cli tel_cli, ');
    SQL.Add('        clientes.dom_cli, lpad(clientes.cod_pob, 5, "0") cod_pob,                     ');
    SQL.Add('        poblaciones.tit_pob tit_pob, provincias.tit_pro tit_pro,                      ');
    SQL.Add('        tipos.cal_tip cal_tip, empresa.raz_soc raz_soc, impresion_tmp.clave_lin clave_lin ');
    SQL.Add(' from impresion_tmp, clientes, poblaciones, provincias, empresa, outer(tipos)         ');
    SQL.Add(' where tipo_impresion = :tipo_impresion                                               ');
    SQL.Add('   and usuario = :usuario                                                             ');

    SQL.Add('   and clientes.cod_zon = impresion_tmp.cod_zon                                       ');
    SQL.Add('   and clientes.cod_cli = impresion_tmp.cod_cli                                       ');

    SQL.Add('   and poblaciones.cod_pob = clientes.cod_pob                                         ');

    SQL.Add('   and provincias.cod_pro = poblaciones.cod_pro                                       ');

    SQL.Add('   and tipos.cod_tip = clientes.cod_tip                                               ');

    Prepare;

  end;
end;

function TFPrincipal.EjecutaQueryPT: boolean;
begin
  with QueryPT do
  begin
    if Active then
      Close;

    ParamByName('tipo_impresion').AsString := QImpresion.fieldbyname('tipo_impresion').AsString;
    ParamByName('usuario').AsString := gsUsuario;

    Open;

    Result := not IsEmpty;
  end;
end;

function TFPrincipal.GetEmail(zona, cliente: Integer): string;
var
  QueryEmail: TQuery;
  ReturnedValue:  string;
begin
  ReturnedValue := '';
  QueryEmail:= TQuery.Create(self);
  try
    QueryEmail.DatabaseName := UDM.DM.BDProyecto.DatabaseName;
    QueryEmail.SQL.Text := 'SELECT email FROM Domicilios '+
    'WHERE cod_zon=:zona AND cod_cli=:cliente AND email is not null AND email <> "" ';
    QueryEmail.ParamByName('zona').AsInteger := zona;
    QueryEmail.ParamByName('cliente').AsInteger := cliente;
    QueryEmail.Open;
    if not QueryEmail.IsEmpty then
      ReturnedValue := QueryEmail.FieldByName('email').AsString;
  finally
    QueryEmail.Free;
  end;
  Result := ReturnedValue;
end;

procedure TFPrincipal.EmailDB;
var
  fileName: string;
  filter: TQRPDFDocumentFilter;
  targetEmail: string;
  zona: Integer;
  cliente: Integer;
  QueryDB2: TQuery;
begin

  if not EjecutaQueryDB then exit;

  QueryDB2 := TQuery.Create(Self);
  with QueryDB2 do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select clientes.cod_zon, clientes.cod_cli, ');
    SQL.Add(' impresion_tmp.texto1_db texto1_db, impresion_tmp.texto2_db texto2_db,                      ');
    SQL.Add('        empresa.nombre[1,2] || clientes.cod_zon || lpad(clientes.cod_cli, 9, "0") referencia,      ');
    SQL.Add('        lpad(clientes.cod_pob, 5, "0") cod_pob,                                                    ');
    SQL.Add('        clientes.cod_iban || lpad(clientes.cod_ban, 4, "0") || lpad(clientes.cod_suc, 4, "0") ||   ');
    SQL.Add('        lpad(clientes.dig_con, 2, "0") || lpad(clientes.cta_cli, 10, "0") iban,                    ');
    SQL.Add('        clientes.cod_bic, banco_swift.des_bic des_bic,                                             ');
    SQL.Add('        poblaciones.tit_pob tit_pob, provincias.tit_pro tit_pro, impresion_tmp.clave_lin clave_lin ');
    SQL.Add('   from impresion_tmp, clientes, poblaciones, provincias, empresa, outer(banco_swift)              ');
    SQL.Add(' where impresion_tmp.tipo_impresion = :tipo_impresion                                         ');
    SQL.Add('   and usuario = :usuario                                                                     ');

    SQL.Add('   and clientes.cod_zon = impresion_tmp.cod_zon                                               ');
    SQL.Add('   and clientes.cod_cli = impresion_tmp.cod_cli                                               ');

    SQL.Add('   and poblaciones.cod_pob = clientes.cod_pob                                                 ');

    SQL.Add('   and provincias.cod_pro = poblaciones.cod_pro                                               ');

    SQL.Add('     and banco_swift.cod_ban = clientes.cod_ban                                               ');
    SQL.Add('     and banco_swift.cod_bic = clientes.cod_bic                                               ');

    SQL.Add('   and clientes.cod_zon = :zona                                                               ');
    SQL.Add('   and clientes.cod_cli = :cliente                                                            ');

    Prepare;

  end;


  CargaSerial('DB');

  QueryDB.First;
  while not QueryDB.Eof do
  begin

    with QueryDB2 do
    begin
      if Active then
        Close;

      ParamByName('tipo_impresion').AsString := 'DB';
      ParamByName('usuario').AsString := gsUsuario;
      ParamByName('zona').AsString := QueryDB.FieldByName('cod_zon').AsString;
      ParamByName('cliente').AsString := QueryDB.FieldByName('cod_cli').AsString;

      Open;
    end;

    try
         //Crear Domiciliacion Bancaria
      RDomiciliacion := TRDomiciliacion.Create(Application);
      RDomiciliacion.PrinterSettings.PrinterIndex := Printer.PrinterIndex;

      RDomiciliacion.DataSet := QueryDB2;
      with RDomiciliacion do
      begin
        qrReferencia.DataSet := QueryDB2;
        qrTexto1.DataSet := QueryDB2;
        qrTexto2.DataSet := QueryDB2;
        qrCodPob.DataSet := QueryDB2;
        qrTitPob.DataSet := QueryDB2;
        qrIBAN.DataSet := QueryDB2;
        qrBIC.DataSet := QueryDB2;
        qrDesBIC.DataSet := QueryDB2;
      end;
      zona := QueryDB.FieldByName('cod_zon').AsInteger;
      cliente := QueryDB.FieldByName('cod_cli').AsInteger;
      fileName := 'domiciliacionBancaria_'+IntToStr(zona)+'_'+IntToStr(cliente)+'.pdf';
      filter := TQRPDFDocumentFilter.Create(Config.tmpDir +'\'+fileName);

      CambiaFuenteInforme(RDomiciliacion,'Courier');

      RDomiciliacion.ShowProgress := false;
      RDomiciliacion.Prepare;
      RDomiciliacion.QRPrinter.ExportToFilter(filter);

      targetEmail := GetEmail(zona,cliente);
      if (targetEmail<>'') then
      begin
        if EmailValido(targetEmail) then
          EnviarMensaje( Config.Usuario, Config.Clave, Config.Servidor, Config.Puerto,
                   Config.tmpDir +'\'+ fileName, 'Domiciliación bancaria',
                   targetEmail, 'Domiciliación bancaria' )
        else
          UEnvioCorreo.log('Zona:'+IntToStr(zona)+' Cliente:'+IntToStr(cliente)+' direccion de correo incorrecta: '+ targetEmail);
      end
      else
      begin
//        UEnvioCorreo.log('Zona:'+IntToStr(zona)+' Cliente:'+IntToStr(cliente)+' no tiene dirección de correo');
      end;
    finally
      FreeAndNil(filter);
      FreeAndNil(RDomiciliacion);
    end;

    QueryDB.Next;
  end;
end;

procedure TFPrincipal.EmailEC;
var
  fileName: string;
  filter: TQRPDFDocumentFilter;
  targetEmail: string;
  zona: Integer;
  cliente: Integer;
  QueryEC2: TQuery;
begin

  if not EjecutaQueryEC then exit;

  QueryEC2 := TQuery.Create(Self);
  with QueryEC2 do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;

    SQL.Add(' select empresa.raz_soc empresa, impresion_tmp.fecha_cobro_ec fecha_cobro,  ');
    SQL.Add('        clientes.cod_zon cod_zon, clientes.cod_cli cod_cli, clientes.tit_cli tit_cli, clientes.dom_cli dom_cli, ');
    SQL.Add('        impresion_tmp.cod_rec cod_rec, impresion_tmp.contador_ec contador_ec, ');
    SQL.Add('        cartera.per_rec per_rec, cartera.ano_rec ano_rec, cartera.tot_rec tot_rec, impresion_tmp.clave_lin clave_lin ');
    SQL.Add(' from impresion_tmp, cartera, empresa, clientes  ');
    SQL.Add(' where tipo_impresion = :tipo_impresion          ');
    SQL.Add('   and usuario = :usuario                        ');

    SQL.Add('   and cartera.cod_rec = impresion_tmp.cod_rec      ');

    SQL.Add('   and clientes.cod_zon = cartera.cod_zon     ');
    SQL.Add('   and clientes.cod_cli = cartera.cod_cli     ');

    SQL.Add('   and cliente.cod_zon = :zona                ');
    SQL.Add('   and cliente.cod_cli = :cliente             ');

    SQL.Add(' order by impresion_tmp.contador_ec, impresion_tmp.cod_rec ');

    Prepare;
  end;


  CargaSerial('EC');

  QueryEC.First;
  while not QueryEC.eof do
  begin

    with QueryEC2 do
    begin
      if Active then
        Close;

      ParamByName('tipo_impresion').AsString := 'EC';
      ParamByName('usuario').AsString := gsUsuario;
      ParamByName('zona').AsString := QueryEC.FieldByName('cod_zon').AsString;
      ParamByName('cliente').AsString := QueryEC.FieldByName('cod_cli').AsString;

      Open;
    end;

    try
      //Crear fichero pdf del informe Extracto de Cuenta
      RExtracto := TRExtracto.Create(Application);

      RExtracto.DataSet := QueryEC2;
      with RExtracto do
      begin
        QREmpresa.DataSet := QueryEC2;
        QRFechaCobro.DataSet := QueryEC2;
        QRCodZon.DataSet := QueryEC2;
        QRCodCli.DataSet := QueryEC2;
        QRTitCli.DataSet := QueryEC2;
        QRDomCli.DataSet := QueryEC2;
        QRCodRec.DataSet := QueryEC2;
        QRtotRec.DataSet := QueryEC2;

      end;
      zona := QueryEC.FieldByName('cod_zon').AsInteger;
      cliente := QueryEC.FieldByName('cod_cli').AsInteger;
      fileName := 'extractoCuenta_'+IntToStr(zona)+'_'+IntToStr(cliente)+'.pdf';
      filter := TQRPDFDocumentFilter.Create(Config.tmpDir +'\'+fileName);

      CambiaFuenteInforme(RExtracto,'Courier');

      RExtracto.ShowProgress := false;
      RExtracto.Prepare;
      RExtracto.QRPrinter.ExportToFilter(filter);

      targetEmail := GetEmail(zona,cliente);
      if (targetEmail<>'') then
      begin
      EnviarMensaje( Config.Usuario, Config.Clave, Config.Servidor, Config.Puerto,
               Config.tmpDir +'\'+ fileName, 'Extracto cuenta',
               targetEmail, 'Adjunto extracto de cuenta' );
      end
      else
      begin
//        UEnvioCorreo.log('Zona:'+IntToStr(zona)+' Cliente:'+IntToStr(cliente)+' no tiene dirección de correo');
      end;
    finally
      FreeAndNil(filter);
      FreeAndNil(RExtracto);
    end;

    QueryEC.Next;
  end;
end;

procedure TFPrincipal.EmailFL;
var
  fileName: string;
  filter: TQRPDFDocumentFilter;
  targetEmail: string;
  zona: Integer;
  cliente: Integer;
  QueryFL2: TQuery;
begin

  if not EjecutaQueryFL then exit;

  QueryFL2 := TQuery.Create(Self);
  with QueryFL2 do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;

    SQL.Add(' select impresion_tmp.ano1_fl ano1_fl, impresion_tmp.ano2_fl ano2_fl, impresion_tmp.ano3_fl ano3_fl, ');
    SQL.Add('        clientes.cod_zon cod_zon, lpad(clientes.cod_cli, 9,"0") cod_cli, clientes.lan_cli lan_cli,  ');
    SQL.Add('        clientes.fan_cli fan_cli,  ');
    SQL.Add('        clientes.cnt_cli cnt_cli, clientes.tit_cli tit_cli, clientes.dom_cli dom_cli, clientes.tel_cli tel_cli,   ');
    SQL.Add('        clientes.let_cli let_cli, clientes.con_cli con_cli, clientes.fco_cli fco_cli, clientes.cod_tip cod_tip,   ');
    SQL.Add('        clientes.dom_ind dom_ind, tipos.cal_tip cal_tip, poblaciones.tit_pob tit_pob, provincias.tit_pro tit_pro, ');
    SQL.Add('        impresion_tmp.clave_lin clave_lin ');
    SQL.Add(' from impresion_tmp, clientes, outer(tipos), poblaciones, provincias     ');
    SQL.Add(' where tipo_impresion = :tipo_impresion           ');
    SQL.Add('   and usuario = :usuario                         ');

    SQL.Add('   and clientes.cod_zon = impresion_tmp.cod_zon   ');
    SQL.Add('   and clientes.cod_cli = impresion_tmp.cod_cli   ');

    SQL.Add('   and tipos.cod_tip = clientes.cod_tip           ');

    SQL.Add('   and poblaciones.cod_pob = clientes.cod_pob     ');

    SQL.Add('   and provincias.cod_pro = poblaciones.cod_pro   ');

    SQL.Add('   and clientes.cod_zon = :zona                    ');
    SQL.Add('   and clientes.cod_cli = :cliente                 ');

    SQL.Add(' order by clientes.cod_zon, clientes.cod_cli ');

    Prepare;
  end;


  CargaSerial('FL');

  QueryFL.First;
  while not QueryFL.Eof do
  begin

    with QueryFL2 do
    begin
      if Active then
        Close;

      ParamByName('tipo_impresion').AsString := 'FL';
      ParamByName('usuario').AsString := gsUsuario;
      ParamByName('zona').AsString := QueryFL.FieldByName('cod_zon').AsString;
      ParamByName('cliente').AsString := QueryFL.FieldByName('cod_cli').AsString;

      Open;
    end;

    try
      //Crear fichero pdf informe Ficha de Lectura
      RFichaLectura := TRFichaLectura.Create(Application);

      RFichaLectura.DataSet := QueryFL2;
      with RFichaLectura do
      begin
        QRAno1.DataSet := QueryFL2;
        QRAno2.DataSet := QueryFL2;
        QRAno3.DataSet := QueryFL2;
        QRLacCli.DataSet := QueryFL2;
        QRFacCli.DataSet := QueryFL2;
        QRCodZon.DataSet := QueryFL2;
        QRCodCli.DataSet := QueryFL2;
        QRCntCli.DataSet := QueryFL2;
        QRTitCli.DataSet := QueryFL2;
        QRDomCli.DataSet := QueryFL2;
        QRTitPob.DataSet := QueryFL2;
        QRTitPro.DataSet := QueryFL2;
        QRTelCli.DataSet := QueryFL2;
        QRFcoCli.DataSet := QueryFL2;
        QRCodTip.DataSet := QueryFL2;
        QRCalTip.DataSet := QueryFL2;

      end;
      zona := QueryFL.FieldByName('cod_zon').AsInteger;
      cliente := QueryFL.FieldByName('cod_cli').AsInteger;
      fileName := 'fichaLectura_'+IntToStr(zona)+'_'+IntToStr(cliente)+'.pdf';
      filter := TQRPDFDocumentFilter.Create(Config.tmpDir +'\'+fileName);

      CambiaFuenteInforme(RFichaLectura,'Courier');

      RFichaLectura.ShowProgress := false;
      RFichaLectura.Prepare;
      RFichaLectura.QRPrinter.ExportToFilter(filter);

      targetEmail := GetEmail(zona,cliente);
      if (targetEmail<>'') then
      begin
      EnviarMensaje( Config.Usuario, Config.Clave, Config.Servidor, Config.Puerto,
               Config.tmpDir +'\'+ fileName, 'Ficha de lectura',
               targetEmail, 'Adjunto ficha de lectura' );
      end
      else
      begin
//        UEnvioCorreo.log('Zona:'+IntToStr(zona)+' Cliente:'+IntToStr(cliente)+' no tiene dirección de correo');
      end;
    finally
      FreeAndNil(filter);
      FreeAndNil(RFichaLectura);
    end;

    QueryFL.Next;
  end;
end;

procedure TFPrincipal.EmailFV;
var
  fileName: string;
  filter: TQRPDFDocumentFilter;
  targetEmail: string;
  zona: Integer;
  cliente: Integer;
  texto: string;
  QueryFV2: TQuery;
begin

  if not EjecutaQueryFV then exit;

  QueryFV2 := TQuery.Create(Self);
  with QueryFV2 do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select clientes.cod_zon, clientes.cod_cli,');
    SQL.Add(' clientes.cod_zon || "/" || lpad(clientes.cod_cli, 9, "0") referencia,                           ');
    SQL.Add('        clientes.tit_cli tit_cli, clientes.nif_cli, clientes.let_cli ||"-"|| clientes.con_cli let_cli,  ');
    SQL.Add('        clientes.cnt_cli cnt_cli, clientes.cod_tip cod_tip, clientes.coe_cor coe_cor,                   ');
    SQL.Add('        cartera.cod_rec cod_rec, cartera.ffa_rec ffa_rec, cartera.per_rec,                        ');
    SQL.Add('        clientes.dom_cli cdom_cli, lpad(clientes.cod_pob, 5, "0") ccod_pob,                             ');
    SQL.Add('        tipos_his.cal_tip cal_tip, poblaciones.tit_pob ctit_pob,                                        ');
    SQL.Add('        provincias.tit_pro ctit_pro,                                                                    ');
    SQL.Add('        domicilios.dom_dom ddom_cli, lpad(domicilios.cod_pobd, 5, "0") dcod_pob,                        ');
    SQL.Add('        domicilios.tit_pobd dtit_pob, v2.tit_pro dtit_pro,                                              ');
    SQL.Add('        cartera.fan_rec fan_rec, cartera.lan_rec lan_rec, cartera.fac_rec fac_rec,                      ');
    SQL.Add('        cartera.lac_rec lac_rec , cartera.m3_rec m3_rec, cartera.porc_im3 porc_im3,                     ');
    SQL.Add('        cartera.con_rec con_rec, cartera.porc_ico porc_ico, cartera.ico_rec ico_rec,                    ');
    SQL.Add('        cartera.man_rec man_rec, cartera.porc_ima porc_ima, cartera.ima_rec ima_rec,                    ');
    SQL.Add('        cartera.cse_rec cse_rec, cartera.cta_cco cta_cco, cartera.cco_rec cco_rec,                      ');
    SQL.Add('        cartera.ano_rec ano_rec, cartera.per_rec per_rec, cartera.pm3_rec pm3_rec,                      ');
    if DataBaseName = 'JIJONA' then
      SQL.Add('        cartera.im3_rec im3_rec, cartera.tot_rec tot_rec, impresion_tmp.clave_lin clave_lin           ')
    else
    begin
      SQL.Add('        cartera.im3_rec im3_rec, cartera.tot_rec tot_rec, impresion_tmp.clave_lin clave_lin,          ');
      SQL.Add('        NVL(cartera.apl_c19, 0) apl_c19                                                               ');
    end;
    SQL.Add(' from impresion_tmp, cartera, clientes, outer(tipos_his), poblaciones, provincias,                      ');
    SQL.Add('      outer(domicilios, poblaciones p2, provincias v2)                                                  ');
    SQL.Add(' where tipo_impresion = :tipo_impresion                                                                 ');
    SQL.Add('   and usuario = :usuario                                                                               ');

    SQL.Add('   and cartera.cod_rec = impresion_tmp.cod_rec                                                          ');

    SQL.Add('   and clientes.cod_zon = cartera.cod_zon                                                               ');
    SQL.Add('   and clientes.cod_cli = cartera.cod_cli                                                               ');

    SQL.Add('   and tipos_his.ano_tip = cartera.ano_rec                                                              ');
    SQL.Add('   and tipos_his.per_tip = cartera.per_rec                                                              ');
    SQL.Add('   and tipos_his.cod_tip = clientes.cod_tip                                                             ');

    SQL.Add('   and poblaciones.cod_pob = clientes.cod_pob                                                           ');

    SQL.Add('   and provincias.cod_pro = poblaciones.cod_pro                                                         ');

    SQL.Add('   and domicilios.cod_zon = clientes.cod_zon                                                            ');
    SQL.Add('   and domicilios.cod_cli = clientes.cod_cli                                                            ');

    SQL.Add('   and p2.cod_pob = domicilios.cod_pobd                                                                 ');

    SQL.Add('   and v2.cod_pro = p2.cod_pro                                                                          ');

    SQL.Add('   and clientes.cod_zon = :zona                                                                         ');
    SQL.Add('   and clientes.cod_cli = :cliente                                                                      ');

    SQL.Add(' UNION ');

    SQL.Add(' select clientes.cod_zon, clientes.cod_cli, ');
    SQL.Add(' clientes.cod_zon || "/" || lpad(clientes.cod_cli, 9, "0") referencia,                           ');
    SQL.Add('        clientes.tit_cli tit_cli, clientes.nif_cli, clientes.let_cli ||"-"|| clientes.con_cli let_cli,  ');
    SQL.Add('        clientes.cnt_cli cnt_cli, clientes.cod_tip cod_tip, clientes.coe_cor coe_cor,                   ');
    SQL.Add('        historico.cod_rec cod_rec, historico.ffa_rec ffa_rec, historico.per_rec,                        ');
    SQL.Add('        clientes.dom_cli cdom_cli, lpad(clientes.cod_pob, 5, "0") ccod_pob,                             ');
    SQL.Add('        tipos_his.cal_tip cal_tip, poblaciones.tit_pob ctit_pob,                                        ');
    SQL.Add('        provincias.tit_pro ctit_pro,                                                                    ');
    SQL.Add('        domicilios.dom_dom ddom_cli, lpad(domicilios.cod_pobd, 5, "0") dcod_pob,                        ');
    SQL.Add('        domicilios.tit_pobd dtit_pob, v2.tit_pro dtit_pro,                                              ');
    SQL.Add('        historico.fan_rec fan_rec, historico.lan_rec lan_rec, historico.fac_rec fac_rec,                ');
    SQL.Add('        historico.lac_rec lac_rec , historico.m3_rec m3_rec, historico.porc_im3 porc_im3,               ');
    SQL.Add('        historico.con_rec con_rec, historico.porc_ico porc_ico, historico.ico_rec ico_rec,              ');
    SQL.Add('        historico.man_rec man_rec, historico.porc_ima porc_ima, historico.ima_rec ima_rec,              ');
    SQL.Add('        historico.cse_rec cse_rec, historico.cta_cco cta_cco, historico.cco_rec cco_rec,                ');
    SQL.Add('        historico.ano_rec ano_rec, historico.per_rec per_rec, historico.pm3_rec pm3_rec,                ');
    if DataBaseName = 'JIJONA' then
      SQL.Add('        historico.im3_rec im3_rec, historico.tot_rec tot_rec, impresion_tmp.clave_lin clave_lin       ')
    else
    begin
      SQL.Add('        historico.im3_rec im3_rec, historico.tot_rec tot_rec, impresion_tmp.clave_lin clave_lin,      ');
      SQL.Add('        NVL(historico.apl_c19, 0) apl_c19                                                             ');
    end;
    SQL.Add(' from impresion_tmp, historico, clientes, outer(tipos_his), poblaciones, provincias,                    ');
    SQL.Add('      outer(domicilios, poblaciones p2, provincias v2)                                                  ');
    SQL.Add(' where tipo_impresion = :tipo_impresion                                                                 ');
    SQL.Add('   and usuario = :usuario                                                                               ');

    SQL.Add('   and historico.cod_rec = impresion_tmp.cod_rec                                                        ');

    SQL.Add('   and clientes.cod_zon = historico.cod_zon                                                             ');
    SQL.Add('   and clientes.cod_cli = historico.cod_cli                                                             ');

    SQL.Add('   and tipos_his.ano_tip = historico.ano_rec                                                            ');
    SQL.Add('   and tipos_his.per_tip = historico.per_rec                                                            ');
    SQL.Add('   and tipos_his.cod_tip = clientes.cod_tip                                                             ');

    SQL.Add('   and poblaciones.cod_pob = clientes.cod_pob                                                           ');

    SQL.Add('   and provincias.cod_pro = poblaciones.cod_pro                                                         ');

    SQL.Add('   and domicilios.cod_zon = clientes.cod_zon                                                            ');
    SQL.Add('   and domicilios.cod_cli = clientes.cod_cli                                                            ');

    SQL.Add('   and p2.cod_pob = domicilios.cod_pobd                                                                 ');

    SQL.Add('   and v2.cod_pro = p2.cod_pro                                                                          ');

    SQL.Add('   and clientes.cod_zon = :zona                                                                         ');
    SQL.Add('   and clientes.cod_cli = :cliente                                                                      ');

    Prepare;
  end;

  CargaSerial('FV');

  QueryFV.First;
  while not QueryFV.eof do
  begin

    with QueryFV2 do
    begin
      if Active then
        Close;

      ParamByName('tipo_impresion').AsString := 'FV';
      ParamByName('usuario').AsString := gsUsuario;
      ParamByName('zona').AsString := QueryFV.FieldByName('cod_zon').AsString;
      ParamByName('cliente').AsString := QueryFV.FieldByName('cod_cli').AsString;

      Open;
    end;

    try
         //Crear Factura Venta
      RFacturaVenta := TRFacturaVenta.Create(Application);
      RFacturaVenta.PrinterSettings.PrinterIndex := Printer.PrinterIndex;

      RFacturaVenta.DataSet := QueryFV2;
      with RFacturaVenta do
      begin
        qrTitCli.DataSet := QueryFV2;
        qrNifCli.DataSet := QueryFV2;
        qrLetCli.DataSet := QueryFV2;
        qrCalTip.DataSet := QueryFV2;
        qrCntCli.DataSet := QueryFV2;
        qrCodRec.DataSet := QueryFV2;
        qrFfaRec.DataSet := QueryFV2;
        qrCDomCli.DataSet := QueryFV2;
        qrCCodPob.DataSet := QueryFV2;
        qrCTitPob.DataSet := QueryFV2;
        qrCTitPro.DataSet := QueryFV2;
        qrTitCli2.DataSet := QueryFV2;
        qrM3Rec.DataSet := QueryFV2;
        qrFanRec.DataSet := QueryFV2;
        qrLanRec.DataSet := QueryFV2;
        qrFacRec.DataSet := QueryFV2;
        qrLacRec.DataSet := QueryFV2;
        qrConRec.DataSet := QueryFV2;
        qrManRec.DataSet := QueryFV2;
        qrCseRec.DataSet := QueryFV2;
        qrCM3Rec.DataSet := QueryFV2;
        qrCtaCco.DataSet := QueryFV2;
        qrCcoRec.DataSet := QueryFV2;
        qrTotRec.DataSet := QueryFV2;
        qrReferencia.DataSet := QueryFV2;
        qrAplazamiento.DataSet := QueryFV2;
      end;
      zona := QueryFV.FieldByName('cod_zon').AsInteger;
      cliente := QueryFV.FieldByName('cod_cli').AsInteger;
      fileName := 'facturaVenta_'+IntToStr(zona)+'_'+IntToStr(cliente)+'.pdf';
      filter := TQRPDFDocumentFilter.Create(Config.tmpDir +'\'+fileName);

  //    CambiaFuenteInforme(RFacturaVenta,'Courier');

      RFacturaVenta.ShowProgress := false;
      RFacturaVenta.Prepare;
      RFacturaVenta.QRPrinter.ExportToFilter(filter);

      targetEmail := GetEmail(zona,cliente);
      if (targetEmail<>'') then
      begin
        if emailValido(targetEmail) then
        begin
          texto := '-----------------------------------------------------'+#13#10;
          texto := texto + 'Se adjunta factura de agua.'+#13#10;
          texto := texto + #13#10;
          texto := texto + 'Este mensaje, y los ficheros anexos que pueda contener, son confidentes.';
          texto := texto + 'Los mismos pueden contener información reservada que no puede ser difundida.';
          texto := texto + 'Si usted ha recibido este correo por error, tenga la amabilidad de eliminarlo de su sistema y remitírnoslo, por correo electrónico, a la dirección tonigonzalez@aguasdemuchavista,es. No deberá copiar el mensaje ni divulgar su contenido.'+#13#10;
          texto := texto + 'Su dirección de correo electrónico, junto a sus datos personales, constan en un fichero de titularidad de AGUAS DE MUCHAVISTA, S.L., debidamente declarado ante la Agencia Española de Proteción de Datos, ';
          texto := texto + 'cuya finalidad es la de mantener el contacto con Ud. podrá Ud. ';
          texto := texto + 'ejercitar sus derechos enviando un escrito al efecto, en los términos que establece la Ley, a AGUAS DE MUCHAVISTA, S.L., Cl. Mayor, 4 Bajo – 03111 Busot (Alicante)'+#13#10;
          texto := texto + '-----------------------------------------------------'+#13#10;
          EnviarMensaje( Config.Usuario, Config.Clave, Config.Servidor, Config.Puerto,
                   Config.tmpDir +'\'+ fileName, 'Factura de agua',
                   targetEmail, texto )
        end
        else
        begin
          UEnvioCorreo.log('Zona:'+IntToStr(zona)+' Cliente:'+IntToStr(cliente)+' direccion de correo incorrecta: '+ targetEmail);
        end;
      end
      else
      begin
//        UEnvioCorreo.log('Zona:'+IntToStr(zona)+' Cliente:'+IntToStr(cliente)+' no tiene dirección de correo');
      end;
    finally
      FreeAndNil(filter);
      FreeAndNil(RFacturaVenta);
    end;

    QueryFV.Next;
  end;
end;

procedure TFPrincipal.EmailPT;
var
  fileName: string;
  filter: TQRPDFDocumentFilter;
  targetEmail: string;
  zona: Integer;
  cliente: Integer;
  QueryPT2: TQuery;
begin

  if not EjecutaQueryPT then exit;

  QueryPT2 := TQuery.Create(Self);
  with QueryPT2 do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;

    SQL.Add(' select impresion_tmp.texto1_pt, impresion_tmp.texto2_pt, impresion_tmp.texto3_pt,    ');
    SQL.Add('        impresion_tmp.texto4_pt, impresion_tmp.texto5_pt, impresion_tmp.texto6_pt,    ');
    SQL.Add('        clientes.cod_zon cod_zon, clientes.cod_cli cod_cli,                           ');
    SQL.Add('        clientes.tit_cli tit_cli, clientes.cnt_cli cnt_cli, clientes.tel_cli tel_cli, ');
    SQL.Add('        clientes.dom_cli, lpad(clientes.cod_pob, 5, "0") cod_pob,                     ');
    SQL.Add('        poblaciones.tit_pob tit_pob, provincias.tit_pro tit_pro,                      ');
    SQL.Add('        tipos.cal_tip cal_tip, empresa.raz_soc raz_soc, impresion_tmp.clave_lin clave_lin ');
    SQL.Add(' from impresion_tmp, clientes, poblaciones, provincias, empresa, outer(tipos)         ');
    SQL.Add(' where tipo_impresion = :tipo_impresion                                               ');
    SQL.Add('   and usuario = :usuario                                                             ');

    SQL.Add('   and clientes.cod_zon = impresion_tmp.cod_zon                                       ');
    SQL.Add('   and clientes.cod_cli = impresion_tmp.cod_cli                                       ');

    SQL.Add('   and poblaciones.cod_pob = clientes.cod_pob                                         ');

    SQL.Add('   and provincias.cod_pro = poblaciones.cod_pro                                       ');

    SQL.Add('   and tipos.cod_tip = clientes.cod_tip                                               ');

    SQL.Add('   and clientes.cod_zon = :zona                                                       ');
    SQL.Add('   and clientes.cod_cli = :cliente                                                    ');

    Prepare;

  end;


  CargaSerial('PT');

  QueryPT.First;
  while not QueryPT.Eof do
  begin

    with QueryPT2 do
    begin
      if Active then
        Close;

      ParamByName('tipo_impresion').AsString := 'PT';
      ParamByName('usuario').AsString := gsUsuario;
      ParamByName('zona').AsString := QueryPT.FieldByName('cod_zon').AsString;
      ParamByName('cliente').AsString := QueryPT.FieldByName('cod_cli').AsString;

      Open;
    end;

    try
         //Crear informe Parte de Trabajo
      RParteTrabajo := TRParteTrabajo.Create(Application);

      RParteTrabajo.DataSet := QueryPT2;
      with RParteTrabajo do
      begin
        qrEmpresa.DataSet := QueryPT2;
        qrTitCli.DataSet := QueryPT2;
        qrCntCli.DataSet := QueryPT2;
        qrCalTip.DataSet := QueryPT2;
        qrCodZon.DataSet := QueryPT2;
        qrCodCli.DataSet := QueryPT2;
        qrTelCli.DataSet := QueryPT2;
        qrDomCli.DataSet := QueryPT2;
        qrCodPob.DataSet := QueryPT2;
        qrTitPob.DataSet := QueryPT2;
        qrTitPro.DataSet := QueryPT2;
        qrTitPro.DataSet := QueryPT2;
        qrTexto1.DataSet := QueryPT2;
        qrTexto2.DataSet := QueryPT2;
        qrTexto3.DataSet := QueryPT2;
        qrTexto4.DataSet := QueryPT2;
        qrTexto5.DataSet := QueryPT2;
        qrTexto6.DataSet := QueryPT2;
      end;
      zona := QueryPT.FieldByName('cod_zon').AsInteger;
      cliente := QueryPT.FieldByName('cod_cli').AsInteger;
      fileName := 'parteTrabajo_'+IntToStr(zona)+'_'+IntToStr(cliente)+'.pdf';
      filter := TQRPDFDocumentFilter.Create(Config.tmpDir +'\'+fileName);

      CambiaFuenteInforme(RParteTrabajo,'Courier');

      RParteTrabajo.ShowProgress := false;
      RParteTrabajo.Prepare;
      RParteTrabajo.QRPrinter.ExportToFilter(filter);

      targetEmail := GetEmail(zona,cliente);
      if (targetEmail<>'') then
      begin
      EnviarMensaje( Config.Usuario, Config.Clave, Config.Servidor, Config.Puerto,
               Config.tmpDir +'\'+ fileName, 'Parte de trabajo',
               targetEmail, 'Adjunto parte de trabajo' );
      end
      else
      begin
//        UEnvioCorreo.log('Zona:'+IntToStr(zona)+' Cliente:'+IntToStr(cliente)+' no tiene dirección de correo');
      end;
    finally
      FreeAndNil(filter);
      FreeAndNil(RParteTrabajo);
    end;

    QueryPT.Next;
  end;

end;

function TFPrincipal.emailValido(const Value: string): Boolean;
  FUNCTION CheckAllowed(CONST s: String): boolean; 
  VAR i: Integer; 
  BEGIN 
  Result:= False;
  FOR i:= 1 TO Length(s) DO // illegal char in s -> no valid address 
  IF NOT (s[i] IN ['a'..'z','A'..'Z','0'..'9','_','-','.']) THEN Exit; 
  Result:= true; 
  END; 
VAR 
  i,len: Integer; 
  namePart, serverPart: String;
begin
  Result:= False;
  i:= Pos('@', Value); 
  IF (i=0) OR (Pos('..',Value) > 0) THEN Exit; 
  namePart:= Copy(Value, 1, i - 1); 
  serverPart:= Copy(Value,i+1,Length(Value)); 
  len:=Length(serverPart); 
  // must have dot and at least 3 places from end, 2 places from begin 
  IF (len<4) OR 
     (Pos('.',serverPart)=0) OR 
     (serverPart[1]='.') OR 
     (serverPart[len]='.') OR 
     (serverPart[len-1]='.') THEN Exit; 
  Result:= CheckAllowed(namePart) AND CheckAllowed(serverPart);
end;

procedure TFPrincipal.CreaQueryFV;
begin
  QueryFV := TQuery.Create(Self);
  with QueryFV do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;

    SQL.Add(' select clientes.cod_zon, clientes.cod_cli,');
    SQL.Add(' clientes.cod_zon || "/" || lpad(clientes.cod_cli, 9, "0") referencia,                           ');
    SQL.Add('        clientes.tit_cli tit_cli, clientes.nif_cli, clientes.let_cli ||"-"|| clientes.con_cli let_cli,  ');
    SQL.Add('        clientes.cnt_cli cnt_cli, clientes.cod_tip cod_tip, clientes.coe_cor coe_cor,                   ');
    SQL.Add('        cartera.cod_rec cod_rec, cartera.ffa_rec ffa_rec, cartera.per_rec,                        ');
    SQL.Add('        clientes.dom_cli cdom_cli, lpad(clientes.cod_pob, 5, "0") ccod_pob,                             ');
    SQL.Add('        tipos_his.cal_tip cal_tip, poblaciones.tit_pob ctit_pob,                                        ');
    SQL.Add('        provincias.tit_pro ctit_pro,                                                                    ');
    SQL.Add('        domicilios.dom_dom ddom_cli, lpad(domicilios.cod_pobd, 5, "0") dcod_pob,                        ');
    SQL.Add('        domicilios.tit_pobd dtit_pob, v2.tit_pro dtit_pro,                                              ');
    SQL.Add('        cartera.fan_rec fan_rec, cartera.lan_rec lan_rec, cartera.fac_rec fac_rec,                      ');
    SQL.Add('        cartera.lac_rec lac_rec , cartera.m3_rec m3_rec, cartera.porc_im3 porc_im3,                     ');
    SQL.Add('        cartera.con_rec con_rec, cartera.porc_ico porc_ico, cartera.ico_rec ico_rec,                    ');
    SQL.Add('        cartera.man_rec man_rec, cartera.porc_ima porc_ima, cartera.ima_rec ima_rec,                    ');
    SQL.Add('        cartera.cse_rec cse_rec, cartera.cta_cco cta_cco, cartera.cco_rec cco_rec,                      ');
    SQL.Add('        cartera.ano_rec ano_rec, cartera.per_rec per_rec, cartera.pm3_rec pm3_rec,                      ');
    if DataBaseName = 'JIJONA' then
      SQL.Add('        cartera.im3_rec im3_rec, cartera.tot_rec tot_rec, impresion_tmp.clave_lin clave_lin           ')
    else
    begin
      SQL.Add('        cartera.im3_rec im3_rec, cartera.tot_rec tot_rec, impresion_tmp.clave_lin clave_lin,          ');
      SQL.Add('        NVL(cartera.apl_c19, 0) apl_c19                                                               ');
    end;
    SQL.Add(' from impresion_tmp, cartera, clientes, outer(tipos_his), poblaciones, provincias,                      ');
    SQL.Add('      outer(domicilios, poblaciones p2, provincias v2)                                                  ');
    SQL.Add(' where tipo_impresion = :tipo_impresion                                                                 ');
    SQL.Add('   and usuario = :usuario                                                                               ');

    SQL.Add('   and cartera.cod_rec = impresion_tmp.cod_rec                                                          ');

    SQL.Add('   and clientes.cod_zon = cartera.cod_zon                                                               ');
    SQL.Add('   and clientes.cod_cli = cartera.cod_cli                                                               ');

    SQL.Add('   and tipos_his.ano_tip = cartera.ano_rec                                                              ');
    SQL.Add('   and tipos_his.per_tip = cartera.per_rec                                                              ');
    SQL.Add('   and tipos_his.cod_tip = clientes.cod_tip                                                             ');

    SQL.Add('   and poblaciones.cod_pob = clientes.cod_pob                                                           ');

    SQL.Add('   and provincias.cod_pro = poblaciones.cod_pro                                                         ');

    SQL.Add('   and domicilios.cod_zon = clientes.cod_zon                                                            ');
    SQL.Add('   and domicilios.cod_cli = clientes.cod_cli                                                            ');

    SQL.Add('   and p2.cod_pob = domicilios.cod_pobd                                                                 ');

    SQL.Add('   and v2.cod_pro = p2.cod_pro                                                                          ');

    SQL.Add(' UNION ');

    SQL.Add(' select clientes.cod_zon, clientes.cod_cli, ');
    SQL.Add(' clientes.cod_zon || "/" || lpad(clientes.cod_cli, 9, "0") referencia,                           ');
    SQL.Add('        clientes.tit_cli tit_cli, clientes.nif_cli, clientes.let_cli ||"-"|| clientes.con_cli let_cli,  ');
    SQL.Add('        clientes.cnt_cli cnt_cli, clientes.cod_tip cod_tip, clientes.coe_cor coe_cor,                   ');
    SQL.Add('        historico.cod_rec cod_rec, historico.ffa_rec ffa_rec, historico.per_rec,                        ');
    SQL.Add('        clientes.dom_cli cdom_cli, lpad(clientes.cod_pob, 5, "0") ccod_pob,                             ');
    SQL.Add('        tipos_his.cal_tip cal_tip, poblaciones.tit_pob ctit_pob,                                        ');
    SQL.Add('        provincias.tit_pro ctit_pro,                                                                    ');
    SQL.Add('        domicilios.dom_dom ddom_cli, lpad(domicilios.cod_pobd, 5, "0") dcod_pob,                        ');
    SQL.Add('        domicilios.tit_pobd dtit_pob, v2.tit_pro dtit_pro,                                              ');
    SQL.Add('        historico.fan_rec fan_rec, historico.lan_rec lan_rec, historico.fac_rec fac_rec,                ');
    SQL.Add('        historico.lac_rec lac_rec , historico.m3_rec m3_rec, historico.porc_im3 porc_im3,               ');
    SQL.Add('        historico.con_rec con_rec, historico.porc_ico porc_ico, historico.ico_rec ico_rec,              ');
    SQL.Add('        historico.man_rec man_rec, historico.porc_ima porc_ima, historico.ima_rec ima_rec,              ');
    SQL.Add('        historico.cse_rec cse_rec, historico.cta_cco cta_cco, historico.cco_rec cco_rec,                ');
    SQL.Add('        historico.ano_rec ano_rec, historico.per_rec per_rec, historico.pm3_rec pm3_rec,                ');
    if DataBaseName = 'JIJONA' then
      SQL.Add('        historico.im3_rec im3_rec, historico.tot_rec tot_rec, impresion_tmp.clave_lin clave_lin       ')
    else
    begin
      SQL.Add('        historico.im3_rec im3_rec, historico.tot_rec tot_rec, impresion_tmp.clave_lin clave_lin,      ');
      SQL.Add('        NVL(historico.apl_c19, 0) apl_c19                                                             ');
    end;
    SQL.Add(' from impresion_tmp, historico, clientes, outer(tipos_his), poblaciones, provincias,                    ');
    SQL.Add('      outer(domicilios, poblaciones p2, provincias v2)                                                  ');
    SQL.Add(' where tipo_impresion = :tipo_impresion                                                                 ');
    SQL.Add('   and usuario = :usuario                                                                               ');

    SQL.Add('   and historico.cod_rec = impresion_tmp.cod_rec                                                        ');

    SQL.Add('   and clientes.cod_zon = historico.cod_zon                                                             ');
    SQL.Add('   and clientes.cod_cli = historico.cod_cli                                                             ');

    SQL.Add('   and tipos_his.ano_tip = historico.ano_rec                                                            ');
    SQL.Add('   and tipos_his.per_tip = historico.per_rec                                                            ');
    SQL.Add('   and tipos_his.cod_tip = clientes.cod_tip                                                             ');

    SQL.Add('   and poblaciones.cod_pob = clientes.cod_pob                                                           ');

    SQL.Add('   and provincias.cod_pro = poblaciones.cod_pro                                                         ');

    SQL.Add('   and domicilios.cod_zon = clientes.cod_zon                                                            ');
    SQL.Add('   and domicilios.cod_cli = clientes.cod_cli                                                            ');

    SQL.Add('   and p2.cod_pob = domicilios.cod_pobd                                                                 ');

    SQL.Add('   and v2.cod_pro = p2.cod_pro                                                                          ');

    Prepare;

  end;
end;

function TFPrincipal.EjecutaQueryFV: boolean;
begin
  with QueryFV do
  begin
    if Active then
      Close;

    ParamByName('tipo_impresion').AsString := QImpresion.fieldbyname('tipo_impresion').AsString;
    ParamByName('usuario').AsString := gsUsuario;

    Open;

    Result := not IsEmpty;
  end;
end;

procedure TFPrincipal.CreaQueryDB;
begin

  QueryDB := TQuery.Create(Self);
  with QueryDB do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;
    SQL.Add(' select clientes.cod_zon, clientes.cod_cli, ');
    SQL.Add(' impresion_tmp.texto1_db texto1_db, impresion_tmp.texto2_db texto2_db,                      ');
    SQL.Add('        empresa.nombre[1,2] || clientes.cod_zon || lpad(clientes.cod_cli, 9, "0") referencia,      ');
    SQL.Add('        lpad(clientes.cod_pob, 5, "0") cod_pob,                                                    ');
    SQL.Add('        clientes.cod_iban || lpad(clientes.cod_ban, 4, "0") || lpad(clientes.cod_suc, 4, "0") ||   ');
    SQL.Add('        lpad(clientes.dig_con, 2, "0") || lpad(clientes.cta_cli, 10, "0") iban,                    ');
    SQL.Add('        clientes.cod_bic, banco_swift.des_bic des_bic,                                             ');
    SQL.Add('        poblaciones.tit_pob tit_pob, provincias.tit_pro tit_pro, impresion_tmp.clave_lin clave_lin ');
    SQL.Add('   from impresion_tmp, clientes, poblaciones, provincias, empresa, outer(banco_swift)              ');
    SQL.Add(' where impresion_tmp.tipo_impresion = :tipo_impresion                                         ');
    SQL.Add('   and usuario = :usuario                                                                     ');

    SQL.Add('   and clientes.cod_zon = impresion_tmp.cod_zon                                               ');
    SQL.Add('   and clientes.cod_cli = impresion_tmp.cod_cli                                               ');

    SQL.Add('   and poblaciones.cod_pob = clientes.cod_pob                                                 ');

    SQL.Add('   and provincias.cod_pro = poblaciones.cod_pro                                               ');

    SQL.Add('     and banco_swift.cod_ban = clientes.cod_ban                                               ');
    SQL.Add('     and banco_swift.cod_bic = clientes.cod_bic                                               ');

    Prepare;

  end;
end;

function TFPrincipal.EjecutaQueryDB: boolean;
begin
  with QueryDB do
  begin
    if Active then
      Close;

    ParamByName('tipo_impresion').AsString := QImpresion.fieldbyname('tipo_impresion').AsString;
    ParamByName('usuario').AsString := gsUsuario;

    Open;

    Result := not IsEmpty;
  end;
end;

procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  CerrarTablas;
  FreeAndNil(Config);
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
var
  logFile: File;
begin
  Config := TConfig.Create;
  if not FileExists(Config.logFile) then
    begin
    AssignFile(logFile, Config.logFile);
    Rewrite(logFile);
    CloseFile(logFile);
    end;
end;

procedure TFPrincipal.btnImpresionClick(Sender: TObject);
begin
  if gsAlias = 'NO CONECTADO' then
  begin
    showmessage(' ATENCION! No está conectado a ninguna Base de Datos. ');
    exit;
  end;
   
  IniciarSerial;

  if not EjecutaQImpresion then
  begin
    ShowMessage(' ATENCION! No existen datos para imprimir');
    exit;
  end;
  while not QImpresion.Eof do
  begin
    if QImpresion.fieldbyname('tipo_impresion').AsString = 'EC' then      //Extracto Cuenta Bancaria
      ImpresionEC;
    if QImpresion.fieldbyname('tipo_impresion').AsString = 'FL' then      //Ficha de Lectura
      ImpresionFL;
    if QImpresion.fieldbyname('tipo_impresion').AsString = 'PT' then      //Parte de Trabajo
      ImpresionPT;
    if QImpresion.fieldbyname('tipo_impresion').AsString = 'FV' then      //Factura de Venta
      ImpresionFV;
    if QImpresion.fieldbyname('tipo_impresion').AsString = 'DB' then      //Domiciliacion Bancaria
      ImpresionDB;

    QImpresion.Next;
  end;

  BorrarImpresion;

end;

//Impresion Extracto Cuenta
procedure TFPrincipal.ImpresionEC;
begin

  if not EjecutaQueryEC then exit;

  CargaSerial('EC');

  try
       //Crear informe Extracto de Cuenta
    RExtracto := TRExtracto.Create(Application);
    RExtracto.PrinterSettings.PrinterIndex := Printer.PrinterIndex;

    RExtracto.DataSet := QueryEC;
    with RExtracto do
    begin
      QREmpresa.DataSet := QueryEC;
      QRFechaCobro.DataSet := QueryEC;
      QRCodZon.DataSet := QueryEC;
      QRCodCli.DataSet := QueryEC;
      QRTitCli.DataSet := QueryEC;
      QRDomCli.DataSet := QueryEC;
      QRCodRec.DataSet := QueryEC;
      QRtotRec.DataSet := QueryEC;

    end;
//    RExtracto.Preview;
    RExtracto.Print;
  finally
    FreeAndNil(RExtracto);
  end;
end;

//Impresion Ficha de Lectura

procedure TFPrincipal.ImpresionFL;
begin

  if not EjecutaQueryFL then exit;

  CargaSerial('FL');

  try
       //Crear informe Ficha de Lectura
    RFichaLectura := TRFichaLectura.Create(Application);
    RFichaLectura.PrinterSettings.PrinterIndex := Printer.PrinterIndex;

    RFichaLectura.DataSet := QueryFL;
    with RFichaLectura do
    begin
      QRAno1.DataSet := QueryFL;
      QRAno2.DataSet := QueryFL;
      QRAno3.DataSet := QueryFL;
      QRLacCli.DataSet := QueryFL;
      QRFacCli.DataSet := QueryFL;
      QRCodZon.DataSet := QueryFL;
      QRCodCli.DataSet := QueryFL;
      QRCntCli.DataSet := QueryFL;
      QRTitCli.DataSet := QueryFL;
      QRDomCli.DataSet := QueryFL;
      QRTitPob.DataSet := QueryFL;
      QRTitPro.DataSet := QueryFL;
      QRTelCli.DataSet := QueryFL;
      QRFcoCli.DataSet := QueryFL;
      QRCodTip.DataSet := QueryFL;
      QRCalTip.DataSet := QueryFL;

    end;
//    RFichaLectura.Preview;
    RFichaLectura.Print;
  finally
    FreeAndNil(RFichaLectura);
  end;
end;

//Impresion Parte de Trabajo
procedure TFPrincipal.ImpresionPT;
begin

  if not EjecutaQueryPT then exit;

  CargaSerial('PT');

  try
       //Crear informe Parte de Trabajo
    RParteTrabajo := TRParteTrabajo.Create(Application);
    RParteTrabajo.PrinterSettings.PrinterIndex := Printer.PrinterIndex;

    RParteTrabajo.DataSet := QueryPT;
    with RParteTrabajo do
    begin
      qrEmpresa.DataSet := QueryPT;
      qrTitCli.DataSet := QueryPT;
      qrCntCli.DataSet := QueryPT;
      qrCalTip.DataSet := QueryPT;
      qrCodZon.DataSet := QueryPT;
      qrCodCli.DataSet := QueryPT;
      qrTelCli.DataSet := QueryPT;
      qrDomCli.DataSet := QueryPT;
      qrCodPob.DataSet := QueryPT;
      qrTitPob.DataSet := QueryPT;
      qrTitPro.DataSet := QueryPT;
      qrTitPro.DataSet := QueryPT;
      qrTexto1.DataSet := QueryPT;
      qrTexto2.DataSet := QueryPT;
      qrTexto3.DataSet := QueryPT;
      qrTexto4.DataSet := QueryPT;
      qrTexto5.DataSet := QueryPT;
      qrTexto6.DataSet := QueryPT;
    end;
//    RParteTrabajo.Preview;
    RParteTrabajo.Print;
  finally
    FreeAndNil(RParteTrabajo);
  end;
end;

//Impresion Factura de Venta
procedure TFPrincipal.ImpresionFV;
begin

  if not EjecutaQueryFV then exit;

  CargaSerial('FV');

  try
       //Crear Factura Venta
    RFacturaVenta := TRFacturaVenta.Create(Application);
    RFacturaVenta.PrinterSettings.PrinterIndex := Printer.PrinterIndex;

    RFacturaVenta.DataSet := QueryFV;
    with RFacturaVenta do
    begin
      qrTitCli.DataSet := QueryFV;
      qrNifCli.DataSet := QueryFV;
      qrLetCli.DataSet := QueryFV;
      qrCalTip.DataSet := QueryFV;
      qrCntCli.DataSet := QueryFV;
      qrCodRec.DataSet := QueryFV;
      qrFfaRec.DataSet := QueryFV;
      qrCDomCli.DataSet := QueryFV;
      qrCCodPob.DataSet := QueryFV;
      qrCTitPob.DataSet := QueryFV;
      qrCTitPro.DataSet := QueryFV;
      qrTitCli2.DataSet := QueryFV;
      qrM3Rec.DataSet := QueryFV;
      qrFanRec.DataSet := QueryFV;
      qrLanRec.DataSet := QueryFV;
      qrFacRec.DataSet := QueryFV;
      qrLacRec.DataSet := QueryFV;
      qrConRec.DataSet := QueryFV;
      qrManRec.DataSet := QueryFV;
      qrCseRec.DataSet := QueryFV;
      qrCM3Rec.DataSet := QueryFV;
      qrCtaCco.DataSet := QueryFV;
      qrCcoRec.DataSet := QueryFV;
      qrTotRec.DataSet := QueryFV;
      qrReferencia.DataSet := QueryFV;
      qrAplazamiento.DataSet := QueryFV;
    end;
//    RFacturaVenta.Preview;
    RFacturaVenta.Print;
  finally
    FreeAndNil(RFacturaVenta);
  end;
end;

//Impresion Domiciliacion Bancaria
procedure TFPrincipal.ImpresionDB;
begin

  if not EjecutaQueryDB then exit;

  CargaSerial('DB');

  try
       //Crear Domiciliacion Bancaria
    RDomiciliacion := TRDomiciliacion.Create(Application);
    RDomiciliacion.PrinterSettings.PrinterIndex := Printer.PrinterIndex;

    RDomiciliacion.DataSet := QueryDB;
    with RDomiciliacion do
    begin
      qrReferencia.DataSet := QueryDB;
      qrTexto1.DataSet := QueryDB;
      qrTexto2.DataSet := QueryDB;
      qrCodPob.DataSet := QueryDB;
      qrTitPob.DataSet := QueryDB;
      qrIBAN.DataSet := QueryDB;
      qrBIC.DataSet := QueryDB;
      qrDesBIC.DataSet := QueryDB;
    end;
//    RDomiciliacion.Preview;
    RDomiciliacion.Print;
  finally
    FreeAndNil(RDomiciliacion);
  end;

end;

procedure TFPrincipal.IniciarSerial;
var i: integer;
begin
  for i:= 0 to 9999 do
    aSerial[i] := 0;

  indice:= 0;
end;

procedure TFPrincipal.CambiaFuenteInforme(informe: TQuickRep; fuente: string);
var
  componentsIterator: Integer;
begin
    for componentsIterator := 0  to informe.ComponentCount - 1 do
    begin
      if informe.Components[componentsIterator] is TQRCustomLabel then
      begin
       TQRCustomLabel(informe.Components[componentsIterator]).Font.Name := 'Verdana'
      end;
    end;
end;

procedure TFPrincipal.CargaSerial(ATipo: String);
begin

  if ATipo = 'EC' then
  begin
    QueryEC.First;
    while not QueryEC.eof do
    begin
      aSerial[indice] := QueryEC.FieldByName('clave_lin').AsInteger;
      inc(indice);

      QueryEC.Next;
    end;
    QueryEC.First;
  end;

  if ATipo = 'FL' then
  begin
    QueryFL.First;
    while not QueryFL.eof do
    begin
      aSerial[indice] := QueryFL.FieldByName('clave_lin').AsInteger;
      inc(indice);

      QueryFL.Next;
    end;
    QueryFL.First;
  end;

  if ATipo = 'PT' then
  begin
    QueryPT.First;
    while not QueryPT.eof do
    begin
      aSerial[indice] := QueryPT.FieldByName('clave_lin').AsInteger;
      inc(indice);

      QueryPT.Next;
    end;
    QueryPT.First;
  end;

  if ATipo = 'FV' then
  begin
    QueryFV.First;
    while not QueryFV.eof do
    begin
      aSerial[indice] := QueryFV.FieldByName('clave_lin').AsInteger;
      inc(indice);

      QueryFV.Next;
    end;
    QueryFV.First;
  end;

  if ATipo = 'DB' then
  begin
    QueryDB.First;
    while not QueryDB.eof do
    begin
      aSerial[indice] := QueryDB.FieldByName('clave_lin').AsInteger;
      inc(indice);

      QueryDB.Next;
    end;
    QueryDB.First;
  end;

end;

procedure TFPrincipal.CreaQueryBorrar;
begin
  QueryBorrar := TQuery.Create(Self);
  with QueryBorrar do
  begin
    DataBaseName := DM.BDProyecto.DatabaseName;

    SQL.Add(' delete from impresion_tmp ');
    SQL.Add('   where clave_lin = :clave_lin ');

    Prepare;

  end;
end;

procedure TFPrincipal.BorrarImpresion;
begin
  indice := 0;
  while(aSerial[indice] > 0) and (indice < 10000) do
  begin
    BorrarRegistro(aSerial[indice]);

    inc(indice);
  end;
end;

procedure TFPrincipal.BorrarRegistro(AClave: Integer);
begin
  with QueryBorrar do
  begin
    if Active then
      Close;

    ParamByName('clave_lin').AsInteger := AClave;

    ExecSQL;
  end;
end;

procedure TFPrincipal.AccesoBD;
begin
  AbrirBaseDatos;

  lbEmpresa.Caption := gsAlias;
  lbUsuario.Caption := gsUsuario;
  lbImpresora.Caption := Printer.Printers[Printer.PrinterIndex];

  if gsAlias <> 'NO CONECTADO' then
  begin                              
    CreaQEmpresa;
    CreaQTiposHis;
    CreaQImpresion;
    CreaQueryEC;
    CreaQueryFL;
    CreaQueryPT;
    CreaQueryFV;
    CreaQueryDB;
    CreaQueryBorrar;
  end;
end;

procedure TFPrincipal.CerrarTablas;
begin
  if QEmpresa.Active then
  begin
    QEmpresa.Cancel;
    QEmpresa.Close;
  end;
  if QTiposHis.Active then
  begin
    QTiposHis.Cancel;
    QTiposHis.Close;
  end;
  if QImpresion.Active then
  begin
    QImpresion.Cancel;
    QImpresion.Close;
  end;
  if QueryEC.Active then
  begin
    QueryEC.Cancel;
    QueryEC.Close;
  end;
  if QueryFL.Active then
  begin
    QueryFL.Cancel;
    QueryFL.Close;
  end;
  if QueryPT.Active then
  begin
    QueryPT.Cancel;
    QueryPT.Close;
  end;
  if QueryFV.Active then
  begin
    QueryFV.Cancel;
    QueryFV.Close;
  end;
  if QueryDB.Active then
  begin
    QueryDB.Cancel;
    QueryDB.Close;
  end;
end;

procedure TFPrincipal.FormShow(Sender: TObject);
begin
  gsDirActual := ExtractFilePath(ParamStr(0));
  AccesoBD;
end;

procedure TFPrincipal.btnSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TFPrincipal.btnConfigurarClick(Sender: TObject);
begin
  if gsAlias = 'NO CONECTADO' then
  begin
    showmessage(' ATENCION! No está conectado a ninguna Base de Datos. ');
    exit;
  end;

  dlgImpresion.Execute;
  lbImpresora.Caption := Printer.Printers[printer.printerindex];
end;

procedure TFPrincipal.btnCorreoClick(Sender: TObject);
begin
  if gsAlias = 'NO CONECTADO' then
  begin
    showmessage(' ATENCION! No está conectado a ninguna Base de Datos. ');
    exit;
  end;
   
  IniciarSerial;

  if not EjecutaQImpresion then
  begin
    ShowMessage(' ¡ATENCION! No existen datos para enviar');
    exit;
  end;
  while not QImpresion.Eof do
  begin
//    if QImpresion.fieldbyname('tipo_impresion').AsString = 'EC' then      //Extracto Cuenta Bancaria
//      EmailEC;
//    if QImpresion.fieldbyname('tipo_impresion').AsString = 'FL' then      //Ficha de Lectura
//      EmailFL;
//    if QImpresion.fieldbyname('tipo_impresion').AsString = 'PT' then      //Parte de Trabajo
//      EmailPT;
    if QImpresion.fieldbyname('tipo_impresion').AsString = 'FV' then      //Factura de Venta
      EmailFV;
//    if QImpresion.fieldbyname('tipo_impresion').AsString = 'DB' then      //Domiciliacion Bancaria
//      EmailDB;

    QImpresion.Next;
  end;

  ShowMessage('Mensajes envíados');
  BorrarImpresion;

end;

procedure TFPrincipal.btCambioEmpClick(Sender: TObject);
begin
  if gsAlias <> 'NO CONECTADO' then
    CerrarTablas;
  AccesoBD;
end;

end.
