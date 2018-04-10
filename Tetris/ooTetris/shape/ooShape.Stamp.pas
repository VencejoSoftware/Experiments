unit ooShape.Stamp;

interface

uses
  Graphics,
  ooStyle,
  ooPosition,
  ooRectSize,
  ooShape.Render,
  ooShape;

type
  IShapeStamp = interface(IShape)
    ['{E3A017D0-710A-41EF-A8FA-37D582D413A2}']
    function Stamp: TBitmap;
    procedure ChangeRender(const Render: IShapeRender);
    procedure Paint;
  end;

  TShapeStamp = class(TInterfacedObject, IShapeStamp, IShape)
  strict private
    _Shape: IShape;
    _Stamp: TBitmap;
    _Render: IShapeRender;
    procedure InvalidateStamp;
  public
    function Stamp: TBitmap;
    function Position: IPosition;
    function Size: IRectSize;
    function Style: IStyle;
    function IsVisible: Boolean;
    procedure Show;
    procedure Hide;
    procedure Move(const Position: IPosition);
    procedure Resize(const Size: IRectSize);
    procedure ChangeStyle(const Style: IStyle);
    procedure Paint;
    procedure ChangeRender(const Render: IShapeRender);
    constructor Create(const Shape: IShape);
    destructor Destroy; override;
    class function New(const Shape: IShape): IShapeStamp;
    class function NewDefault: IShapeStamp;
  end;

implementation

function TShapeStamp.Position: IPosition;
begin
  Result := _Shape.Position;
end;

procedure TShapeStamp.Move(const Position: IPosition);
begin
  _Shape.Move(Position);
end;

function TShapeStamp.Size: IRectSize;
begin
  Result := _Shape.Size;
end;

procedure TShapeStamp.Resize(const Size: IRectSize);
begin
  _Shape.Resize(Size);
  InvalidateStamp;
end;

function TShapeStamp.IsVisible: Boolean;
begin
  Result := _Shape.IsVisible;
end;

procedure TShapeStamp.Show;
begin
  _Shape.Show;
end;

procedure TShapeStamp.Hide;
begin
  _Shape.Hide;
end;

function TShapeStamp.Style: IStyle;
begin
  Result := _Shape.Style;
end;

procedure TShapeStamp.ChangeRender(const Render: IShapeRender);
begin
  _Render := Render;
  InvalidateStamp;
end;

procedure TShapeStamp.ChangeStyle(const Style: IStyle);
begin
  _Shape.ChangeStyle(Style);
  InvalidateStamp;
end;

function TShapeStamp.Stamp: TBitmap;
begin
  Result := _Stamp;
end;

procedure TShapeStamp.InvalidateStamp;
begin
  if (_Stamp.Width <> Size.Width) or (_Stamp.Height <> Size.Height) then
    _Stamp.SetSize(Size.Width, Size.Height);
  if Assigned(_Render) then
    _Render.DrawStamp(Stamp, Self);
end;

procedure TShapeStamp.Paint;
begin
  if not IsVisible then
    Exit;
  _Render.Paint(Stamp, Self);
end;

constructor TShapeStamp.Create(const Shape: IShape);
begin
  _Stamp := TBitmap.Create;
  _Stamp.PixelFormat := pf32bit;
  _Shape := Shape;
end;

destructor TShapeStamp.Destroy;
begin
  _Stamp.Free;
  inherited;
end;

class function TShapeStamp.New(const Shape: IShape): IShapeStamp;
begin
  Result := TShapeStamp.Create(Shape);
end;

class function TShapeStamp.NewDefault: IShapeStamp;
begin
  Result := TShapeStamp.New(TShape.New);
end;

end.
