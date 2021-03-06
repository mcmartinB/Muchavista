unit DPreview;

interface

uses
  Windows, SysUtils, quickrpt, Printers, QRExport,
  ImgList, Spin, Dialogs, Classes, Controls, Forms, ExtCtrls, StdCtrls,
  ComCtrls, QRWebFilt, ToolWin, QRPrntr, ActnList, AFQuickMail;

type
  // To have a custom preview be used as the default preview,
  // you first define an interface class.  You will provide two
  // functions for this class, Show, and ShowModal.

  TPreviewInterface = class(TQRPreviewInterface)
  public
    function Show(AQRPrinter: TQRPrinter): TWinControl; override;
    function ShowModal(AQRPrinter: TQRPrinter): TWinControl; override;
  end;

  // We need the ParentReport property from TQRCompositeWinControl.  As of
  // the 3.0.4 release, this property is protected.  We create a descendant
  // class and that will give us access to the property
  TQRPatch = class(TQRCompositeWinControl)
  end;

  TFDPreview = class(TForm)
    Panel1: TPanel;
    QRPreview1: TQRPreview;
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ActiveImages: TImageList;
    ActionList1: TActionList;
    AImprimir: TAction;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    APrimero: TAction;
    AAnterior: TAction;
    ASiguiente: TAction;
    AUltimo: TAction;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    AAncho: TAction;
    ALargo: TAction;
    AMas: TAction;
    AMenos: TAction;
    ToolButton12: TToolButton;
    ToolButton14: TToolButton;
    AAbrir: TAction;
    ASalir: TAction;
    AGuardarPDF: TAction;
    ToolButton13: TToolButton;
    NumeroCopias: TSpinEdit;
    Label2: TLabel;
    ToolButton15: TToolButton;
    PrinterSetupDialog: TPrinterSetupDialog;
    AConfigPrinter: TAction;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    AEnviar: TAction;
    QRHTMLFilter1: TQRHTMLFilter;
    QuickMail: TAFQuickMail;
    //AFilter: TQRFilters;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure QRPreview1PageAvailable(Sender: TObject; PageNum: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure QRPreview1ProgressUpdate(Sender: TObject; Progress: Integer);
    procedure AImprimirExecute(Sender: TObject);
    procedure APrimeroExecute(Sender: TObject);
    procedure ASiguienteExecute(Sender: TObject);
    procedure AAnteriorExecute(Sender: TObject);
    procedure AUltimoExecute(Sender: TObject);
    procedure AAnchoExecute(Sender: TObject);
    procedure ALargoExecute(Sender: TObject);
    procedure AMasExecute(Sender: TObject);
    procedure AMenosExecute(Sender: TObject);
    procedure NumeroCopiasEnter(Sender: TObject);
    procedure OpcionClick(Sender: TObject);
    procedure AGuardarPDFExecute(Sender: TObject);
    procedure AConfigPrinterExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ASalirExecute(Sender: TObject);
    procedure AEnviarExecute(Sender: TObject);

  private
    { Private declarations }
    bEnviado: Boolean;
    FQRPrinter: TQRPrinter;
    procedure Init;
    procedure UpdateButtons;
    procedure SetMyWindow;
    function  EnviarPorCorreoMAPI( const ATipo: string ): boolean;
    procedure CrearPDF(const AReport: TQuickRep; const AFileName, AFileNameAux: string );
  public
    { Public declarations }
    bImprimir: Boolean;
    bPleaseInit: Boolean;
    bForcePrint: boolean;
    bDistinctCopies: boolean;
    bNumCopies: Integer;
    bForceMail: Boolean;
    sStatus, sTitle: string;
    adjunto: string;
    constructor CreatePreview(AOwner: TComponent; aQRPrinter: TQRPrinter);
    property QRPrinter: TQRPrinter read FQRPrinter write FQRPrinter;
  end;

function Previsualiza(QR: TQuickRep; Copias: Integer = 1): Boolean;
function Preview(QR: TQuickRep; Copias: Integer = 1; Force: Boolean = False; Distinct: Boolean = False; AForceMail: Boolean = False; Impresora: integer = -1 ): boolean;

var
  FDPreview: TFDPreview;

  Imprimir: boolean;
  ForcePrint: boolean;
  DistinctCopies: boolean;
  NumCopies: Integer;
  PressBtnPrint: Boolean;
  ForceMail: Boolean;

  bCanSend: Boolean;

implementation

{$R *.DFM}

// Now define the functions for the interface class.

function TPreviewInterface.Show(AQRPrinter: TQRPrinter): TWinControl;
begin
  Result := TFDPreview.CreatePreview(Application, AQRPrinter);
  // You can set options for your preview here
  TFDPreview(Result).bImprimir := Imprimir;
  TFDPreview(Result).bForcePrint := ForcePrint;
  TFDPreview(Result).bForceMail := ForceMail;
  TFDPreview(Result).bDistinctCopies := DistinctCopies;
  TFDPreview(Result).bNumCopies := NumCopies;
  TFDPreview(Result).NumeroCopias.Value := NumCopies;
  TFDPreview(Result).Visible := true;
  if ForcePrint then
    TFDPreview(Result).ASalir.Enabled := False;
  TFDPreview(Result).Show;
end;

function TPreviewInterface.ShowModal(AQRPrinter: TQRPrinter): TWinControl;
begin
  Result := TFDPreview.CreatePreview(Application, AQRPrinter);
  // You can set options for your preview here
  TFDPreview(Result).bForcePrint := ForcePrint;
  TFDPreview(Result).bForceMail := ForceMail;
  TFDPreview(Result).bDistinctCopies := DistinctCopies;
  TFDPreview(Result).bNumCopies := NumCopies;
  TFDPreview(Result).NumeroCopias.Value := NumCopies;
  TFDPreview(Result).Visible := false;
  if ForcePrint then
    TFDPreview(Result).ASalir.Enabled := False;
  TFDPreview(Result).ShowModal;
end;

constructor TFDPreview.CreatePreview(AOwner: TComponent; aQRPrinter: TQRPrinter);
begin
  inherited Create(AOwner);
  QRPrinter := aQRPrinter;
  // Connect the preview component to the report's qrprinter object
  QRPreview1.QRPrinter := aQRPrinter;
  if (QRPrinter <> nil) and (QRPrinter.Title <> '') then
    Caption := QRPrinter.Title;
end;

procedure TFDPreview.UpdateButtons;
begin
  with QRPreview1 do
  begin
    AAnterior.Enabled := PageNumber > 1;
    APrimero.Enabled := AAnterior.Enabled;
    ASiguiente.Enabled := PageNumber < QRPreview1.QRPrinter.PageCount;
    AUltimo.Enabled := ASiguiente.Enabled;
  end;
  StatusBar.Panels[0].Text := sStatus;
  StatusBar.Panels[1].Text := 'Pagina ' + IntToStr(QRPreview1.PageNumber) + ' de ' +
    IntToStr(QRPreview1.QRPrinter.PageCount);
end;


procedure TFDPreview.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //Podemos salir
  if bForcePrint then
  begin
    MessageDlg('' + #13 + #10 + '  Informe/listado de obligada impresi?n.      ', mtWarning, [mbOK], 0);
    Action := caNone;
    Exit;
  end;

  QRPrinter.ClosePreview(Self);
  bCanSend := false;

  Action := caFree;
end;

procedure TFDPreview.SetMyWindow;
var
  wp: TWindowPlacement;
  Rec: TRect;
begin
  // Get the client area of the desktop so we can force the preview
  // to use all of the available space.  This keeps the user from
  // minizing the form.
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Rec, 0);
  wp.length := sizeof(wp);
  GetWindowPlacement(handle, @wp);
  wp.rcNormalposition := rec;
  setwindowplacement(handle, @wp);
end;

procedure TFDPreview.FormShow(Sender: TObject);
begin
  bPleaseInit := True;
end;

procedure TFDPreview.Init;
begin
  if bPleaseInit then
  begin
    QRPreview1.ZoomToWidth;

    (*TODO*)
    //No se generan bien los PDF apaisados ??? 
    //AEnviar.Enabled := TQuickRep(qrprinter.master).QRPrinter.Orientation <> poLandscape;
    //ExportQR.Preview := QRPreview1;

    UpdateButtons;
    bPleaseInit := False;
  end;
end;

procedure TFDPreview.QRPreview1PageAvailable(Sender: TObject;
  PageNum: Integer);
var
  sTitle: string;
begin
  Init;

  sTitle := QRPreview1.QRPrinter.Title;
  if Trim(sTitle) = '' then
    sTitle := 'INFORME SIN T?TULO';

  if PageNum = 1 then
    Caption := sTitle + ' - 1 p?gina'
  else
    Caption := sTitle + ' - ' + IntToStr(PageNum) + ' p?ginas.';

  case QRPreview1.QRPrinter.Status of
    mpReady: sStatus := 'Leyendo';
    mpBusy: sStatus := 'Ocupado';
    //Si ha acabado y es la impresion de facturas se llama al envio de correo
    mpFinished:
      sStatus := 'Acabado';
  end;
  UpdateButtons;
end;

procedure TFDPreview.FormCreate(Sender: TObject);
begin
  {teclas rapidas que no puedo poner en dise?o}
  AAnterior.ShortCut := ShortCut(vk_prior, []);
  ASiguiente.ShortCut := ShortCut(vk_next, []);
  ALargo.ShortCut := ShortCut(vk_multiply, []);
  AAncho.ShortCut := ShortCut(vk_divide, []);
  AMas.ShortCut := ShortCut(vk_add, []);
  AMenos.ShortCut := ShortCut(vk_subtract, []);
  {Variables}
  bForcePrint := true;
  bDistinctCopies := false;
  bNumCopies := 1;

  // Put the progress bar on the statusbar
  ProgressBar.Parent := StatusBar;

  // Get the client area of the desktop
  SetMyWindow;

  bEnviado:= False;
  bForceMail:= False;
end;

procedure TFDPreview.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Copias
  if ssAlt in Shift then
  begin
    case Key of
      vk_Down: NumeroCopias.Value := NumeroCopias.Value - 1;
      vk_Up: NumeroCopias.Value := NumeroCopias.Value + 1;
    end;
    Exit;
  end;
end;

procedure TFDPreview.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Copias
  if Key = vk_Escape then
    if ssShift in Shift then begin bForcePrint := False; Close; end
    else Close;

  //Navegacion
  case Key of
    vk_Down: with QRPreview1.VertScrollBar do
        Position := Position + trunc(Range / 10);
    vk_Up: with QRPreview1.VertScrollBar do
        Position := Position - trunc(Range / 10);
    vk_Left: with QRPreview1.HorzScrollBar do
        Position := Position - trunc(Range / 10);
    vk_Right: with QRPreview1.HorzScrollBar do
        Position := Position + trunc(Range / 10);
  end;
end;


procedure TFDPreview.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  aRect: TRect;
begin
  if Panel = StatusBar.Panels[2] then begin
    aRect := Rect;
    InflateRect(aRect, 1, 1);
    ProgressBar.BoundsRect := aRect;
  end;
end;


procedure TFDPreview.QRPreview1ProgressUpdate(Sender: TObject;
  Progress: Integer);
begin
  ProgressBar.Position := Progress;
  if (Progress = 0) or (Progress = 100) then
  begin
    ProgressBar.Position := 0;
  end;
end;


procedure TFDPreview.AImprimirExecute(Sender: TObject);
var
  i: integer;
  AceptMultiCopys: boolean;
begin
  PressBtnPrint := true;
  if not bImprimir then
  begin
    bNumCopies := NumeroCopias.Value;
    TQuickRep(qrprinter.master).PrinterSettings.Copies := bNumCopies;
    if bForcePrint then
    begin
      bForcePrint := false;
      ASalir.Enabled := True;
    end;
    Close;
    Exit;
  end;

  //Acepta la impresora multiples copias
  qrprinter.Copies := 2;
  AceptMultiCopys := not (qrprinter.Copies = 1);
  bNumCopies := NumeroCopias.Value;
  qrprinter.Copies := 1;

  //Numero de paginas
  if TQuickRep(qrprinter.master).Bands.HasPageFooter then
    TQuickRep(qrprinter.master).Bands.PageFooterBand.Tag :=
      QRPreview1.QRPrinter.PageCount;

  //Imprimir
  if AceptMultiCopys then begin
    if bDistinctCopies then begin
      //Cada copia debe tener algo que la diferencie de las demas
      //qrprinter.Copies := 1;
      TQuickRep(qrprinter.master).PrinterSettings.Copies := 1;

      TQuickRep(qrprinter.master).Tag := 0;
      for I := 1 to bNumCopies do begin
        TQuickRep(qrprinter.master).Tag := TQuickRep(qrprinter.master).Tag + 1;
        TQuickRep(qrprinter.master).Print;
        //qrprinter.Print;
        Application.ProcessMessages;
      end;
    end else begin
      //Cada copia es identica a las demas
      TQuickRep(qrprinter.master).Tag := 0;
      TQuickRep(qrprinter.master).PrinterSettings.Copies := bNumCopies;
      TQuickRep(qrprinter.master).print;
      Application.ProcessMessages;
    end;
  end else begin
    TQuickRep(qrprinter.master).PrinterSettings.Copies := 1;
    TQuickRep(qrprinter.master).Tag := 0;
    for I := 1 to bNumCopies do begin
      TQuickRep(qrprinter.master).Tag := TQuickRep(qrprinter.master).Tag + 1;
      TQuickRep(qrprinter.master).Print;
      Application.ProcessMessages;
    end;
  end;

  if bForcePrint then
  begin
    bForcePrint := false;
    ASalir.Enabled := True;
  end;

  if ( Copy( LowerCase(TQuickRep(QRPrinter.master).Name), 1, 9)  = 'qralbaran' )  and ( not bEnviado ) and bForceMail then
  begin
    //Hay que envairlo antes de cerrar
  end
  else
  begin
    Close;
  end;
end;

procedure TFDPreview.APrimeroExecute(Sender: TObject);
begin
  Application.ProcessMessages;
  with QRPreview1 do
    PageNumber := 1;
  UpdateButtons;
end;

procedure TFDPreview.AAnteriorExecute(Sender: TObject);
begin
  Application.ProcessMessages;
  with QRPreview1 do
    if PageNumber > 1 then
      PageNumber := PageNumber - 1;
  UpdateButtons;
end;

procedure TFDPreview.ASiguienteExecute(Sender: TObject);
begin
  Application.ProcessMessages;
  with QRPreview1 do
    if PageNumber < QRPreview1.QRPrinter.PageCount then
      PageNumber := PageNumber + 1;
  UpdateButtons;
end;


procedure TFDPreview.AUltimoExecute(Sender: TObject);
begin
  Application.ProcessMessages;
  with QRPreview1 do
    PageNumber := QRPreview1.QRPrinter.PageCount;
  UpdateButtons;
end;

procedure TFDPreview.AAnchoExecute(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview1.ZoomToWidth;
end;

procedure TFDPreview.ALargoExecute(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview1.ZoomToFit;
end;

procedure TFDPreview.AMasExecute(Sender: TObject);
begin
  Application.ProcessMessages;
  with QRPreview1 do
    Zoom := Zoom + 10;
end;

procedure TFDPreview.AMenosExecute(Sender: TObject);
begin
  Application.ProcessMessages;
  with QRPreview1 do
    if Zoom > 10 then
      Zoom := Zoom - 10;
end;

procedure TFDPreview.AGuardarPDFExecute(Sender: TObject);
var
  //aPDFFilt : TQRPDFDocumentFilter;
  sAux: string;
begin
  with TSaveDialog.Create(Application) do
  try
    Title := '  Guardar informe/listado.';
    Filter := 'Documento EXCEL (*.xls)|*.xls|' +
      'Documento PDF (*.pdf)|*.pdf|' +
      'Microsoft Word (*.doc)|*.doc';
              //'Comma Separed File (*.csv)|*.csv';

    sAux:= StringReplace(TQuickRep(qrprinter.master).ReportTitle, ' ', '_', [rfReplaceAll] );
    sAux:= StringReplace(sAux, '?', 'n', [rfReplaceAll,rfIgnoreCase] );
    sAux:= StringReplace(sAux, '?', 'a', [rfReplaceAll,rfIgnoreCase] );
    sAux:= StringReplace(sAux, '?', 'e', [rfReplaceAll,rfIgnoreCase] );
    sAux:= StringReplace(sAux, '?', 'i', [rfReplaceAll,rfIgnoreCase] );
    sAux:= StringReplace(sAux, '?', 'o', [rfReplaceAll,rfIgnoreCase] );
    sAux:= StringReplace(sAux, '?', 'u', [rfReplaceAll,rfIgnoreCase] );
    FileName:= sAux;
    if CVariables.gbTerminalserver then
      InitialDir:= '\\tsclient\c\';

    if Execute then
    begin
      case FilterIndex of
        1: {XLS}
          begin
            if (uppercase(ExtractFileExt(FileName)) <> 'XLS') then
            begin
              if Pos('.XLS',Uppercase( FileName ) ) = 0 then
                FileName := FileName + '.xls';
            end;
            TQuickRep(qrprinter.master).ExportToFilter(TQRXLSFilter.Create(Filename));
          end;
        2: {PDF}
          begin
            //ExportQR.ExportQRPDF(FileName, true, true);
            if (uppercase(ExtractFileExt(FileName)) <> 'PDF') then
            begin
              if Pos('.PDF',Uppercase( FileName ) ) = 0 then
                FileName := FileName + '.pdf';
            end;
            TQuickRep(qrprinter.master).ExportToFilter(  TQRPDFDocumentFilter.Create( Filename ) );
            (*
            //aPDFFilt := TQRPDFDocumentFilter.Create('c:\temp\bancos.pdf');
            if (uppercase(ExtractFileExt(FileName)) <> 'PDF') then
              FileName := FileName + '.pdf';
            TQuickRep(qrprinter.master).ExportToFilter(TQRPDFDocumentFilter.Create(Filename));
            //QRLBancos.ExportToFilter( aPDFFilt );
            //aPDFFilt.free;
            *)
          end;
        3: {DOC}
          begin
            if (uppercase(ExtractFileExt(FileName)) <> 'DOC') and
              (uppercase(ExtractFileExt(FileName)) <> 'RTF') then
            begin
              if Pos('.DOC',Uppercase( FileName ) ) = 0 then
                FileName := FileName + '.doc';
            end;
            TQuickRep(qrprinter.master).ExportToFilter(TQRRTFExportFilter.Create(Filename))
          end;
      end;

      //Ejecutar el programa adecuado segun el formato en el que se haya guardado
      {ShellExecute(Application.Handle,
                 'open',
                 PChar(Filename),
                 nil,
                 PChar(extractfilepath(FileName)),
                 SW_SHOWNORMAL);}
    end;
  finally
    Free;
  end;
end;


procedure TFDPreview.NumeroCopiasEnter(Sender: TObject);
begin
  ActiveControl := nil;
end;

procedure TFDPreview.OpcionClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := true;
end;

function Preview(QR: TQuickRep; Copias: Integer = 1; Force: Boolean = False; Distinct: Boolean = False; AForceMail: Boolean = False; Impresora: integer = -1  ): boolean;
begin
  ForcePrint := Force; {Obligar la impreion}
  NumCopies := Copias; {Numero de copias}
  DistinctCopies := Distinct; {Cada copia puede ser personalizada}
  ForceMail:= AForceMail;

  //Codigo dependiente de la aplicacion
  //Ocultar barra de menus y herramientas de la aplicacion principal
  Fprincipal.Menu := nil;
  Fprincipal.PEstado.Visible := False;
  Fprincipal.CBControlBarras.Visible := False;

  try
    try
      if Impresora <> -1 then
        QR.PrinterSettings.PrinterIndex := Impresora
      else
        QR.PrinterSettings.PrinterIndex := giPrintDefault;
      QR.Preview; {Visualizar informe/listado}
    except
    end;
  finally
    if Imprimir then
      FreeAndNil(QR); {Liberar memoria}
    Application.ProcessMessages; {Procesar todos los mensajes pendientes}
  end;

  //Codigo dependiente de la aplicacion
  //Mostrar barra de menus y herramientas de la aplicacion principal
  Fprincipal.Menu := Fprincipal.MenuPrincipal;
  Fprincipal.PEstado.Visible := True;
  Fprincipal.CBControlBarras.Visible := True;
  Application.ProcessMessages; {Procesar todos los mensajes pendientes}

  result := PressBtnPrint;
end;

function Previsualiza(QR: TQuickRep; Copias: Integer = 1): Boolean;
begin
  ForcePrint := False; {Obligar la impreion}
  NumCopies := Copias; {Numero de copias}
  DistinctCopies := False; {Cada copia puede ser personalizada}

  //Codigo dependiente de la aplicacion
  //Ocultar barra de menus y herramientas de la aplicacion principal
  Fprincipal.Menu := nil;
  Fprincipal.PEstado.Visible := False;
  Fprincipal.CBControlBarras.Visible := False;

  QR.PrinterSettings.PrinterIndex := giPrintDefault;
  QR.Preview; {Visualizar informe/listado}

  //Codigo dependiente de la aplicacion
  //Mostrar barra de menus y herramientas de la aplicacion principal
  Fprincipal.Menu := Fprincipal.MenuPrincipal;
  Fprincipal.PEstado.Visible := True;
  Fprincipal.CBControlBarras.Visible := True;
  Application.ProcessMessages; {Procesar todos los mensajes pendientes}

  result := PressBtnPrint;
end;

procedure TFDPreview.AConfigPrinterExecute(Sender: TObject);
var
  nCopias: Integer;
begin
  {Seleccionar impresora y configurar}
  nCopias := NumeroCopias.Value;
  if ExecuteConfigPrinter(TQuickRep(qrprinter.master), nCopias) then
  begin
    NumeroCopias.Value := nCopias;
    AImprimirExecute(Self);
  end;
end;

procedure TFDPreview.ASalirExecute(Sender: TObject);
begin
  //Si es un albaran comprobar si se ha enviado
  if ( ( Copy( LowerCase(TQuickRep(QRPrinter.master).Name), 1, 9)  = 'qralbaran' ) )  and ( not bEnviado ) and bForceMail then
  begin
    if AdvertenciaFD.VerAdvertencia( Self, 'El albaran no ha sido enviado por correo al cliente.','ADVERTENCIA', 'Enviare el correo mas tarde', 'Mas Tarde' ) = mrIgnore then
    begin
      Close;
      PressBtnPrint := false;
    end;
  end
  else
  begin
    Close;
    PressBtnPrint := false;
  end;
end;

//***************************  CORREO  **************************************
function EMail( const AEmpresa, ACliente, ATipo: string): String;
begin
  with DMBaseDatos.QGeneral do
  begin
    Close;
    SQl.Clear;
    SQl.Add('SELECT ' + ATipo + ' FROM frf_clientes ' +
      'WHERE empresa_c = ' + QuotedStr( AEmpresa ) +
      ' AND cliente_c = ' + QuotedStr( ACliente ) +
      ' AND ' + ATipo + ' IS NOT NULL AND ' + ATipo + ' <>' + QuotedStr('') + ' ');
    Open;
    Result := FieldByName(ATipo).AsString;
    Close;
  end;
end;

function TFDPreview.EnviarPorCorreoMAPI( const ATipo: string ): boolean;
var
  sAux, sAux2: string;
begin
  result:= False;
  (*TODO*)
  if TQuickRep(QRPrinter.master).ReportTitle = '' then
    TQuickRep(QRPrinter.master).ReportTitle:= 'Listado_Comercial';


  if DirectoryExists( gsDirActual + '\temp\' ) then
  begin
    sAux := gsDirActual + '\temp\' + TQuickRep(QRPrinter.master).ReportTitle;
    sAux2 := gsDirActual + '\..\temp\' + TQuickRep(QRPrinter.master).ReportTitle;
  end
  else
  begin
    sAux := gsDirActual + '\..\temp\' + TQuickRep(QRPrinter.master).ReportTitle;
    sAux2 := gsDirActual + '\temp\' + TQuickRep(QRPrinter.master).ReportTitle;
  end;

  if FileExists(sAux + '.pdf') then
    DeleteFile(sAux + '.pdf');
  if FileExists(sAux2 + '.pdf') then
    DeleteFile(sAux2 + '.pdf');

  CrearPDF( TQuickRep(qrprinter.master), sAux, sAux2 );

  sAux:= sAux + '.pdf';
  sAux2:= sAux2 + '.pdf';
  QuickMail.FileNames.Clear;

  if ATipo <> '' then
  begin
    QuickMail.ToEmail.Text:= EMail( sEmpresaConfig, sClienteConfig, ATipo );
    QuickMail.Subject:= 'Env?o del ' + TQuickRep(QRPrinter.master).ReportTitle + ' de '+
                        desCliente( sEmpresaConfig, sClienteConfig );
  end
  else
  begin
    QuickMail.Subject:= 'Env?o del ' + TQuickRep(QRPrinter.master).ReportTitle;
  end;

  if FileExists( sAux ) then
  begin
    QuickMail.FileNames.Add( sAux );
    result:= QuickMail.Execute;
    DeleteFile( sAux );
  end
  else
  begin
    if FileExists( sAux2 ) then
    begin
      QuickMail.FileNames.Add( sAux2 );
      result:= QuickMail.Execute;
      DeleteFile( sAux2 );
    end
    else
    begin
      ShowMessage('Error al crear el fichero PDF [' + sAux + '].');
    end;
  end;
end;

procedure TFDPreview.CrearPDF(const AReport: TQuickRep; const AFileName, AFileNameAux: string );
var
  old_impresora: integer;
begin
  //Escoger impresora de PDF y crear el fichero
  old_impresora := AReport.PrinterSettings.PrinterIndex;

  if giPrintPDF > -1 then
  begin
    AReport.PrinterSettings.PrinterIndex := giPrintPDF;
    AReport.tag := Tag;
    AReport.ShowProgress := False;
    Screen.Cursor := crHourGlass;
    try
      //showmessage( 'PDFCreator');
      AReport.print;
      Sleep(2500);

      //showmessage( AFileName + '.pdf' + #13 + #10 + AFileNameAux + '.pdf' );
      if ( not FileExists( AFileName + '.pdf' ) ) and ( not FileExists( AFileNameAux + '.pdf' ) ) then
      begin
        //showmessage( 'No existe fichero pdf creator ');
        AReport.ExportToFilter(  TQRPDFDocumentFilter.Create( AFileName ) );
        //ExportQR.ExportQRPDF(AFileName, true, true);
        Sleep(2500);
      end;
    except
      //showmessage( 'Error pdf creator ');
      AReport.ExportToFilter(  TQRPDFDocumentFilter.Create( AFileName ) );
      //ExportQR.ExportQRPDF(AFileName, true, true);
      Sleep(2500);
    end;
    AReport.PrinterSettings.PrinterIndex := old_impresora;
    Screen.Cursor := crDefault;
  end
  else
  begin
    //showmessage( 'ExportPDF');
    AReport.ExportToFilter(  TQRPDFDocumentFilter.Create( AFileName ) );
    //ExportQR.ExportQRPDF(AFileName, true, true);
    Sleep(2500);
  end;

(*
  //Escoger impresora de PDF y crear el fichero
  old_impresora := AReport.PrinterSettings.PrinterIndex;

  if giPrintPDF > -1 then
  begin
    AReport.PrinterSettings.PrinterIndex := giPrintPDF;
    AReport.tag := Tag;
    AReport.ShowProgress := False;
    Screen.Cursor := crHourGlass;
    try
      //showmessage( 'PDFCreator');
      AReport.print;
      Sleep(2500);

      //showmessage( AFileName + '.pdf' + #13 + #10 + AFileNameAux + '.pdf' );
      if ( not FileExists( AFileName + '.pdf' ) ) and ( not FileExists( AFileNameAux + '.pdf' ) ) then
      begin
        //showmessage( 'No existe fichero pdf creator ');
        ExportQR.ExportQRPDF(AFileName, true, true);
        Sleep(2500);
      end;
    except
      //showmessage( 'Error pdf creator ');
      ExportQR.ExportQRPDF(AFileName, true, true);
      Sleep(2500);
    end;
    AReport.PrinterSettings.PrinterIndex := old_impresora;
    Screen.Cursor := crDefault;
  end
  else
  begin
    //showmessage( 'ExportPDF');
    ExportQR.ExportQRPDF(AFileName, true, true);
    Sleep(2500);
  end;
*)
end;

procedure TFDPreview.AEnviarExecute(Sender: TObject);
begin
  (*TODO*)
  //Si tiene direccion de correo gsHostCorreo <> ''
  //entonces  EnviarCorreo
  //sino   EnviarPorCorreoMAPI

  if DMConfig.EsLaFont then
  begin
    if Copy( LowerCase(TQuickRep(QRPrinter.master).Name), 1, 9)  = 'qralbaran'  then

      bEnviado:= EnviarAlbaranes( TQuickRep(qrprinter.master) )
    else
      if LowerCase(TQuickRep(QRPrinter.master).Name) = 'qrlalbarantransito2' then
        bEnviado:= EnviarTransitos( TQuickRep(qrprinter.master) )
      else
        if LowerCase(TQuickRep(QRPrinter.master).Name) = 'qrlfacturamanual' then
          bEnviado:= EnviarFacturasManuales( TQuickRep(qrprinter.master) )
        else
          if (LowerCase(QRPreview1.QRPrinter.Master.Name) = 'qrlfacturas') or
             (LowerCase(QRPreview1.QRPrinter.Master.Name) = 'qrlfacturaskilos') then
          begin
            bEnviado:= EnviarYGuardarFacturas(TQuickRep(qrprinter.master));
          end
          else
          begin
            if gbTerminalserver then
              bEnviado:= EnviarCorreo( TQuickRep(qrprinter.master) )
            else
              bEnviado:= EnviarPorCorreoMAPI( '' );
          end
  end
  else
  begin
    if gsHostCorreo <> '' then
    begin
     if ( Copy( LowerCase(TQuickRep(QRPrinter.master).Name), 1, 9)  = 'qralbaran' )  then

      begin
        bEnviado:= EnviarAlbaranes( TQuickRep(qrprinter.master) )
      end
      else
      begin
        bEnviado:= EnviarCorreo( TQuickRep(qrprinter.master) );
      end;
    end
    else
    begin
      bEnviado:= EnviarPorCorreoMAPI( '' );
    end;
  end;
end;

initialization
  Imprimir := True;
  ForcePrint := false;
  NumCopies := 1;
  DistinctCopies := false;

  bCanSend := False;

end.
