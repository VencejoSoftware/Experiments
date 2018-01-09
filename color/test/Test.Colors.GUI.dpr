program Test.Colors.GUI;

uses
  Forms,
  DUnitX.Loggers.GUI.VCL,
  Test.Strings.Replace in 'source\Test.Strings.Replace.pas',
  Test.Strings.Tokenize in 'source\Test.Strings.Tokenize.pas',
  Test.Strings.Format in 'source\Test.Strings.Format.pas';

{$R *.RES}


begin
{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
{$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TGUIVCLTestRunner, GUIVCLTestRunner);
  Application.Run;

end.
