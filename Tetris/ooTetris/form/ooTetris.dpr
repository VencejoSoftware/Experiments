program ooTetris;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  ooGrid in '..\grid\ooGrid.pas',
  ooGrid.Column.List in '..\grid\column\ooGrid.Column.List.pas',
  ooGrid.Column in '..\grid\column\ooGrid.Column.pas',
  ooGrid.Row in '..\grid\row\ooGrid.Row.pas',
  ooGrid.Row.List in '..\grid\row\ooGrid.Row.List.pas',
  ooGrid.Cell in '..\grid\cell\ooGrid.Cell.pas',
  ooPosition in '..\dimension\ooPosition.pas',
  ooRectSize in '..\dimension\ooRectSize.pas',
  ooBorder in '..\style\ooBorder.pas',
  ooFill in '..\style\ooFill.pas',
  ooStyle in '..\style\ooStyle.pas',
  ooGrid.Style in '..\grid\ooGrid.Style.pas',
  ooGrid.Render in '..\grid\ooGrid.Render.pas',
  ooShape in '..\shape\ooShape.pas',
  ooShape.Stamp in '..\shape\ooShape.Stamp.pas',
  ooShape.Render in '..\shape\ooShape.Render.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
