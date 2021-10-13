unit AplicacionProcedimientosFunciones;

interface

uses
  SysUtils, Classes, DateUtils, StdCtrls, Mask, ExtCtrls, CheckLst,
  DB, DBTables, Controls, Dialogs, Forms, Grids, DBGrids, ComCtrls, Graphics, Windows;

  // Devuelve True si todos los caracteres son números
  function CheckIsStrAllNumber(Value: String): Boolean;

  procedure EventColorBackgroundEnter(Sender: TObject);
  procedure EventColorBackgroundExit(Sender: TObject);

  function GetDateToStr(Date: TDateTime): String;
  function GetTimeToStr(Time: TDateTime): String;
  function GetDateTimeToStr(DateTime: TDateTime): String;

  function QuotedDateTimeToStr(ParamDateTime: String; DateTime: TDateTime): String; overload;
  function QuotedDateTimeToStr(ParamDateTime: String; DateTime: String): String; overload;
  function QuotedDateTimeToStr(DateTime: TDateTime): String; overload;
  function QuotedDateTimeToStr(DateTime: String): String; overload;

  function QuotedTimeToStr(ParamDateTime: String; Time: TDateTime): String; overload;
  function QuotedTimeToStr(ParamDateTime: String; Time: String): String; overload;
  function QuotedTimeToStr(Time: TDateTime): String; overload;
  function QuotedTimeToStr(Time: String): String; overload;

  function QuotedBetweenDateTimeToStr(ParamDateTime: String; DateTime, DateTime2: TDateTime): String; overload;
  function QuotedBetweenDateTimeToStr(ParamDateTime, DateTime, DateTime2: String): String; overload;
  function GetDateTimeToDate(ValueDateTime: TDateTime): TDateTime;
  function GetDateTimeToTime(ValueDateTime: TDateTime): TDateTime;

  function GetDay(DDate: TDateTime = 0): ShortInt; overload;
  function GetDay(DDate: String = '01/01/1900'): ShortInt; overload;
  function GetMonth(MDate: TDateTime = 0): ShortInt; overload;
  function GetMonth(MDate: String = '01/01/1900'): ShortInt; overload;
  function GetMonthName(Month: ShortInt): String;
  function GetYear(YDate: TDateTime): Integer; overload;
  function GetYear(YDate: String = '01/01/1900'): Integer; overload;
  function GetDayWeek(Date: TDateTime): ShortInt;
  function GetDecenaMonth(MDate: TDateTime): ShortInt;
  function GetLastDay(S: String): Integer;

  function Hours(HDate: TDateTime): ShortInt;
  function Minutes(MDate: TDateTime): ShortInt;

  function GetDayDiff(Date1: TDateTime = 0; Date2: TDateTime = 0): Integer; overload;
  function GetDayDiff(Date1: String = ''; Date2: String = ''): Integer; overload;
  function GetHourDiff(Hour1: TDateTime = 0; Hour2: TDateTime = 0): TTime; overload;
  function GetHourDiff(Hour1: String = ''; Hour2: String = ''): TTime; overload;

  function CheckingIsDate(Value: String): Boolean;
  function CheckingIsTime(Value: String): Boolean;
  function BetweenHour(HourSource, HourFrom, HourTo: TDateTime): Boolean;

  procedure ShowMessageErrorDate(MsgStr: String);
  procedure ShowMessageErrorTime(MsgStr: String);

  procedure SetResultWnd(Value: Boolean);
  function GetResultWnd: Boolean;

  function GetActionBeforeCloseForm(IsModified, IsActiveOptions: Boolean): TCloseAction;

// -------------------------------------------------------------------------------------------------//
//      PROCEDIMIENTOS Y FUNCIONES PARA VALIDAR UN CIF NACIONAL O EXTRANJERO                        //
{
      A - Sociedades Anónimas
      B - Sociedades de responsabilidad limitada
      C - Sociedades colectivas
      D - Sociedades comanditarias
      E - Comunidades de bienes
      F - Sociedades cooperativas
      G - Asociaciones y otros tipos no definidos
      H - Comunidades de propietarios
      P - Corporaciones locales
      Q - Organismos autónomos
      S - Organos de la administración
      K, L y M - seguramente para compatibilidad con formatos antiguos
      X - Extranjeros, que en lugar del D.N.I. tienen el N.I.E.
}
// -------------------------------------------------------------------------------------------------//

  function GetBicSwiftBank(EntityBank: String): String;
  function GetIbanBank(Pais, Cuenta: String): String;

  function StrX(X: Double; Decimals: Byte = 2): String; overload;
  function StrX(X: String; Decimals: Byte = 2): String; overload;

  function CountChar(SubStr: Char; S: String): Integer;
  function CountDecimals(SubStr: Char; S: String): Integer;

  function NewRegisterIdentification: Integer;

  function DatabaseDefault: TDatabase;

implementation

uses
  BaseDatos, AplicacionConstantes, AplicacionVariables;

function CheckIsStrAllNumber(Value: String): Boolean;
var
  nI: Byte;
begin
  Result := False;

  if (Length(Trim(Value)) = 0) then
    Exit;

  for nI := 1 to Length(Value) do
    if not (Value[nI] in ['0'..'9']) then
      Exit;

  Result := True;
end;

procedure EventColorBackgroundEnter(Sender: TObject);
begin
  if (Sender is TLabeledEdit) then // TLabelEdit
  begin
    (Sender as TLabeledEdit).Color := COLOR_EDIT_BACKGROUND_ENTER;
    Exit;
  end;

  if (Sender is TEdit) then // TEdit
  begin
    (Sender as TEdit).Color := COLOR_EDIT_BACKGROUND_ENTER;
    Exit;
  end;

  if (Sender is TMaskEdit) then // TMaskEdit
  begin
    (Sender as TMaskEdit).Color := COLOR_EDIT_BACKGROUND_ENTER;
    Exit;
  end;

  if (Sender is TComboBox) then // TComboBox
  begin
    (Sender as TComboBox).Color := COLOR_EDIT_BACKGROUND_ENTER;
    Exit;
  end;

  if (Sender is TCheckBox) then // TCheckBox
  begin
    (Sender as TCheckBox).Color := COLOR_EDIT_BACKGROUND_ENTER;
    Exit;
  end;

  if (Sender is TCheckListBox) then // TCheckListBox
  begin
    (Sender as TCheckListBox).Color := COLOR_EDIT_BACKGROUND_ENTER;
    Exit;
  end;

  if (Sender is TListBox) then // TListBox
  begin
    (Sender as TListBox).Color := COLOR_EDIT_BACKGROUND_ENTER;
    Exit;
  end;

  if (Sender is TRadioButton) then // TRadioButton
  begin
    (Sender as TRadioButton).Color := COLOR_EDIT_BACKGROUND_ENTER;
    Exit;
  end;

  if (Sender is TDBGrid) then // TDBGrid
  begin
    (Sender as TDBGrid).Color := COLOR_EDIT_BACKGROUND_ENTER;
    Exit;
  end;

  if (Sender is TMemo) then // TMemo
  begin
    (Sender as TMemo).Color := COLOR_EDIT_BACKGROUND_ENTER;
    Exit;
  end;

  if (Sender is TRichEdit) then // TRichEdit
  begin
    (Sender as TRichEdit).Color := COLOR_EDIT_BACKGROUND_ENTER;
    Exit;
  end;

  if (Sender is TTreeView) then // TTreeView
  begin
    (Sender as TTreeView).Color := COLOR_EDIT_BACKGROUND_ENTER;
    Exit;
  end;
end;

procedure EventColorBackgroundExit(Sender: TObject);
begin
  if (Sender is TLabeledEdit) then
  begin
    (Sender as TLabeledEdit).Color := COLOR_EDIT_BACKGROUND_EXIT;
    Exit;
  end;

  if (Sender is TEdit) then // TEdit
  begin
    (Sender as TEdit).Color := COLOR_EDIT_BACKGROUND_EXIT;
    Exit;
  end;

  if (Sender is TMaskEdit) then // TMaskEdit
  begin
    (Sender as TMaskEdit).Color := COLOR_EDIT_BACKGROUND_EXIT;
    Exit;
  end;

  if (Sender is TComboBox) then // TComboBox
  begin
    (Sender as TComboBox).Color := COLOR_EDIT_BACKGROUND_EXIT;
    Exit;
  end;

  if (Sender is TCheckBox) then // TCheckBox
  begin
    (Sender as TCheckBox).Color := clBtnFace; //--->COLOR_EDIT_BACKGROUND_EXIT;
    Exit;
  end;

  if (Sender is TCheckListBox) then // TCheckListBox
  begin
    (Sender as TCheckListBox).Color := COLOR_EDIT_BACKGROUND_EXIT;
    Exit;
  end;

  if (Sender is TListBox) then // TListBox
  begin
    (Sender as TListBox).Color := COLOR_EDIT_BACKGROUND_EXIT;
    Exit;
  end;

  if (Sender is TRadioButton) then // TRadioButton
  begin
    (Sender as TRadioButton).Color := clBtnFace; //--->COLOR_EDIT_BACKGROUND_EXIT;
    Exit;
  end;

  if (Sender is TDBGrid) then // TDBGrid
  begin
    (Sender as TDBGrid).Color := COLOR_EDIT_BACKGROUND_EXIT;
    Exit;
  end;

  if (Sender is TMemo) then // TMemo
  begin
    (Sender as TMemo).Color := COLOR_EDIT_BACKGROUND_EXIT;
    Exit;
  end;

  if (Sender is TRichEdit) then // TMemo
  begin
    (Sender as TRichEdit).Color := COLOR_EDIT_BACKGROUND_EXIT;
    Exit;
  end;

  if (Sender is TTreeView) then // TTreeView
  begin
    (Sender as TTreeView).Color := COLOR_EDIT_BACKGROUND_EXIT;
    Exit;
  end;
end;

function GetDateToStr(Date: TDateTime): String;
begin
  Result := DateToStr(Date);
  if (Date <= 1900) then
    Result := '';
end;

function GetTimeToStr(Time: TDateTime): String;
begin
  Result := FormatDateTime('hh:nn', Time);
end;

function GetDateTimeToStr(DateTime: TDateTime): String;
begin
  Result := FormatDateTime('dd/mm/yyyy hh:nn', DateTime);
  if (GetYear(DateTime) <= 1900) then
    Result := '';
end;

// Devuelve entre comillas la fecha según parametros enviados
function QuotedDateTimeToStr(ParamDateTime: String; DateTime: TDateTime): String;
begin
  if (GetYear(DateTime) <= 1900) then
    DateTime := 2; // Esto es igual a StrToDateTime('01/01/1900 00:00');
  Result := QuotedStr(FormatDateTime(ParamDateTime, DateTime));
end;

function QuotedDateTimeToStr(ParamDateTime: String; DateTime: String): String;
var
  DT: TDateTime;
begin
  DT := StrToDateTime(DateTime);
  Result := QuotedDateTimeToStr(ParamDateTime, DT);
end;

function QuotedDateTimeToStr(DateTime: TDateTime): String; overload;
begin
  Result := QuotedDateTimeToStr('dd/mm/yyyy hh:nn', DateTime);
end;

function QuotedDateTimeToStr(DateTime: String): String; overload;
begin
  Result := QuotedDateTimeToStr('dd/mm/yyyy hh:nn', DateTime);
end;

function QuotedTimeToStr(ParamDateTime: String; Time: TDateTime): String; overload;
begin
  Result := QuotedStr(FormatDateTime(ParamDateTime, Time));
end;

function QuotedTimeToStr(ParamDateTime: String; Time: String): String; overload;
var
  T: TTime;
begin
  T := StrToTime(Time);
  Result := QuotedTimeToStr(ParamDateTime, T);
end;

function QuotedTimeToStr(Time: TDateTime): String; overload;
begin
  Result := QuotedTimeToStr('hh:nn', Time);
end;

function QuotedTimeToStr(Time: String): String; overload;
begin
  Result := QuotedTimeToStr('hh:nn', Time);
end;

// Devuelve entre comillas las fechas y horas
function QuotedBetweenDateTimeToStr(ParamDateTime: String; DateTime, DateTime2: TDateTime): String;
begin
  Result := QuotedDateTimeToStr(ParamDateTime, DateTime) + ' AND ' +
    QuotedDateTimeToStr(ParamDateTime, DateTime2);
end;

function QuotedBetweenDateTimeToStr(ParamDateTime, DateTime, DateTime2: String): String;
begin
  Result := QuotedDateTimeToStr(ParamDateTime, StrToDateTime(DateTime)) + ' AND ' +
    QuotedDateTimeToStr(ParamDateTime, StrToDateTime(DateTime2));
end;

// Devuelve sólo la fecha
function GetDateTimeToDate(ValueDateTime: TDateTime): TDateTime;
begin
  Result := StrToDate(FormatDateTime('dd/mm/yyyy', ValueDateTime));
end;

// Devuelve sólo la hora
function GetDateTimeToTime(ValueDateTime: TDateTime): TDateTime;
begin
  Result := StrToDate(FormatDateTime('hh:nn', ValueDateTime));
end;

function GetDay(DDate: TDateTime): ShortInt;
begin
  Result := StrToInt(FormatDateTime('dd', DDate));
end;

function GetDay(DDate: String): ShortInt;
begin
  Result := GetDay(StrToDate(DDate));
end;

// Devuelve el Mes de Agosto es el (08)
function GetMonth(MDate: TDateTime): ShortInt;
begin
  Result := StrToInt(FormatDateTime('mm', MDate));
end;

function GetMonth(MDate: String): ShortInt;
begin
  Result := GetMonth(StrToDate(MDate));
end;

function GetMonthName(Month: ShortInt): String;
var
  Months: Array[1..12] of String;
begin
  Months[1]  := 'Enero';
  Months[2]  := 'Febrero';
  Months[3]  := 'Marzo';
  Months[4]  := 'Abril';
  Months[5]  := 'Mayo';
  Months[6]  := 'Junio';
  Months[7]  := 'Julio';
  Months[8]  := 'Agosto';
  Months[9]  := 'Septiembre';
  Months[10] := 'Octubre';
  Months[11] := 'Noviembre';
  Months[12] := 'Diciembre';

  if (Month <= 0) then
    Result := Months[12]
  else if (Month > 12) then
    Result := Months[1]
  else
    Result := Months[Month];
end;

// Devuelve el año, eje. 2008
function GetYear(YDate: TDateTime): Integer;
begin
  Result := StrToInt(FormatDateTime('yyyy', YDate));
end;

function GetYear(YDate: String): Integer;
begin
  Result := GetYear(StrToDateTime(YDate));
end;

// Devuelve el número de la semana (1..7)
function GetDayWeek(Date: TDateTime): ShortInt;
begin
{
  Ingles
  ------
  1 = Domingo
  ..
  ..
  7 = Sábado

  Español
  -------
  1 = Lunes
  ..
  ..
  7 = Domingo
}
  Result := (DayOfWeek(Date) -1);

  if (Result = 0) then
    Result := 7
end;

// Devuelve la Decena del mes, 1..10 = 1, 11..20 = 2, 21..xx = 3
function GetDecenaMonth(MDate: TDateTime): ShortInt;
begin
  if (GetDay(MDate) >= 21) then
    Result := 3
  else
    if (GetDay(MDate) >= 11) then
      Result := 2
    else
      Result := 1;
end;

// Devuelve el último día del mes (mm-yyyy), eje. 06/2015 = 30
function GetLastDay(S: String): Integer;
var
  X: TDateTime;
begin
  if (Length(S) = 7) then
    X := StrToDate('01/' + S)
  else
    X := StrToDate(S);

  Result := DaysInMonth(X);
end;

// Devuelve la hora 12:15 = 12
function Hours(HDate: TDateTime): ShortInt;
begin
  Result := StrToInt(FormatDateTime('hh', HDate));
end;

// Devuelve los minutos 12:15 = 15
function Minutes(MDate: TDateTime): ShortInt;
begin
  Result := StrToInt(FormatDateTime('nn', MDate));
end;

// Devuelve el número de días que hay entre dos fecha
function GetDayDiff(Date1: TDateTime; Date2: TDateTime): Integer;
var
  xDate1, xDate2: TDateTime;
begin
  Result := 0;
  if (GetYear(Date1) > 1900) and (GetYear(Date2) > 1900) then
  begin
    xDate1 := StrToDate(FormatDateTime('dd/mm/yyyy', Date1));
    xDate2 := StrToDate(FormatDateTime('dd/mm/yyyy', Date2));
    Result := Trunc(xDate2 - xDate1) +1;
  end;
end;

// Devuelve la diferencia entre dos horas
function GetHourDiff(Hour1: TDateTime; Hour2: TDateTime): TTime;
begin
  Result := (Hour2 - Hour1);
end;

function GetDayDiff(Date1: String; Date2: String): Integer;
var
  xDate1, xDate2: TDateTime;
begin
  xDate1 := 0;
  if (Date1 <> '') then
    xDate1 := StrToDate(FormatDateTime('dd/mm/yyyy', StrToDate(Date1)));

  xDate2 := 0;
  if (Date2 <> '') then
    xDate2 := StrToDate(FormatDateTime('dd/mm/yyyy', StrToDate(Date2)));

  Result := GetDayDiff(xDate1, xDate2);
end;

function GetHourDiff(Hour1: String; Hour2: String): TTime; overload;
var
  xHour1, xHour2: TTime;
begin
  if (Hour1 = '') then
    xHour1 := 0
  else
    xHour1 := StrToTime(Hour1);

  if (Hour2 = '') then
    xHour2 := 0
  else
    xHour2 := StrToTime(Hour2);

  Result := GetHourDiff(xHour1, xHour2);
end;

procedure SetResultWnd(Value: Boolean);
begin
  if (ResultWnd <> Value) then
    ResultWnd := Value;
end;

function GetResultWnd: Boolean;
begin
  Result := ResultWnd;
end;

function GetActionBeforeCloseForm(IsModified, IsActiveOptions: Boolean): TCloseAction;
var
  MsgText: Array[0..1] of String;
  wResult: Word;
begin
  MsgText[0] := '¡¡¡ A T E N C I O N !!!' + DCR_LF +
                'Los cambios no se han guardado, ¿Guardamos ahora?';

  MsgText[1] := '¡¡¡ A T E N C I O N !!!' + DCR_LF +
                'Formulario no compleatodo, ¿Continuamos?';

  // Por defecto
  Result := caFree;

  // Comprobar si se han modificado algún dato del formulario y la opción del menu grabar esta activa.
  if IsModified then
  begin
    if IsActiveOptions then
      wResult := MessageDlg(MsgText[0], mtWarning, [mbYes, mbNo, mbCancel], 0)
    else
      wResult := MessageDlg(MsgText[1], mtWarning, [mbNo, mbCancel], 0);

    case wResult of
      mrYes:
        Result := caHide;
      mrNo:
        Result := caFree;
      mrCancel:
        Result := caNone;
    end;
  end;
end;

function CheckingIsDate(Value: String): Boolean;
begin
  Result := False;

  case Length(Value) of
    7: // mm/yyyy
      begin
        try
          StrToDate('01/' + Value);
          Result := True;
        except
          Result := False;
        end;
    end;

    10: // dd/mm/yyyy
      begin
        try
          StrToDate(Value);
          Result := True;
        except
          Result := False;
        end;
    end;
  end;
end;

function CheckingIsTime(Value: String): Boolean;
begin
  try
    StrToTime(Value);
    Result := True;
  except
    Result := False;
  end;
end;

function BetweenHour(HourSource, HourFrom, HourTo: TDateTime): Boolean;
begin
  HourSource := StrToTime(FormatDateTime('hh:nn', HourSource));
  HourFrom := StrToTime(FormatDateTime('hh:nn', HourFrom));
  HourTo := StrToTime(FormatDateTime('hh:nn', HourTo));

  Result := (HourSource >= HourFrom) and (HourSource <= HourTo);
end;

procedure ShowMessageErrorDate(MsgStr: String);
var
  MsgText: Array[0..1] of String;
begin
  MsgText[0] := '¡¡¡ E R R O R !!!' + CR_LF +
    '__________________________________________________' + DCR_LF +
    '[%s]' + DCR_LF +
    'Fecha erronea, formato correcto: ( mm/aaaa )' + CR_LF;

  MsgText[1] := '¡¡¡ E R R O R !!!' + CR_LF +
    '__________________________________________________' + DCR_LF +
    '[%s]' + DCR_LF +
    'Fecha erronea, formato correcto: ( dd/mm/aaaa )' + CR_LF;

  case Length(MsgStr) of
    7: MessageDlg(Format(MsgText[0], [MsgStr]), mtError, [mbOK], 0);
   10: MessageDlg(Format(MsgText[1], [MsgStr]), mtError, [mbOK], 0);
  end;
end;

// Muestra mensaje de hora incorrecta
procedure ShowMessageErrorTime(MsgStr: String);
var
  MsgText: String;
begin
  MsgText := '¡¡¡ E R R O R !!!' + CR_LF +
    '__________________________________________________' + DCR_LF +
    '[%s]' + DCR_LF +
    'Hora erronea, formato correcto: ( hh:mm )';

  MessageDlg(Format(MsgText, [MsgStr]), mtError, [mbOK], 0);
end;

// -------------------------------------------------------------------------------------------------//
//      PROCEDIMIENTOS Y FUNCIONES PARA VALIDAR UN CIF NACIONAL O EXTRANJERO                        //
{
A - Sociedades Anónimas
B - Sociedades de responsabilidad limitada
C - Sociedades colectivas
D - Sociedades comanditarias
E - Comunidades de bienes
F - Sociedades cooperativas
G - Asociaciones y otros tipos no definidos
H - Comunidades de propietarios
P - Corporaciones locales
Q - Organismos autónomos
S - Organos de la administración
K, L y M - seguramente para compatibilidad con formatos antiguos
X - Extranjeros, que en lugar del D.N.I. tienen el N.I.E.
}
// -------------------------------------------------------------------------------------------------//

function GetBicSwiftBank(EntityBank: String): String;
var
  aBic: TStringList;
begin
  aBic := TStringList.create;
    aBic.Values['0001'] := 'BSABESBBXXX';
    aBic.Values['0003'] := 'BDEPESM1XXX';
    aBic.Values['0004'] := 'POPUESMMXXX';
    aBic.Values['0008'] := 'BSABESBBXXX';
    aBic.Values['0009'] := 'BBVAESMMXXX';
    aBic.Values['0010'] := 'BBVAESMMXXX';
    aBic.Values['0013'] := 'BSABESBBXXX';
    aBic.Values['0015'] := 'BBVAESMMXXX';
    aBic.Values['0016'] := 'BSCHESMMXXX';
    aBic.Values['0019'] := 'DEUTESBBXXX';
    aBic.Values['0020'] := 'BBVAESMMXXX';
    aBic.Values['0021'] := 'BDEPESM1XXX';
    aBic.Values['0024'] := 'POPUESMMXXX';
    aBic.Values['0029'] := 'CSSOES2SXXX';
    aBic.Values['0030'] := 'ESPCESMMXXX';
    aBic.Values['0031'] := 'ETCHES2GXXX';
    aBic.Values['0035'] := 'BBVAESMMXXX';
    aBic.Values['0036'] := 'SABNESMMXXX';
    aBic.Values['0041'] := 'CAIXESBBXXX';
    aBic.Values['0042'] := 'BSABESBBXXX';
    aBic.Values['0043'] := 'BSABESBBXXX';
    aBic.Values['0044'] := 'BBVAESMMXXX';
    aBic.Values['0045'] := 'BBVAESMMXXX';
    aBic.Values['0046'] := 'BSABESBBXXX';
    aBic.Values['0049'] := 'BSCHESMMXXX';
    aBic.Values['0050'] := 'BBVAESMMXXX';
    aBic.Values['0053'] := 'BSCHESMMXXX';
    aBic.Values['0056'] := 'CAHMESMMXXX';
    aBic.Values['0057'] := 'BVADESMMXXX';
    aBic.Values['0058'] := 'BNPAESMMXXX';
    aBic.Values['0059'] := 'MADRESMMXXX';
    aBic.Values['0061'] := 'BMARES2MXXX';
    aBic.Values['0062'] := 'BBVAESMMXXX';
    aBic.Values['0063'] := 'CAHMESMMXXX';
    aBic.Values['0065'] := 'BARCESMMXXX';
    aBic.Values['0067'] := 'BSCHESMMXXX';
    aBic.Values['0068'] := 'BBVAESMMXXX';
    aBic.Values['0069'] := 'CAIXESBBXXX';
    aBic.Values['0072'] := 'POPUESMMXXX';
    aBic.Values['0073'] := 'OPENESMMXXX';
    aBic.Values['0075'] := 'POPUESMMXXX';
    aBic.Values['0076'] := 'BSABESBBXXX';
    aBic.Values['0077'] := 'UNOEESM1XXX';
    aBic.Values['0078'] := 'BAPUES22XXX';
    aBic.Values['0081'] := 'BSABESBBXXX';
    aBic.Values['0082'] := 'POPUESMMXXX';
    aBic.Values['0085'] := 'BSCHESMMXXX';
    aBic.Values['0086'] := 'NORTESMMXXX';
    aBic.Values['0087'] := 'CAHMESMMXXX';
    aBic.Values['0093'] := 'CAIXESBBXXX';
    aBic.Values['0094'] := 'BVALESMMXXX';
    aBic.Values['0095'] := 'POPUESMMXXX';
    aBic.Values['0097'] := 'POPUESMMXXX';
    aBic.Values['0099'] := 'CAHMESMMXXX';
    aBic.Values['0100'] := 'ESPCESMMXXX';
    aBic.Values['0200'] := 'PRVBESB1XXX';
    aBic.Values['2000'] := 'CECAESMMXXX';
    aBic.Values['2100'] := 'CAIXESBBXXX';
    aBic.Values['0101'] := 'CAIXESBBXXX';
    aBic.Values['0102'] := 'BBVAESMMXXX';
    aBic.Values['0103'] := 'BARCESMMXXX';
    aBic.Values['0104'] := 'BBVAESMMXXX';
    aBic.Values['0106'] := 'BSABESBBXXX';
    aBic.Values['0107'] := 'BNPAESMSXXX';
    aBic.Values['0108'] := 'SOGEESMMXXX';
    aBic.Values['0109'] := 'ESPCESMMXXX';
    aBic.Values['0112'] := 'BSABESBBXXX';
    aBic.Values['0114'] := 'CAIXESBBXXX';
    aBic.Values['0118'] := 'BSABESBBXXX';
    aBic.Values['0119'] := 'BSABESBBXXX';
    aBic.Values['0122'] := 'CITIES2XXXX';
    aBic.Values['0124'] := 'CESCESBBXXX';
    aBic.Values['0125'] := 'BAOFESM1XXX';
    aBic.Values['0127'] := 'BBVAESMMXXX';
    aBic.Values['0128'] := 'BKBKESMMXXX';
    aBic.Values['0130'] := 'CGDIESMMXXX';
    aBic.Values['0131'] := 'BESMESMMXXX';
    aBic.Values['0133'] := 'MIKBESB1XXX';
    aBic.Values['0136'] := 'AREBESMMXXX';
    aBic.Values['0137'] := 'BBVAESMMXXX';
    aBic.Values['0138'] := 'BKOAES22XXX';
    aBic.Values['0142'] := 'CAIXESBBXXX';
    aBic.Values['0149'] := 'BNPAESMSXXX';
    aBic.Values['0151'] := 'CHASESM3XXX';
    aBic.Values['0154'] := 'BSUIESMMXXX';
    aBic.Values['0155'] := 'BRASESMMXXX';
    aBic.Values['0156'] := 'ABNAESMMXXX';
    aBic.Values['0159'] := 'COBAESMXXXX';
    aBic.Values['0160'] := 'BOTKESMXXXX';
    aBic.Values['0162'] := 'MIDLESMMXXX';
    aBic.Values['0167'] := 'GEBAESMMXXX';
    aBic.Values['0168'] := 'BBRUESMXXXX';
    aBic.Values['0169'] := 'NACNESMMXXX';
    aBic.Values['0182'] := 'BBVAESMMXXX';
    aBic.Values['0184'] := 'BEDFESM1XXX';
    aBic.Values['0185'] := 'BSABESBBXXX';
    aBic.Values['0186'] := 'BFIVESBBXXX';
    aBic.Values['0188'] := 'ALCLESMMXXX';
    aBic.Values['0190'] := 'BBPIESMMXXX';
    aBic.Values['0196'] := 'WELAESMMXXX';
    aBic.Values['0198'] := 'BCOEESMMXXX';
    aBic.Values['0202'] := 'BBVAESMMXXX';
    aBic.Values['0205'] := 'DEUTESBBXXX';
    aBic.Values['0208'] := 'CSSOES2SXXX';
    aBic.Values['0209'] := 'BSABESBBXXX';
    aBic.Values['0210'] := 'BSABESBBXXX';
    aBic.Values['0216'] := 'POHIESMMXXX';
    aBic.Values['0217'] := 'BSABESBBXXX';
    aBic.Values['0219'] := 'BMCEESMMXXX';
    aBic.Values['0220'] := 'FIOFESM1XXX';
    aBic.Values['0224'] := 'SCFBESMMXXX';
    aBic.Values['0226'] := 'UBSWESMMXXX';
    aBic.Values['0227'] := 'UNOEESM1XXX';
    aBic.Values['0229'] := 'POPLESMMXXX';
    aBic.Values['0230'] := 'BSABESBBXXX';
    aBic.Values['0232'] := 'INVLESMMXXX';
    aBic.Values['0233'] := 'POPIESMMXXX';
    aBic.Values['0233'] := 'POPIESMMXXX';
    aBic.Values['0234'] := 'CCOCESMMXXX';
    aBic.Values['0235'] := 'PICHESMMXXX';
    aBic.Values['0236'] := 'BSABESBBXXX';
    aBic.Values['0237'] := 'CSURES2CXXX';
    aBic.Values['0238'] := 'PSTRESMMXXX';
    aBic.Values['0239'] := 'EVOBESMMXXX';
    aBic.Values['0240'] := 'CCRIES2AXXX';
    aBic.Values['0486'] := 'CECAESMM086';
    aBic.Values['0487'] := 'GBMNESMMXXX';
    aBic.Values['0490'] := 'CAIXESBBXXX';
    aBic.Values['1001'] := 'BBVAESMMXXX';
    aBic.Values['1004'] := 'BBVAESMMXXX';
    aBic.Values['1005'] := 'BBVAESMMXXX';
    aBic.Values['1301'] := 'BBVAESMMXXX';
    aBic.Values['1302'] := 'BBVAESMMXXX';
    aBic.Values['1451'] := 'AGRIESB1XXX';
    aBic.Values['1460'] := 'CRESESMMXXX';
    aBic.Values['1465'] := 'INGDESMMXXX';
    aBic.Values['1469'] := 'BBVAESMMXXX';
    aBic.Values['1474'] := 'CITIESMXXXX';
    aBic.Values['1480'] := 'VOWAES21XXX';
    aBic.Values['1484'] := 'ESPCESMMXXX';
    aBic.Values['1485'] := 'BOFAES2XXXX';
    aBic.Values['1490'] := 'SELFESMMXXX';
    aBic.Values['1491'] := 'TRIOESMMXXX';
    aBic.Values['1494'] := 'BCITESMMXXX';
    aBic.Values['1513'] := 'CGDIESMMXXX';
    aBic.Values['1524'] := 'UBIBESMMXXX';
    aBic.Values['1525'] := 'BCDMESMMXXX';
    aBic.Values['1534'] := 'KBLXESMMXXX';
    aBic.Values['1544'] := 'BACAESMMXXX';
    aBic.Values['1545'] := 'AGRIESMMXXX';
    aBic.Values['2001'] := 'CECAESMM105';
    aBic.Values['2005'] := 'BSABESBBXXX';
    aBic.Values['2006'] := 'UCJAES2MXXX';
    aBic.Values['2007'] := 'UCJAES2MXXX';
    aBic.Values['2010'] := 'CECAESMM086';
    aBic.Values['2011'] := 'CAIXESBBXXX';
    aBic.Values['2012'] := 'CAIXESBBXXX';
    aBic.Values['2013'] := 'CESCESBBXXX';
    aBic.Values['2015'] := 'BASKES2BXXX';
    aBic.Values['2016'] := 'BASKES2BXXX';
    aBic.Values['2017'] := 'CECAESMM086';
    aBic.Values['2018'] := 'CAIXESBBXXX';
    aBic.Values['2019'] := 'CECAESMM099';
    aBic.Values['2020'] := 'UCJAES2MXXX';
    aBic.Values['2021'] := 'CAHMESMMXXX';
    aBic.Values['2022'] := 'CAHMESMMXXX';
    aBic.Values['2024'] := 'CSURES2CXXX';
    aBic.Values['2025'] := 'CSURES2CXXX';
    aBic.Values['2028'] := 'CECAESMM105';
    aBic.Values['2030'] := 'CAIXESBBXXX';
    aBic.Values['2031'] := 'CECAESMM031';
    aBic.Values['2032'] := 'CAIXESBBXXX';
    aBic.Values['2033'] := 'CAIXESBBXXX';
    aBic.Values['2034'] := 'CAIXESBBXXX';
    aBic.Values['2035'] := 'CSPAES2LXXX';
    aBic.Values['2037'] := 'CAHMESMMXXX';
    aBic.Values['2038'] := 'CAHMESMMXXX';
    aBic.Values['2039'] := 'UCJAES2MXXX';
    aBic.Values['2040'] := 'BBVAESMMXXX';
    aBic.Values['2041'] := 'CESCESBBXXX';
    aBic.Values['2042'] := 'CAHMESMMXXX';
    aBic.Values['2043'] := 'CECAESMM043';
    aBic.Values['2045'] := 'CECAESMM045';
    aBic.Values['2046'] := 'CAGLESMMXXX';
    aBic.Values['2048'] := 'CECAESMM048';
    aBic.Values['2049'] := 'CSPAES2LXXX';
    aBic.Values['2051'] := 'CECAESMM051';
    aBic.Values['2052'] := 'CAHMESMMXXX';
    aBic.Values['2053'] := 'CAIXESBBXXX';
    aBic.Values['2054'] := 'CAIXESBBXXX';
    aBic.Values['2055'] := 'CECAESMM099';
    aBic.Values['2056'] := 'CECAESMM056';
    aBic.Values['2057'] := 'CAGLESMMXXX';
    aBic.Values['2058'] := 'UCJAES2MXXX';
    aBic.Values['2059'] := 'BBVAESMMXXX';
    aBic.Values['2060'] := 'CAHMESMMXXX';
    aBic.Values['2061'] := 'CSSOES2SXXX';
    aBic.Values['2062'] := 'BASKES2BXXX';
    aBic.Values['2063'] := 'BASKES2BXXX';
    aBic.Values['2065'] := 'CAIXESBBXXX';
    aBic.Values['2066'] := 'CECAESMM066';
    aBic.Values['2068'] := 'CAHMESMMXXX';
    aBic.Values['2069'] := 'CAHMESMMXXX';
    aBic.Values['2070'] := 'CAIXESBBXXX';
    aBic.Values['2071'] := 'CAIXESBBXXX';
    aBic.Values['2072'] := 'CSSOES2SXXX';
    aBic.Values['2073'] := 'CESCESBBXXX';
    aBic.Values['2074'] := 'BBVAESMMXXX';
    aBic.Values['2075'] := 'CECAESMM105';
    aBic.Values['2076'] := 'BSABESBBXXX';
    aBic.Values['2077'] := 'CAHMESMMXXX';
    aBic.Values['2078'] := 'CSPAES2LXXX';
    aBic.Values['2079'] := 'CSPAES2LXXX';
    aBic.Values['2080'] := 'CAGLESMMXXX';
    aBic.Values['2081'] := 'BSABESBBXXX';
    aBic.Values['2082'] := 'BASKES2BXXX';
    aBic.Values['2083'] := 'BASKES2BXXX';
    aBic.Values['2084'] := 'CSPAES2LXXX';
    aBic.Values['2085'] := 'CAZRES2ZXXX';
    aBic.Values['2086'] := 'CECAESMM086';
    aBic.Values['2088'] := 'BBVAESMMXXX';
    aBic.Values['2089'] := 'CECAESMM031';
    aBic.Values['2090'] := 'BSABESBBXXX';
    aBic.Values['2091'] := 'CAGLESMMXXX';
    aBic.Values['2092'] := 'UCJAES2MXXX';
    aBic.Values['2093'] := 'BSABESBBXXX';
    aBic.Values['2094'] := 'CAHMESMMXXX';
    aBic.Values['2095'] := 'BASKES2BXXX';
    aBic.Values['2096'] := 'CSPAES2LXXX';
    aBic.Values['2097'] := 'BASKES2BXXX';
    aBic.Values['2098'] := 'CAIXESBBXXX';
    aBic.Values['2099'] := 'CECAESMM099';
    aBic.Values['2101'] := 'BASKES2BXXX';
    aBic.Values['2102'] := 'BSABESBBXXX';
    aBic.Values['2103'] := 'UCJAES2MXXX';
    aBic.Values['2104'] := 'CSSOES2SXXX';
    aBic.Values['2105'] := 'CECAESMM105';
    aBic.Values['2106'] := 'CAIXESBBXXX';
    aBic.Values['2107'] := 'BBVAESMMXXX';
    aBic.Values['3001'] := 'BCOEESMM001';
    aBic.Values['3005'] := 'BCOEESMM005';
    aBic.Values['3007'] := 'BCOEESMM007';
    aBic.Values['3008'] := 'BCOEESMM008';
    aBic.Values['3009'] := 'BCOEESMM009';
    aBic.Values['3016'] := 'BCOEESMM016';
    aBic.Values['3017'] := 'BCOEESMM017';
    aBic.Values['3018'] := 'BCOEESMM018';
    aBic.Values['3020'] := 'BCOEESMM020';
    aBic.Values['3021'] := 'BCOEESMM191';
    aBic.Values['3022'] := 'BCOEESMM060';
    aBic.Values['3023'] := 'BCOEESMM023';
    aBic.Values['3024'] := 'BAOFESM1XXX';
    aBic.Values['3025'] := 'CDENESBBXXX';
    aBic.Values['3029'] := 'CCRIES2A029';
    aBic.Values['3035'] := 'CLPEES2MXXX';
    aBic.Values['3045'] := 'CCRIES2A045';
    aBic.Values['3054'] := 'CCRIES2AXXX';
    aBic.Values['3056'] := 'BCOEESMM190';
    aBic.Values['3057'] := 'CCRIES2AXXX';
    aBic.Values['3058'] := 'CCRIES2AXXX';
    aBic.Values['3059'] := 'BCOEESMM059';
    aBic.Values['3060'] := 'BCOEESMM060';
    aBic.Values['3061'] := 'CCRIES2AXXX';
    aBic.Values['3062'] := 'BCOEESMM190';
    aBic.Values['3063'] := 'BCOEESMM063';
    aBic.Values['3064'] := 'BCOEESMM190';
    aBic.Values['3065'] := 'BCOEESMM187';
    aBic.Values['3066'] := 'BCOEESMM191';
    aBic.Values['3067'] := 'BCOEESMM067';
    aBic.Values['3068'] := 'CAGLESMMXXX';
    aBic.Values['3069'] := 'CAZRES2ZXXX';
    aBic.Values['3070'] := 'BCOEESMM070';
    aBic.Values['3072'] := 'CCRIES2AXXX';
    aBic.Values['3076'] := 'BCOEESMM076';
    aBic.Values['3078'] := 'BCOEESMM060';
    aBic.Values['3079'] := 'BCOEESMM187';
    aBic.Values['3080'] := 'BCOEESMM080';
    aBic.Values['3081'] := 'BCOEESMM081';
    aBic.Values['3082'] := 'CCRIES2AXXX';
    aBic.Values['3083'] := 'CCRIES2AXXX';
    aBic.Values['3084'] := 'CVRVES2BXXX';
    aBic.Values['3085'] := 'BCOEESMM085';
    aBic.Values['3089'] := 'BCOEESMM089';
    aBic.Values['3092'] := 'BCOEESMM191';
    aBic.Values['3093'] := 'BCOEESMM191';
    aBic.Values['3094'] := 'CCRIES2AXXX';
    aBic.Values['3095'] := 'CCRIES2A095';
    aBic.Values['3096'] := 'BCOEESMM096';
    aBic.Values['3098'] := 'BCOEESMM098';
    aBic.Values['3102'] := 'CCRIES2A102';
    aBic.Values['3104'] := 'BCOEESMM104';
    aBic.Values['3105'] := 'CCRIES2A105';
    aBic.Values['3108'] := 'CCRIES2AXXX';
    aBic.Values['3110'] := 'CCRIES2A110';
    aBic.Values['3111'] := 'BCOEESMM111';
    aBic.Values['3112'] := 'CCRIES2A112';
    aBic.Values['3113'] := 'BCOEESMM113';
    aBic.Values['3114'] := 'CCRIES2AXXX';
    aBic.Values['3115'] := 'BCOEESMM115';
    aBic.Values['3116'] := 'BCOEESMM116';
    aBic.Values['3117'] := 'BCOEESMM117';
    aBic.Values['3118'] := 'CCRIES2A118';
    aBic.Values['3119'] := 'CCRIES2A119';
    aBic.Values['3121'] := 'CCRIES2A121';
    aBic.Values['3123'] := 'CCRIES2A123';
    aBic.Values['3127'] := 'BCOEESMM127';
    aBic.Values['3128'] := 'BCOEESMM190';
    aBic.Values['3129'] := 'BCOEESMM191';
    aBic.Values['3130'] := 'BCOEESMM130';
    aBic.Values['3131'] := 'CCRIES2AXXX';
    aBic.Values['3134'] := 'BCOEESMM134';
    aBic.Values['3135'] := 'CCRIES2A135';
    aBic.Values['3137'] := 'CCRIES2AXXX';
    aBic.Values['3138'] := 'BCOEESMM138';
    aBic.Values['3140'] := 'BCOEESMM140';
    aBic.Values['3141'] := 'CESCESBBXXX';
    aBic.Values['3144'] := 'BCOEESMM144';
    aBic.Values['3146'] := 'CCCVESM1XXX';
    aBic.Values['3147'] := 'CCRIES2AXXX';
    aBic.Values['3150'] := 'BCOEESMM150';
    aBic.Values['3152'] := 'CCRIES2A152';
    aBic.Values['3157'] := 'CCRIES2A157';
    aBic.Values['3159'] := 'BCOEESMM159';
    aBic.Values['3160'] := 'CCRIES2A160';
    aBic.Values['3161'] := 'BCOEESMM060';
    aBic.Values['3162'] := 'BCOEESMM162';
    aBic.Values['3163'] := 'CCRIES2AXXX';
    aBic.Values['3165'] := 'CCRIES2A165';
    aBic.Values['3166'] := 'BCOEESMM166';
    aBic.Values['3167'] := 'CCRIES2AXXX';
    aBic.Values['3171'] := 'BCOEESMM191';
    aBic.Values['3172'] := 'CCOCESMMXXX';
    aBic.Values['3174'] := 'BCOEESMM174';
    aBic.Values['3177'] := 'CCRIES2AXXX';
    aBic.Values['3179'] := 'CCRIES2A179';
    aBic.Values['3181'] := 'CCRIES2AXXX';
    aBic.Values['3183'] := 'CASDESBBXXX';
    aBic.Values['3186'] := 'CCRIES2A186';
    aBic.Values['3187'] := 'BCOEESMM187';
    aBic.Values['3188'] := 'CCRIES2AXXX';
    aBic.Values['3189'] := 'BCOEESMM191';
    aBic.Values['3190'] := 'BCOEESMM190';
    aBic.Values['3191'] := 'BCOEESMM191';

  Result := aBic.Values[EntityBank];
end;

function GetIbanBank(Pais, Cuenta: String): String;

  function EsAlfanumerico(Caracter: Char): Boolean;
  begin
    Result := (Caracter in ['A'..'Z', 'a'..'z']);
  end;

  function EsNumerico(Caracter: Char): Boolean;
  begin
    Result := (Caracter in ['0'..'9']);
  end;

var
  cAux,
  AuxCuenta: String;
  i: Integer;
  auxTemp: Extended;
begin
  Result := '';
  Cuenta := Trim(Cuenta);
  if (Cuenta = '') or (Length(Cuenta) > 34) then
    Exit
  else
  begin
    // Fase 1: Nos aseguramos que solo contiene Letras y Numeros
    Cuenta := UpperCase(Cuenta);
    cAux := '';
    for i := 1 to Length(Cuenta) do
    if (EsAlfanumerico(Cuenta[i]) or EsNumerico(Cuenta[i])) then
      cAux := cAux + AnsiString(Cuenta[i]);
    Cuenta := cAux;
    AuxCuenta := Cuenta;

    // Fase 2: Se comprueba si ya es un codigo IBAN, y si no lo es, se añade el PAIS
    if (EsAlfanumerico(Cuenta[1]) and EsAlfanumerico(Cuenta[2])) then // Es IBAN
    begin
      if (EsAlfanumerico(Cuenta[3]) or EsAlfanumerico(Cuenta[4])) then
        Exit;

      Pais   := Copy(Cuenta, 1, 2);//Cuenta.SubString(1, 2);
      Cuenta := Copy(Cuenta, 5, Length(Cuenta));//Cuenta.SubString(5, Length(Cuenta)) + Cuenta.SubString(1, 2) + '00';
      AuxCuenta := Cuenta;
    end
    else
    begin
      // y si no lo es, se añade el PAIS
      if (Trim(Pais) = '') then
        Pais := 'ES';
    end;
    Cuenta := Cuenta + Pais + '00';

    // Fase 3: Se convierten las letras del pais en sus numeros equivalentes:
      //A=10, B=11, C=12 ... Z=35
    cAux := '';
    for i := 1 to Length(Cuenta) do
    begin
      if (EsAlfanumerico(Cuenta[i])) then
        cAux := cAux + FormatFloat('00', Ord(Cuenta[i]) - 55)//Cuenta[i - 1] - 55)
      else
        cAux := cAux + Copy(Cuenta, i, 1);
    end;
    Cuenta := cAux;

    // Fase 4: Dividimos por 97
    auxTemp := StrToInt(Copy(Cuenta, 1, 9)) mod 97;
    cAux   := FormatFloat('0', auxTemp);
    Cuenta := Copy(Cuenta, 10, Length(Cuenta));
    while (Trim(Cuenta) <> '') do
    begin
      if (StrToInt(cAux) < 10) then
      begin
        cAux   := cAux + Copy(Cuenta, 1, 8);
        Cuenta := Copy(Cuenta, 9, Length(Cuenta));
      end
      else
      begin
        cAux   := cAux + Copy(Cuenta, 1, 7);
        Cuenta := Copy(Cuenta, 8, Length(Cuenta));
      end;
      auxTemp := StrToInt(cAux) mod 97;
      cAux := FormatFloat('0', auxTemp);
    end;

    // Fase 5: Devolvemos el IBAN completo con sus digitos de control.
    Result := Pais + FormatFloat('00', 98 - StrToInt(cAux)) + AuxCuenta;
  end;
end;

function StrX(X: Double; Decimals: Byte): String;
var
  S: String;
begin
  Str(X:0:Decimals, S);
  Result := S;
end;

function StrX(X: String; Decimals: Byte): String;
var
  Y: Double;
begin
  Y := StrToFloat(X);
  Result := StrX(Y, Decimals);
end;

function CountChar(SubStr: Char; S: String): Integer;
var
  X: Char;
begin
  Result := 0;
  for X in S do
    if (X = SubStr) then
      Inc(Result);
end;

function CountDecimals(SubStr: Char; S: String): Integer;
var
  nPos: Integer;
begin
  Result := 0;
  nPos := Pos(SubStr, S);
  if (nPos = 0) or (nPos = Length(S)) then
    Exit;
  Result := (Length(S) - nPos);
end;

function NewRegisterIdentification: Integer;
begin
  Inc(__RegisterIdentifications__);
  Result := ID_CONEXION_IDENTIFICADOR_DATABASE + __RegisterIdentifications__;
end;

function DatabaseDefault: TDatabase;
begin
  Result := MBaseDatos.BaseDatos;
end;

end.
