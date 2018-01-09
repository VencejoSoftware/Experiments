unit uColor.RGBFromColor;

interface

uses
  Graphics,
  uColor.RGB,
  uColor.RGB.Intf;

type
  TRGBFromColor = class(TInterfacedObject, IRGB)
  private
    _RGB: IRGB;
  public
    function Red: Byte;
    function Green: Byte;
    function Blue: Byte;
    function Alpha: Byte;

    constructor Create(const Color: TColor);

    class function New(const Color: TColor): IRGB;
  end;

implementation

function TRGBFromColor.Alpha: Byte;
begin
  Result := _RGB.Alpha;
end;

function TRGBFromColor.Red: Byte;
begin
  Result := _RGB.Red;
end;

function TRGBFromColor.Green: Byte;
begin
  Result := _RGB.Green;
end;

function TRGBFromColor.Blue: Byte;
begin
  Result := _RGB.Blue;
end;

constructor TRGBFromColor.Create(const Color: TColor);
var
  SysColor: Longint;
begin
  SysColor := Graphics.ColorToRGB(Color);
  _RGB := TRGB.New(Byte(SysColor), Byte(SysColor shr 8), Byte(SysColor shr 16), 255);
end;

class function TRGBFromColor.New(const Color: TColor): IRGB;
begin
  Result := TRGBFromColor.Create(Color);
end;

end.
