unit Grid.Drawable;

interface

uses
  Graphics, Types,
  Grid.Column, Grid.Row,
  Grid.Cell,
  Grid;

type
  IGridDrawable = interface(IGrid)
    ['{34DA9C3C-FFCE-41C5-AA60-83EDF6714894}']
    function Left: Cardinal;
    function Top: Cardinal;
    procedure Draw(const Canvas: TCanvas);
  end;

  TGridDrawable = class sealed(TInterfacedObject, IGridDrawable)
  strict private
    _Grid: IGrid;
    _Left, _Top: Cardinal;
    _FillColor, _LineColor: TColor;
  private
    procedure DrawCells(const Canvas: TCanvas);
    procedure DrawCell(const Canvas: TCanvas; const RectCell: TRect);
    procedure DrawBorder(const Canvas: TCanvas);
    function CalcHeight: Cardinal;
    function CalcWidth: Cardinal;
  public
    function Columns: TColumnList;
    function Rows: TRowList;
    function Cells: TCellList;
    function Left: Cardinal;
    function Top: Cardinal;
    procedure Draw(const Canvas: TCanvas);
    constructor Create(const Left, Top: Cardinal; const FillColor, LineColor: TColor);
    class function New(const Left, Top: Cardinal; const FillColor, LineColor: TColor): IGridDrawable;
  end;

implementation

function TGridDrawable.Rows: TRowList;
begin
  Result := _Grid.Rows;
end;

function TGridDrawable.Columns: TColumnList;
begin
  Result := _Grid.Columns;
end;

function TGridDrawable.Cells: TCellList;
begin
  Result := _Grid.Cells;
end;

function TGridDrawable.Left: Cardinal;
begin
  Result := _Left;
end;

function TGridDrawable.Top: Cardinal;
begin
  Result := _Top;
end;

procedure TGridDrawable.DrawCell(const Canvas: TCanvas; const RectCell: TRect);
begin
  Canvas.Pen.Style := psClear;
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := _FillColor;
  Canvas.Rectangle(RectCell);
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Color := _LineColor;
  Canvas.Brush.Style := bsClear;
  Canvas.Rectangle(RectCell.Left - 0, RectCell.Top - 0, RectCell.Right, RectCell.Bottom);
end;

procedure TGridDrawable.DrawCells(const Canvas: TCanvas);
var
  Row: IRow;
  Column: IColumn;
  RectCell: TRect;
  CurrentLeft, CurrentTop: Cardinal;
begin
  CurrentTop := Top + 1;
  for Row in Rows do
  begin
    CurrentLeft := Left + 1;
    for Column in Columns do
    begin
      RectCell := Rect(CurrentLeft, CurrentTop, CurrentLeft + Column.Width, CurrentTop + Row.Height);
      DrawCell(Canvas, RectCell);
      Inc(CurrentLeft, Column.Width);
    end;
    Inc(CurrentTop, Row.Height);
  end;
end;

function TGridDrawable.CalcHeight: Cardinal;
var
  Row: IRow;
begin
  Result := 0;
  for Row in Rows do
    Inc(Result, Row.Height);
end;

function TGridDrawable.CalcWidth: Cardinal;
var
  Column: IColumn;
begin
  Result := 0;
  for Column in Columns do
    Inc(Result, Column.Width);
end;

procedure TGridDrawable.DrawBorder(const Canvas: TCanvas);
begin
  Canvas.Rectangle(Left, Top, Left + CalcWidth + 2, Top + CalcHeight + 2);
end;

procedure TGridDrawable.Draw(const Canvas: TCanvas);
begin
  DrawCells(Canvas);
  DrawBorder(Canvas);
end;

constructor TGridDrawable.Create(const Left, Top: Cardinal; const FillColor, LineColor: TColor);
begin
  _Grid := TGrid.New;
  _Left := Left;
  _Top := Top;
  _FillColor := FillColor;
  _LineColor := LineColor;
end;

class function TGridDrawable.New(const Left, Top: Cardinal; const FillColor, LineColor: TColor): IGridDrawable;
begin
  Result := TGridDrawable.Create(Left, Top, FillColor, LineColor);
end;

end.
