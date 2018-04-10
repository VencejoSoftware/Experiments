unit Grid.Tetris;

interface

uses
  VCL.Graphics, System.Types,
  Grid.Value;

type
  TGridTetris = class(TGridValue<Boolean>)
  protected
    procedure DoDrawCells(aCanvas: TCanvas); virtual;
    procedure DoDrawBack(aCanvas: TCanvas); virtual;
    procedure DoDrawBorder(aCanvas: TCanvas); virtual;
  public
    procedure Draw(aCanvas: TCanvas); virtual;
  end;

implementation


procedure TGridTetris.DoDrawBack(aCanvas: TCanvas);
begin
  aCanvas.Brush.Color := clCream;
  // aCanvas.Rectangle(GetBounds);
end;

procedure TGridTetris.DoDrawBorder(aCanvas: TCanvas);
begin
  aCanvas.Pen.Color := clGray;
  // aCanvas.Rectangle(GetBounds);
end;

procedure TGridTetris.DoDrawCells(aCanvas: TCanvas);
var
  i: Integer;
  iPos, iLimit: Extended;
begin
  aCanvas.Pen.Color := clLtGray;
  iLimit := Top + Height;
  for i := 0 to Pred(Columns) do
  begin
    iPos := Left + CellWidth * i;
    // aCanvas.MoveTo(iPos, Top);
    // aCanvas.LineTo(iPos, iLimit);
  end;
  iLimit := Left + Width;
  for i := 0 to Pred(Rows) do
  begin
    iPos := Top + CellHeight * i;
    // aCanvas.MoveTo(Left, iPos);
    // aCanvas.LineTo(iLimit, iPos);
  end;
end;

procedure TGridTetris.Draw(aCanvas: TCanvas);
begin
  aCanvas.Brush.Style := bsSolid;
  aCanvas.Pen.Style := psClear;
  DoDrawBack(aCanvas);
  aCanvas.Pen.Width := 1;
  aCanvas.Brush.Style := bsClear;
  aCanvas.Pen.Style := psSolid;
  DoDrawCells(aCanvas);
  DoDrawBorder(aCanvas);
end;

end.
