unit ooColor;

interface

uses
  Graphics;

type
  _TColor = Graphics.TColor;

  IColor = interface
    ['{EC67056A-6D68-4337-A01C-9F20A74B9D77}']
    function AsTColor: _TColor;
  end;

  TColor = class sealed(TInterfacedObject, IColor)
  strict private
    _Color: _TColor;
  public
    function AsTColor: _TColor;
    constructor Create(const Color: _TColor);
    class function New(const Color: _TColor): IColor;
  end;

implementation

function TColor.AsTColor: _TColor;
begin
  Result := _Color;
end;

constructor TColor.Create(const Color: _TColor);
begin
  _Color := Color;
end;

class function TColor.New(const Color: _TColor): IColor;
begin
  Result := TColor.Create(Color);
end;

end.
