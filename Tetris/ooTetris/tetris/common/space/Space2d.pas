unit Space2d;

interface

uses
  Vertex.Intf, Vertex.List, Vertex2d.Intf, Vertex2d,
  Space2d.Intf;

type
  TSpace2d = class(TInterfacedObject, ISpace2d)
  private
    objVertexList: TVertexList<IVertex2d>;
  protected
    function VertexList: TVertexList<IVertex2d>;
  public
    function Left: TVertexValue;
    function Top: TVertexValue;
    function Height: TVertexValue;
    function Width: TVertexValue;
    function IsVertexInside(const aVertex: IVertex2d): Boolean;

    procedure ChangeLeft(const aLeft: TVertexValue);
    procedure ChangeTop(const aTop: TVertexValue);
    procedure ChangeHeight(const aHeight: TVertexValue);
    procedure ChangeWidth(const aWidth: TVertexValue);

    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

function TSpace2d.Left: TVertexValue;
begin
  Result := VertexList[0].X;
end;

procedure TSpace2d.ChangeLeft(const aLeft: TVertexValue);
begin
  VertexList[0].MoveX(aLeft);
end;

function TSpace2d.Top: TVertexValue;
begin
  Result := VertexList[0].Y;
end;

procedure TSpace2d.ChangeTop(const aTop: TVertexValue);
begin
  VertexList[0].MoveY(aTop);
end;

function TSpace2d.Width: TVertexValue;
begin
  Result := VertexList[1].Y;
end;

procedure TSpace2d.ChangeWidth(const aWidth: TVertexValue);
begin
  VertexList[1].MoveX(aWidth);
end;

function TSpace2d.Height: TVertexValue;
begin
  Result := VertexList[1].Y;
end;

procedure TSpace2d.ChangeHeight(const aHeight: TVertexValue);
begin
  VertexList[1].MoveY(aHeight);
end;

function TSpace2d.VertexList: TVertexList<IVertex2d>;
begin
  Result := objVertexList;
end;

function TSpace2d.IsVertexInside(const aVertex: IVertex2d): Boolean;
begin
  Result := (aVertex.X >= Left) and (aVertex.Y >= Top) and (aVertex.X <= Width) and (aVertex.Y <= Height);
end;

constructor TSpace2d.Create;
begin
  inherited;
  objVertexList := TVertexList<IVertex2d>.Create;
  VertexList.Add(TVertex2d.New(0, 0));
  VertexList.Add(TVertex2d.New(0, 0));
end;

destructor TSpace2d.Destroy;
begin
  objVertexList.Free;
  inherited;
end;

end.
