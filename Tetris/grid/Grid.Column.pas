unit Grid.Column;

interface

uses
  Generics.Collections;

type
  IColumn = interface
    ['{CBE8A6D6-12EA-4B8A-BAF1-1AA5F98F8238}']
    function Width: Cardinal;
  end;

  TColumn = class sealed(TInterfacedObject, IColumn)
  strict private
    _Width: Cardinal;
  public
    function Width: Cardinal;
    constructor Create(const Width: Cardinal);
    class function New(const Width: Cardinal): IColumn;
  end;

  TColumnList = class sealed(TList<IColumn>)
  public
    function ColumnIndex(const Column: IColumn): Integer;
  end;

implementation

function TColumn.Width: Cardinal;
begin
  Result := _Width;
end;

constructor TColumn.Create(const Width: Cardinal);
begin
  _Width := Width;
end;

class function TColumn.New(const Width: Cardinal): IColumn;
begin
  Result := TColumn.Create(Width);
end;

{ TColumnList }

function TColumnList.ColumnIndex(const Column: IColumn): Integer;
var
  Item: IColumn;
  Founded: Boolean;
begin
  Result := -1;
  for Item in Self do
  begin
    Founded := Column = Item;
    if Founded then
      Break
    else
      Inc(Result);
  end;
  if not Founded then
    Result := - 1;
end;

end.
