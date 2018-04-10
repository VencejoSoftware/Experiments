unit ooGrid.Column;

interface

uses
  ooEventHub.Event;

type
  IGridColumn = interface
    ['{875A48F2-9843-4795-954B-4D8C7A255939}']
    function Left: Integer;
    function Width: Integer;
    procedure Move(const Left: Integer);
  end;

  TGridColumn = class sealed(TInterfacedObject, IGridColumn)
  strict private
    _Left, _Width: Integer;
  public
    function Left: Integer;
    function Width: Integer;
    procedure Move(const Left: Integer);
    constructor Create(const Width: Integer);
    class function New(const Width: Integer): IGridColumn;
  end;

  TEventColumn = TEvent<IGridColumn>;

implementation

function TGridColumn.Width: Integer;
begin
  Result := _Width;
end;

function TGridColumn.Left: Integer;
begin
  Result := _Left;
end;

procedure TGridColumn.Move(const Left: Integer);
begin
  _Left := Left;
end;

constructor TGridColumn.Create(const Width: Integer);
begin
  _Width := Width;
end;

class function TGridColumn.New(const Width: Integer): IGridColumn;
begin
  Result := TGridColumn.Create(Width);
end;

end.
