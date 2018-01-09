unit ooSize;

interface

type
  ISize = interface
    ['{D14BF9E0-441F-4CEB-8682-8FF973B85575}']
    function Width: Cardinal;
    function Height: Cardinal;
  end;

  TSize = class sealed(TInterfacedObject, ISize)
  strict private
    _Width, _Height: Cardinal;
  public
    function Width: Cardinal;
    function Height: Cardinal;
    constructor Create(const Width, Height: Cardinal);
    class function New(const Width, Height: Cardinal): ISize;
    class function NewDefault: ISize;
  end;

implementation

function TSize.Width: Cardinal;
begin
  Result := _Width;
end;

function TSize.Height: Cardinal;
begin
  Result := _Height;
end;

constructor TSize.Create(const Width, Height: Cardinal);
begin
  _Width := Width;
  _Height := Height;
end;

class function TSize.New(const Width, Height: Cardinal): ISize;
begin
  Result := TSize.Create(Width, Height);
end;

class function TSize.NewDefault: ISize;
begin
  Result := TSize.New(1, 1);
end;

end.
