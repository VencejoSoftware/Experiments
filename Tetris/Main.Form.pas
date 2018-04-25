unit Main.Form;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Types,
  Grid, Grid.Column, Grid.Row,
  Draw.Pencil, Draw.Fill,
  Grid.Style, Grid.Artist, Grid.Rect.Artist, Grid.Hexagon.Artist;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    _Grid: IGrid;
    _GridStyle: IGridStyle;
    _GridArtist: IGridArtist;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormPaint(Sender: TObject);
begin
  _GridArtist.Draw(Point(10, 10), Canvas);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  _Grid := TGrid.New;
  _Grid.Columns.Add(TColumn.New(100));
  _Grid.Columns.Add(TColumn.New(200));
  _Grid.Columns.Add(TColumn.New(100));
  _Grid.Rows.Add(TRow.New(80));
  _Grid.Rows.Add(TRow.New(100));
  _Grid.Rows.Add(TRow.New(100));
  _Grid.Rows.Add(TRow.New(150));

  _Grid.Columns.ColumnIndex(TColumn.New(100));
  _Grid.Columns.ColumnIndex(_Grid.Columns.Items[0]);

  _GridStyle := TGridStyle.New(TPencil.New(clRed, TPencilPattern.Solid, 1), TFill.New(clYellow, TFillKind.Solid));
  _GridArtist := TGridRectArtist.New(_Grid, _GridStyle);
// _GridArtist := TGridHexagonArtist.New(_Grid, _GridStyle);
end;

end.
