unit Global;

interface

uses Forms, Windows, sysUtils, DBTables, Dialogs, Math;

const
     MonthStrings: array [1 .. 12] of string = ('Enero','Febrero','Marzo',
                  'Abril','Mayo','Junio','Julio','Agosto','Septiembre',
                  'Octubre','Noviembre','Diciembre');

procedure AtentionBox(AMsg:string);
procedure ErrorBox(AMsg:string);Overload;
procedure ErrorBox(AError: Exception);Overload;
function  MonthToStr( AMonth: Word): String;      //Descripcion del mes en castellano
function  RellenarCeros(Cadena:String;Longitud:Integer;Sentido:Char):String; //Rellena con ceros una cadena por la Izq. o Dcha.
function  RellenarBlancos(Cadena:String;Longitud:Integer;Sentido:Char):String; //Rellena con blancos una cadena por la Izq. o Dcha.
function  Redondear(valor:real;decimales:integer):real;overload; //Redondea un numero de decimales
function  ParteEntera(Numero: Real):Integer;
function  ParteDecimal(Numero: Real):String;
function  EsNumerico(Cadena:String):Boolean; //Comprueba el formato de un número
function  UpperPrimerasLetras(Cadena: String):String;

implementation

//------------------------- MENSAJE DE ATENCION --------------------------------
procedure AtentionBox(AMsg:string);
begin
     Application.MessageBox(PChar(AMsg),'  ATENCIÓN !',MB_OK+MB_ICONWARNING);
end;

//------------------------- MENSAJE DE ERROR -----------------------------------
procedure ErrorBox(AMsg:string);
begin
     MessageDlg(AMsg,mtError,[mbOK],0);
end;

//------------------------- MENSAJE DE ERROR EXCEPTION GENERAL -----------------
procedure ErrorBox(AError: Exception);
begin
     MessageDlg(AError.Message,mtError,[mbOK],0);
end;

//FUNCION QUE A PARTIR DEL NUMERO DE MES NOS DEVULEVE EL NOMBRE DEL MES
function MonthToStr(AMonth: Word): String;
begin
     if (AMonth < 1) or (AMonth > 12) then
        result:= 'Unkown'
     else
         result:= MonthStrings[AMonth];
end;

//FUNCIÓN PARA RELLENAR CON CEROS(POR LA IZQ. O POR LA DCHA.) UNA CADENA
function RellenarCeros(Cadena:String;Longitud:Integer;Sentido:Char):String;
  Var CadenaCeros: String;
begin
     CadenaCeros:='';
     SetLength(CadenaCeros,Longitud-Length(Cadena));
     FillChar(CadenaCeros[1],Longitud-Length(Cadena),'0');
     If Sentido='I' then //Por la Izquierda
     begin
          Result:=CadenaCeros + Cadena;
     end
     else  //Por la Derecha
        Result:=Cadena + CadenaCeros;
end;

//FUNCIÓN PARA RELLENAR CON BLANCOS(POR LA IZQ. O POR LA DCHA.) UNA CADENA
function RellenarBlancos(Cadena:String;Longitud:Integer;Sentido:Char):String;
  Var CadenaBlancos: String;
begin
     CadenaBlancos:='';
     SetLength(CadenaBlancos,Longitud-Length(Cadena));
     FillChar(CadenaBlancos[1],Longitud-Length(Cadena),' ');
     If Sentido='I' then //Por la Izquierda
     begin
          Result:=CadenaBlancos + Cadena;
     end
     else  //Por la Derecha
        Result:=Cadena + CadenaBlancos;

     if Length(Result)>Longitud then
        Result:=copy(Result,1,Longitud);
end;

//FUNCION QUE REDONDEA LOS DECIMALES QUE LE PASEMOS
//!!!!!!!!!!!!! SOLO CON COMA DECIMAL !!!!!!!!!!!!!
function Redondear(Valor:real;decimales:integer):real;overload;
var
  Adjust: real;
  LFactor: real;
  Posicion: Integer;
  Cadena: string;
begin
  //Calculamos el ajuste
  if (valor > 0) then
     Adjust := 0.5
  else
      Adjust := -0.5;
  //Calculamos el factor
  LFactor := IntPower(10,decimales);

  //Buscamos la coma decimal
  Cadena:=FloatToStr(Valor * LFactor + Adjust);
  Posicion:=Pos(',',Cadena);

  if Posicion<>0 then //Si hay coma decimal nos quedamos con la parte entera y dividimos por el Factor
     Result := StrToFloat(Copy(Cadena,1,Posicion-1))/LFactor
  else  //Si no hay coma decimal dividimos por el Factor
      Result:=((Valor * LFactor) + Adjust)/LFactor;
end;

//--- FUNCION QUE DEVUELVE LA PARTE ENTERA DE UN DECIMAL ----
function ParteEntera(Numero: Real):Integer;
Var
   Num: String;
   i: Integer;
begin
     Num:=FloatToStr(Numero);
     i:=Pos(',',Num);
     if i<>0 then
        result:=StrToInt(Copy(Num,1,i-1))
     else
         result:=StrToInt(Num);
end;

//--- FUNCION QUE DEVUELVE LA PARTE DECIMAL DE UN DECIMAL ----
function ParteDecimal(Numero: Real):String;
Var
   Num: String;
   i: Integer;
begin
     Num:=FloatToStr(Numero);
     i:=Pos(',',Num);
     if i<>0 then
        result:=Copy(Num,i+1,Length(Num))
     else
         result:='0';
end;

//FUNCIÓN QUE COMPRUEBA SI UNA CADENA ES NUMÉRICA
function EsNumerico(Cadena:String):Boolean ;
begin
     try
        StrToInt64(Cadena);
        Result:=True;
     except  //Al hacer la conversión se produce un error
          on E: Exception do
             begin
                 Result:=False;
             end;
     end;
end;

//CONVIERTE UNA CADENA A: LA PRIMERA LETRA DE CADA PALABRA EN MAYUSCULAS Y EL RESTO MINUSCULAS
function UpperPrimerasLetras(Cadena: String):String;
     Var
        i: integer;
        Aux: String;
        Letra: String;
        Primera: Boolean;
begin
     Aux:='';
     Primera:=True;
     i:=1;
     Letra:=Copy(Cadena,i,1);
     while i<=Length(Cadena) do
     begin
          if ((Letra>='a') and (Letra<='z')) or ((Letra>='A') and (Letra<='Z')) then
          begin
               if Primera then
               begin
                    Aux:=Aux + UpperCase(Letra);
                    Primera:=False;
               end
               else
                   Aux:=Aux + LowerCase(Letra);
          end
          else
          begin
               Primera:=True;
               Aux:=Aux + Letra;
          end;
          i:=i+1;
          Letra:=Copy(Cadena,i,1);
     end;
     Result:=Aux;
end;

end.
