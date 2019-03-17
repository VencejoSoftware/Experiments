program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' { Form1 },
  Token.Classify in 'Token.Classify.pas',
  Token in 'Token.pas',
  Token.Breacket.Classify in 'Token.Breacket.Classify.pas',
  TextTokenize in 'TextTokenize.pas';

{$R *.res}

begin
{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
{$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
