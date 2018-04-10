unit Vertex3d;

interface

uses
  Vertex.Intf, Vertex2d, Vertex3d.Intf;

type
  TVertex3d = class(TVertex2d, IVertex, IVertex3d)
  private
    utZ: TVertexValue;
  public
    function Z: TVertexValue;

    procedure MoveZ(const aZ: TVertexValue);

    class function New(const aX, aY, aZ: TVertexValue): IVertex3d;
  end;

implementation

function TVertex3d.Z: TVertexValue;
begin
  Result := utZ;
end;

procedure TVertex3d.MoveZ(const aZ: TVertexValue);
begin
  utZ := aZ;
end;

class function TVertex3d.New(const aX, aY, aZ: TVertexValue): IVertex3d;
begin
  Result := Create;
  Result.MoveX(aX);
  Result.MoveX(aY);
  Result.MoveZ(aZ);
end;

end.
