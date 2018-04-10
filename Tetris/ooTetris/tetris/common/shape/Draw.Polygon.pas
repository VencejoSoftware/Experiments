unit Draw.Polygon;

interface

uses
  Vertex.Intf,
  Draw.Polygon.Intf,
  Vertex.List;

type
  TPolygon<T: IVertex> = class(TInterfacedObject, IPolygon<T>)
  private
    objVertexList: TVertexList<T>;
  public
    function GetVertexList: TVertexList<T>;

    procedure SetVertexList(const aVertexList: TVertexList<T>);

    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

function TPolygon<T>.GetVertexList: TVertexList<T>;
begin
  Result := objVertexList;
end;

procedure TPolygon<T>.SetVertexList(const aVertexList: TVertexList<T>);
begin
  objVertexList := aVertexList;
end;

constructor TPolygon<T>.Create;
begin
  objVertexList := TVertexList<T>.Create;
end;

destructor TPolygon<T>.Destroy;
begin
  objVertexList.Free;
  inherited;
end;

end.
