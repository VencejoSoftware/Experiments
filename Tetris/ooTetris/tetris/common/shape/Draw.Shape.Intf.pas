unit Draw.Shape.Intf;

interface

uses
  Vertex.Intf,
  Draw.Polygon.Intf;

type
  IShape<T: IVertex> = interface(IPolygon<T>)
    ['{11BD0A7E-05D3-47DA-971E-B20EF9B9C542}']
    function GetContainer: IPolygon<T>;
    function IsInsideContainer: Boolean;

    procedure SetContainer(const aContainer: IPolygon<T>);
  end;

implementation

end.
