unit AplicacionConstantes;

interface

uses
  SysUtils, ComCtrls, Forms, Graphics;


const

  PRINTER_PREVIEW           = 1;  // Impresión preliminar (Pantalla)
  PRINTER_DIRECT            = 2;  // Impresión directa
  PRINTER_PDF               = 3;  // Impresión a PDF

  FILTER_DIALOG_EXPORT_EXCEL = 'Exportar Libro Microsoft Office Excel (*.xls)|*.xls|Exportar Libre Office Cálculo (*.ods)|*.ods|Exportar CSV (*.csv)|*.csv|Exportar TXT (*.txt)|*.txt';
  FILTER_DIALOG_EXPORT_PDF   = 'Exportar Fichero Acrobat Reader (*.PDF)|*.pdf';

  CR_             = #13;
  LF_             = #10;
  CR_LF           = CR_+LF_;
  DCR_LF          = CR_LF + CR_LF;

  WVK_NULL        = #0;
  WVK_RETURN      = #13;
  WVK_ENTER       = #13;
  WVK_ESCAPE      = #27;
  WVK_DOWN        = #40;
  WVK_UP          = #48;
  WVK_LEFT        = #37;
  WVK_RIGHT       = #39;
  WVK_INSERT      = #45;
  WVK_BACKDELETE  = #8;
  WVK_SPACE       = #32;
  WVK_COMMA       = #44;
  WVK_DEDUCT      = #45;
  WVK_POINT       = #46;



  //COLOR_EDIT_BACKGROUND_ENTER = $00FFFFCA;
  COLOR_EDIT_BACKGROUND_ENTER = clSkyblue;
  //COLOR_EDIT_BACKGROUND_EXIT  = clWindow;
  COLOR_EDIT_BACKGROUND_EXIT  = clWhite;
  COLOR_EDIT_BACKGROUND_SELECTED = clYellow;

  COLOR_DBGRID_LETTER_DEFAULT       = clBlack;
  COLOR_DBGRID_LETTER_SELECTED      = clRed;
  COLOR_DBGRID_LETTER_DELETED       = clActiveCaption;
  COLOR_DBGRID_LETTER_PREDETERMINED = clGreen;
  COLOR_DBGRID_LETTER_DEBT_YES      = clRed;
  COLOR_DBGRID_LETTER_DEBT_NO       = clBlue;

  COLOR_EXIST_VALUE_IN_TABLE: Array[Boolean] of TColor = (clWindowText, clRed);

  PAIS_IBAN_DEFAULT: String = 'ES';

  ID_CONEXION_IDENTIFICADOR_DATABASE = 100000000;

  SIN_EFE_CLIENTE_SINO: Array[Boolean] of String = ('N', 'S');
  TIPO_CLIENTE_SINO: Array[Boolean] of String = ('J', 'F');
  SITUACION_CLIENTE_SINO: Array[Boolean] of String = ('B', 'A');

implementation

end.
