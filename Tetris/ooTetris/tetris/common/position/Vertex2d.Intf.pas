unit Vertex2d.Intf;

interface

uses
  Vertex.Intf;

type
  IVertex2d = interface(IVertex)
    ['{33E831F8-47FC-4CD5-A195-229B09CFC312}']
    function X: TVertexValue;
    function Y: TVertexValue;

    procedure MoveX(const aX: TVertexValue);
    procedure MoveY(const aY: TVertexValue);
  end;

implementation

end.
