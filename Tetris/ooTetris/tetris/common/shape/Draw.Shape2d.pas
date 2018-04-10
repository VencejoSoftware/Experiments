unit Draw.Shape2d;

interface

uses
  Vertex.Intf, Vertex2d, Draw.Shape;

type
  TShape2d = class(TShape<TVertex2d>)
  protected
    function GetHeight: TVertexValue; virtual;
    function GetWidth: TVertexValue; virtual;
    function GetLeft: TVertexValue; virtual;
    function GetTop: TVertexValue; virtual;

    procedure SetHeight(const aHeight: TVertexValue); virtual;
    procedure SetWidth(const aWidth: TVertexValue); virtual;
    procedure SetLeft(const aLeft: TVertexValue); virtual;
    procedure SetTop(const aTop: TVertexValue); virtual;
  public
    constructor Create; override;

    property Height: TVertexValue read GetHeight write SetHeight;
    property Width: TVertexValue read GetWidth write SetWidth;
    property Left: TVertexValue read GetLeft write SetLeft;
    property Top: TVertexValue read GetTop write SetTop;
  end;

implementation

function TShape2d.GetLeft: TVertexValue;
begin
  Result := GetVertexList[0].X;
end;

procedure TShape2d.SetLeft(const aLeft: TVertexValue);
begin
//  GetVertexList[0].X := aLeft;
end;

function TShape2d.GetTop: TVertexValue;
begin
//  Result := GetVertexList[0].Y;
end;

procedure TShape2d.SetTop(const aTop: TVertexValue);
begin
//  GetVertexList[0].Y := aTop;
end;

function TShape2d.GetWidth: TVertexValue;
begin
//  Result := GetVertexList[1].X;
end;

procedure TShape2d.SetWidth(const aWidth: TVertexValue);
begin
//  GetVertexList[1].X := aWidth;
end;

function TShape2d.GetHeight: TVertexValue;
begin
//  Result := GetVertexList[1].Y;
end;

procedure TShape2d.SetHeight(const aHeight: TVertexValue);
begin
//  GetVertexList[1].Y := aHeight;
end;

constructor TShape2d.Create;
begin
  inherited;
  GetVertexList.Add(TVertex2d.Create);
  GetVertexList.Add(TVertex2d.Create);
end;

end.
