unit Busqueda;

interface

uses
  Contnrs;

type

  TOrden = (Ascendente, Descendente, SinEspecificar);

  TElementoBusqueda = class
  private
    Fcampo: string;
    Forden: TOrden;
    function GetOrdenCadena: string;
  public
    constructor Create( pCampo: string; pOrden: TOrden);
    destructor Destroy; override;
    property campo: string read Fcampo;
    property orden: TOrden read Forden;
    property ordenCadena: string read GetOrdenCadena;
  end;

  TBusqueda = class
  private
    ListaElementos: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    function devuelveClausulaOrder: string;
    procedure estableceOrden(pCampo: string; pOrden: TOrden);
    procedure eliminaOrden(pCampo: string);
    function devuelveOrdenCampo(pCampo: string): TOrden;
  end;

implementation

{ TBusqueda }

constructor TBusqueda.Create;
begin
  ListaElementos := TObjectList.Create;
end;

destructor TBusqueda.Destroy;
begin
  inherited;
  ListaElementos.Free;
end;

function TBusqueda.devuelveClausulaOrder: string;
var
  iteradorOrden: Integer;
begin
  Result := '';
  for iteradorOrden:= 0 to ListaElementos.Count - 1 do
    begin
      if iteradorOrden = 0 then
        Result := ' ORDER BY ';
      Result := Result + ' ' + TElementoBusqueda(ListaElementos[iteradorOrden]).Campo;
      Result := Result + ' ' + TElementoBusqueda(ListaElementos[iteradorOrden]).ordenCadena;
      if iteradorOrden < (ListaElementos.Count - 1) then
        Result := Result + ', ';
    end;
end;

function TBusqueda.devuelveOrdenCampo(pCampo: string): TOrden;
var
  iteradorOrden: Integer;
begin
  Result := SinEspecificar;
  for iteradorOrden:= 0 to ListaElementos.Count - 1 do
    begin
    if TElementoBusqueda(ListaElementos[iteradorOrden]).campo = pCampo then
      begin
      Result := TElementoBusqueda(ListaElementos[iteradorOrden]).orden;
      break;
      end;
    end;
end;

procedure TBusqueda.eliminaOrden(pCampo: string);
var
  iteradorOrden: Integer;
begin
  for iteradorOrden:= 0 to ListaElementos.Count - 1 do
    begin
    if TElementoBusqueda(ListaElementos[iteradorOrden]).campo = pCampo then
      begin
      ListaElementos.Remove(ListaElementos[iteradorOrden]);
      break;
      end;
    end;
end;

procedure TBusqueda.estableceOrden(pCampo: string; pOrden: TOrden);
var
  nuevoElemento: TElementoBusqueda;
begin
  eliminaOrden(pCampo);
  nuevoElemento := TElementoBusqueda.Create(pCampo, pOrden);
  ListaElementos.Insert(0, nuevoElemento);
end;

{ TElementoBusqueda }

constructor TElementoBusqueda.Create(pCampo: string; pOrden: TOrden);
begin
  FCampo := pCampo;
  FOrden := pOrden;
end;

destructor TElementoBusqueda.Destroy;
begin

end;

function TElementoBusqueda.GetOrdenCadena: string;
begin
  if FOrden = Ascendente then
    Result:= 'ASC'
  else
    Result:= 'DESC';
end;

end.
