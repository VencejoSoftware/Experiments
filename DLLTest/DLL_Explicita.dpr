program DLL_Explicita;

uses
  Forms,
  UnExplicita in 'UnExplicita.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
