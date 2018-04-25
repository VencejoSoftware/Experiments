program Tetris;

uses
  Vcl.Forms,
  Main.Form in 'Main.Form.pas' {Form1},
  Grid in 'grid\Grid.pas',
  Grid.Rect.Artist in 'grid\Grid.Rect.Artist.pas',
  Grid.Column in 'grid\Grid.Column.pas',
  Grid.Row in 'grid\Grid.Row.pas',
  Grid.Style in 'grid\Grid.Style.pas',
  Grid.Cell in 'grid\Grid.Cell.pas',
  Draw.Pencil in 'draw\Draw.Pencil.pas',
  Draw.Fill in 'draw\Draw.Fill.pas',
  Grid.Hexagon.Artist in 'grid\Grid.Hexagon.Artist.pas',
  Grid.Artist in 'grid\Grid.Artist.pas',
  Grid.ColumnIndexed in 'grid\Grid.ColumnIndexed.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
