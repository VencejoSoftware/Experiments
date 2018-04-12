unit Draw.Pencil;

interface

uses
  Graphics;

type
  TPencilPattern = (None, Solid, Dash, Dot, DashDot);

  TPencilSize = Byte;

  IPencil = interface
    ['{E45B50CF-0E54-49AA-8107-A034F9D1F054}']
    function Color: TColor;
    function Pattern: TPencilPattern;
    function Size: Byte;
  end;

  TPencil = class sealed(TInterfacedObject, IPencil)
  strict private
    _Color: TColor;
    _Pattern: TPencilPattern;
    _Size: TPencilSize;
  public
    function Color: TColor;
    function Pattern: TPencilPattern;
    function Size: Byte;
    constructor Create(const Color: TColor; const Pattern: TPencilPattern; const Size: TPencilSize);
    class function New(const Color: TColor; const Pattern: TPencilPattern; const Size: TPencilSize): IPencil;
  end;

implementation

function TPencil.Color: TColor;
begin
  Result := _Color;
end;

function TPencil.Pattern: TPencilPattern;
begin
  Result := _Pattern;
end;

function TPencil.Size: Byte;
begin
  Result := _Size;
end;

constructor TPencil.Create(const Color: TColor; const Pattern: TPencilPattern; const Size: TPencilSize);
begin
  _Color := Color;
  _Pattern := Pattern;
  _Size := Size;
end;

class function TPencil.New(const Color: TColor; const Pattern: TPencilPattern; const Size: TPencilSize): IPencil;
begin
  Result := TPencil.Create(Color, Pattern, Size);
end;

end.
