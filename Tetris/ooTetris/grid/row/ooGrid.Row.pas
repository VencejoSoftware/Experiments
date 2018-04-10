unit ooGrid.Row;

interface

uses
  ooEventHub.Event;

type
  IGridRow = interface
    ['{D6ED43EE-8A97-4F5E-972F-0BD398744151}']
    function Height: Integer;
  end;

  TGridRow = class sealed(TInterfacedObject, IGridRow)
  strict private
    _Height: Integer;
  public
    function Height: Integer;
    constructor Create(const Height: Integer);
    class function New(const Height: Integer): IGridRow;
  end;

  TEventRow = TEvent<IGridRow>;

implementation

function TGridRow.Height: Integer;
begin
  Result := _Height;
end;

constructor TGridRow.Create(const Height: Integer);
begin
  _Height := Height;
end;

class function TGridRow.New(const Height: Integer): IGridRow;
begin
  Result := TGridRow.Create(Height);
end;

end.
