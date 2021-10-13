unit Informes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, nbEdits, nbLabels, nbButtons, ExtCtrls, DBTables;

type
  TFInformes = class(TForm)
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    Zona: TnbLabel;
    GroupBox1: TGroupBox;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    GroupBox3: TGroupBox;
    cFiscal: TnbRadioButton;
    cSuministro: TnbRadioButton;
    SpeedButtonAceptar: TSpeedButton;
    SpeedButtonCancelar: TSpeedButton;
    GroupBox4: TGroupBox;
    cNota: TnbRadioButton;
    cCarta: TnbRadioButton;
    nbLabel3: TnbLabel;
    cCartaSinAyto: TnbRadioButton;
    GroupBox5: TGroupBox;
    cEmpresa: TComboBox;
    cZonaDes: TEdit;
    cZonaHas: TEdit;
    cClienteDes: TEdit;
    cClienteHas: TEdit;
    procedure Cancelar(Sender: TObject);
    procedure Aceptar(Sender: TObject);
    procedure cEmpresaEnter(Sender: TObject);
    procedure cEmpresaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cEmpresaChange(Sender: TObject);
  private
    { Private declarations }
      function  ComprobarDatos(): Boolean;
      procedure Listado1(Zona, Cliente: Integer);
      procedure Listado2(Zona, Cliente: Integer);
      procedure Listado2Bis(Zona, Cliente: Integer);
      procedure Listado3(Zona, Cliente: Integer);
  public
    { Public declarations }
  end;

var
  FInformes: TFInformes;

implementation

uses Global, Carta1, Carta2, BaseDatos, Carta3, Carta2Bis, IniFiles;

{$R *.dfm}

//------------------------------- CANCELAR -------------------------------------
procedure TFInformes.Cancelar(Sender: TObject);
begin
     Close;
end;

//------------------------------- ACEPTAR --------------------------------------
procedure TFInformes.Aceptar(Sender: TObject);
     Var
        QSeleccion: TQuery;
        NumClientes: Integer;
        Pregunta: String;
begin
     if ComprobarDatos() then
     begin
          try
             try
                QSeleccion:=TQuery.Create(Self);
                QSeleccion.DatabaseName:=MBaseDatos.BaseDatos.DatabaseName;
                QSeleccion.SQL.Add(' SELECT DISTINCT COD_ZON, COD_CLI FROM CARTERA ' +
                                   ' WHERE COD_ZON BETWEEN ' + cZonaDes.Text + ' AND ' + cZonaHas.Text + 
                                   ' AND COD_CLI BETWEEN ' + cClienteDes.Text +
                                   ' AND ' + cClienteHas.Text +
                                   ' AND FCO_REC IS NULL ');
                QSeleccion.Open;
                if not QSeleccion.IsEmpty then
                begin
                     NumClientes:=QSeleccion.RecordCount;
                     if NumClientes>1 then
                        Pregunta:='¿Desea Imprimir '  + IntToStr(NumClientes) + ' clientes?'
                     else
                         Pregunta:='¿Desea Imprimir '  + IntToStr(NumClientes) + ' cliente?';
                     if MessageDlg(Pregunta,mtConfirmation,[mbYes,mbNo],0)=mrYes then
                     begin
                          if cNota.Checked then //Nota Informativa
                          begin
                               While not QSeleccion.Eof do
                               begin
                                    Listado1(QSeleccion.FieldByName('Cod_Zon').AsInteger,QSeleccion.FieldByName('Cod_Cli').AsInteger);
                                    QSeleccion.Next;
                               end;
                          end
                          else if cCarta.Checked then   //Cartas Notificacion
                               begin
                                     While not QSeleccion.Eof do
                                     begin
                                          //if (QSeleccion.FieldByName('Cod_Zon').AsInteger=5) or
                                          //   (QSeleccion.FieldByName('Cod_Zon').AsInteger=6) or
                                          //   (QSeleccion.FieldByName('Cod_Zon').AsInteger=7) then   //BUSOT
                                          //begin
                                               Listado2(QSeleccion.FieldByName('Cod_Zon').AsInteger,QSeleccion.FieldByName('Cod_Cli').AsInteger);
                                               Listado3(QSeleccion.FieldByName('Cod_Zon').AsInteger,QSeleccion.FieldByName('Cod_Cli').AsInteger);
                                          //end
                                          //else  //CAMPELLO
                                          //    Listado2Bis(QSeleccion.FieldByName('Cod_Zon').AsInteger,QSeleccion.FieldByName('Cod_Cli').AsInteger);
                                          QSeleccion.Next;
                                     end;
                              end
                              else
                              begin
                                   While not QSeleccion.Eof do
                                   begin
                                        //if (QSeleccion.FieldByName('Cod_Zon').AsInteger=5) or
                                        //   (QSeleccion.FieldByName('Cod_Zon').AsInteger=6) or
                                        //   (QSeleccion.FieldByName('Cod_Zon').AsInteger=7) then   //BUSOT
                                        //begin
                                             Listado2(QSeleccion.FieldByName('Cod_Zon').AsInteger,QSeleccion.FieldByName('Cod_Cli').AsInteger);
                                        //end
                                        //else  //CAMPELLO
                                        //    Listado2Bis(QSeleccion.FieldByName('Cod_Zon').AsInteger,QSeleccion.FieldByName('Cod_Cli').AsInteger);
                                        QSeleccion.Next;
                                   end;
                              end;
                     end;
                end
                else
                    AtentionBox(Chr(13) + 'No Existen Datos en la Selección.');
             finally
                    FreeAndNil(QSeleccion);
             end;
          except
                On E:Exception do       //Otros
                     ErrorBox(E);
          end;
     end;
end;

//---------------------------- COMPROBAR DATOS ---------------------------------
function TFInformes.ComprobarDatos(): Boolean;
begin
     //Comprobamos la ZONA DESDE
     if cZonaDes.Text='' then
     begin
          AtentionBox(Chr(13) + 'Falta la zona desde.');
          Application.ProcessMessages;
          cZonaDes.SetFocus;
          Result:=False;
          Exit;
     end;
     //Comprobamos la ZONA HASTA
     if cZonaHas.Text='' then
     begin
          AtentionBox(Chr(13) + 'Falta la zona hasta.');
          Application.ProcessMessages;
          cZonaHas.SetFocus;
          Result:=False;
          Exit;
     end;
     //Rango de Zonas
     if cZonaDes.Text > cZonaHas.Text then
     begin
          AtentionBox(Chr(13) + 'Rango de zonas incorrecto.');
          Application.ProcessMessages;
          cZonaHas.SetFocus;
          Result:=False;
          Exit;
     end;
     //Comprobamos el CLIENTE DESDE
     if cClienteDes.Text='' then
     begin
          AtentionBox(Chr(13) + 'Falta el cliente desde.');
          Application.ProcessMessages;
          cClienteDes.SetFocus;
          Result:=False;
          Exit;
     end;
     //Comprobamos el CLIENTE HASTA
     if cClienteHas.Text='' then
     begin
          AtentionBox(Chr(13) + 'Falta el cliente hasta.');
          Application.ProcessMessages;
          cClienteHas.SetFocus;
          Result:=False;
          Exit;
     end;
     if cClienteDes.Text > cClienteHas.Text then
     begin
          AtentionBox(Chr(13) + 'Rango de clientes incorrecto.');
          Application.ProcessMessages;
          cClienteHas.SetFocus;
          Result:=False;
          Exit;
     end;
     Result:=True
end;

//---------------------- LISTADO DE NOTA INFORMATIVA ---------------------------
procedure TFInformes.Listado1(Zona, Cliente: Integer);
     Var
        Carta1: TQRCarta1;
        QAux: TQuery;
        CPostal: Integer;
        NumTotalDetalles: Integer;
begin
     try
        Carta1:=TQRCarta1.Create(Self);
        With Carta1 do
        begin
             Query1.DatabaseName:=MBaseDatos.BaseDatos.DatabaseName;
             Query1.Close;
             Query1.SQL.Clear;
             Query1.SQL.Add(' SELECT * FROM CARTERA ' +
                            ' WHERE COD_ZON = ' + IntToStr(Zona) +
                            ' AND COD_CLI = ' + IntToStr(Cliente) +
                            ' AND FCO_REC IS NULL ' +
                            ' ORDER BY COD_ZON, COD_CLI, ANO_REC, PER_REC');
             Query1.Open;
             Referencia.Caption:=IntToStr(Zona) + '/' + IntToStr(Cliente);
             try
                QAux:=TQuery.Create(Self);
                With QAux do
                begin
                     DatabaseName:=MBaseDatos.BaseDatos.DatabaseName;
                     SQL.Add(' SELECT * FROM CLIENTES ' +
                             ' WHERE COD_ZON = ' + IntToStr(Zona) +
                             ' AND COD_CLI = ' +  IntToStr(Cliente));
                     Open;
                     NomCliente.Caption:=UpperCase(FieldByName('TIT_CLI').AsString);
                     Direccion1.Caption:=UpperCase(FieldByName('DOM_CLI').AsString);
                     CPostal:=FieldByName('COD_POB').AsInteger;
                     Close;
                 end;
             finally
                    FreeAndNil(QAux);
             end;
             Prepare;           //Preparamos
             NumPaginas:=Carta1.QRPrinter.PageCount;  //Numero Total de Paginas
             //Preview;         //Previsualizamos
             Print;             //Imprimimos directamente en impresora

             Query1.Close;
        end;
     finally
            FreeAndNil(Carta1);
     end;
end;

//------------------ LISTADO PRIMERA CARTA DE NOTIFICACION ---------------------
procedure TFInformes.Listado2(Zona, Cliente: Integer);
     Var
        Carta2: TQRCarta2;
        QAux: TQuery;
        Ano, Mes, Dia: Word;
        CPostal: Integer;
        Suministro1, Suministro2: String;
begin
     try
        Carta2:=TQRCarta2.Create(Self);
        with Carta2 do
        begin
             Query1.DatabaseName:=MBaseDatos.BaseDatos.DatabaseName;
             Query1.SQL.Clear;
             Query1.SQL.Add(' SELECT COD_REC, COD_ZON, COD_CLI, ANO_REC, PER_REC, FCO_REC, TOT_REC ' +
                            ' FROM CARTERA ' +
                            ' WHERE COD_ZON = ' + IntToStr(Zona) +
                            ' AND COD_CLI = ' + IntToStr(Cliente) +
                            ' AND FCO_REC IS NULL ' +
                            ' ORDER BY COD_ZON, COD_CLI, ANO_REC, PER_REC');
             Query1.Open;
             DecodeDate(Date(),Ano, Mes, Dia);
             QRLabel1.Caption:='Busot, ' +
                               IntToStr(Dia) +
                               ' de ' +
                               MonthToStr(Mes) +
                               ' de ' +
                               IntToStr(Ano);
             Referencia.Caption:=IntToStr(Zona) + '/' + IntToStr(Cliente);
             try
                QAux:=TQuery.Create(Self);
                With QAux do
                begin
                     DatabaseName:=MBaseDatos.BaseDatos.DatabaseName;
                     SQL.Add(' SELECT * FROM CLIENTES ' +
                             ' WHERE COD_ZON = ' + IntToStr(Zona) +
                             ' AND COD_CLI = ' +  IntToStr(Cliente));
                     Open;
                     NomCliente.Caption:=UpperPrimerasLetras(FieldByName('TIT_CLI').AsString);
                     LetraContrato.Caption:=UpperPrimerasLetras(FieldByName('LET_CLI').AsString + '-' +
                                                                FieldByName('CON_CLI').AsString);
                     //Direccion Suministro
                     Suministro1:=FieldByName('DOM_CLI').AsString;
                     CPostal:=FieldByName('COD_POB').AsInteger;
                     Close;
                     SQL.Clear;
                     SQL.Add(' SELECT * FROM POBLACIONES ' +
                             ' WHERE COD_POB = ' + IntToStr(CPostal));
                     Open;
                     Suministro2:=RellenarCeros(IntToStr(CPostal),5,'I') + ' ' +
                                  FieldByName('TIT_POB').AsString;
                     DirSuministro.Caption:=UpperPrimerasLetras(Suministro1 + ', ' +
                                                                FieldByName('TIT_POB').AsString + ':');
                     Close;
                     if cFiscal.Checked=True then   //Direccion Fiscal
                     begin
                          SQL.Clear;
                          SQL.Add(' SELECT * FROM DOMICILIOS ' +
                                  ' WHERE COD_ZON = '  + IntToStr(Zona) +
                                  ' AND COD_CLI = ' +  IntToStr(Cliente));
                          Open;
                          Direccion1.Caption:=UpperPrimerasLetras(FieldByName('DOM_DOM').AsString);
                          Direccion2.Caption:=UpperPrimerasLetras(RellenarCeros(IntToStr(FieldByName('COD_POBD').AsInteger),5,'I') + ' ' +
                                                                  FieldByName('TIT_POBD').AsString);
                     end
                     else
                     begin
                          Direccion1.Caption:=UpperPrimerasLetras(Suministro1);
                          Direccion2.Caption:=UpperPrimerasLetras(Suministro2);
                     end;
                     Close;
                     //Contamos el numero de detalles
                     SQL.Clear;
                     SQL.Add(' SELECT COUNT(*) AS NDetalles FROM CARTERA ' +
                             ' WHERE COD_ZON = ' + IntToStr(Zona) +
                             ' AND COD_CLI = ' + IntToStr(Cliente) +
                             ' AND FCO_REC IS NULL ');
                     Open;
                     NumTotalDetalles:=FieldByName('NDetalles').AsInteger;
                     Close;
                  end
             Finally
                    FreeAndNil(QAux);
             end;
             Print;
             //Preview;           //Previsualizamos
             Query1.Close;
        end;
     finally
            FreeAndNil(Carta2);
     end;
end;

//------------------ LISTADO PRIMERA CARTA DE NOTIFICACION ---------------------
procedure TFInformes.Listado2Bis(Zona, Cliente: Integer);
     Var
        Carta2: TQRCarta2Bis;
        QAux: TQuery;
        Ano, Mes, Dia: Word;
        CPostal: Integer;
        Suministro1, Suministro2: String;
begin
     try
        Carta2:=TQRCarta2Bis.Create(Self);
        with Carta2 do
        begin
             Query1.DatabaseName:=MBaseDatos.BaseDatos.DatabaseName;
             Query1.SQL.Clear;
             Query1.SQL.Add(' SELECT COD_REC, COD_ZON, COD_CLI, ANO_REC, PER_REC, FCO_REC, TOT_REC ' +
                            ' FROM CARTERA ' +
                            ' WHERE COD_ZON = ' + IntToStr(Zona) +
                            ' AND COD_CLI = ' + IntToStr(Cliente) +
                            ' AND FCO_REC IS NULL ' +
                            ' ORDER BY COD_ZON, COD_CLI, ANO_REC, PER_REC');
             Query1.Open;
             DecodeDate(Date(),Ano, Mes, Dia);
             QRLabel1.Caption:='Busot, ' +
                               IntToStr(Dia) +
                               ' de ' +
                               MonthToStr(Mes) +
                               ' de ' +
                               IntToStr(Ano);
             Referencia.Caption:=IntToStr(Zona) + '/' + IntToStr(Cliente);
             try
                QAux:=TQuery.Create(Self);
                With QAux do
                begin
                     DatabaseName:=MBaseDatos.BaseDatos.DatabaseName;
                     SQL.Add(' SELECT * FROM CLIENTES ' +
                             ' WHERE COD_ZON = ' + IntToStr(Zona) +
                             ' AND COD_CLI = ' +  IntToStr(Cliente));
                     Open;
                     NomCliente.Caption:=UpperPrimerasLetras(FieldByName('TIT_CLI').AsString);
                     LetraContrato.Caption:=UpperPrimerasLetras(FieldByName('LET_CLI').AsString + '-' +
                                                                FieldByName('CON_CLI').AsString);
                     //Direccion Suministro
                     Suministro1:=FieldByName('DOM_CLI').AsString;
                     CPostal:=FieldByName('COD_POB').AsInteger;
                     Close;
                     SQL.Clear;
                     SQL.Add(' SELECT * FROM POBLACIONES ' +
                             ' WHERE COD_POB = ' + IntToStr(CPostal));
                     Open;
                     Suministro2:=RellenarCeros(IntToStr(CPostal),5,'I') + ' ' +
                                  FieldByName('TIT_POB').AsString;
                     DirSuministro.Caption:=UpperPrimerasLetras(Suministro1 + ', ' +
                                            FieldByName('TIT_POB').AsString + ':');
                     Close;
                     if cFiscal.Checked=True then   //Direccion Fiscal
                     begin
                          SQL.Clear;
                          SQL.Add(' SELECT * FROM DOMICILIOS ' +
                                  ' WHERE COD_ZON = '  + IntToStr(Zona) +
                                  ' AND COD_CLI = ' +  IntToStr(Cliente));
                          Open;
                          Direccion1.Caption:=UpperPrimerasLetras(FieldByName('DOM_DOM').AsString);
                          Direccion2.Caption:=UpperPrimerasLetras(RellenarCeros(IntToStr(FieldByName('COD_POBD').AsInteger),5,'I') + ' ' +
                                                                  FieldByName('TIT_POBD').AsString);
                     end
                     else
                     begin
                          Direccion1.Caption:=UpperPrimerasLetras(Suministro1);
                          Direccion2.Caption:=UpperPrimerasLetras(Suministro2);
                     end;
                     Close;
                     //Contamos el numero de detalles
                     SQL.Clear;
                     SQL.Add(' SELECT COUNT(*) AS NDetalles FROM CARTERA ' +
                             ' WHERE COD_ZON = ' + IntToStr(Zona) +
                             ' AND COD_CLI = ' + IntToStr(Cliente) +
                             ' AND FCO_REC IS NULL ');
                     Open;
                     NumTotalDetalles:=FieldByName('NDetalles').AsInteger;
                     Close;
                  end
             Finally
                    FreeAndNil(QAux);
             end;
             Print;
             //Preview;           //Previsualizamos
             Query1.Close;
        end;
     finally
            FreeAndNil(Carta2);
     end;
end;

//------------------ LISTADO SEGUNDA CARTA DE NOTIFICACION ---------------------
procedure TFInformes.Listado3(Zona, Cliente: Integer);
     Var
        Carta3: TQRCarta3;
        QAux: TQuery;
        Ano, Mes, Dia: Word;
        CPostal: Integer;
        Suministro1, Suministro2: String;
        Domicilio: String;
begin
     try
        Carta3:=TQRCarta3.Create(Self);
        with Carta3 do
        begin
             Query1.DatabaseName:=MBaseDatos.BaseDatos.DatabaseName;
             Query1.SQL.Clear;
             Query1.SQL.Add(' SELECT COD_REC, COD_ZON, COD_CLI, ANO_REC, PER_REC, FCO_REC, TOT_REC ' +
                            ' FROM CARTERA ' +
                            ' WHERE COD_ZON = ' + IntToStr(Zona) +
                            ' AND COD_CLI = ' + IntToStr(Cliente) +
                            ' AND FCO_REC IS NULL ' +
                            ' ORDER BY COD_ZON, COD_CLI, ANO_REC, PER_REC');
             Query1.Open;
             DecodeDate(Date(),Ano, Mes, Dia);
             QRLabel1.Caption:='Busot, ' +
                               IntToStr(Dia) +
                               ' de ' +
                               MonthToStr(Mes) +
                               ' de ' +
                               IntToStr(Ano) + '.';
            try
                QAux:=TQuery.Create(Self);
                With QAux do
                begin
                     DatabaseName:=MBaseDatos.BaseDatos.DatabaseName;
                     SQL.Add(' SELECT * FROM CLIENTES ' +
                             ' WHERE COD_ZON = ' + IntToStr(Zona) +
                             ' AND COD_CLI = ' +  IntToStr(Cliente));
                     Open;

                     Texto.Lines.Add('usuario D. ' +
                                     UpperPrimerasLetras(RellenarBlancos(Copy(FieldByName('TIT_CLI').AsString,1,30),30,'D')) +
                                     ', con domicilio en');
                     Texto2.Lines.Add('acuse de  recibo  a ' +
                                      UpperPrimerasLetras(RellenarBlancos(Copy(FieldByName('TIT_CLI').AsString,1,30),30,'D')) +
                                      '  a fin de');
                     //Direccion de suministro
                     Domicilio:=FieldByName('DOM_CLI').AsString;
                     CPostal:=FieldByName('COD_POB').AsInteger;
                     Close;
                     SQL.Clear;
                     SQL.Add(' SELECT * FROM POBLACIONES ' +
                             ' WHERE COD_POB = ' + IntToStr(CPostal));
                     Open;
                     Texto.Lines.Add(RellenarBlancos(UpperPrimerasLetras(Copy(Domicilio + ', ' + FieldByName('TIT_POB').AsString ,1,45)),45,'D') +
                                     ', por no haber');
                     Texto.Lines.Add('satisfecho los siguientes recibos:');
                     Close;
                     SQL.Clear;
                     SQL.Add(' SELECT COUNT(*) AS NDetalles FROM CARTERA ' +
                             ' WHERE COD_ZON = ' + IntToStr(Zona) +
                             ' AND COD_CLI = ' + IntToStr(Cliente) +
                             ' AND FCO_REC IS NULL ');
                     Open;
                     NumTotalDetalles:=FieldByName('NDetalles').AsInteger;
                     Close;
                  end
             Finally
                    FreeAndNil(QAux);
             end;
             Print;
             //Preview;           //Previsualizamos
             Query1.Close;
        end;
     finally
            FreeAndNil(Carta3);
     end;

end;

procedure TFInformes.cEmpresaChange(Sender: TObject);
begin
  if MBaseDatos.Basedatos.Connected then
    MBaseDatos.Basedatos.Close;
  MBaseDatos.CargarParametrosBaseDatos(CEmpresa.Items[CEmpresa.ItemIndex]);

end;

procedure TFInformes.cEmpresaEnter(Sender: TObject);
begin
     cEmpresa.Color:=clMoneyGreen;
end;

procedure TFInformes.cEmpresaExit(Sender: TObject);
begin
     cEmpresa.Color:=clWindow;
end;

procedure TFInformes.FormCreate(Sender: TObject);
var
  iniFile: TIniFile;
  sections: TStringList;
  databaseIterator: Integer;
begin
FInformes:=Self;
  iniFile := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\aguas.ini') ;
  sections := TStringList.Create;
  iniFile.ReadSections(sections);
  try
    for databaseIterator := 0 to sections.Count - 1 do
    begin
      cEmpresa.Items.add(iniFile.ReadString(sections[databaseIterator],'DATABASE NAME',''));
    end;
  finally
    sections.Free;
    iniFile.Free;
  end;
end;

end.
