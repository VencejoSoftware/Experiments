program Project2;

uses
  Forms,
  PubSub.Publisher,
  Unit2 in 'Unit2.pas' { Form2 } ,
  Subscriber1 in 'Subscriber1.pas',
  Subscriber2 in 'Subscriber2.pas',
  Subscriber2.Filter in 'Subscriber2.Filter.pas';
{$R *.res}

var
  Publisher: IPublisher<String>;

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
// Application.CreateForm(TForm2, Form2);
  Publisher := TPublisher<String>.New;
  Form2 := TForm2.Create(Application, Publisher);
  Form2.ShowModal;
  Application.Run;

end.
