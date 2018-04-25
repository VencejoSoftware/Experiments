unit Grid.ColumnIndexed;

interface

uses
  Generics.Collections,
  Grid.Column;

type
  IColumnIndexed = interface(IColumn)
    ['{CE26637F-EE2A-4169-8EB7-58C4D851104F}']
    function Index: Cardinal;
  end;

  TColumnIndexed = class sealed(TInterfacedObject, IColumnIndexed)
  strict private
    _Index: Cardinal;
    _Column: IColumn;
  public
    function Index: Cardinal;
    function Width: Cardinal;
    constructor Create(const Index: Cardinal; const Column: IColumn);
    class function New(const Index: Cardinal; const Column: IColumn): IColumnIndexed;
  end;

  TColumnIndexedList = class sealed(TList<IColumnIndexed>)
  public
    function AddColumn(const Column: IColumn): Cardinal;
  end;

implementation

function TColumnIndexed.Index: Cardinal;
begin
  Result := _Index;
end;

function TColumnIndexed.Width: Cardinal;
begin
  Result := _Column.Width;
end;

constructor TColumnIndexed.Create(const Index: Cardinal; const Column: IColumn);
begin
  _Index := Index;
  _Column := Column;
end;

class function TColumnIndexed.New(const Index: Cardinal; const Column: IColumn): IColumnIndexed;
begin
  Result := TColumnIndexed.Create(Index, Column);
end;

{ TColumnIndexedList }

function TColumnIndexedList.AddColumn(const Column: IColumn): Cardinal;
begin
  inherited Add(TColumnIndexed.New(Count, Column));
  Result := Count;
end;

end.
