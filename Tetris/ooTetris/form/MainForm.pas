unit MainForm;

interface

uses
  SysUtils, Classes, Graphics, ExtCtrls, StdCtrls,
  Controls, Forms, Dialogs,
  ooEventHub.BroadcastHub,
  ooPosition, ooRectSize,
  ooShape.Render,
  ooBorder, ooFill, ooStyle,
  ooGrid, ooGrid.Style, ooGrid.Render,
  ooGrid.Row, ooGrid.Row.List,
  ooGrid.Column, ooGrid.Column.List,
  ooGrid.Cell;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Button1: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    CellTimer: IGridCell;
    Grid: IGrid;
    BroadcastHubColumn: IBroadcastHubColumn;
    BroadcastHubRow: IBroadcastHubRow;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);
// var
// GridRender: IGridRender;
begin
  CellTimer.Move(TPosition.New(CellTimer.Position.Left + 10, CellTimer.Position.Top + 10));
  Invalidate;
// GridRender := TGridRender.New(Canvas);
// GridRender.Draw(Grid);
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  CellTimer.Paint;
end;

procedure TForm1.Button1Click(Sender: TObject);
// var
// Cell: IGridCell;
// Style: IStyle;
// CellStyle: IGridCellStyle;
// GridCellRender: IGridCellRender;
begin
// Cell := TGridCell.New;
// Cell.Move(TPosition.New(100, 80));
// Cell.Resize(TRectSize.New(100, 22));
// CellStyle := TGridCellStyle.New(Cell);
// Style := TStyle.New(TBorder.New(clBlack, TBorderMode.Dot), TFill.New(clCream, TFillMode.Solid));
// CellStyle.ChangeStyle(Style);
// GridCellRender := TGridCellRender.New(Canvas);
// GridCellRender.Draw(CellStyle);
//
// Cell := TGridCell.New;
// Cell.Move(TPosition.New(220, 80));
// Cell.Resize(TRectSize.New(100, 22));
// CellStyle := TGridCellStyle.New(Cell);
// GridCellRender := TGridCellRender.New(Canvas);
// GridCellRender.Draw(CellStyle);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Style: IStyle;
begin
  CellTimer := TGridCell.NewDefault(nil);
  CellTimer.ChangeRender(TShapeRender.New(Canvas));
  CellTimer.Move(TPosition.New(100, 80));
  CellTimer.Resize(TRectSize.New(100, 22));
  Style := TStyle.New(TBorder.New(clMaroon, TBorderMode.Dot), TFill.New(clCream, TFillMode.Solid));
  CellTimer.ChangeStyle(Style);
  Exit;
  Style := TStyle.New(TBorder.New(clDkGray, TBorderMode.Line), TFill.New(clWhite, TFillMode.Solid));
  BroadcastHubColumn := TBroadcastHubColumn.New;
  BroadcastHubRow := TBroadcastHubRow.New;

  Grid := TGrid.New(BroadcastHubColumn, BroadcastHubRow);
  Grid.Rows.Add(TGridRow.New(22));
  Grid.Rows.Add(TGridRow.New(22));
  Grid.Rows.Add(TGridRow.New(70));
  Grid.Rows.Add(TGridRow.New(22));
  Grid.Rows.Add(TGridRow.New(22));
  Grid.Rows.Add(TGridRow.New(22));

  Grid.Columns.Add(TGridColumn.New(100));
  Grid.Columns.Add(TGridColumn.New(50));
  Grid.Columns.Add(TGridColumn.New(200));
end;

end.
