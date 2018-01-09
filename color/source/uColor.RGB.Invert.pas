unit uColor.RGB.Invert;

interface

uses
  uColor.RGB.Intf;

type
  TRGBInvert = class(TInterfacedObject, IRGB)
  private
    _RGB: IRGB;
  public
    function Red: Byte;
    function Green: Byte;
    function Blue: Byte;
    function Alpha: Byte;

    constructor Create(const RGB: IRGB);

    class function New(const RGB: IRGB): IRGB;
  end;

implementation

function TRGBInvert.Red: Byte;
begin
  Result := not _RGB.Red;
end;

function TRGBInvert.Green: Byte;
begin
  Result := not _RGB.Green;
end;

function TRGBInvert.Blue: Byte;
begin
  Result := not _RGB.Blue;
end;

function TRGBInvert.Alpha: Byte;
begin
  Result := _RGB.Alpha;
end;

constructor TRGBInvert.Create(const RGB: IRGB);
begin
  _RGB := RGB;
end;

class function TRGBInvert.New(const RGB: IRGB): IRGB;
begin
  Result := TRGBInvert.Create(RGB);
end;

end.
