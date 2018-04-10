program TetrisGame;

uses
  Forms,
  Tetris in 'Tetris.pas' {FrmMain},
  uHelp in 'uHelp.pas' {frmHelp};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmHelp, frmHelp);
  Application.Run;
end.
