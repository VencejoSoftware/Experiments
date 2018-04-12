unit Draw.Fill;

interface

uses
  Graphics;

type
  TFillKind = (None, Solid);

  IFill = interface
    ['{DDF20262-0160-424F-B034-B32F29ED27CA}']
    function Color: TColor;
    function Kind: TFillKind;
  end;

  TFill = class sealed(TInterfacedObject, IFill)
  strict private
    _Color: TColor;
    _Kind: TFillKind;
  public
    function Color: TColor;
    function Kind: TFillKind;
    constructor Create(const Color: TColor; const Kind: TFillKind);
    class function New(const Color: TColor; const Kind: TFillKind): IFill;
  end;

implementation

function TFill.Color: TColor;
begin
  Result := _Color;
end;

function TFill.Kind: TFillKind;
begin
  Result := _Kind;
end;

constructor TFill.Create(const Color: TColor; const Kind: TFillKind);
begin
  _Color := Color;
  _Kind := Kind;
end;

class function TFill.New(const Color: TColor; const Kind: TFillKind): IFill;
begin
  Result := TFill.Create(Color, Kind);
end;

end.
