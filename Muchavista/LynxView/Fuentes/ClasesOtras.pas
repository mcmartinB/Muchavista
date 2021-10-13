unit ClasesOtras;

interface

uses
  // Clases de delphi
  Classes, SysUtils, StdCtrls, DBTables,

  // Clases propias
  BaseDatos
  ;

type

  {TEnumItem}

  TEnumItem = class(TObject)
  private
    FIDFieldValue: Integer;
    FIDFieldValue2: String;
    FTitleField: String;
    FFieldValue: Double;
    FFieldValues: Array of Double;
    FFieldItemIndex: Integer;
    FTag: Integer;
    FEnumOther: TEnumItem;
    FFieldObject: TObject;
  private
    function GetItemsValue(Index: Integer): Double;
  private
    function GetFieldValueToStr2X: String;
    function GetFieldValueToStr3X: String;
    function GetFieldValueToStr4X: String;
  protected
  public
    constructor Create; overload;
    constructor Create(const AIDFieldValue: Integer; const ATitleField: String; const AFieldValue: Variant; const ATag: Integer = 0); overload;
    constructor Create(const AIDFieldValue2: String; const ATitleField: String; const AFieldValue: Variant; const ATag: Integer = 0); overload;
    destructor Destroy; override;
  public
    function GetEnumItem(const Items: TStrings; const ItemIndex: Integer): TEnumItem; overload;
    function GetEnumItem(const obj: TObject): TEnumItem; overload;

    function GetSearchEnumItem(const Items: TStrings; const IDFieldValueSearch: Integer; const FieldValueSearch: Double = -1): TEnumItem; overload;
    function GetSearchEnumItem(const obj: TObject; const IDFieldValueSearch: Integer; const FieldValueSearch: Double = -1): TEnumItem; overload;
    function GetSearchEnumItem(const Items: TStrings; const IDFieldValueSearch: String): TEnumItem; overload;
    function GetSearchEnumItem(const obj: TObject; const IDFieldValueSearch: String): TEnumItem; overload;

    procedure SetEnumItemFreeAndNil(AItems: TStrings); overload;
    procedure SetEnumItemFreeAndNil(Aobjs: TObject); overload;

    procedure SetEnumItemDelete(AItems: TStrings; Index: Integer); overload;
    procedure SetEnumItemDelete(Aobjs: TObject; Index: Integer); overload;
  public
    property ItemsValue[Index: Integer]: Double read GetItemsValue;
     function AddItemFieldValue(Value: Double): Double;
  public
    property IDFieldValue: Integer read FIDFieldValue write FIDFieldValue;
    property IDFieldValue2: String read FIDFieldValue2 write FIDFieldValue2;
    property TitleField: String read FTitleField write FTitleField;
    property FieldValue: Double read FFieldValue write FFieldValue;
    property FieldItemIndex: Integer read FFieldItemIndex write FFieldItemIndex;
    property FieldObject: TObject read FFieldObject write FFieldObject;
    property Tag: Integer read FTag write FTag;
  public
    property FieldValueToStr2X: String read GetFieldValueToStr2X;
    property FieldValueToStr3X: String read GetFieldValueToStr3X;
    property FieldValueToStr4X: String read GetFieldValueToStr4X;
  end;

implementation

uses
  CheckLst,
  AplicacionProcedimientosFunciones
  ;

{ TEnumItem }

constructor TEnumItem.Create;
begin
  FIDFieldValue   := -1;
  FTitleField     := '';
  FFieldValue     := 0;
  FFieldItemIndex := -1;
  FTag            := -1;
  FEnumOther      := nil;
end;

constructor TEnumItem.Create(const AIDFieldValue: Integer; const ATitleField: String; const AFieldValue: Variant; const ATag: Integer = 0);
begin
  inherited Create;
  FIDFieldValue   := AIDFieldValue;
  FTitleField     := ATitleField;
  FFieldValue     := AFieldValue;
  FTag            := ATag;
end;

constructor TEnumItem.Create(const AIDFieldValue2: String; const ATitleField: String; const AFieldValue: Variant; const ATag: Integer = 0);
begin
  inherited Create;
  FIDFieldValue2  := AIDFieldValue2;
  FTitleField     := ATitleField;
  FFieldValue     := AFieldValue;
  FTag            := ATag;
end;

destructor TEnumItem.Destroy;
begin
  inherited;
end;

function TEnumItem.GetEnumItem(const Items: TStrings; const ItemIndex: Integer): TEnumItem;
begin
  if (ItemIndex = -1) then
    Result := TEnumItem.Create(0, '', 0)
  else
    Result := (Items.Objects[ItemIndex] as TEnumItem);
end;

function TEnumItem.GetEnumItem(const obj: TObject): TEnumItem;
var
  Items: TStrings;
  ItemIndex: Integer;
begin
  ItemIndex := -1;
  Items     := nil;

  if (obj is TComboBox) then
  begin
    ItemIndex := (obj as TComboBox).ItemIndex;
    Items := (obj as TComboBox).Items;
  end;

  Result := GetEnumItem(Items, ItemIndex);
end;

function TEnumItem.GetSearchEnumItem(const Items: TStrings; const IDFieldValueSearch: Integer; const FieldValueSearch: Double): TEnumItem;
var
  I: Integer;
begin
  Result := nil;

  for I := 0 to (Items.Count -1) do
    if (Result <> nil) then
      Break
    else
      if (FieldValueSearch <> -1) then
        if ((Items.Objects[I] as TEnumItem).FieldValue = FieldValueSearch) then
        begin
          Result := (Items.Objects[I] as TEnumItem);
            Result.FieldItemIndex := I;
        end
        else
      else
        if ((Items.Objects[I] as TEnumItem).IDFieldValue = IDFieldValueSearch) then
        begin
          Result := (Items.Objects[I] as TEnumItem);
            Result.FieldItemIndex := I;
        end;

  if (Result = nil) then
    Result := TEnumItem.Create(-1, '', -1);
end;

function TEnumItem.GetSearchEnumItem(const obj: TObject; const IDFieldValueSearch: Integer; const FieldValueSearch: Double): TEnumItem;
var
  Items: TStrings;
begin
  Items := nil;

  if (obj is TComboBox) then
    Items := (obj as TComboBox).Items;

  Result := GetSearchEnumItem(Items, IDFieldValueSearch, FieldValueSearch);
end;

function TEnumItem.GetSearchEnumItem(const Items: TStrings; const IDFieldValueSearch: String): TEnumItem;
var
  I: Integer;
begin
  Result := nil;

  for I := 0 to (Items.Count -1) do
    if (Result <> nil) then
      Break
    else
      if ((Items.Objects[I] as TEnumItem).IDFieldValue2 = IDFieldValueSearch) then
      begin
        Result := (Items.Objects[I] as TEnumItem);
          Result.FieldItemIndex := I;
      end;

  if (Result = nil) then
    Result := TEnumItem.Create(' ', '', -1);
end;

function TEnumItem.GetSearchEnumItem(const obj: TObject; const IDFieldValueSearch: String): TEnumItem;
var
  Items: TStrings;
begin
  Items := nil;

  if (obj is TComboBox) then
    Items := (obj as TComboBox).Items;

  Result := GetSearchEnumItem(Items, IDFieldValueSearch);
end;

procedure TEnumItem.SetEnumItemFreeAndNil(AItems: TStrings);
var
  nI: Integer;
  EnumItem: TEnumItem;
begin
  for nI := 0 to (AItems.Count -1) do
  begin
    EnumItem := TEnumItem(AItems.Objects[nI]);
    if Assigned(EnumItem) then
    begin
      FreeAndNil(EnumItem);
      AItems.Objects[nI] := nil;
    end;
  end;
  AItems.Clear;
end;

procedure TEnumItem.SetEnumItemFreeAndNil(Aobjs: TObject);
var
  nI: Integer;
  Items: TStrings;
  EnumItem: TEnumItem;
begin
  Items := nil;
  if (Aobjs is TComboBox) then
    Items := (Aobjs as TComboBox).Items;
  if (Aobjs is TCheckListBox) then
    Items := (Aobjs as TCheckListBox).Items;
  if (Aobjs is TListBox) then
    Items := (Aobjs as TListBox).Items;

  SetEnumItemFreeAndNil(Items);

  for nI := 0 to (Items.Count -1) do
  begin
    EnumItem := TEnumItem(Items.Objects[nI]);
    if Assigned(EnumItem) then
    begin
      FreeAndNil(EnumItem);
      Items.Objects[nI] := nil;
    end;
  end;

  Items.Clear;
end;

procedure TEnumItem.SetEnumItemDelete(AItems: TStrings; Index: Integer);
var
  EnumItem: TEnumItem;
begin
  EnumItem := TEnumItem(AItems.Objects[Index]);
  FreeAndNil(EnumItem);
  AItems.Delete(Index);
end;

procedure TEnumItem.SetEnumItemDelete(Aobjs: TObject; Index: Integer);
var
  Items: TStrings;
begin
  Items := nil;
  if (Aobjs is TComboBox) then
    Items := (Aobjs as TComboBox).Items;
  if (Aobjs is TCheckListBox) then
    Items := (Aobjs as TCheckListBox).Items;
  if (Aobjs is TListBox) then
    Items := (Aobjs as TListBox).Items;

  SetEnumItemDelete(Items, Index);
end;

function TEnumItem.GetItemsValue(Index: Integer): Double;
begin
  Result := FFieldValues[Index];
end;

function TEnumItem.AddItemFieldValue(Value: Double): Double;
var
  Count: Integer;
begin
  Count := Length(FFieldValues);
  SetLength(FFieldValues, Count);
  FFieldValues[Pred(Count)] := Value;
  Result := Value;
end;

function TEnumItem.GetFieldValueToStr2X: String;
begin
  Result := StrX(Double(FFieldValue));
end;

function TEnumItem.GetFieldValueToStr3X: String;
begin
  Result := StrX(Double(FFieldValue), 3);
end;

function TEnumItem.GetFieldValueToStr4X: String;
begin
  Result := StrX(Double(FFieldValue), 4);
end;

end.
