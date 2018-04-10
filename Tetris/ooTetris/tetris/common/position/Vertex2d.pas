unit Vertex2d;

interface

uses
  Vertex.Intf, Vertex2d.Intf;

type
  TVertex2d = class(TInterfacedObject, IVertex, IVertex2d)
  private
    utX: TVertexValue;
    utY: TVertexValue;
  public
    function X: TVertexValue;
    function Y: TVertexValue;

    procedure MoveX(const aX: TVertexValue);
    procedure MoveY(const aY: TVertexValue);

    class function New(const aX, aY: TVertexValue): IVertex2d;
  end;

implementation

function TVertex2d.X: TVertexValue;
begin
  Result := utX;
end;

function TVertex2d.Y: TVertexValue;
begin
  Result := utY;
end;

procedure TVertex2d.MoveX(const aX: TVertexValue);
begin
  utX := aX;
end;

procedure TVertex2d.MoveY(const aY: TVertexValue);
begin
  utY := aY;
end;

class function TVertex2d.New(const aX, aY: TVertexValue): IVertex2d;
begin
  Result := Create;
  Result.MoveX(aX);
  Result.MoveX(aY);
end;

end.
