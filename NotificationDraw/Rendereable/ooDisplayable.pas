unit ooDisplayable;

interface

type
  IDisplayable = interface
    ['{7E1BEF86-3933-4502-A4DA-C881BD203F86}']
    function IsVisible: Boolean;
    procedure Show;
    procedure Hide;
  end;

implementation

end.
