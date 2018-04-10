program Tetris;

uses
  Forms,
  UTetris in 'UTetris.pas' {Form1},
  BestScor in 'BestScor.pas' {BestScorDlg};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TBestScorDlg, BestScorDlg);
  Application.Run;
end.
