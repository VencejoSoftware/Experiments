unit uHSV.FromRGB;

interface

uses
  Graphics, Math,
  uRGB.Intf,
  uHSV.Intf, uHSV;

type
  THSVFromRGB = class(TInterfacedObject, IHSV)
  private
    _HSV: IHSV;
  public
    function Hue: Double;
    function Saturation: Double;
    function Value: Double;

    constructor Create(const RGB: IRGB);

    class function New(const RGB: IRGB): IHSV;
  end;

implementation

function THSVFromRGB.Hue: Double;
begin
  Result := _HSV.Hue;
end;

function THSVFromRGB.Saturation: Double;
begin
  Result := _HSV.Saturation;
end;

function THSVFromRGB.Value: Double;
begin
  Result := _HSV.Value;
end;

function FMod(const x, y: Double): Double;
begin
  Result := x - Int(x / y) * y;
end;

constructor THSVFromRGB.Create(const RGB: IRGB);
var
  Hue, Saturation, Value: Double;
  x, f, i: Double;
begin
  x := Min(Min(RGB.Red, RGB.Green), RGB.Blue);
  Value := Max(Max(RGB.Red, RGB.Green), RGB.Blue);
  if x = Value then
  begin
    Hue := 0;
    Saturation := 0;
  end
  else
  begin
    if RGB.Red = x then
      f := RGB.Green - RGB.Blue
    else
      if RGB.Green = x then
        f := RGB.Blue - RGB.Red
      else
        f := RGB.Red - RGB.Green;
    if RGB.Red = x then
      i := 3
    else
      if RGB.Green = x then
        i := 5
      else
        i := 1;
    Hue := FMod((i - f / (Value - x)) * 60, 360);
    Saturation := ((Value - x) / Value);
  end;
  _HSV := THSV.New(h, s, v);
end;

class function THSVFromRGB.New(const RGB: IRGB): IHSV;
begin
  Result := THSVFromRGB.Create(RGB);
end;

end.
