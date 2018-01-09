unit uHSV.Intf;

interface

type
  IHSV = interface
    ['{E656BC07-8193-4C38-8916-9E584B5788B2}']
    function Hue: Double;
    function Saturation: Double;
    function Value: Double;
  end;

implementation

end.
