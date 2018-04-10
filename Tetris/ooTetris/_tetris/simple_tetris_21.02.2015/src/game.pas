unit game;

interface

uses
  SysUtils,
  zgl_text,
  zgl_font,
  zgl_keyboard,
  MondoZenGL,
  mainmenuscene,
  resources;

type
  TGameApplication = class(TMZApplication)
  private
    FStartupScene: TMZScene;

  protected
    procedure Startup; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Run;
    property StartupScene: TMZScene read FStartupScene;
  end;

procedure runGame;

implementation

procedure runGame();
var
  App: TGameApplication;
begin
  App := TGameApplication.Create;
  App.Options := App.Options + [aoUseInputEvents];
  App.Run;
end;

{TDemoApplication}

constructor TGameApplication.Create;
begin
  inherited Create;
  Randomize;
  Options := Options + [aoShowCursor];
  Caption := 'Tetris';
  ScreenWidth := 455;
  ScreenHeight := 768;
  FStartupScene := TMenuScene.Create;
  FStartupScene.AutoFree := False;
end;

destructor TGameApplication.Destroy;
begin
  FStartupScene.Free;
  inherited Destroy;
end;

procedure TGameApplication.Run;
begin
  SetScene(FStartupScene);
end;

procedure TGameApplication.Startup;
begin
  inherited Startup;

end;

end.
