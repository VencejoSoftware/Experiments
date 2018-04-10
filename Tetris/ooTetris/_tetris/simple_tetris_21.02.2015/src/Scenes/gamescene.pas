unit gamescene;

interface

uses
  SysUtils,
  zgl_text,
  zgl_font,
  zgl_keyboard,
  MondoZenGL,
  resources, glass;

const
  ROW_COUNT = 20;
  COLUMN_COUNT = 11;

type

  TGameScene = class(TMZScene)
  private
    FGlass: TGlass;
    Ftext: string;
    FFigureUpdate: TMZTimer;
    FAnimation: TMZTimer;
    FRes: TTetrisResources;
    FOwner: TObject;
  private
    procedure AutoPressDown(Sender: TObject);
  protected
    procedure RenderFrame; override;
    procedure Update(const DeltaTimeMs: Double); override;
    procedure Startup; override;
    procedure Shutdown; virtual;

    procedure KeyDown(const KeyCode: TMZKeyCode); override;
  public
    constructor Create(AOwner: TObject); overload;
  end;

implementation

uses
  game, mainmenuscene;

{ TGameScene }

procedure TGameScene.AutoPressDown(Sender: TObject);
begin
//
  FGlass.Down;
end;

constructor TGameScene.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TGameScene.KeyDown(const KeyCode: TMZKeyCode);
begin
  inherited KeyDown(KeyCode);
  case KeyCode of
    kcLeft:
      FGlass.Left;
    kcRight:
      FGlass.Right;
    kcUp:
      // the direction of rotation is determined by the settings
      // now left
      FGlass.RotateLeft;
    kcDown:
      FGlass.Down;
    kcSpace:
      FGlass.Drop;
  end;

end;

procedure TGameScene.RenderFrame;
var
  Font: TMZFont;
begin
  inherited RenderFrame;
  Font := FRes.Font;
  // render background
  Canvas.BeginBatch;
  Canvas.DrawSprite(FRes.glass, 78, 109, FRes.glass.Width, FRes.glass.Height);

  Canvas.DrawText(Font, 10, 10, 'This is Tetris Game ' + Ftext);
  Canvas.DrawText(Font, 10, 40, 'Press "Esc" to quit');
  // render the contents of glass
  FGlass.Draw(Canvas);
  // draw border
  Canvas.DrawSprite(FRes.BackGround, 0, 0, FRes.BackGround.Width, FRes.BackGround.Height);
  FGlass.DrawNextFigure(Canvas);
  Canvas.EndBatch;
end;

procedure TGameScene.Shutdown;
begin
  FreeAndNil(FFigureUpdate);
  FreeAndNil(FGlass);
  FreeAndNil(FRes);
end;

procedure TGameScene.Startup;
begin
  inherited Startup;
  // get resources
  FRes := TMenuScene(FOwner).TetrisResources;
  // create GLass
  FGlass := TGlass.Create(FRes);
  // Timer for Move Figure down
{$IFDEF FPC}
  FFigureUpdate := TMZTimer.Create(@AutoPressDown, 1500);
{$ELSE}
  FFigureUpdate := TMZTimer.Create(AutoPressDown, 1500);
{$ENDIF}
end;

procedure TGameScene.Update(const DeltaTimeMs: Double);
begin
  inherited Update(DeltaTimeMs);
  if TMZKeyboard.IsKeyPressed(kcEscape) then
    // {Go back to the owner scene
    Application.SetScene(TMZScene(FOwner));

  // Glass Update
  FGlass.Update(DeltaTimeMs);
  // Clear keyboard state
  TMZKeyboard.ClearState;
end;

end.
