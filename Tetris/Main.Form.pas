unit Main.Form;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grid, Grid.Column, Grid.Row, Grid.Drawable;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    _Grid: IGridDrawable;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormPaint(Sender: TObject);
begin
  _Grid.Draw(Canvas);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  _Grid := TGridDrawable.New(10, 10, clCream, clLtGray);
  _Grid.Columns.Add(TColumn.New(100));
  _Grid.Columns.Add(TColumn.New(100));
  _Grid.Columns.Add(TColumn.New(100));
  _Grid.Rows.Add(TRow.New(100));
  _Grid.Rows.Add(TRow.New(100));
  _Grid.Rows.Add(TRow.New(100));
end;

end.
