unit ooPosition;

interface

type
  IPosition = interface
    ['{30397F34-39F9-433D-AE63-76DC2C334341}']
    function Left: Integer;
    function Top: Integer;
  end;

  TPosition = class sealed(TInterfacedObject, IPosition)
  strict private
    _Left, _Top: Integer;
  public
    function Left: Integer;
    function Top: Integer;
    constructor Create(const Left, Top: Integer);
    class function New(const Left, Top: Integer): IPosition;
    class function NewDefault: IPosition;
  end;

implementation

function TPosition.Left: Integer;
begin
  Result := _Left;
end;

function TPosition.Top: Integer;
begin
  Result := _Top;
end;

constructor TPosition.Create(const Left, Top: Integer);
begin
  _Left := Left;
  _Top := Top;
end;

class function TPosition.New(const Left, Top: Integer): IPosition;
begin
  Result := TPosition.Create(Left, Top);
end;

class function TPosition.NewDefault: IPosition;
begin
  Result := TPosition.New(0, 0);
end;

end.
