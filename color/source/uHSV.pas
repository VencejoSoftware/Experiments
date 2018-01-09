unit uHSV;

interface

uses
  uHSV.Intf;

type
  THSV = class(TInterfacedObject, IHSV)
  private
    _Hue: Double;
    _Saturation: Double;
    _Value: Double;
  public
    function Hue: Double;
    function Saturation: Double;
    function Value: Double;

    constructor Create(const Hue, Saturation, Value: Double);

    class function New(const Hue, Saturation, Value: Double): IHSV;
  end;

implementation

function THSV.Hue: Double;
begin
  Result := _Hue;
end;

function THSV.Saturation: Double;
begin
  Result := _Saturation;
end;

function THSV.Value: Double;
begin
  Result := _Value;
end;

constructor THSV.Create(const Hue, Saturation, Value: Double);
begin
  _Hue := Hue;
  _Saturation := Saturation;
  _Value := Value;
end;

class function THSV.New(const Hue, Saturation, Value: Double): IHSV;
begin
  Result := THSV.Create(Hue, Saturation, Value);
end;

end.
