unit uRGB.ToColor;

interface

uses
  Graphics,
  uRGB,
  uRGB.Intf;

type
  IRGBToColor = interface(IRGB)
    ['{6D5477A4-314F-46C5-A0C1-05358AF0850B}']
    function ToColor: TColor;
  end;

  TRGBToColor = class(TInterfacedObject, IRGBToColor)
  private
    _RGB: IRGB;
  public
    function Red: Byte;
    function Green: Byte;
    function Blue: Byte;
    function Alpha: Byte;
    function ToColor: TColor;

    constructor Create(const RGB: IRGB);

    class function New(const RGB: IRGB): IRGBToColor;
  end;

implementation

function TRGBToColor.Alpha: Byte;
begin
  Result := _RGB.Alpha;
end;

function TRGBToColor.Red: Byte;
begin
  Result := _RGB.Red;
end;

function TRGBToColor.Green: Byte;
begin
  Result := _RGB.Green;
end;

function TRGBToColor.Blue: Byte;
begin
  Result := _RGB.Blue;
end;

function TRGBToColor.ToColor: TColor;
begin
  Result := (Blue shl 16) or (Green shl 8) or Red;
end;

constructor TRGBToColor.Create(const RGB: IRGB);
begin
  _RGB := RGB;
end;

class function TRGBToColor.New(const RGB: IRGB): IRGBToColor;
begin
  Result := Create(RGB);
end;

end.
