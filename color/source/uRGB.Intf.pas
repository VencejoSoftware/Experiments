unit uRGB.Intf;

interface

type
  IRGB = interface
    ['{20366090-BECC-4227-A4CD-778A6C36DB85}']
    function Red: Byte;
    function Green: Byte;
    function Blue: Byte;
    function Alpha: Byte;
  end;

implementation

end.
