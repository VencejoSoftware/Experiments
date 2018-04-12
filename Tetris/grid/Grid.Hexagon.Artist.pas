unit Grid.Hexagon.Artist;

interface

uses
  Graphics, Types,
  Grid.Column, Grid.Row, Grid,
  Grid.Style, Grid.Artist;

type
  TGridHexagonArtist = class sealed(TInterfacedObject, IGridArtist)
  strict private
    _Grid: IGrid;
    _GridStyle: IGridStyle;
  private
  public
    procedure DrawCell(const Offset: TPoint; const Canvas: TCanvas; const Column: IColumn; const Row: IRow);
    procedure DrawCells(const Offset: TPoint; const Canvas: TCanvas);
    constructor Create(const Grid: IGrid; const GridStyle: IGridStyle);
    class function New(const Grid: IGrid; const GridStyle: IGridStyle): IGridArtist;
  end;

implementation

type
  THexCellSize = record
    Width: Cardinal;
    Height: Cardinal;
    SmallWidth: Cardinal;
  end;

function GetHexDrawPoint(const HexCellSize: THexCellSize; const Column, Row: Cardinal): TPoint;
begin
  Result.X := ((HexCellSize.Width - HexCellSize.SmallWidth) div 2 + HexCellSize.SmallWidth) * Column;
  Result.Y := HexCellSize.Height * Row + (HexCellSize.Height div 2) * (Column mod 2);
end;

procedure DrawHexCell(const Canvas: TCanvas; const Offset: TPoint; const HexCellSize: THexCellSize;
  const Column, Row: Cardinal);
var
  DrawPoint: TPoint;
  XOffset: Cardinal;
begin
// *     | small |
// *     | width |
// *     1_______2 ______
// *     /       \       h
// *    /         \      e
// * 6 /           \ 3   i
// *   \           /     g
// *    \         /      h
// *  |  \_______/ _|____t
// *  | 5         4 |
// *  |--- width ---|
  XOffset := (HexCellSize.Width - HexCellSize.SmallWidth) div 2;
  // Move to point 1
  DrawPoint := GetHexDrawPoint(HexCellSize, Column, Row);
  DrawPoint.Offset(Offset);
  Canvas.MoveTo(DrawPoint.X, DrawPoint.Y);
  // Line to point 2
  DrawPoint.Offset(HexCellSize.SmallWidth, 0);
  Canvas.LineTo(DrawPoint.X, DrawPoint.Y);
  // Line to point 3
  DrawPoint.Offset(XOffset, HexCellSize.Height div 2);
  Canvas.LineTo(DrawPoint.X, DrawPoint.Y);
  // Line to point 4
  DrawPoint.Offset( - XOffset, HexCellSize.Height div 2);
  Canvas.LineTo(DrawPoint.X, DrawPoint.Y);
  // Line to point 5
  DrawPoint.Offset( - HexCellSize.SmallWidth, 0);
  Canvas.LineTo(DrawPoint.X, DrawPoint.Y);
  // Line to point 6
  DrawPoint.Offset( - XOffset, - HexCellSize.Height div 2);
  Canvas.LineTo(DrawPoint.X, DrawPoint.Y);
  // Line to point 1
  DrawPoint.Offset(XOffset, - HexCellSize.Height div 2);
  Canvas.LineTo(DrawPoint.X, DrawPoint.Y);
end;

procedure DrawHexCellGrid(const Canvas: TCanvas; const Offset: TPoint; const HexCellSize: THexCellSize;
  const Columns, Rows: Cardinal);
var
  Column, Row: Cardinal;
begin
  for Row := 0 to Pred(Rows) do
    for Column := 0 to Pred(Columns) do
      DrawHexCell(Canvas, Offset, HexCellSize, Column, Row);
end;

procedure TGridHexagonArtist.DrawCell(const Offset: TPoint; const Canvas: TCanvas; const Column: IColumn;
  const Row: IRow);
var
  DrawPoint: TPoint;
  XOffset: Cardinal;
  HexCellSize: THexCellSize;
begin
  HexCellSize.Width := Column.Width;
  HexCellSize.Height := Row.Height;
  HexCellSize.SmallWidth := Column.Width div 2;
// *     | small |
// *     | width |
// *     1_______2 ______
// *     /       \       h
// *    /         \      e
// * 6 /           \ 3   i
// *   \           /     g
// *    \         /      h
// *  |  \_______/ _|____t
// *  | 5         4 |
// *  |--- width ---|
  XOffset := (HexCellSize.Width - HexCellSize.SmallWidth) div 2;
  // Move to point 1
// DrawPoint := GetHexDrawPoint(HexCellSize, Column, Row);
  DrawPoint := Offset;
//  DrawPoint.Offset(Offset);
  Canvas.MoveTo(DrawPoint.X, DrawPoint.Y);
  // Line to point 2
  DrawPoint.Offset(HexCellSize.SmallWidth, 0);
  Canvas.LineTo(DrawPoint.X, DrawPoint.Y);
  // Line to point 3
  DrawPoint.Offset(XOffset, HexCellSize.Height div 2);
  Canvas.LineTo(DrawPoint.X, DrawPoint.Y);
  // Line to point 4
  DrawPoint.Offset( - XOffset, HexCellSize.Height div 2);
  Canvas.LineTo(DrawPoint.X, DrawPoint.Y);
  // Line to point 5
  DrawPoint.Offset( - HexCellSize.SmallWidth, 0);
  Canvas.LineTo(DrawPoint.X, DrawPoint.Y);
  // Line to point 6
  DrawPoint.Offset( - XOffset, - HexCellSize.Height div 2);
  Canvas.LineTo(DrawPoint.X, DrawPoint.Y);
  // Line to point 1
  DrawPoint.Offset(XOffset, - HexCellSize.Height div 2);
  Canvas.LineTo(DrawPoint.X, DrawPoint.Y);
end;

procedure TGridHexagonArtist.DrawCells(const Offset: TPoint; const Canvas: TCanvas);
var
  Row: IRow;
  Column: IColumn;
  CurrentOffset: TPoint;
  HexCellSize: THexCellSize;
  Col, Row1: Cardinal;
begin
//  CurrentOffset := Point(Offset.X, Offset.Y);
  Col := 0;
  Row1 := 0;
  for Row in _Grid.Rows do
  begin
//    CurrentOffset.X := Offset.X;
    for Column in _Grid.Columns do
    begin
      HexCellSize.Width := Column.Width;
      HexCellSize.Height := Row.Height;
      HexCellSize.SmallWidth := Column.Width div 2;
      CurrentOffset := GetHexDrawPoint(HexCellSize, Col, Row1);

      DrawCell(CurrentOffset, Canvas, Column, Row);
//      Inc(CurrentOffset.X, Column.Width);
      Inc(Col);
    end;
//    Inc(CurrentOffset.Y, Row.Height);
    Inc(Row1);
  end;
end;

constructor TGridHexagonArtist.Create(const Grid: IGrid; const GridStyle: IGridStyle);
begin
  _Grid := Grid;
  _GridStyle := GridStyle;
end;

class function TGridHexagonArtist.New(const Grid: IGrid; const GridStyle: IGridStyle): IGridArtist;
begin
  Result := TGridHexagonArtist.Create(Grid, GridStyle);
end;

end.
