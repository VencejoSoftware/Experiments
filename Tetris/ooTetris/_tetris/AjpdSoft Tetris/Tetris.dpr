program Tetris;

uses
  Forms,
  UnidadTetris in 'UnidadTetris.pas' {formTetris},
  UnidadMejoresTiempos in 'UnidadMejoresTiempos.pas' {formPuntuaciones};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'AjpdSoft Tetris';
  Application.CreateForm(TformTetris, formTetris);
  Application.CreateForm(TformPuntuaciones, formPuntuaciones);
  Application.Run;
end.
