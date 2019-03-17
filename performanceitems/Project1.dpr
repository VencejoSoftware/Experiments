program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1} ,
  IfTest in 'IfTest.pas',
  RecordTest in 'RecordTest.pas',
  ObjectTest in 'ObjectTest.pas',
  ArrayConstTest in 'ArrayConstTest.pas',
  ArrayConstRecordTest in 'ArrayConstRecordTest.pas',
  ArrayConstRecordPointerTest in 'ArrayConstRecordPointerTest.pas',
  RecordPointerTest in 'RecordPointerTest.pas',
  Data in 'Data.pas',
  DataRecord in 'DataRecord.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
