program Tetris;

uses
  Vcl.Forms,
  Main.Form in 'Main.Form.pas' {Form1},
  Grid in 'grid\Grid.pas',
  Grid.Drawable in 'grid\Grid.Drawable.pas',
  Grid.Column in 'grid\Grid.Column.pas',
  Grid.Row in 'grid\Grid.Row.pas',
  Grid.Cell.Drawable in 'grid\Grid.Cell.Drawable.pas',
  Grid.Cell in 'grid\Grid.Cell.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
