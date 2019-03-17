program DLL_Implicita;

uses
  Forms,
  UnImplicita in 'UnImplicita.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
