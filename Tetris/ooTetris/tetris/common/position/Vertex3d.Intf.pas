unit Vertex3d.Intf;

interface

uses
  Vertex.Intf, Vertex2d.Intf;

type
  IVertex3d = interface(IVertex2d)
    ['{6198B2FB-E6AD-469B-AEB2-D8725B0E9F32}']
    function Z: TVertexValue;

    procedure MoveZ(const aZ: TVertexValue);
  end;

implementation

end.
