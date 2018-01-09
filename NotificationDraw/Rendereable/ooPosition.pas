unit ooPosition;

interface

type
  IPosition = interface
    ['{E7A927EE-022F-4ACE-9CC3-54E927E02AED}']
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
  Result := TPosition.New(1, 1);
end;

end.
