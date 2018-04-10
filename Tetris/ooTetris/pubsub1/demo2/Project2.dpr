program Project2;

uses
  Forms,
  StdCtrls,
  PubSub.Publisher,
  PubSub.Subscriber,
  Unit2 in 'Unit2.pas' { Form2 },
  Content.Validate in 'Content.Validate.pas',
  Check.Text in 'Check.Text.pas',
  Unit1 in 'Unit1.pas' { Form1 },
  LabelUpdate in 'LabelUpdate.pas';

{$R *.res}

var
  Publisher: IPublisher<TEdit>;

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Publisher := TPublisher<TEdit>.New;
  Publisher.Attach(MSG_TEXT, TCheckText.New('^[A-z]+$'));
  Publisher.Attach(MSG_INT, TCheckText.New('^[0-9]+$'));
  Publisher.Attach(MSG_DATE, TCheckText.New('^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$'));
  Form1 := TForm1.Create(Application, Publisher);
  Form1.ShowModal;
  Application.Run;

end.
