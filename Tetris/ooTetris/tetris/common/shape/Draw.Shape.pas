unit Draw.Shape;

interface

uses
  Vertex.Intf,
  Draw.Polygon.Intf, Draw.Polygon;

type
  TShape<T: IVertex> = class(TPolygon<T>, IPolygon<T>)
  private
    objContainer: IPolygon<T>;
  public
    function GetContainer: IPolygon<T>;
    function IsInsideContainer: Boolean;

    procedure SetContainer(const aContainer: IPolygon<T>);
  end;

implementation

function TShape<T>.GetContainer: IPolygon<T>;
begin
  Result := objContainer;
end;

procedure TShape<T>.SetContainer(const aContainer: IPolygon<T>);
begin
  objContainer := aContainer;
end;

function TShape<T>.IsInsideContainer: Boolean;
begin
  // TODO: hacer
end;

end.
