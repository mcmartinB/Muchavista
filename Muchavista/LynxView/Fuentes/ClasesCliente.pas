unit ClasesCliente;

interface

uses
  Classes, DBTables;

type

  TTextTitCli30   = string[30];
  TTextDomCli30   = string[30];
  TTextNifCli12   = string[12];
  TTextTelCli15   = string[15];
  TTextCodBic15   = string[15];
  TTextCodIban4   = string[4];
  TTextCtaCli10   = string[10];
  TTextCntCli12   = string[12];

  TTextTitPobd25  = string[25];
  TTextCpPostal5  = string[5];
  TTextEmail40    = string[40];

  TTextTitPro15   = string[15];

  TTextTitBan30   = string[30];
  TTextDicSuc30   = string[30];

  { TCodigoZonaCodigoCliente }

  TCodigoZonaCodigoCliente = record
    FCod_Zon: SmallInt;
    FCod_Cli: Integer;
    FCod_Cli_Man: Integer; // Código del cliente manual
    FCod_Cli_Aut: Integer; // Código del cliente automático que ha sugerido el ordenador según la zona
  end;

  { TEnumDomicilio }

  TDomicilio = class;

  { TEnumCliente }

  TEnumCliente = class(TObject)
  private
//    FCod_Zon: SmallInt;           // Código zona
//    FCod_Cli: Integer;            // Código cliente
    FCodigoZonaCodigoCliente: TCodigoZonaCodigoCliente;
    FTit_Cli: TTextTitCli30;      // Título / Cliente
    FDom_Cli: TTextDomCli30;      // Domicilio cliente
    FCod_Pob: Integer;            // Código población
    FJoF_Cli: Char;               // Persona (J) Jurídica, (F) Física
    FNif_Cli: TTextNifCli12;      // Nif
    FTel_Cli: TTextTelCli15;      // Telefono del cliente
    FCod_Bic: TTextCodBic15;      // Código BicSwift
    FCod_Iban: TTextCodIban4;     // Código Iban
    FCod_Ban: SmallInt;           // Código banco
    FCod_Suc: SmallInt;           // Código sucursal
    FDig_Con: SmallInt;           // Dígito de control
    FCta_Cli: TTextCtaCli10;      // Cuenta bancaria
    FLet_Cli: Char;               // Letra
    FCon_Cli: Integer;            // Contrato
    FFco_Cli: TDateTime;          // Fecha contrato
    FCod_Tip: SmallInt;           // Código tipo contador
    FCnt_Cli: TTextCntCli12;      // Contador
    FImp_Cli: Double;             // Importe
    FIva_Cli: SmallInt;           // Iva
    FLan_Cli: Integer;            // Lectura anterior
    FFan_Cli: TDateTime;          // Fecha lectura anterior
    FLac_Cli: Integer;            // Lectura actual
    FFac_Cli: TDateTime;          // Fecha lectura actual
    FCod_Sit: Char;               // Código Situación
    FDom_Ind: Char;               // Domicilio / Industrial (D, I, E, R, J)
    FM3_Ano: Char;                // Consumo mayor de 3000 m3
    FSin_Efe: Char;               // Sin efecto
    FCoe_Cor: Double;             // Coeficiente
  private
    procedure SetCod_Zon(const Value: SmallInt); virtual;
    function GetCod_Zon: SmallInt; virtual;

    procedure SetCod_Cli(const Value: Integer); virtual;
    function GetCod_Cli: Integer; virtual;

    function GetCod_Cli_Manu: Integer;
    procedure SetCod_Cli_Manu(const Value: Integer);

    function GetCod_Cli_Auto: Integer;

    function GetLastCodigoCliente(ACod_Zon: SmallInt): Integer;

    function GetCuentaBancaria: String;
  private
    FDomicilio: TDomicilio;
  protected
    FObjDatabase: TDatabase;
    FQryTmp: TQuery;
  public
    constructor Create(const objDatabase: TDatabase = nil);
    destructor Destroy; override;
    function GetExistName(const AWhereFields: array of String; const AWhereValues: array of Variant;
      const ATableName, AIDFieldName: String; const AIDFieldValueOld: Integer): Boolean;
    procedure Delete; // Poner en el Codigo Situación (cod_sit) (A) = Alta, (B) = Baja
  published
    property Cod_Zon: SmallInt read GetCod_Zon write SetCod_Zon;            // Código zona
    property Cod_Cli: Integer read GetCod_Cli write SetCod_Cli;             // Código cliente
    property Tit_Cli: TTextTitCli30 read FTit_Cli write FTit_Cli;           // Título / Cliente
    property Dom_Cli: TTextDomCli30 read FDom_Cli write FDom_Cli;           // Domicilio cliente
    property Cod_Pob: Integer read FCod_Pob write FCod_Pob;                 // Código población
    property JoF_Cli: Char read FJoF_Cli write FJoF_Cli;                    // Persona jurídica o Física
    property Nif_Cli: TTextNifCli12 read FNif_Cli write FNif_Cli;           // Nif
    property Tel_Cli: TTextTelCli15 read FTel_Cli write FTel_Cli;           // Telefono del cliente
    property Cod_Bic: TTextCodBic15 read FCod_Bic write FCod_Bic;           // Código BicSwift
    property Cod_Iban: TTextCodIban4 read FCod_Iban write FCod_Iban;        // Código Iban
    property Cod_Ban: SmallInt read FCod_Ban write FCod_Ban;                // Código banco
    property Cod_Suc: SmallInt read FCod_Suc write FCod_Suc;                // Código sucursal
    property Dig_Con: SmallInt read FDig_Con write FDig_Con;                // Dígito de control
    property Cta_Cli: TTextCtaCli10 read FCta_Cli write FCta_Cli;           // Cuenta bancaria
    property Let_Cli: Char read FLet_Cli write FLet_Cli;                    // Letra
    property Con_Cli: Integer read FCon_Cli write FCon_Cli;                 // Contrato
    property Fco_Cli: TDateTime read FFco_Cli write FFco_Cli;               // Fecha contrato
    property Cod_Tip: SmallInt read FCod_Tip write FCod_Tip;                // Código tipo contador
    property Cnt_Cli: TTextCntCli12 read FCnt_Cli write FCnt_Cli;           // Contrador
    property Imp_Cli: Double read FImp_Cli write FImp_Cli;                  // Importe
    property Iva_Cli: SmallInt read FIva_Cli write FIva_Cli;                // Iva
    property Lan_Cli: Integer read FLan_Cli write FLan_Cli;                 // Lectura anterior
    property Fan_Cli: TDateTime read FFan_Cli write FFan_Cli;               // Fecha lectura anterior
    property Lac_Cli: Integer read FLac_Cli write FLac_Cli;                 // Lectura actual
    property Fac_Cli: TDateTime read FFac_Cli write FFac_Cli;               // Fecha lectura actual
    property Cod_Sit: Char read FCod_Sit write FCod_Sit;                    // Código Situación
    property Dom_Ind: Char read FDom_Ind write FDom_Ind;                    // Domicilio / Industrial (D, I, E, R, J)
    property M3_Ano: Char read FM3_Ano write FM3_Ano;                       // Consumo mayor de 3000 m3
    property Sin_Efe: Char read FSin_Efe write FSin_Efe;                    // Sin efecto
    property Coe_Cor: Double read FCoe_Cor write FCoe_Cor;                  // Coeficiente
  published
    property Cod_Cli_Auto: Integer read GetCod_Cli_Auto;
    property Cod_Cli_Manu: Integer read GetCod_Cli_Manu write SetCod_Cli_Manu;
    property CuentaBancaria: String read GetCuentaBancaria;
    property Domicilio: TDomicilio read FDomicilio write FDomicilio;
    property Database: TDatabase read FObjDatabase;
  end;

  { TCliente }

  TCliente = class(TEnumCliente)
  private
    FEnumItem: TEnumCliente;
    procedure SetCod_Zon(const Value: SmallInt); override;
    function GetCod_Zon: SmallInt; override;

    procedure SetCod_Cli(const Value: Integer); override;
    function GetCod_Cli: Integer; override;
  private
    function GetModified: Boolean;
    function GetModifiedAll: Boolean;
    function GetModifiedBankAccount: Boolean;
    function GetModifiedCounter: Boolean;
  protected
  public
    constructor Create(const objDatabase: TDatabase = nil);
    destructor Destroy; override;
    function Post: Integer;
    procedure ObservacionCambioCuentaBancaria;
    procedure ObservacionCambioContador;
    procedure NuevaObservacion(const observacion: string);
  published
    property Cod_Zon;//: SmallInt read GetCod_Zon write SetCod_Zon;      // Código zona
    property Cod_Cli;//: Integer read GetCod_Cli write SetCod_Cli; // Código cliente
    property Modified: Boolean read GetModified;
    property ModifiedAll: Boolean read GetModifiedAll;
    property ModifiedBankAccount: Boolean read GetModifiedBankAccount;
    property ModifiedContador: Boolean read GetModifiedCounter;
  end;

  { TEnumDomicilio }

  TEnumDomicilio = class(TObject)
  private
    FCod_Zon: SmallInt;
    FCod_Cli: Integer;
    FDom_Dom: TTextDomCli30;
    FCod_Pobd: Integer;
    FTit_Pobd: TTextTitPobd25;
    FTel_Dom: TTextTelCli15;
    FNom_Postal: TTextTitCli30;
    FDom_Postal: TTextDomCli30;
    FCp_Postal: TTextCpPostal5;
    FPob_Postal: TTextTitPobd25;
    FEmail: TTextEmail40;
  private
    procedure SetCod_Zon(const Value: SmallInt); virtual;
//    function GetCod_Zon: SmallInt; virtual;
    procedure SetCod_Cli(const Value: Integer); virtual;
  protected
    FObjEnumCliente: TEnumCliente;
  public
    constructor Create(const objEnumCliente: TEnumCliente);
    destructor Destroy; override;
    procedure Delete;
  published
    property Cod_Zon: SmallInt read FCod_Zon write SetCod_Zon;
    property Cod_Cli: Integer read FCod_Cli write SetCod_Cli;
    property Dom_Dom: TTextDomCli30 read FDom_Dom write FDom_Dom;
    property Cod_Pobd: Integer read FCod_Pobd write FCod_Pobd;
    property Tit_Pobd: TTextTitPobd25 read FTit_Pobd write FTit_Pobd;
    property Tel_Dom: TTextTelCli15 read FTel_Dom write FTel_Dom;
    property Nom_Postal: TTextTitCli30 read FNom_Postal write FNom_Postal;
    property Dom_Postal: TTextDomCli30 read FDom_Postal write FDom_Postal;
    property Cp_Postal: TTextCpPostal5 read FCp_Postal write FCp_Postal;
    property Pob_Postal: TTextTitPobd25 read FPob_Postal write FPob_Postal;
    property Email: TTextEmail40 read FEmail write FEmail;
  end;

  TDomicilio = class(TEnumDomicilio)
  private
    FEnumItem: TEnumDomicilio;
    procedure SetCod_Zon(const Value: SmallInt); override;
    procedure SetCod_Cli(const Value: Integer); override;
  private
    function GetModified: Boolean;
  protected
  public
    constructor Create(const objCliente: TEnumCliente);
    destructor Destroy; override;
    function Post: Integer;
  published
    property Cod_Zon;//: SmallInt read FCod_Zon write SetCod_Zon;
    property Cod_Cli;//: Integer read FCod_Cli write SetCod_Cli;
    property Modified: Boolean read GetModified;
  end;

  { TEnumPoblaciones }

  TEnumPoblaciones = class(TObject)
  private
    FCod_Pob: Integer;
    FTit_Pob: TTextTitPobd25;
    FCod_Pro: Integer;
    procedure SetCod_Pob(const Value: Integer);
  protected
    FobjDatabase: TDatabase;
  public
    constructor Create(const objDatabase: TDatabase);
    destructor Destroy; override;
    function GetPoblacionesToListString: TStringList;
  public
    property Cod_Pob: Integer read FCod_Pob write SetCod_Pob;
    property Tit_Pob: TTextTitPobd25 read FTit_Pob;
    property Cod_Pro: Integer read FCod_Pro;
  end;

  { TEnumProvincias }

  TEnumProvincias = class(TObject)
  private
    FCod_Pro: Integer;
    FTit_Pro: TTextTitPro15;
    procedure SetCod_Pro(const Value: Integer);
  protected
    FobjDatabase: TDatabase;
  public
    constructor Create(const objDatabase: TDatabase);
    destructor Destroy; override;
    function GetProvinciasToListString: TStringList;
  public
    property Cod_Pro: Integer read FCod_Pro write SetCod_Pro;
    property Tit_Pro: TTextTitPro15 read FTit_Pro;
  end;

  { TEnumJuridicoFisico }

  TEnumJuridicoFisico = class(TObject)
  private
  protected
    FobjDatabase: TDatabase;
  public
    constructor Create(const objDatabase: TDatabase);
    destructor Destroy; override;
    function GetJuridicoFisicoToListString: TStringList;
  end;

  { TEnumTiposSuministros }

  TEnumTiposSuministros = class(TObject)
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function GetTiposSuministrosToListString: TStringList;
  end;

  { TEnumTiposContadores }

  TEnumTiposContadores = class(TObject)
  private
    FCod_Tip: Integer;
    procedure SetCod_Tip(const Value: Integer);
  protected
    FobjDatabase: TDatabase;
  public
    constructor Create(const objDatabase: TDatabase);
    destructor Destroy; override;
    function GetTiposContadoresToListString: TStringList;
  public
    property Cod_Tip: Integer read FCod_Tip write SetCod_Tip;
  end;

  { TEnumBancos }

  TEnumBancos = class(TObject)
  private
    FCod_Ban: Integer;
    FTit_Ban: TTextTitBan30;
    FCod_Bic: TTextCodBic15;
    procedure SetCod_Ban(const Value: Integer);
  protected
    FobjDatabase: TDatabase;
  public
    constructor Create(const objDatabase: TDatabase);
    destructor Destroy; override;
    function GetBancosToListString: TStringList;
  public
    property Cod_Ban: Integer read FCod_Ban write SetCod_Ban;
    property Tit_Ban: TTextTitBan30 read FTit_Ban;
    property Cod_Bic: TTextCodBic15 read FCod_Bic;
  end;
  
  { TEnumTiposZonas }

  TEnumTiposZonas = class(TObject)
  private
    FobjDatabase: TDatabase;
  protected
  public
    constructor Create(const objDatabase: TDatabase);
    destructor Destroy; override;
    function GetTiposZonasToListString: TStringList;
  end;

  { TEnumLetra }

  TEnumLetra = class(TObject)
  private
    FobjDatabase: TDatabase;
  protected
  public
    constructor Create(const objDatabase: TDatabase);
    destructor Destroy; override;
    function GetLetrasToListString: TStringList;
  end;

  { TEnumTipoContador }

  TEnumTipoContador = class(TObject)
  private
    FobjDatabase: TDatabase;
  protected
  public
    constructor Create(const objDatabase: TDatabase);
    destructor Destroy; override;
    function GetTiposContadoresToListString: TStringList;
  end;

  { TEnumSituacion }

  TEnumSituacion = class(TObject)
  private
  protected
    FobjDatabase: TDatabase;
  public
    constructor Create(const objDatabase: TDatabase);
    destructor Destroy; override;
    function GetSituacionToListString: TStringList;
  end;
  
implementation

uses
  // Librerias delphi
  SysUtils,

  // Librerias propias
  AplicacionProcedimientosFunciones,
  ClasesOtras
  ;


{ TEnumCliente }

constructor TEnumCliente.Create(const objDatabase: TDatabase);
begin
  inherited Create;

  if (not Assigned(objDatabase)) then
    FObjDatabase := DatabaseDefault
  else
    FObjDatabase := objDatabase;

  FCodigoZonaCodigoCliente.FCod_Zon     := -1;
  FCodigoZonaCodigoCliente.FCod_Cli     := -1;
  FCodigoZonaCodigoCliente.FCod_Cli_Man := -1;
  FCodigoZonaCodigoCliente.FCod_Cli_Aut := -1;

//    FCod_Zon: SmallInt;                  // Código zona
//    FCod_Cli: Integer;                   // Código cliente
  FTit_Cli  := '';    // TTextTitCli30;      // Título / Cliente
  FDom_Cli  := '';    // TTextDomCli30;      // Domicilio cliente
  FCod_Pob  := 0;     // Integer;            // Código población
  FJoF_Cli  := 'F';   // Char;               // Persona Jurídica o Física
  FNif_Cli  := '';    // TTextNifCli12;      // Nif
  FTel_Cli  := '';    // TTextTelCli15;      // Telefono del cliente
  FCod_Bic  := '';    // TTextCodBic15;      // Código BicSwift
  FCod_Iban := '';    // TTextCodIban4;      // Código Iban
  FCod_Ban  := 0;     // SmallInt;           // Código banco
  FCod_Suc  := 0;     // SmallInt;           // Código sucursal
  FDig_Con  := 0;     // SmallInt;           // Dígito de control
  FCta_Cli  := '';    // TTextCtaCli10;      // Cuenta bancaria
  FLet_Cli  := ' ';   // Char;               // Letra
  FCon_Cli  := 0;     // Integer;            // Contrato
  FFco_Cli  := 2;     // TDateTime;          // Fecha contrato
  FCod_Tip  := 0;     // SmallInt;           // Código tipo
  FCnt_Cli  := '';    // TTextCntCli12;      // Contrador
  FImp_Cli  := 0.00;  // Double;             // Importe
  FIva_Cli  := 0;     // SmallInt;           // Iva
  FLan_Cli  := 0;     // Integer;            // Lectura anterior
  FFan_Cli  := 0;     // TDateTime;          // Fecha lectura anterior
  FLac_Cli  := 0;     // Integer;            // Lectura actual
  FFac_Cli  := 2;     // TDateTime;          // Fecha lectura actual
  FCod_Sit  := 'A';   // Char;               // Código Situación
  FDom_Ind  := 'D';   // Char;               // Domicilio / Industrial (D, I, E, R, J)
  FM3_Ano   := 'N';   // Char;               // Consumo mayor de 3000 m3
  FSin_Efe  := 'N';   // Char;               // Sin efecto
  FCoe_Cor  := 0.00;  // Double;             // Coeficiente

  FDomicilio := TDomicilio.Create(Self);
end;

destructor TEnumCliente.Destroy;
begin
  FreeAndNil(FDomicilio);
  inherited;
end;

procedure TEnumCliente.Delete;
const
  BORRAR_CLIENTE_NOSI: Array[Boolean] of String = ('A', 'B');
begin
  with TQuery.Create(nil) do
  begin
    DatabaseName := FObjDatabase.DatabaseName;
    with SQL do
    begin
      Add('UPDATE Clientes');
      Add('  SET');
      Add('    COD_SIT = ' + QuotedStr(BORRAR_CLIENTE_NOSI[(FCod_Sit = 'A')]));
      Add('  WHERE COD_ZON = ' + IntToStr(FCodigoZonaCodigoCliente.FCod_Zon));
      Add('        AND COD_CLI = ' + IntToStr(FCodigoZonaCodigoCliente.FCod_Cli));
    end;
    ExecSQL;

    Free;
  end;
end;

procedure TEnumCliente.SetCod_Zon(const Value: SmallInt);
begin
  with FCodigoZonaCodigoCliente do
    try
      FCod_Zon     := Value;
      FCod_Cli     := -1;
      FCod_Cli_Aut := GetLastCodigoCliente(Value) +1;
      FCod_Cli_Man := FCod_Cli_Aut;
    except
      raise Exception.Create('Error solicitando el número máximo de clientes, Código de zona: ' + IntToStr(FCod_Zon));
    end;

  FDomicilio.Cod_Zon := Value;
end;

function TEnumCliente.GetCod_Zon: SmallInt;
begin
  Result := FCodigoZonaCodigoCliente.FCod_Zon;
end;

function TEnumCliente.GetCuentaBancaria: String;
begin
  Result := FormatFloat('0000', Cod_Ban);
    Result := Result + FormatFloat('0000', Cod_Suc);
    Result := Result + FormatFloat('00', Dig_Con);
    Result := Result + Cta_Cli;
end;

function TEnumCliente.GetExistName(const AWhereFields: array of String; const AWhereValues: array of Variant;
  const ATableName, AIDFieldName: String; const AIDFieldValueOld: Integer): Boolean;
var
  nW: Integer;
begin
  with TQuery.Create(nil) do
  begin
    DatabaseName := FObjDatabase.DatabaseName;
    with SQL do
    begin
      Add('SELECT');
      Add(     AIDFieldName + ' AS FIELDINTEGER');
      Add('  FROM ' + ATableName);
      for nW := 0 to Pred(Length(AWhereFields)) do
        if nW = 0 then
          Add('WHERE ' + AWhereFields[nW] + ' = ' + QuotedStr(AWhereValues[nW]))
        else
          Add('AND ' + AWhereFields[nW] + ' = ' + QuotedStr(AWhereValues[nW]));
    end;

    Open;

    if (AIDFieldValueOld > -1) then
      if (FieldByName('FIELDINTEGER').AsInteger = 0) then
        Result := False
      else
        Result := (AIDFieldValueOld <> FieldByName('FIELDINTEGER').AsInteger)
    else
      Result := (FieldByName('FIELDINTEGER').AsInteger > 0);

    Free;
  end;
end;

procedure TEnumCliente.SetCod_Cli(const Value: Integer);

  function GetFieldStringToFieldChar(const S: String): Char;
  begin
    if (Length(S) = 0) then
      Result := ' '
    else
      Result := S[1];
  end;

begin
  FCodigoZonaCodigoCliente.FCod_Cli := Value;
  with TQuery.Create(nil) do
  begin
    DatabaseName := FObjDatabase.DatabaseName;
    with SQL do
    begin
      Add('SELECT');
      Add('    COD_ZON');
      Add('    ,COD_CLI');
      Add('    ,TIT_CLI');
      Add('    ,DOM_CLI');
      Add('    ,COD_POB');
      Add('    ,JOF_CLI');
      Add('    ,NIF_CLI');
      Add('    ,TEL_CLI');
      Add('    ,COD_BIC');
      Add('    ,COD_IBAN');
      Add('    ,COD_BAN');
      Add('    ,COD_SUC');
      Add('    ,DIG_CON');
      Add('    ,CTA_CLI');
      Add('    ,LET_CLI');
      Add('    ,CON_CLI');
      Add('    ,FCO_CLI');
      Add('    ,COD_TIP');
      Add('    ,CNT_CLI');
      Add('    ,IMP_CLI');
      Add('    ,IVA_CLI');
      Add('    ,LAN_CLI');
      Add('    ,FAN_CLI');
      Add('    ,LAC_CLI');
      Add('    ,FAC_CLI');
      Add('    ,COD_SIT');
      Add('    ,DOM_IND');
      Add('    ,M3_ANO');
      Add('    ,SIN_EFE');
      Add('    ,COE_COR');
      Add('  FROM Clientes');
      Add('  WHERE COD_ZON = ' + IntToStr(GetCod_Zon));
      Add('        AND COD_CLI = ' + IntToStr(GetCod_Cli));
    end;

    try
      try
        Open;

        with FCodigoZonaCodigoCliente do
        begin
          FCod_Zon     := FieldByName('COD_ZON').AsInteger;
          FCod_Cli     := FieldByName('COD_CLI').AsInteger;
          FCod_Cli_Man := FCod_Cli;
          FCod_Cli_Aut := -1;
        end;

        FTit_Cli  := FieldByName('TIT_CLI').AsString;      // TTextTitCli30;      // Título / Cliente
        FDom_Cli  := FieldByName('DOM_CLI').AsString;      // TTextDomCli30;      // Domicilio cliente
        FCod_Pob  := FieldByName('COD_POB').AsInteger;     // Integer;            // Código población
        FJoF_Cli  := GetFieldStringToFieldChar(FieldByName('JOF_CLI').AsString);  // Char;               // Persona Jurídica o Física
        FNif_Cli  := FieldByName('NIF_CLI').AsString;      // TTextNifCli12;      // Nif
        FTel_Cli  := FieldByName('TEL_CLI').AsString;      // TTextTelCli15;      // Telefono del cliente
        FCod_Bic  := FieldByName('COD_BIC').AsString;      // TTextCodBic15;      // Código BicSwift
        FCod_Iban := FieldByName('COD_IBAN').AsString;     // TTextCodIban4;      // Código Iban
        FCod_Ban  := FieldByName('COD_BAN').AsInteger;     // SmallInt;           // Código banco
        FCod_Suc  := FieldByName('COD_SUC').AsInteger;     // SmallInt;           // Código sucursal
        FDig_Con  := FieldByName('DIG_CON').AsInteger;     // SmallInt;           // Dígito de control
        FCta_Cli  := FieldByName('CTA_CLI').AsString;      // TTextCtaCli10;      // Cuenta bancaria
        FLet_Cli  := GetFieldStringToFieldChar(FieldByName('LET_CLI').AsString);   // Char;               // Letra
        FCon_Cli  := FieldByName('CON_CLI').AsInteger;     // Integer;            // Contrato
        FFco_Cli  := FieldByName('FCO_CLI').AsDateTime;    // TDateTime;          // Fecha contrato
        FCod_Tip  := FieldByName('COD_TIP').AsInteger;     // SmallInt;           // Código tipo
        FCnt_Cli  := FieldByName('CNT_CLI').AsString;      // TTextCntCli12;      // Contrador
        FImp_Cli  := FieldByName('IMP_CLI').AsFloat;       // Double;             // Importe
        FIva_Cli  := FieldByName('IVA_CLI').AsInteger;     // SmallInt;           // Iva
        FLan_Cli  := FieldByName('LAN_CLI').AsInteger;     // Integer;            // Lectura anterior
        FFan_Cli  := FieldByName('FAN_CLI').AsDateTime;    // TDateTime;          // Fecha lectura anterior
        FLac_Cli  := FieldByName('LAC_CLI').AsInteger;     // Integer;            // Lectura actual
        FFac_Cli  := FieldByName('FAC_CLI').AsDateTime;    // TDateTime;          // Fecha lectura actual
        FCod_Sit  := GetFieldStringToFieldChar(FieldByName('COD_SIT').AsString);   // Char;               // Código Situación
        FDom_Ind  := GetFieldStringToFieldChar(FieldByName('DOM_IND').AsString);   // Char;               // Domicilio / Industrial (D, I, E, R, J)
        FM3_Ano   := GetFieldStringToFieldChar(FieldByName('M3_ANO').AsString);    // Char;               // Consumo mayor de 3000 m3
        FSin_Efe  := GetFieldStringToFieldChar(FieldByName('SIN_EFE').AsString);   // Char;               // Sin efecto
        FCoe_Cor  := FieldByName('COE_COR').AsFloat;       // Double;             // Coeficiente

        FDomicilio.Cod_Cli := FCodigoZonaCodigoCliente.FCod_Cli;
      except
        with FCodigoZonaCodigoCliente do
        begin
          FCod_Zon     := -1;
          FCod_Cli     := -1;
          FCod_Cli_Man := -1;
          FCod_Cli_Aut := -1;
        end;

        raise Exception.Create('Error solicitando el número máximo de clientes, en el código de zona: ' + IntToStr(Value));
      end;
    finally
      Free;
    end;
  end;
end;

procedure TEnumCliente.SetCod_Cli_Manu(const Value: Integer);
begin
  FCodigoZonaCodigoCliente.FCod_Cli_Man := Value;
end;

function TEnumCliente.GetCod_Cli: Integer;
begin
  Result := FCodigoZonaCodigoCliente.FCod_Cli;
end;

function TEnumCliente.GetCod_Cli_Auto: Integer;
begin
  Result := FCodigoZonaCodigoCliente.FCod_Cli_Aut;
end;

function TEnumCliente.GetCod_Cli_Manu: Integer;
begin
  Result := FCodigoZonaCodigoCliente.FCod_Cli_Man;
end;

function TEnumCliente.GetLastCodigoCliente(ACod_Zon: SmallInt): Integer;
begin
  Result := 0;
  with TQuery.Create(nil) do
  begin
    DatabaseName := FObjDatabase.DatabaseName;
    with SQL do
    begin
      Add('SELECT');
      Add('    MAX(COD_CLI) AS FIELDINTEGER');
      Add('  FROM Clientes');
      Add('  WHERE COD_ZON = ' + IntToStr(ACod_Zon));
    end;
    try
      try
        Open;
        Result := FieldByName('FIELDINTEGER').AsInteger;
      except
        raise Exception.Create('Error solicitando el número máximo de clientes, en código zona: ' + IntToStr(ACod_Zon));
      end;
    finally
      Free;
    end;
  end;
end;

{ TCliente }

constructor TCliente.Create(const objDatabase: TDatabase = nil);
begin
  inherited;
  FEnumItem := TEnumCliente.Create(objDatabase);
end;

destructor TCliente.Destroy;
begin
  FreeAndNil(FEnumItem);
  inherited;
end;

procedure TCliente.SetCod_Zon(const Value: SmallInt);
begin
  inherited;
  FEnumItem.Cod_Zon := Value;
end;

function TCliente.GetCod_Zon: SmallInt;
begin
  Result := FCodigoZonaCodigoCliente.FCod_Zon
end;

procedure TCliente.SetCod_Cli(const Value: Integer);
begin
  inherited;
  FEnumItem.Cod_Cli := Value;
end;

function TCliente.GetCod_Cli: Integer;
begin
  Result := FCodigoZonaCodigoCliente.FCod_Cli
end;

function TCliente.GetModified: Boolean;
begin
  Result :=
    (FCodigoZonaCodigoCliente.FCod_Zon <> FEnumItem.FCodigoZonaCodigoCliente.FCod_Zon) or
    (FCodigoZonaCodigoCliente.FCod_Cli <> FEnumItem.FCodigoZonaCodigoCliente.FCod_Cli) or
    (FCodigoZonaCodigoCliente.FCod_Cli_Man <> FEnumItem.FCodigoZonaCodigoCliente.FCod_Cli_Man) or

    (FTit_Cli <> FEnumItem.FTit_Cli) or
    (FDom_Cli <> FEnumItem.FDom_Cli) or
    (FCod_Pob <> FEnumItem.FCod_Pob) or
    (FJoF_Cli <> FEnumItem.FJoF_Cli) or
    (FNif_Cli <> FEnumItem.FNif_Cli) or
    (FTel_Cli <> FEnumItem.FTel_Cli) or

//    (FDomicilio.FCod_Zon <> FEnumItem.FDomicilio.FCod_Zon) or
//    (FDomicilio.FCod_Cli <> FEnumItem.FDomicilio.FCod_Cli) or
//    (FDomicilio.Dom_Dom <> FEnumItem.FDomicilio.Dom_Dom) or
//    (FDomicilio.FDom_Dom <> FEnumItem.FDomicilio.FDom_Dom) or
//    (FDomicilio.FCod_Pobd <> FEnumItem.FDomicilio.FCod_Pobd) or
//    (FDomicilio.FTit_Pobd <> FEnumItem.FDomicilio.FTit_Pobd) or
//    (FDomicilio.FTel_Dom <> FEnumItem.FDomicilio.FTel_Dom) or
//    (FDomicilio.FNom_Postal <> FEnumItem.FDomicilio.FNom_Postal) or
//    (FDomicilio.FDom_Postal <> FEnumItem.FDomicilio.FDom_Postal) or
//    (FDomicilio.FCp_Postal <> FEnumItem.FDomicilio.FCp_Postal) or
//    (FDomicilio.FPob_Postal <> FEnumItem.FDomicilio.FPob_Postal) or
//    (FDomicilio.FEmail <> FEnumItem.FDomicilio.FEmail) or

    (FLet_Cli <> FEnumItem.FLet_Cli) or
    (FCon_Cli <> FEnumItem.FCon_Cli) or
    (FFco_Cli <> FEnumItem.FFco_Cli) or
    (FCod_Tip <> FEnumItem.FCod_Tip) or
    (FCnt_Cli <> FEnumItem.FCnt_Cli) or
    (FImp_Cli <> FEnumItem.FImp_Cli) or
    (FIva_Cli <> FEnumItem.FIva_Cli) or
    (FLan_Cli <> FEnumItem.FLan_Cli) or
    (FFan_Cli <> FEnumItem.FFan_Cli) or
    (FLac_Cli <> FEnumItem.FLac_Cli) or
    (FFac_Cli <> FEnumItem.FFac_Cli) or
    (FCod_Sit <> FEnumItem.FCod_Sit) or
    (FDom_Ind <> FEnumItem.FDom_Ind) or
    (FM3_Ano <> FEnumItem.FM3_Ano) or
    (FSin_Efe <> FEnumItem.FSin_Efe) or
    (FCoe_Cor <> FEnumItem.FCoe_Cor) or

    (FCod_Bic <> FEnumItem.FCod_Bic) or
    (FCod_Iban <> FEnumItem.FCod_Iban) or
    (FCod_Ban <> FEnumItem.FCod_Ban) or
    (FCod_Suc <> FEnumItem.FCod_Suc) or
    (FDig_Con <> FEnumItem.FDig_Con) or
    (FCta_Cli <> FEnumItem.FCta_Cli);
end;

function TCliente.GetModifiedAll: Boolean;
begin
  Result := GetModified or FDomicilio.GetModified;
end;

function TCliente.GetModifiedBankAccount: Boolean;
begin
    Result :=
    (FCod_Bic <> FEnumItem.FCod_Bic) or
    (FCod_Iban <> FEnumItem.FCod_Iban) or
    (FCod_Ban <> FEnumItem.FCod_Ban) or
    (FCod_Suc <> FEnumItem.FCod_Suc) or
    (FDig_Con <> FEnumItem.FDig_Con) or
    (FCta_Cli <> FEnumItem.FCta_Cli);
end;

function TCliente.GetModifiedCounter: Boolean;
begin
    Result :=
    (FCod_Tip <> FEnumItem.FCod_Tip) or
    (FCnt_Cli <> FEnumItem.FCnt_Cli);
end;

procedure TCliente.NuevaObservacion(const observacion: string);
var
  Query: TQuery;
  Contador: string;
begin
  Query := TQuery.Create(nil);
  try
    Query.DatabaseName := DatabaseDefault.DatabaseName;
    Query.SQL.Add('INSERT INTO observaciones ');
    Query.SQL.Add('(cod_zon, cod_cli, fecha, observacion) ');
    Query.SQL.Add('VALUES(');
    Query.SQL.Add(IntToStr(FCodigoZonaCodigoCliente.FCod_Zon));
    Query.SQL.Add(',' + IntToStr(FCodigoZonaCodigoCliente.FCod_Cli_Man));
    Query.SQL.Add(',' + QuotedDateTimeToStr('dd/mm/yyyy', date));
    Query.SQL.Add(','''+ observacion +'''');
    Query.SQL.Add(')');
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TCliente.ObservacionCambioContador;
var
  Query: TQuery;
  Contador: string;
begin
  Query := TQuery.Create(nil);
  try
    Query.DatabaseName := DatabaseDefault.DatabaseName;
    Query.SQL.Add('INSERT INTO observaciones ');
    Query.SQL.Add('(cod_zon, cod_cli, fecha, observacion) ');
    Query.SQL.Add('VALUES(');
    Query.SQL.Add(IntToStr(FCodigoZonaCodigoCliente.FCod_Zon));
    Query.SQL.Add(',' + IntToStr(FCodigoZonaCodigoCliente.FCod_Cli_Man));
    Query.SQL.Add(',' + QuotedDateTimeToStr('dd/mm/yyyy', date));
    Contador := format('%.4d', [FEnumItem.FCod_Tip]) +' '+
     FEnumItem.FCnt_Cli;
    Query.SQL.Add(',''Cambio contador:'+Contador+'''');
    Query.SQL.Add(')');
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TCliente.ObservacionCambioCuentaBancaria;
var
  Query: TQuery;
  ccc: string;
begin
  Query := TQuery.Create(nil);
  try
    Query.DatabaseName := DatabaseDefault.DatabaseName;
    Query.SQL.Add('INSERT INTO observaciones ');
    Query.SQL.Add('(cod_zon, cod_cli, fecha, observacion) ');
    Query.SQL.Add('VALUES(');
    Query.SQL.Add(IntToStr(FCodigoZonaCodigoCliente.FCod_Zon));
    Query.SQL.Add(',' + IntToStr(FCodigoZonaCodigoCliente.FCod_Cli_Man));
    Query.SQL.Add(',' + QuotedDateTimeToStr('dd/mm/yyyy', date));
    ccc := FCod_Iban+' '+
     format('%.4d', [FCod_Ban]) +' '+
     format('%.4d', [FCod_suc]) +' '+
     format('%.2d', [FDig_Con]) +' '+
     FCta_cli;
    Query.SQL.Add(',''Cambio CCC:'+ccc+'''');
    Query.SQL.Add(')');
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TCliente.Post: Integer;
begin
  case FCodigoZonaCodigoCliente.FCod_Cli of
    -1..0:
      begin
        with TQuery.Create(nil) do
        begin
          DatabaseName := DatabaseDefault.DatabaseName;
          with SQL do
          begin
            Clear;
            Add('INSERT INTO Clientes');
            Add('  (');
            Add('    COD_ZON');
            Add('    ,COD_CLI');
            Add('    ,TIT_CLI');
            Add('    ,DOM_CLI');
            Add('    ,COD_POB');
            Add('    ,JOF_CLI');
            Add('    ,NIF_CLI');
            Add('    ,TEL_CLI');
            Add('    ,COD_BIC');
            Add('    ,COD_IBAN');
            Add('    ,COD_BAN');
            Add('    ,COD_SUC');
            Add('    ,DIG_CON');
            Add('    ,CTA_CLI');
            Add('    ,LET_CLI');
            Add('    ,CON_CLI');
            Add('    ,FCO_CLI');
            Add('    ,COD_TIP');
            Add('    ,CNT_CLI');
            Add('    ,IMP_CLI');
            Add('    ,IVA_CLI');
            Add('    ,LAN_CLI');
            Add('    ,FAN_CLI');
            Add('    ,LAC_CLI');
            Add('    ,FAC_CLI');
            Add('    ,COD_SIT');
            Add('    ,DOM_IND');
            Add('    ,M3_ANO');
            Add('    ,SIN_EFE');
            Add('    ,COE_COR');
            Add('  )');
            Add('  VALUES');
            Add('    (');
            Add(       IntToStr(FCodigoZonaCodigoCliente.FCod_Zon));
            Add('      ,' + IntToStr(FCodigoZonaCodigoCliente.FCod_Cli_Man));
            Add('      ,' + QuotedStr(Tit_Cli));
            Add('      ,' + QuotedStr(Dom_Cli));
            Add('      ,' + IntToStr(Cod_Pob));
            Add('      ,' + QuotedStr(JoF_Cli));
            Add('      ,' + QuotedStr(Nif_Cli));
            Add('      ,' + QuotedStr(Tel_Cli));
            Add('      ,' + QuotedStr(Cod_Bic));
            Add('      ,' + QuotedStr(Cod_Iban));
            Add('      ,' + IntToStr(Cod_Ban));
            Add('      ,' + IntToStr(Cod_Suc));
            Add('      ,' + IntToStr(Dig_Con));
            Add('      ,' + QuotedStr(Cta_Cli));
            Add('      ,' + QuotedStr(Let_Cli));
            Add('      ,' + IntToStr(Con_Cli));
            Add('      ,' + QuotedDateTimeToStr('dd/mm/yyyy', Fco_Cli));
            Add('      ,' + IntToStr(Cod_Tip));
            Add('      ,' + QuotedStr(Cnt_Cli));
            Add('      ,' + StrX(Imp_Cli));
            Add('      ,' + IntToStr(Iva_Cli));
            Add('      ,' + IntToStr(Lan_Cli));
            Add('      ,' + QuotedDateTimeToStr('dd/mm/yyyy', Fan_Cli));
            Add('      ,' + IntToStr(Lac_Cli));
            Add('      ,' + QuotedDateTimeToStr('dd/mm/yyyy', Fac_Cli));
            Add('      ,' + QuotedStr(Cod_Sit));
            Add('      ,' + QuotedStr(Dom_Ind));
            Add('      ,' + QuotedStr(M3_Ano));
            Add('      ,' + QuotedStr(Sin_Efe));
            Add('      ,' + StrX(Coe_Cor));
            Add('    )');
          end;
          ExecSQL;

          FDomicilio.Post;

          Cod_Cli := Cod_Cli_Manu;
          Result := Cod_Cli;

          Free;
        end;
      end;
    else begin
      Result := Cod_Cli;

      FDomicilio.Post;

      if (not Modified) then
        Exit;

      // Si se ha modificado la cuenta bancaria añadimos una observación
      if ModifiedBankAccount then
        ObservacionCambioCuentaBancaria;

      // Sis se ha modificad el contador, añadimos una observación
      if ModifiedContador then
        ObservacionCambioContador;

      with TQuery.Create(nil) do
      begin
        DatabaseName := DatabaseDefault.DatabaseName;
        with SQL do
        begin
          Clear;
          Add('UPDATE Clientes');
          Add('  SET');
          Add('    TIT_CLI   = ' + QuotedStr(FTit_Cli));
          Add('    ,DOM_CLI   = ' + QuotedStr(FDom_Cli));
          Add('    ,COD_POB   = ' + IntToStr(FCod_Pob));
          Add('    ,JOF_CLI   = ' + QuotedStr(FJoF_Cli));
          Add('    ,NIF_CLI   = ' + QuotedStr(FNif_Cli));
          Add('    ,TEL_CLI   = ' + QuotedStr(FTel_Cli));
          Add('    ,COD_BIC   = ' + QuotedStr(FCod_Bic));
          Add('    ,COD_IBAN  = ' + QuotedStr(Cod_Iban));
          Add('    ,COD_BAN   = ' + IntToStr(FCod_Ban));
          Add('    ,COD_SUC   = ' + IntToStr(FCod_Suc));
          Add('    ,DIG_CON   = ' + IntToStr(FDig_Con));
          Add('    ,CTA_CLI   = ' + QuotedStr(FCta_Cli));
          Add('    ,LET_CLI   = ' + QuotedStr(FLet_Cli));
          Add('    ,CON_CLI   = ' + IntToStr(FCon_Cli));
          Add('    ,FCO_CLI   = ' + QuotedDateTimeToStr('dd/mm/yyyy', FFco_Cli));
          Add('    ,COD_TIP   = ' + IntToStr(FCod_Tip));
          Add('    ,CNT_CLI   = ' + QuotedStr(FCnt_Cli));
          Add('    ,IMP_CLI   = ' + StrX(FImp_Cli));
          Add('    ,IVA_CLI   = ' + IntToStr(FIva_Cli));
          Add('    ,LAN_CLI   = ' + IntToStr(FLan_Cli));
          Add('    ,FAN_CLI   = ' + QuotedDateTimeToStr('dd/mm/yyyy', FFan_Cli));
          Add('    ,LAC_CLI   = ' + IntToStr(FLac_Cli));
          Add('    ,FAC_CLI   = ' + QuotedDateTimeToStr('dd/mm/yyyy', FFac_Cli));
          Add('    ,COD_SIT   = ' + QuotedStr(FCod_Sit));
          Add('    ,DOM_IND   = ' + QuotedStr(FDom_Ind));
          Add('    ,M3_ANO    = ' + QuotedStr(FM3_Ano));
          Add('    ,SIN_EFE   = ' + QuotedStr(FSin_Efe));
          Add('    ,COE_COR   = ' + StrX(FCoe_Cor));
          Add('  WHERE COD_ZON = ' + IntToStr(Cod_Zon));
          Add('        AND COD_CLI = ' + IntToStr(Cod_Cli));
        end;
        ExecSQL;

        FEnumItem.Cod_Cli := Result;

        Free;
      end;
    end;
  end;
end;

{ TEnumDomicilio }

constructor TEnumDomicilio.Create(const objEnumCliente: TEnumCliente);
begin
  inherited Create;

  FObjEnumCliente := objEnumCliente;

  FCod_Zon    := 0;  // Integer;
  FCod_Cli    := 0;  // Integer;
  FDom_Dom    := ''; // TTextDomCli30;
  FCod_Pobd   := 0;  // Integer;
  FTit_Pobd   := ''; // TTextTitPobd25;
  FTel_Dom    := ''; // TTextTelCli15;
  FNom_Postal := ''; // TTextTitCli30;
  FDom_Postal := ''; // TTextDomCli30;
  FCp_Postal  := ''; // TTextCpPostal5;
  FPob_Postal := ''; // TTextTitPobd25;
  FEmail      := ''; // TTextEmail40;
end;

destructor TEnumDomicilio.Destroy;
begin
  inherited;
end;

procedure TEnumDomicilio.Delete;
begin
end;

procedure TEnumDomicilio.SetCod_Zon(const Value: SmallInt);
begin
  FCod_Zon := Value;
end;

//function TEnumDomicilio.GetCod_Zon: SmallInt;
//begin
//end;

procedure TEnumDomicilio.SetCod_Cli(const Value: Integer);
begin
  with TQuery.Create(nil) do
  begin
    DatabaseName := FObjEnumCliente.FObjDatabase.DatabaseName;
    with SQL do
    begin
      Clear;

      Add('SELECT');
      Add('    COD_ZON');
      Add('    ,COD_CLI');
      Add('    ,DOM_DOM');
      Add('    ,COD_POBD');
      Add('    ,TIT_POBD');
      Add('    ,TEL_DOM');
      Add('    ,NOM_POSTAL');
      Add('    ,DOM_POSTAL');
      Add('    ,CP_POSTAL');
      Add('    ,POB_POSTAL');
      Add('    ,EMAIL');
      Add('  FROM Domicilios');
      Add('  WHERE COD_ZON = ' + IntToStr(FCod_Zon));
      Add('        AND COD_CLI = ' + IntToStr(Value));
    end;
    try
      try
        Open;
        FCod_Zon    := FieldByName('COD_ZON').AsInteger;
        FCod_Cli    := FieldByName('COD_CLI').AsInteger;
        FDom_Dom    := FieldByName('DOM_DOM').AsString;
        FCod_Pobd   := FieldByName('COD_POBD').AsInteger;
        FTit_Pobd   := FieldByName('TIT_POBD').AsString;
        FTel_Dom    := FieldByName('TEL_DOM').AsString;
        FNom_Postal := FieldByName('NOM_POSTAL').AsString;
        FDom_Postal := FieldByName('DOM_POSTAL').AsString;
        FCp_Postal  := FieldByName('CP_POSTAL').AsString;
        FPob_Postal := FieldByName('POB_POSTAL').AsString;
        FEmail      := FieldByName('EMAIL').AsString;
      except
        raise Exception.Create('Error cargando los datos del domicilio');
      end;
    finally
      Free;
    end;
  end;
end;

{ TDomicilio }

constructor TDomicilio.Create(const objCliente: TEnumCliente);
begin
  inherited;
  FEnumItem := TEnumDomicilio.Create(objCliente);
end;

destructor TDomicilio.Destroy;
begin
  FreeAndNil(FEnumItem);
  inherited;
end;

procedure TDomicilio.SetCod_Cli(const Value: Integer);
begin
  inherited;
  FEnumItem.Cod_Cli := Value;
end;

procedure TDomicilio.SetCod_Zon(const Value: SmallInt);
begin
  inherited;
  FEnumItem.Cod_Zon := Value;
end;

function TDomicilio.GetModified: Boolean;
begin
  Result :=
//    (FCod_Zon <> FEnumItem.FCod_Zon) or
//    (FCod_Cli <> FEnumItem.FCod_Cli) or
    (FDom_Dom <> FEnumItem.FDom_Dom) or
    (FCod_Pobd <> FEnumItem.FCod_Pobd) or
    (FTit_Pobd <> FEnumItem.FTit_Pobd) or
    (FTel_Dom <> FEnumItem.FTel_Dom) or
    (FNom_Postal <> FEnumItem.FNom_Postal) or
    (FDom_Postal <> FEnumItem.FDom_Postal) or
    (FCp_Postal <> FEnumItem.FCp_Postal) or
    (FPob_Postal <> FEnumItem.FPob_Postal) or
    (FEmail <> FEnumItem.FEmail);
end;

function TDomicilio.Post: Integer;
begin
  case FCod_Cli of
    -1..0:
      begin
        with TQuery.Create(nil) do
        begin
          DatabaseName := FObjEnumCliente.FObjDatabase.DatabaseName;
          with SQL do
          begin
            Clear;
            Add('INSERT INTO Domicilios');
            Add('  (');
            Add('    COD_ZON');
            Add('    ,COD_CLI');
            Add('    ,DOM_DOM');
            Add('    ,COD_POBD');
            Add('    ,TIT_POBD');
            Add('    ,TEL_DOM');
            Add('    ,NOM_POSTAL');
            Add('    ,DOM_POSTAL');
            Add('    ,CP_POSTAL');
            Add('    ,POB_POSTAL');
            Add('    ,EMAIL');
            Add('  )');
            Add('  VALUES');
            Add('    (');
            Add(       IntToStr(FObjEnumCliente.Cod_Zon));
            Add('      ,' + IntToStr(FObjEnumCliente.Cod_Cli_Manu));
            Add('      ,' + QuotedStr(FDom_Dom));
            Add('      ,' + IntToStr(FCod_Pobd));
            Add('      ,' + QuotedStr(FTit_Pobd));
            Add('      ,' + QuotedStr(FTel_Dom));
            Add('      ,' + QuotedStr(FNom_Postal));
            Add('      ,' + QuotedStr(FDom_Postal));
            Add('      ,' + QuotedStr(FCp_Postal));
            Add('      ,' + QuotedStr(FPob_Postal));
            Add('      ,' + QuotedStr(FEmail));
            Add('    )');
          end;
          ExecSQL;

          Cod_Cli := FObjEnumCliente.Cod_Cli_Manu;
          Result := Cod_Cli;

          Free;
        end;
      end;
    else begin
      Result := Cod_Cli;

      if (not Modified) then
        Exit;

      with TQuery.Create(nil) do
      begin
        DatabaseName := FObjEnumCliente.FObjDatabase.DatabaseName;
        with SQL do
        begin
          Clear;

          Add('UPDATE Domicilios');
          Add('  SET');
          Add('    DOM_DOM      = ' + QuotedStr(FDom_Dom));
          Add('    ,COD_POBD    = ' + IntToStr(FCod_Pobd));
          Add('    ,TIT_POBD    = ' + QuotedStr(FTit_Pobd));
          Add('    ,TEL_DOM     = ' + QuotedStr(FTel_Dom));
          Add('    ,NOM_POSTAL  = ' + QuotedStr(FNom_Postal));
          Add('    ,DOM_POSTAL  = ' + QuotedStr(FDom_Postal));
          Add('    ,CP_POSTAL   = ' + QuotedStr(FCp_Postal));
          Add('    ,POB_POSTAL  = ' + QuotedStr(FPob_Postal));
          Add('    ,EMAIL       = ' + QuotedStr(FEmail));
          Add('  WHERE COD_ZON = ' + IntToStr(FCod_Zon));
          Add('        AND COD_CLI = ' + IntToStr(FCod_Cli));

        end;
        ExecSQL;

        FEnumItem.Cod_Cli := Result;

        Free;
      end;
    end;
  end;
end;

{ TEnumPoblaciones }

constructor TEnumPoblaciones.Create(const objDatabase: TDatabase);
begin
  inherited Create;
  FobjDatabase := objDatabase;
end;

destructor TEnumPoblaciones.Destroy;
begin
  inherited;
end;

function TEnumPoblaciones.GetPoblacionesToListString: TStringList;
var
  EnumItem: TEnumItem;
begin
  Result := TStringList.Create;
    Result.AddObject('--', TEnumItem.Create(0, '--', 0));

  with TQuery.Create(nil) do
  begin
    DatabaseName := FobjDatabase.DatabaseName;
    with SQL do
    begin
      Clear;

      Add('SELECT');
      Add('    COD_POB');
      Add('    ,TIT_POB');
      Add('    ,COD_PRO');
      Add('  FROM Poblaciones');
      Add('  ORDER BY TIT_POB, COD_POB');
    end;
    Active := True;

    while (not Eof) do
    begin
      EnumItem := TEnumItem.Create
        (
          FieldByName('COD_POB').AsInteger
          ,FieldByName('COD_POB').AsString + ' - ' + FieldByName('TIT_POB').AsString + ' - ' + FieldByName('COD_PRO').AsString
          ,0
        );

      Result.AddObject(EnumItem.TitleField, EnumItem);

      Next;
    end;

    Active := False;
    Free;
  end;
end;

procedure TEnumPoblaciones.SetCod_Pob(const Value: Integer);
begin
  FCod_Pob := Value;
  with TQuery.Create(nil) do
  begin
    DatabaseName := FObjDatabase.DatabaseName;
    with SQL do
    begin
      Add('SELECT');
      Add('    COD_POB');
      Add('    ,TIT_POB');
      Add('    ,COD_PRO');
      Add('  FROM Poblaciones');
      Add('  WHERE COD_POB = ' + IntToStr(FCod_Pob));
    end;

    try
      try
        Open;

        FCod_Pob := FieldByName('COD_POB').AsInteger;
        FTit_Pob := FieldByName('TIT_POB').AsString;
        FCod_Pro := FieldByName('COD_PRO').AsInteger;
      except
        raise Exception.Create('Error solicitando código de población: ' + IntToStr(Value));
      end;
    finally
      Free;
    end;
  end;
end;

{ TEnumProvincias }

constructor TEnumProvincias.Create(const objDatabase: TDatabase);
begin
  inherited Create;
  FobjDatabase := objDatabase;
end;

destructor TEnumProvincias.Destroy;
begin
  inherited;
end;

function TEnumProvincias.GetProvinciasToListString: TStringList;
var
  EnumItem: TEnumItem;
begin
  Result := TStringList.Create;
    Result.AddObject('--', TEnumItem.Create(0, '--', 0));

  with TQuery.Create(nil) do
  begin
    DatabaseName := FobjDatabase.DatabaseName;
    with SQL do
    begin
      Clear;

      Add('SELECT');
      Add('    COD_PRO');
      Add('    ,TIT_PRO');
      Add('  FROM Provincias');
      Add('  ORDER BY TIT_PRO, COD_PRO');
    end;
    Active := True;

    while (not Eof) do
    begin
      EnumItem := TEnumItem.Create
        (
          FieldByName('COD_PRO').AsInteger
          ,FieldByName('COD_PRO').AsString + ' - ' + FieldByName('TIT_PRO').AsString
          ,0
        );

      Result.AddObject(EnumItem.TitleField, EnumItem);

      Next;
    end;

    Active := False;
    Free;
  end;
end;

procedure TEnumProvincias.SetCod_Pro(const Value: Integer);
begin
  FCod_Pro := Value;
  with TQuery.Create(nil) do
  begin
    DatabaseName := FObjDatabase.DatabaseName;
    with SQL do
    begin
      Add('SELECT');
      Add('    COD_PRO');
      Add('    ,TIT_PRO');
      Add('  FROM Provincias');
      Add('  WHERE COD_PRO = ' + IntToStr(FCod_Pro));
    end;

    try
      try
        Open;

        FCod_Pro := FieldByName('COD_PRO').AsInteger;
        FTit_Pro := FieldByName('TIT_PRO').AsString;
      except
        raise Exception.Create('Error solicitando código de provincia: ' + IntToStr(Value));
      end;
    finally
      Free;
    end;
  end;
end;

{ TEnumJuridicoFisico }

constructor TEnumJuridicoFisico.Create(const objDatabase: TDatabase);
begin
  inherited Create;
  FobjDatabase := objDatabase;
end;

destructor TEnumJuridicoFisico.Destroy;
begin
  inherited;
end;

function TEnumJuridicoFisico.GetJuridicoFisicoToListString: TStringList;
var
  EnumItem: TEnumItem;
begin
  Result := TStringList.Create;
    Result.AddObject('Todos', TEnumItem.Create(' ', 'Todos', 0));

  with TQuery.Create(nil) do
  begin
    DatabaseName := FobjDatabase.DatabaseName;
    with SQL do
    begin
      Clear;

      Add('SELECT');
      Add('    JOF_CLI');
      Add('  FROM Clientes');
      Add('  WHERE JOF_CLI <> ' + QuotedStr(''));
      Add('  GROUP BY JOF_CLI');
      Add('  ORDER BY JOF_CLI');
    end;
    Active := True;

    while (not Eof) do
    begin
      EnumItem := TEnumItem.Create
        (
          FieldByName('JOF_CLI').AsString
          ,FieldByName('JOF_CLI').AsString
          ,0
        );

      if (EnumItem.TitleField = 'J') then
        EnumItem.TitleField := '(J) Jurídico';

      if (EnumItem.TitleField = 'F') then
        EnumItem.TitleField := '(F) Físico';

      Result.AddObject(EnumItem.TitleField, EnumItem);

      Next;
    end;

    Active := False;
    Free;
  end;
end;

{ TEnumTiposSuministros }

constructor TEnumTiposSuministros.Create;
begin
  inherited;
end;

destructor TEnumTiposSuministros.Destroy;
begin
  inherited;
end;

function TEnumTiposSuministros.GetTiposSuministrosToListString: TStringList;
begin
  Result := TStringList.Create;
    Result.AddObject('Todos', TEnumItem.Create(' ', 'Todos', 0));
    Result.AddObject('(D) Doméstico', TEnumItem.Create('D', 'Doméstico', 0));
    Result.AddObject('(I) Uso Industrial', TEnumItem.Create('I', 'Uso Industrial', 0));
    Result.AddObject('(E) Exento', TEnumItem.Create('E', 'Exento', 0));
    Result.AddObject('(R) Exento Canon', TEnumItem.Create('R', 'Exento Canon', 0));
    Result.AddObject('(J) Uso Riego', TEnumItem.Create('J', 'Uso Riego', 0));
end;

{ TEnumTiposContadores }

constructor TEnumTiposContadores.Create(const objDatabase: TDatabase);
begin
  FobjDatabase := objDatabase;
end;

destructor TEnumTiposContadores.Destroy;
begin
  inherited;
end;

function TEnumTiposContadores.GetTiposContadoresToListString: TStringList;
var
  EnumItem: TEnumItem;
begin
  Result := TStringList.Create;
    Result.AddObject('Todos', TEnumItem.Create(0, 'Todos', 0));

  with TQuery.Create(nil) do
  begin
    DatabaseName := FobjDatabase.DatabaseName;
    with SQL do
    begin
      Clear;

      Add('SELECT');
      Add('    COD_TIP');
      Add('  FROM Tipos');
      Add('  ORDER BY COD_TIP');
    end;
    Active := True;

    while (not Eof) do
    begin
      EnumItem := TEnumItem.Create
        (
          FieldByName('COD_TIP').AsInteger
          ,'Tipo Contrador:' + FieldByName('COD_TIP').AsString
          ,0
        );

      Result.AddObject(EnumItem.TitleField, EnumItem);

      Next;
    end;

    Active := False;
    Free;
  end;
end;

procedure TEnumTiposContadores.SetCod_Tip(const Value: Integer);
begin
  FCod_Tip := Value;
  with TQuery.Create(nil) do
  begin
    DatabaseName := FObjDatabase.DatabaseName;
    with SQL do
    begin
      Add('SELECT');
      Add('    COD_TIP');
      Add('  FROM Tipos');
      Add('  WHERE COD_TIP = ' + IntToStr(FCod_Tip));
    end;

    try
      try
        Open;

        FCod_Tip := FieldByName('COD_TIP').AsInteger;
      except
        raise Exception.Create('Error solicitando tipo de contador: ' + IntToStr(Value));
      end;
    finally
      Free;
    end;
  end;
end;

{ TEnumBancos }

constructor TEnumBancos.Create(const objDatabase: TDatabase);
begin
  inherited Create;
  FobjDatabase := objDatabase;
end;

destructor TEnumBancos.Destroy;
begin
  inherited;
end;

function TEnumBancos.GetBancosToListString: TStringList;
var
  EnumItem: TEnumItem;
begin
  Result := TStringList.Create;
    Result.AddObject('--', TEnumItem.Create(0, '--', 0));

  with TQuery.Create(nil) do
  begin
    DatabaseName := FobjDatabase.DatabaseName;
    with SQL do
    begin
      Clear;

      Add('SELECT');
      Add('    COD_BAN');
      Add('    ,TIT_BAN');
      Add('  FROM Bancos');
      Add('  ORDER BY TIT_BAN, COD_BAN');
    end;
    Active := True;

    while (not Eof) do
    begin
      EnumItem := TEnumItem.Create
        (
          FieldByName('COD_BAN').AsInteger
          ,FieldByName('COD_BAN').AsString + ' - ' + FieldByName('TIT_BAN').AsString
          ,0
        );

      Result.AddObject(EnumItem.TitleField, EnumItem);

      Next;
    end;

    Active := False;
    Free;
  end;
end;

procedure TEnumBancos.SetCod_Ban(const Value: Integer);
begin
  FCod_Ban := Value;
  with TQuery.Create(nil) do
  begin
    DatabaseName := FObjDatabase.DatabaseName;
    with SQL do
    begin
      Add('SELECT');
      Add('    B.COD_BAN');
      Add('    ,B.TIT_BAN');
      Add('    ,BS.COD_BIC');
      Add('  FROM Bancos AS B');
      Add('    INNER JOIN Banco_swift AS BS');
      Add('      ON B.COD_BAN = BS.COD_BAN');
      Add('  WHERE B.COD_BAN = ' + IntToStr(FCod_Ban));
    end;

    try
      try
        Open;

        FCod_Ban := FieldByName('COD_BAN').AsInteger;
        FTit_Ban := FieldByName('TIT_BAN').AsString;
        FCod_Bic := FieldByName('COD_BIC').AsString;
      except
        raise Exception.Create('Error solicitando código del banco: ' + IntToStr(Value));
      end;
    finally
      Free;
    end;
  end;
end;

{ TEnumTiposZonas }

constructor TEnumTiposZonas.Create(const objDatabase: TDatabase);
begin
  inherited Create;
  FobjDatabase := objDatabase;
end;

destructor TEnumTiposZonas.Destroy;
begin
  inherited;
end;

function TEnumTiposZonas.GetTiposZonasToListString: TStringList;
var
  EnumItem: TEnumItem;
  Query: TQuery;
begin
  Result := TStringList.Create;
  Result.AddObject('5,6,7', TEnumItem.Create(0, '5,6,7', 0));
  Query := TQuery.Create(nil);

  try
    Query.DatabaseName := FobjDatabase.DatabaseName;
    Query.SQL.Clear;
    Query.SQL.Text:= 'SELECT COD_ZON, TIT_ZON FROM Zonas';
    Query.Active := True;

    while (not Query.Eof) do
    begin
      EnumItem := TEnumItem.Create
        (
          Query.FieldByName('COD_ZON').AsInteger
          ,Query.FieldByName('COD_ZON').AsString + ' - ' + Query.FieldByName('TIT_ZON').AsString
          ,0
        );
      Result.AddObject(EnumItem.TitleField, EnumItem);

      Query.Next;
    end;
    Query.Active := False;
   finally
    Query.Free;
   end;

   Result.AddObject('Todas', TEnumItem.Create(100, 'Todas', 0));
end;

{ TEnumLetra }

constructor TEnumLetra.Create(const objDatabase: TDatabase);
begin
  inherited Create;
  FobjDatabase := objDatabase;
end;

destructor TEnumLetra.Destroy;
begin
  inherited;
end;

function TEnumLetra.GetLetrasToListString: TStringList;
var
  EnumItem: TEnumItem;
begin
  Result := TStringList.Create;
    Result.AddObject('--', TEnumItem.Create(' ', '--', 0));

  with TQuery.Create(nil) do
  begin
    DatabaseName := FobjDatabase.DatabaseName;
    with SQL do
    begin
      Clear;

      Add('SELECT');
      Add('    LET_CLI');
      Add('  FROM Clientes');
      Add('  GROUP BY LET_CLI');
      Add('  ORDER BY LET_CLI');
    end;
    Active := True;

    while (not Eof) do
    begin
      EnumItem := TEnumItem.Create
        (
          FieldByName('LET_CLI').AsString
          ,FieldByName('LET_CLI').AsString
          ,0
        );

      Result.AddObject(EnumItem.TitleField, EnumItem);

      Next;
    end;

    Active := False;
    Free;
  end;
end;

{ TEnumTipoContador }

constructor TEnumTipoContador.Create(const objDatabase: TDatabase);
begin
  inherited Create;
  FobjDatabase := objDatabase;
end;

destructor TEnumTipoContador.Destroy;
begin
  inherited;
end;

function TEnumTipoContador.GetTiposContadoresToListString: TStringList;
var
  EnumItem: TEnumItem;
begin
  Result := TStringList.Create;
    Result.AddObject('--', TEnumItem.Create(0, '--', 0));

  with TQuery.Create(nil) do
  begin
    DatabaseName := FobjDatabase.DatabaseName;
    with SQL do
    begin
      Clear;

      Add('SELECT');
      Add('    COD_TIP');
      Add('  FROM Clientes');
      Add('  GROUP BY COD_TIP');
      Add('  ORDER BY COD_TIP');
    end;
    Active := True;

    while (not Eof) do
    begin
      EnumItem := TEnumItem.Create
        (
          FieldByName('COD_TIP').AsInteger
          ,FieldByName('COD_TIP').AsString
          ,0
        );

      Result.AddObject(EnumItem.TitleField, EnumItem);

      Next;
    end;

    Active := False;
    Free;
  end;
end;

{ TEnumSituacion }

constructor TEnumSituacion.Create(const objDatabase: TDatabase);
begin
  inherited Create;
  FobjDatabase := objDatabase;
end;

destructor TEnumSituacion.Destroy;
begin
  inherited;
end;

function TEnumSituacion.GetSituacionToListString: TStringList;
var
  EnumItem: TEnumItem;
begin
  Result := TStringList.Create;
    Result.AddObject('Todos', TEnumItem.Create(' ', 'Todos', 0));

  with TQuery.Create(nil) do
  begin
    DatabaseName := FobjDatabase.DatabaseName;
    with SQL do
    begin
      Clear;

      Add('SELECT');
      Add('    COD_SIT');
      Add('  FROM Clientes');
      Add('  GROUP BY COD_SIT');
      Add('  ORDER BY COD_SIT');
    end;
    Active := True;

    while (not Eof) do
    begin
      EnumItem := TEnumItem.Create
        (
          FieldByName('COD_SIT').AsString
          ,FieldByName('COD_SIT').AsString
          ,0
        );

      if (EnumItem.TitleField = 'A') then
        EnumItem.TitleField := '(A) Alta';

      if (EnumItem.TitleField = 'B') then
        EnumItem.TitleField := '(B) Baja';

      if (EnumItem.TitleField = 'C') then
        EnumItem.TitleField := '(C) Cortado';

      if (EnumItem.TitleField = 'D') then
        EnumItem.TitleField := '(D) Baja Total';

      if (EnumItem.TitleField = 'F') then
        EnumItem.TitleField := '(F) Cortado sin recibo';

      if (EnumItem.TitleField = 'P') then
        EnumItem.TitleField := '(P) Personal';

      Result.AddObject(EnumItem.TitleField, EnumItem);

      Next;
    end;

    Active := False;
    Free;
  end;
end;

end.
