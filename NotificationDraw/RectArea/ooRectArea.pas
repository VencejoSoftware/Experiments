unit ooRectArea;

interface

type
  IRectArea = interface
    ['{C9DFBEE7-8B46-4090-A125-73B20CD98248}']
    function Left: Integer;
    function Top: Integer;
    function Right: Integer;
    function Bottom: Integer;
    function Width: Integer;
    function Height: Integer;
  end;

  TRectArea = class sealed(TInterfacedObject, IRectArea)
  strict private
    _Left, _Top, _Right, _Bottom: Integer;
  public
    function Left: Integer;
    function Top: Integer;
    function Right: Integer;
    function Bottom: Integer;
    function Width: Integer;
    function Height: Integer;
    constructor Create(const Left, Top, Right, Bottom: Integer);
    class function New(const Left, Top, Right, Bottom: Integer): IRectArea;
    class function NewEmpty: IRectArea;
  end;

implementation

function TRectArea.Bottom: Integer;
begin
  Result := _Bottom;
end;

function TRectArea.Left: Integer;
begin
  Result := _Left;
end;

function TRectArea.Right: Integer;
begin
  Result := _Right;
end;

function TRectArea.Top: Integer;
begin
  Result := _Top;
end;

function TRectArea.Width: Integer;
begin
  Result := Right - Left;
end;

function TRectArea.Height: Integer;
begin
  Result := Bottom - Top;
end;

constructor TRectArea.Create(const Left, Top, Right, Bottom: Integer);
begin
  _Left := Left;
  _Top := Top;
  _Right := Right;
  _Bottom := Bottom;
end;

class function TRectArea.New(const Left, Top, Right, Bottom: Integer): IRectArea;
begin
  Result := TRectArea.Create(Left, Top, Right, Bottom);
end;

class function TRectArea.NewEmpty: IRectArea;
begin
  Result := TRectArea.New(0, 0, 0, 0)
end;

end.
