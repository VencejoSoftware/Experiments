unit ooShape.Render;

interface

uses
  Graphics,
  ooBorder,
  ooFill,
  ooShape;

type
  IShapeRender = interface
    ['{C08AB22F-BB18-4119-A287-680BCB61D54D}']
    procedure DrawStamp(const Stamp: TBitmap; const Shape: IShape);
    procedure Paint(const Stamp: TBitmap; const Shape: IShape);
  end;

  TShapeRender = class sealed(TInterfacedObject, IShapeRender)
  strict private
    _Canvas: TCanvas;
  public
    procedure DrawStamp(const Stamp: TBitmap; const Shape: IShape);
    procedure Paint(const Stamp: TBitmap; const Shape: IShape);
    constructor Create(const Canvas: TCanvas);
    class function New(const Canvas: TCanvas): IShapeRender;
  end;

implementation

procedure TShapeRender.DrawStamp(const Stamp: TBitmap; const Shape: IShape);
begin
  if not Shape.IsVisible then
    Exit;
  if Shape.Style.Fill.Mode = TFillMode.Solid then
  begin
    Stamp.Canvas.Brush.Color := Shape.Style.Fill.Color;
    Stamp.Canvas.Brush.Style := bsSolid;
  end
  else
  begin
    Stamp.Canvas.Brush.Style := bsClear;
  end;
  Stamp.Canvas.Pen.Color := Shape.Style.Border.Color;
  case Shape.Style.Border.Mode of
    TBorderMode.Line:
      Stamp.Canvas.Pen.Style := psSolid;
    TBorderMode.Dash:
      Stamp.Canvas.Pen.Style := psDash;
    TBorderMode.Dot:
      Stamp.Canvas.Pen.Style := psDot;
    TBorderMode.None:
      Stamp.Canvas.Pen.Style := psClear;
  end;
  Stamp.Canvas.Rectangle(Stamp.Canvas.ClipRect);
end;

procedure TShapeRender.Paint(const Stamp: TBitmap; const Shape: IShape);
begin
  try
    _Canvas.Lock;
    _Canvas.Draw(Shape.Position.Left, Shape.Position.Top, Stamp);
  finally
    _Canvas.Unlock;
  end;
end;

constructor TShapeRender.Create(const Canvas: TCanvas);
begin
  _Canvas := Canvas;
end;

class function TShapeRender.New(const Canvas: TCanvas): IShapeRender;
begin
  Result := TShapeRender.Create(Canvas);
end;

end.
