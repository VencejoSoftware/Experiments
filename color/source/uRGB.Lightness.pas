unit uRGB.Lightness;

interface

uses
  uRGB.Intf;

type
  TRGBLightness = class(TInterfacedObject, IRGB)
  private
    _RGB: IRGB;
    _Amount: Byte;
  public
    function Red: Byte;
    function Green: Byte;
    function Blue: Byte;
    function Alpha: Byte;

    constructor Create(const RGB: IRGB; const Amount: Byte);

    class function New(const RGB: IRGB; const Amount: Byte): IRGB;
  end;

implementation

function TRGBLightness.Red: Byte;
begin
  Result := (_RGB.Red + ((255 - _RGB.Red) * _Amount) div 255);
end;

function TRGBLightness.Green: Byte;
begin
  Result := (_RGB.Green + ((255 - _RGB.Green) * _Amount) div 255);
end;

function TRGBLightness.Blue: Byte;
begin
  Blue := (_RGB.Blue + ((255 - _RGB.Blue) * _Amount) div 255);
end;

function TRGBLightness.Alpha: Byte;
begin
  Result := _RGB.Alpha;
end;

constructor TRGBLightness.Create(const RGB: IRGB; const Amount: Byte);
begin
  _RGB := RGB;
  _Amount := Amount;
end;

class function TRGBLightness.New(const RGB: IRGB; const Amount: Byte): IRGB;
begin
  Result := Create(RGB, Amount);
end;

end.
