unit uRGB.Darkness;

interface

uses
  uRGB.Intf;

type
  TRGBDarkness = class(TInterfacedObject, IRGB)
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

function TRGBDarkness.Red: Byte;
begin
  Red := (_RGB.Red - (_RGB.Red * _Amount) div 255);
end;

function TRGBDarkness.Green: Byte;
begin
  Green := (_RGB.Green - (_RGB.Green * _Amount) div 255);
end;

function TRGBDarkness.Blue: Byte;
begin
  Blue := (_RGB.Blue - (_RGB.Blue * _Amount) div 255);
end;

function TRGBDarkness.Alpha: Byte;
begin
  Result := _RGB.Alpha;
end;

constructor TRGBDarkness.Create(const RGB: IRGB; const Amount: Byte);
begin
  _RGB := RGB;
  _Amount := Amount;
end;

class function TRGBDarkness.New(const RGB: IRGB; const Amount: Byte): IRGB;
begin
  Result := Create(RGB, Amount);
end;

end.
