unit uColor.RGB.Contrast;

interface

uses
  uMath.Bytes,
  uColor.RGB.Intf;

type
  TRGBContrast = class(TInterfacedObject, IRGB)
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

function TRGBContrast.Red: Byte;
var
  Calc: SmallInt;
begin
  Calc := Round(((127 - _RGB.Red) * _Amount) / 255);
  if (_RGB.Red > 127) then
    Result := RangeByte(_RGB.Red + Calc)
  else
    Result := RangeByte(_RGB.Red - Calc);
end;

function TRGBContrast.Green: Byte;
var
  Calc: SmallInt;
begin
  Calc := Round(((127 - _RGB.Green) * _Amount) / 255);
  if (_RGB.Green > 127) then
    Result := RangeByte(_RGB.Green + Calc)
  else
    Result := RangeByte(_RGB.Green - Calc);
end;

function TRGBContrast.Blue: Byte;
var
  Calc: SmallInt;
begin
  Calc := Round(((127 - _RGB.Blue) * _Amount) / 255);
  if (_RGB.Blue > 127) then
    Result := RangeByte(_RGB.Blue + Calc)
  else
    Result := RangeByte(_RGB.Blue - Calc);
end;

function TRGBContrast.Alpha: Byte;
begin
  Result := _RGB.Alpha;
end;

constructor TRGBContrast.Create(const RGB: IRGB; const Amount: Byte);
begin
  _RGB := RGB;
  _Amount := Amount;
end;

class function TRGBContrast.New(const RGB: IRGB; const Amount: Byte): IRGB;
begin
  Result := Create(RGB, Amount);
end;

end.
