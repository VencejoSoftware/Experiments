unit test;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  TArrayEnumerator<T> = class(TInterfacedObject, IUnknown)
  type
    TArray = Array of T;
  private
    _CurrentIndex: Integer;
    _Array: TArray;
  public
    function MoveNext: Boolean;
    function GetCurrent: T;
    constructor Create(const Items: TArray);
    property Current: T read GetCurrent;
  end;

  TArrayEnumerable<T> = record
  private
    _Array: TArrayEnumerator<T>.TArray;
    function OpenArrayToArray(const Items: array of T): TArrayEnumerator<T>.TArray;
  public
    function GetEnumerator: TArrayEnumerator<T>;
    function IndexOf(const aItem: T): Integer;
    function Exists(const aItem: T): Boolean;
    class function New(const Items: array of T): TArrayEnumerable<T>; static;
  end;

type
  TTestEnum = (ItemA, ItemB, ItemC, ItemD, ItemF, ItemG, ItemH, ItemI, ItemJ, ItemK);

procedure TForm1.FormCreate(Sender: TObject);
var
  EnumItem: TTestEnum;
begin
  ShowMessage(BoolToStr(TArrayEnumerable<TTestEnum>.New([ItemA, ItemJ, ItemK, ItemC]).Exists(ItemC), true));
  for EnumItem in TArrayEnumerable<TTestEnum>.New(TArrayEnumerable<TTestEnum>.New([])
    .OpenArrayToArray([ItemA, ItemJ, ItemK, ItemC, ItemH])) do
  begin
    case EnumItem of
      ItemJ, ItemH:
        Caption := 'a';
    else
      Caption := 'b';
    end;
  end;
end;

function TArrayEnumerator<T>.GetCurrent: T;
begin
  Result := _Array[_CurrentIndex];
end;

function TArrayEnumerator<T>.MoveNext: Boolean;
begin
  Result := _CurrentIndex < High(_Array);
  if Result then
    Inc(_CurrentIndex);
end;

constructor TArrayEnumerator<T>.Create(const Items: TArray);
begin
  inherited Create;
  _CurrentIndex := - 1;
  _Array := Items;
end;

function TArrayEnumerable<T>.IndexOf(const aItem: T): Integer;
var
  i: Integer;
begin
  Result := - 1;
  for i := 0 to High(_Array) do
    if CompareMem(@_Array[i], @aItem, 1) then
    begin
      Result := i;
      Break;
    end;
end;

function TArrayEnumerable<T>.Exists(const aItem: T): Boolean;
begin
  Result := IndexOf(aItem) > - 1;
end;

function TArrayEnumerable<T>.GetEnumerator: TArrayEnumerator<T>;
begin
  Result := TArrayEnumerator<T>.Create(_Array);
end;

function TArrayEnumerable<T>.OpenArrayToArray(const Items: array of T): TArrayEnumerator<T>.TArray;
var
  i: Integer;
begin
  SetLength(Result, Length(Items));
  for i := 0 to High(Items) do
    Result[i] := Items[i];
end;

class function TArrayEnumerable<T>.New(const Items: array of T): TArrayEnumerable<T>;
begin
  Result._Array := Result.OpenArrayToArray(Items);
end;

end.
