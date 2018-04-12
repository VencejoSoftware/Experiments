unit Grid.Rect.Artist;

interface

uses
  Graphics, Types,
  Grid.Column, Grid.Row, Grid,
  Grid.Style, Grid.Artist;

type
  TGridRectArtist = class sealed(TInterfacedObject, IGridArtist)
  strict private
    _Grid: IGrid;
    _GridStyle: IGridStyle;
  private
// function CalcHeight: Cardinal;
// function CalcWidth: Cardinal;
  public
    procedure DrawCell(const Offset: TPoint; const Canvas: TCanvas; const Column: IColumn; const Row: IRow);
    procedure DrawCells(const Offset: TPoint; const Canvas: TCanvas);
    constructor Create(const Grid: IGrid; const GridStyle: IGridStyle);
    class function New(const Grid: IGrid; const GridStyle: IGridStyle): IGridArtist;
  end;

implementation

// function TGridRectArtist.CalcHeight: Cardinal;
// var
// Row: IRow;
// begin
// Result := 0;
// for Row in _Grid.Rows do
// Inc(Result, Row.Height);
// end;
//
// function TGridRectArtist.CalcWidth: Cardinal;
// var
// Column: IColumn;
// begin
// Result := 0;
// for Column in _Grid.Columns do
// Inc(Result, Column.Width);
// end;

procedure TGridRectArtist.DrawCell(const Offset: TPoint; const Canvas: TCanvas; const Column: IColumn; const Row: IRow);
var
  RectCell: TRect;
begin
  RectCell := Rect(Offset.X, Offset.Y, Offset.X + Column.Width, Offset.Y + Row.Height);
  _GridStyle.ClearPencil(Canvas);
  _GridStyle.ApplyFill(Canvas);
  Canvas.Rectangle(RectCell);
  _GridStyle.ClearFill(Canvas);
  _GridStyle.ApplyPencil(Canvas);
  RectCell.Left := RectCell.Left - 1;
  RectCell.Top := RectCell.Top - 1;
  Canvas.Rectangle(RectCell);
end;

procedure TGridRectArtist.DrawCells(const Offset: TPoint; const Canvas: TCanvas);
var
  Row: IRow;
  Column: IColumn;
  CurrentOffset: TPoint;
begin
  CurrentOffset := Point(Offset.X, Offset.Y);
  for Row in _Grid.Rows do
  begin
    CurrentOffset.X := Offset.X;
    for Column in _Grid.Columns do
    begin
      DrawCell(CurrentOffset, Canvas, Column, Row);
      Inc(CurrentOffset.X, Column.Width);
    end;
    Inc(CurrentOffset.Y, Row.Height);
  end;
end;

constructor TGridRectArtist.Create(const Grid: IGrid; const GridStyle: IGridStyle);
begin
  _Grid := Grid;
  _GridStyle := GridStyle;
end;

class function TGridRectArtist.New(const Grid: IGrid; const GridStyle: IGridStyle): IGridArtist;
begin
  Result := TGridRectArtist.Create(Grid, GridStyle);
end;

end.
