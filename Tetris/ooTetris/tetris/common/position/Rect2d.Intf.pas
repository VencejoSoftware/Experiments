unit Rect2d.Intf;

interface

uses
  Vertex.Intf;

type
  IRect2d = interface
    ['{33E831F8-47FC-4CD5-A195-229B09CFC312}']
    function Left: TVertexValue;
    function Top: TVertexValue;
    function Right: TVertexValue;
    function Bottom: TVertexValue;

    procedure ChangeLeft(const aLeft: TVertexValue);
    procedure ChangeTop(const aTop: TVertexValue);
    procedure ChangeRight(const aRight: TVertexValue);
    procedure ChangeBottom(const aBottom: TVertexValue);
  end;

implementation

end.
