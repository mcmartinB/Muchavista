unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  IdSMTP, IdMessage, StdCtrls, IdAttachment, IdSSLOpenSSL, IdExplicitTLSClientServerBase;

type
  TForm1 = class(TForm)
    btEnviar: TButton;
    Memo1: TMemo;
    procedure btEnviarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure log(const msg: string);
    procedure EnviarMensaje( sUsuario, sClave, sHost, sAdjunto, sAsunto, sDestino, sMensaje: String );
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.EnviarMensaje( sUsuario, sClave, sHost, sAdjunto, sAsunto, sDestino, sMensaje: String );
var SMTP: TIdSMTP;
   Mensaje: TIdMessage;
   Adjunto: TIdAttachment;
   IdSSLIOHandlerSocketOpenSSL:TIdSSLIOHandlerSocketOpenSSL;
begin
  // Creamos el componente de conexión con el servidor
  SMTP := TIdSMTP.Create( nil );
  IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := sslvSSLv23;
  SMTP.Username := sUsuario;
  SMTP.Password := sClave;
  SMTP.Host := sHost;
  SMTP.Port := 465;
  SMTP.IOHandler := IdSSLIOHandlerSocketOpenSSL;
  SMTP.UseTLS := utUseImplicitTLS;

  // SMTP.AuthType:= atLogin;

  // Creamos el contenido del mensaje
  Mensaje := TIdMessage.Create( nil );
  Mensaje.Clear;
  Mensaje.From.Name := sUsuario;
  Mensaje.From.Address := sUsuario;
  Mensaje.Subject := sAsunto;
  Mensaje.Body.Text := sMensaje;
  Mensaje.Recipients.Add;
  Mensaje.Recipients.Items[0].Address := sDestino;

  // Si hay que meter un archivo adjunto lo creamos y lo asignamos al mensaje
  if sAdjunto <> '' then
  begin
    if FileExists( sAdjunto ) then
      // Adjunto := TIdAttachment.Create( Mensaje.MessageParts );
  end
  else
    Adjunto := nil;

  // Conectamos con el servidor SMTP
  try
    SMTP.Connect;
  except
    on E: Exception do
      log(E.ClassName + ': '+ E.Message)
  end;

  // Si ha conectado enviamos el mensaje y desconectamos
  if SMTP.Connected then
  begin
    try
      SMTP.Send( Mensaje );
      Application.MessageBox( 'Mensaje enviado correctamente.',
      'Fin de proceso',MB_ICONINFORMATION );
    except
     on E: Exception do
      log(E.ClassName + ': '+ E.Message)
    end;

    try
      SMTP.Disconnect;
    except
    on E: Exception do
      log(E.ClassName + ': '+ E.Message)
    end;
  end;

  // Liberamos los objetos creados
  if Adjunto <> nil then
    FreeAndNil( Adjunto );

  FreeAndNil( Mensaje );
  FreeAndNil( SMTP );
  IdSSLIOHandlerSocketOpenSSL.Free;
end;

procedure TForm1.btEnviarClick(Sender: TObject);
begin
EnviarMensaje( 'lynxview@bonnysa.es', 'Lynx784512', 'smtp.serviciodecorreo.es',
             'c:\tmp\prueba.txt', 'Te envio mi documento',
             'rpozo@lynxview.es', 'Adjunto archivo' );

end;

procedure TForm1.log(const msg: string);
begin
  self.Memo1.lines.add(msg)
end;

end.
