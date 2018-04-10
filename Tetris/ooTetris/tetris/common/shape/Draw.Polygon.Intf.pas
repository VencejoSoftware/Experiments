unit Draw.Polygon.Intf;

interface

uses
  Vertex.Intf,
  Vertex.List;

type
  IPolygon<T: IVertex> = interface
    ['{2CE9A94C-E3A1-4819-B489-7486D751987C}']
    function GetVertexList: TVertexList<T>;

    procedure SetVertexList(const aVertexList: TVertexList<T>);
  end;

implementation

end.
