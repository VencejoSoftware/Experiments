program Tetris_fly;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  About in 'About.pas' {Form2},
  Records in 'Records.pas' {Form4};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Тетрис';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
