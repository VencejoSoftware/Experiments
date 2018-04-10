program ObserverDemo;

uses
  Forms,
  Weather in 'Weather.pas',
  Form.Main in 'Form.Main.pas' {MainForm},
  Form.WeatherStatics in 'Form.WeatherStatics.pas' {WeatherStatics},
  Form.WeatherLog in 'Form.WeatherLog.pas' {WeatherLogForm},
  Pattern.Observer in 'Pattern.Observer.pas',
  Weather.Subject in 'Weather.Subject.pas';

{$R *.res}


begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
