unit Space2d.Intf;

interface

uses
  Vertex.Intf, Vertex2d.Intf,
  Space.Intf;

type
  ISpace2d = interface(ISpace<IVertex2d>)
    ['{2A027EB0-2AAB-4D58-AF39-6BEB608AA024}']
    function Left: TVertexValue;
    function Top: TVertexValue;
    function Height: TVertexValue;
    function Width: TVertexValue;

    procedure ChangeLeft(const aLeft: TVertexValue);
    procedure ChangeTop(const aTop: TVertexValue);
    procedure ChangeHeight(const aHeight: TVertexValue);
    procedure ChangeWidth(const aWidth: TVertexValue);
  end;

implementation

end.
