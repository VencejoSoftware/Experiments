unit ooRectSize;

interface

type
  IRectSize = interface
    ['{3C33E491-B0D1-4C11-A010-D3664DA2EFBF}']
    function Width: Integer;
    function Height: Integer;
  end;

  TRectSize = class sealed(TInterfacedObject, IRectSize)
  strict private
    _Height, _Width: Integer;
  public
    function Width: Integer;
    function Height: Integer;
    constructor Create(const Width, Height: Integer);
    class function New(const Width, Height: Integer): IRectSize;
    class function NewDefault: IRectSize;
  end;

implementation

function TRectSize.Width: Integer;
begin
  Result := _Width;
end;

function TRectSize.Height: Integer;
begin
  Result := _Height;
end;

constructor TRectSize.Create(const Width, Height: Integer);
begin
  _Height := Height;
  _Width := Width;
end;

class function TRectSize.New(const Width, Height: Integer): IRectSize;
begin
  Result := TRectSize.Create(Width, Height);
end;

class function TRectSize.NewDefault: IRectSize;
begin
  Result := TRectSize.New(1, 1);
end;

end.
