unit UEnvioCorreo;

interface

uses
  // System
  Classes,
  SysUtils,
  // Indy
  IdSMTP,
  IdMessage,
  IdAttachmentFile,
  IdSSLOpenSSL,
  IdExplicitTLSClientServerBase;

procedure log(const msg: string);  
procedure EnviarMensaje( sUsuario, sClave, sHost, sPort, sAdjunto, sAsunto, sDestino, sMensaje: String );

implementation

uses
  UConfig;

var
  Config: TConfig;


procedure log(const msg: string);
var
  logFile : TextFile;
  lineToPrint: string;
begin
  AssignFile(logFile,Config.logFile);
  Append(logFile);
  lineToPrint := DateTimeToStr(now) + ' ' + msg;
  Writeln(logFile, lineToPrint);
  CloseFile(logFile);
end;

procedure EnviarMensaje( sUsuario, sClave, sHost, sPort, sAdjunto, sAsunto, sDestino, sMensaje: String );
var SMTP: TIdSMTP;
   Mensaje: TIdMessage;
   Adjunto: TIdAttachmentFile;
   IdSSLIOHandlerSocketOpenSSL:TIdSSLIOHandlerSocketOpenSSL;
begin
  // Creamos el componente de conexión con el servidor
  SMTP := TIdSMTP.Create( nil );
  IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := sslvSSLv23;
  SMTP.Username := sUsuario;
  SMTP.Password := sClave;
  SMTP.Host := sHost;
  SMTP.Port := StrToInt(sPort);
  SMTP.IOHandler := IdSSLIOHandlerSocketOpenSSL;
  SMTP.UseTLS := utUseImplicitTLS;

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
      Adjunto := TIdAttachmentFile.Create( Mensaje.MessageParts, sAdjunto );
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
      log('Mensaje: ' + sAsunto + ' a '+ sDestino + ' enviado correctamente .')
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

Initialization
    Config := TConfig.Create;

Finalization
    Config.Free;

end.
