unit Vertex.List;

interface

uses
  Generics.Collections,
  Vertex.Intf;

type
  TVertexList<T: IVertex> = class(TList<T>)
  public
    function IsVertexInside(const aVertex: IVertex): Boolean;
  end;

implementation

function TVertexList<T>.IsVertexInside(const aVertex: IVertex): Boolean;
begin
  // TODO: revisar
  Result := False;
end;

end.
