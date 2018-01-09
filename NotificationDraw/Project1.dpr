program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ooMenuEntry.Icon.Artist in 'MenuEntry\ooMenuEntry.Icon.Artist.pas',
  ooMenuEntry.Icon.Measure in 'MenuEntry\ooMenuEntry.Icon.Measure.pas',
  ooMenuEntry.Icon in 'MenuEntry\ooMenuEntry.Icon.pas',
  ooMenuEntry.Text.Artist in 'MenuEntry\ooMenuEntry.Text.Artist.pas',
  ooMenuEntry.Text.Draw in 'MenuEntry\ooMenuEntry.Text.Draw.pas',
  ooMenuEntry.Text.Measure in 'MenuEntry\ooMenuEntry.Text.Measure.pas',
  ooMenuEntry.Text in 'MenuEntry\ooMenuEntry.Text.pas',
  ooRectArea.Add in 'RectArea\ooRectArea.Add.pas',
  ooRectArea.Constraint in 'RectArea\ooRectArea.Constraint.pas',
  ooRectArea.Inflated in 'RectArea\ooRectArea.Inflated.pas',
  ooRectArea.Max in 'RectArea\ooRectArea.Max.pas',
  ooRectArea.Offset in 'RectArea\ooRectArea.Offset.pas',
  ooRectArea in 'RectArea\ooRectArea.pas',
  ooRectArea.Transform in 'RectArea\ooRectArea.Transform.pas',
  ooColor in 'Render\ooColor.pas',
  ooFill in 'Render\ooFill.pas',
  ooFontStyle in 'Render\ooFontStyle.pas',
  ooRender in 'Render\ooRender.pas',
  ooTextSplitter in 'Render\ooTextSplitter.pas',
  ooBorder in 'Rendereable\ooBorder.pas',
  ooGlyph in 'Rendereable\ooGlyph.pas',
  ooPosition in 'Rendereable\ooPosition.pas',
  ooSize in 'Rendereable\ooSize.pas',
  ooStyle in 'Rendereable\ooStyle.pas',
  ooStyledText in 'Rendereable\ooStyledText.pas',
  ooDisplayable in 'Rendereable\ooDisplayable.pas',
  ooRectArea.Min in 'RectArea\ooRectArea.Min.pas',
  ooRender.Canvas in 'Render\ooRender.Canvas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
