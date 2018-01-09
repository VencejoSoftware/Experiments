program Test.Colors;
{$APPTYPE CONSOLE}


uses
  DUnitMain,
  ColorX.Test in 'source\ColorX.Test.pas',
  Colors.Invert.Test in 'source\Colors.Invert.Test.pas',
  Colors.Lightness.Test in 'source\Colors.Lightness.Test.pas',
  Colors.Greyscale.Test in 'source\Colors.Greyscale.Test.pas';

{$R *.RES}


begin
{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
{$WARN SYMBOL_PLATFORM ON}
  Main;

end.
