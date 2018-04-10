unit Space.Intf;

interface

uses
  Vertex.Intf, Vertex.List;

type
  ISpace<T: IVertex> = interface
    ['{B1346CA4-FD01-4B1E-BF00-FBF0DEFE6C5C}']
    function VertexList: TVertexList<T>;
    function IsVertexInside(const aVertex: T): Boolean;
  end;

implementation


end.
