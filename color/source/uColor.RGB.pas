unit uColor.RGB;

interface

uses
  uColor.RGB.Intf;

type
  TRGB = class(TInterfacedObject, IRGB)
  private
    _Red: Byte;
    _Green: Byte;
    _Blue: Byte;
    _Alpha: Byte;
  public
    function Red: Byte;
    function Green: Byte;
    function Blue: Byte;
    function Alpha: Byte;

    constructor Create(const Red, Green, Blue: Byte; const Alpha: Byte = 255);

    class function New(const Red, Green, Blue: Byte; const Alpha: Byte = 255): IRGB;
  end;

implementation

function TRGB.Alpha: Byte;
begin
  Result := _Alpha;
end;

function TRGB.Red: Byte;
begin
  Result := _Red;
end;

function TRGB.Green: Byte;
begin
  Result := _Green;
end;

function TRGB.Blue: Byte;
begin
  Result := _Blue;
end;

constructor TRGB.Create(const Red, Green, Blue: Byte; const Alpha: Byte = 255);
begin
  _Red := Red;
  _Green := Green;
  _Blue := Blue;
  _Alpha := Alpha;
end;

class function TRGB.New(const Red, Green, Blue: Byte; const Alpha: Byte = 255): IRGB;
begin
  Result := TRGB.Create(Red, Green, Blue, Alpha);
end;

end.
