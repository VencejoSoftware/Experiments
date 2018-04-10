unit resources;

interface

uses
  SysUtils,
  zgl_text,
  zgl_font,
  zgl_keyboard,
  MondoZenGL;

type
  TTetrisResources = class
  private
    FNextOffsetX: SmallInt;
    FNextOffsetY: SmallInt;
    FOffsetX: SmallInt;
    FOffsetY: SmallInt;
    FBackGroundTexture: TMZTexture;
    FGlassTexture: TMZTexture;
    FFont: TMZFont;
    FResourcesFolder: string;
    FFigureTexture: TMZTexture;
    FShadowFigure: TMZTexture;
  public
    constructor Create(ResourcesFolder: string); overload;
    destructor Destroy; override;
  public
    property ResourcesFolder: string read FResourcesFolder;
    property Font: TMZFont read FFont;
    property BackGround: TMZTexture read FBackGroundTexture;
    property FigureTexture: TMZTexture read FFigureTexture;
    property Glass: TMZTexture read FGlassTexture;
    property ShadowFigure: TMZTexture read FShadowFigure;
    property OffsetX: SmallInt read FOffsetX;
    property OffsetY: SmallInt read FOffsetY;
    property NextOffsetX: SmallInt read FNextOffsetX;
    property NextOffsetY: SmallInt read FNextOffsetY;
  end;
implementation

{ TTetrisResources }

constructor TTetrisResources.Create(ResourcesFolder: string);
begin
  inherited Create;
  FResourcesFolder := ResourcesFolder;
  FBackGroundTexture := TMZTexture.Create(FResourcesFolder + 'Background.png');
  FFont := TMZFont.Create(FResourcesFolder + 'font.zfi');
  FFigureTexture := TMZTexture.Create(FResourcesFolder + 'figure1.png');
  FGlassTexture := TMZTexture.Create((FResourcesFolder + 'Glass.png'));
  FShadowFigure := TMZTexture.Create((FResourcesFolder + 'shadowfigure.png'));
  FOffsetX := 79;
  FOffsetY := 110;
  FNextOffsetX := 400;
  FNextOffsetY := 190;
end;

destructor TTetrisResources.Destroy;
begin
  FreeAndNil(FShadowFigure);
  FreeAndNil(FGlassTexture);
  FreeAndNil(FFigureTexture);
  FreeAndNil(FFont);
  FreeAndNil(FBackGroundTexture);
  inherited Destroy;
end;

end.
