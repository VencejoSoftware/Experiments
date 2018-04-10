unit Rect2d;

interface

uses
  Vertex.Intf,
  Rect2d.Intf;

type
  TRect2d = class(TInterfacedObject, IRect2d)
  private
    utLeft: TVertexValue;
    utTop: TVertexValue;
    utRight: TVertexValue;
    utBottom: TVertexValue;
  public
    function Left: TVertexValue;
    function Top: TVertexValue;
    function Right: TVertexValue;
    function Bottom: TVertexValue;

    procedure ChangeLeft(const aLeft: TVertexValue);
    procedure ChangeTop(const aTop: TVertexValue);
    procedure ChangeRight(const aRight: TVertexValue);
    procedure ChangeBottom(const aBottom: TVertexValue);

    constructor Create(const aLeft, aTop, aRight, aBottom: TVertexValue);

    class function New(const aLeft, aTop, aRight, aBottom: TVertexValue): IRect2d;
  end;

implementation

procedure TRect2d.ChangeLeft(const aLeft: TVertexValue);
begin
  utLeft := aLeft;
end;

function TRect2d.Left: TVertexValue;
begin
  Result := utLeft;
end;

function TRect2d.Top: TVertexValue;
begin
  Result := utTop;
end;

procedure TRect2d.ChangeTop(const aTop: TVertexValue);
begin
  utTop := aTop;
end;

function TRect2d.Bottom: TVertexValue;
begin
  Result := utBottom;
end;

procedure TRect2d.ChangeBottom(const aBottom: TVertexValue);
begin
  utBottom := aBottom;
end;

function TRect2d.Right: TVertexValue;
begin
  Result := utRight;
end;

procedure TRect2d.ChangeRight(const aRight: TVertexValue);
begin
  utRight := aRight;
end;

constructor TRect2d.Create(const aLeft, aTop, aRight, aBottom: TVertexValue);
begin
  utLeft := aLeft;
  utTop := aTop;
  utRight := aRight;
  utBottom := aBottom;
end;

class function TRect2d.New(const aLeft, aTop, aRight, aBottom: TVertexValue): IRect2d;
begin
  Result := Create(aLeft, aTop, aRight, aBottom);
end;

end.
