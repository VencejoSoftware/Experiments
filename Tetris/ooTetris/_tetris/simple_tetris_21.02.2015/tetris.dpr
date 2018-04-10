program tetris;

{$R *.res}

uses
  game in 'src\game.pas',
  mainmenuscene in 'src\Scenes\mainmenuscene.pas',
  gamescene in 'src\Scenes\gamescene.pas',
  figure in 'src\figure.pas',
  resources in 'src\resources.pas',
  glass in 'src\glass.pas';

begin
  RunGame();
end.
