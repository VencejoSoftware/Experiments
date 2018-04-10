unit mainmenuscene;


interface



uses
  SysUtils,
  zgl_text,
  zgl_font,
  zgl_keyboard,
  MondoZenGL,
  gamescene, resources;

const
  RESOURCE_DIRECTORY = '../../data/';


type

  TMenuScene = class(TMZScene)
  private
    FTetrisResources: TTetrisResources;
  protected
    procedure RenderFrame; override;
    procedure Startup; override;

    procedure Update(const DeltaTimeMs: double); override;
  public
    property TetrisResources: TTetrisResources read FTetrisResources;
  end;

implementation

uses
  Game;

{TMenuScene}

procedure TMenuScene.RenderFrame;

var
  Font: TMZFont;
  rect: TMZRect;

begin
  inherited RenderFrame;

  Font := TetrisResources.Font;
  rect.X := 10;
  rect.Y := 290;
  rect.W := 435;
  rect.H := 50;
  Canvas.DrawText(Font, rect, 1.7, 1, 'TETRIS', 255, $FFFF00, [tfVAlignCenter, tfHAlignCenter]);

  rect.Y := 200;
  Canvas.DrawText(Font, rect, 1.2, 1, 'Press "1" for start game' , 255, $FFFFFF, [tfVAlignCenter, tfHAlignCenter]);
  rect.Y := 350;
  Canvas.DrawText(Font, rect, 1.2, 1, 'Left - Left Key', 255, $FFFFFF, [tfVAlignCenter, tfHAlignCenter]);
  rect.Y := 380;
  Canvas.DrawText(Font, rect, 1.2, 1, 'Right - Right Key', 255, $FFFFFF, [tfVAlignCenter, tfHAlignCenter]);
  rect.Y := 410;
  Canvas.DrawText(Font, rect, 1.2, 1, 'Rotate - Up key', 255, $FFFFFF, [tfVAlignCenter, tfHAlignCenter]);
  rect.Y := 440;
  Canvas.DrawText(Font, rect, 1.2, 1, 'Down - Down key', 255, $FFFFFF, [tfVAlignCenter, tfHAlignCenter]);
  rect.Y := 470;
  Canvas.DrawText(Font, rect, 1.2, 1, 'Drop - Space key', 255, $FFFFFF, [tfVAlignCenter, tfHAlignCenter]);
  rect.Y := 500;
  Canvas.DrawText(Font, rect, 1.2, 1, 'Quit - ESC key', 255, $FFFFFF, [tfVAlignCenter, tfHAlignCenter]);

end;

procedure TMenuScene.Startup;
begin
  inherited Startup;
  // create resources
  FTetrisResources := TTetrisResources.Create(RESOURCE_DIRECTORY);
end;

procedure TMenuScene.Update(const DeltaTimeMs: double);


begin
  inherited Update(DeltaTimeMs);

  if TMZKeyboard.IsKeyPressed(kcEscape) then
    Application.Quit;
  if TMZKeyboard.IsKeyPressed(kc1) or TMZKeyboard.IsKeyPressed(kcKP1) then
    Application.SetScene(TGameScene.Create(Self));

  TMZKeyboard.ClearState;
end;

end.
