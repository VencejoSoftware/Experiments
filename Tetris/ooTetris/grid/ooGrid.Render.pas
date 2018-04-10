unit ooGrid.Render;

interface

uses
  Graphics, Types,
  ooGrid.Cell, //ooGrid.Cell.Render, //ooGrid.Cell.Render,
  ooBorder, ooFill,
  ooGrid.Style;

//type
//  IGridRender = interface
//    ['{0736D743-0858-44C7-A09F-ADADD735CDDD}']
//    procedure Draw(const Grid: IGridDrawable);
//  end;
//
//  TGridRender = class sealed(TInterfacedObject, IGridRender)
//  strict private
//    _Canvas: TCanvas;
//  private
//    function CalculateRect(const Grid: IGridDrawable): TRect;
//    procedure DrawCells(const Grid: IGridDrawable);
//  public
//    procedure Draw(const Grid: IGridDrawable);
//    constructor Create(const Canvas: TCanvas);
//    class function New(const Canvas: TCanvas): IGridRender;
//  end;

implementation
//
//function TGridRender.CalculateRect(const Grid: IGridDrawable): TRect;
//begin
//  Result.Left := Grid.Position.Left;
//  Result.Top := Grid.Position.Top;
//  Result.Right := Result.Left + Grid.Size.Width;
//  Result.Bottom := Result.Top + Grid.Size.Height;
//end;
//
//procedure TGridRender.DrawCells(const Grid: IGridDrawable);
//var
//  Cell: IGridCell;
//  CellStyle: IGridCellStyle;
//  GridCellDraw: IGridCellRender;
//begin
//  GridCellDraw := TGridCellRender.New(_Canvas);
//  for Cell in Grid.Cells do
//  begin
//    CellStyle := TGridCellStyle.New(Cell);
//    CellStyle.ChangeStyle(Grid.Style);
//    GridCellDraw.Draw(CellStyle);
//  end;
//end;
//
//procedure TGridRender.Draw(const Grid: IGridDrawable);
//var
//  DrawRect: TRect;
//begin
//  if Grid.Style.Fill.Mode = TFillMode.Solid then
//  begin
//    _Canvas.Brush.Color := Grid.Style.Fill.Color;
//    _Canvas.Brush.Style := bsSolid;
//  end
//  else
//  begin
//    _Canvas.Brush.Style := bsClear;
//  end;
//  _Canvas.Pen.Color := Grid.Style.Border.Color;
//  case Grid.Style.Border.Mode of
//    TBorderMode.Line:
//      _Canvas.Pen.Style := psSolid;
//    TBorderMode.Dash:
//      _Canvas.Pen.Style := psDash;
//    TBorderMode.Dot:
//      _Canvas.Pen.Style := psDot;
//    TBorderMode.None:
//      _Canvas.Pen.Style := psClear;
//  end;
//  DrawRect := CalculateRect(Grid);
//  _Canvas.Rectangle(DrawRect);
//  DrawCells(Grid);
//end;
//
//constructor TGridRender.Create(const Canvas: TCanvas);
//begin
//  _Canvas := Canvas;
//end;
//
//class function TGridRender.New(const Canvas: TCanvas): IGridRender;
//begin
//  Result := TGridRender.Create(Canvas);
//end;

end.
