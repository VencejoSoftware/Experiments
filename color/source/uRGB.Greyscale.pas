unit uRGB.Greyscale;

interface

uses
  uRGB.Intf;

type
  TRGBGreyscale = class(TInterfacedObject, IRGB)
  private
    _RGB: IRGB;
    GrayFactor: Byte;
  public
    function Red: Byte;
    function Green: Byte;
    function Blue: Byte;
    function Alpha: Byte;

    constructor Create(const RGB: IRGB);

    class function New(const RGB: IRGB): IRGB;
  end;

implementation

function TRGBGreyscale.Red: Byte;
begin
  Result := GrayFactor;
end;

function TRGBGreyscale.Green: Byte;
begin
  Result := GrayFactor;
end;

function TRGBGreyscale.Blue: Byte;
begin
  Result := GrayFactor;
end;

function TRGBGreyscale.Alpha: Byte;
begin
  Result := _RGB.Alpha;
end;

constructor TRGBGreyscale.Create(const RGB: IRGB);
begin
  _RGB := RGB;
  GrayFactor := Round((0.30 * _RGB.Red) + (0.59 * _RGB.Green) + (0.11 * _RGB.Blue));
end;

class function TRGBGreyscale.New(const RGB: IRGB): IRGB;
begin
  Result := Create(RGB);
end;

end.
