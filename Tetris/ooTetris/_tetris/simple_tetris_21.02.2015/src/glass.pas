unit glass;

interface

uses
  sysutils, figure, resources,
  MondoZenGL;

type
  TEvent = (evtDelete, evtMoveDown, evtNone);

  TGlassCell = record
    Color: Cardinal;
    Alpha: Single;
    Event: TEvent;
    offsetY: Single;
    DownCount: Byte;
  end;

  TGlassArray = array [0 .. 10, 0 .. 21] of TGlassCell;

  TGlass = class
  private
    // resources link
    FRes: TTetrisResources;
    // Glass array
    FGlass: TGlassArray;
    // Current figure
    FFigure: TFigure;
    // flag for delete row
    FDeleteRow: Boolean;
    // flag for move cubes down
    FMoveAllCubesDown: Boolean;
    // down move speed afte remove
    FDownSpeed: integer;
  private
    function _availablePosition(offsetX, offsetY, offsetR: ShortInt): Boolean;
    // analysys move
    procedure _startAnalysis;
    // add figure to glass
    procedure _addFigureToGlass;
    // render shadow figure
    procedure _drawShadowFigure(const Canvas: TMZCanvas);
    // delete row
    procedure _deletRow(const DeltaTimeMs: Double);
    // move all cube down
    procedure _moveAllCubesDown(const DeltaTimeMs: Double);
    // get next figure
    procedure _GetNextFigure;
  public
    constructor Create(const resources: TTetrisResources); overload;
    destructor Destroy; override;
  public
    // Draw glass
    procedure Draw(const Canvas: TMZCanvas);
    // Draw next figure in glass
    procedure DrawNextFigure(const Canvas: TMZCanvas);
    // Clear Glass
    procedure Clear;
    // Update Glass
    procedure Update(const DeltaTimeMs: Double);
  public
    // event from scene
    // move left 1 position
    procedure Left;
    // move right 1 position
    procedure Right;
    // rotate left 1 position
    procedure RotateLeft;
    // rotate right 1 position
    procedure RotateRight;
    // move down 1 position
    procedure Down;
    // drop figure
    procedure Drop;
    // pause
    procedure Pause;
    // resume
    procedure Resume;
    // start new
    procedure StartNewGame;
  end;

implementation

{ TGlass }

procedure TGlass.Clear;
var
  i, j: integer;
begin
  for i := 0 to 10 do
    for j := 0 to 21 do
    begin
      FGlass[i, j].Color := 0;
      FGlass[i, j].Alpha := 255;
      FGlass[i, j].offsetY := 0;
      FGlass[i, j].Event := evtNone;
      FGlass[i, j].DownCount := 0;
    end;
end;

constructor TGlass.Create(const resources: TTetrisResources);
begin
  inherited Create;
  FRes := resources;
  Clear;
  // for debug
{  FGlass[0, 21].Color := $FFFFFF;
  FGlass[1, 21].Color := $FFFFFF;
  FGlass[2, 21].Color := $FFFFFF;
  FGlass[3, 21].Color := $FFFFFF;
  FGlass[4, 21].Color := $FFFFFF;
  FGlass[5, 21].Color := $FFFFFF;
  FGlass[7, 21].Color := $FFFFFF;
  FGlass[8, 21].Color := $FFFFFF;
  FGlass[9, 21].Color := $FFFFFF;
  FGlass[10, 21].Color := $FFFFFF;
  FGlass[0, 20].Color := $FFFFFF;
  FGlass[1, 20].Color := $FFFFFF;
  FGlass[2, 20].Color := $FFFFFF;
  FGlass[3, 20].Color := $FFFFFF;
  FGlass[4, 20].Color := $FFFFFF;
  FGlass[5, 20].Color := $FFFFFF;
  FGlass[7, 20].Color := $FFFFFF;
  FGlass[8, 20].Color := $FFFFFF;
  FGlass[9, 20].Color := $FFFFFF;
  FGlass[10, 20].Color := $FFFFFF;
  FGlass[10, 19].Color := $FFFFFF; }
  // create figure object
  FFigure := TFigure.Create(FRes);
  _GetNextFigure;
end;

destructor TGlass.Destroy;
begin
  FreeAndNil(FFigure);
  inherited;
end;

procedure TGlass.Drop;
begin
  if not(FDeleteRow or FMoveAllCubesDown) then

    while True do
    begin
      if _availablePosition(0, 1, 0) then
        FFigure.Down
      else
      begin
        _addFigureToGlass;
        _startAnalysis;
        exit;
      end;
    end;
end;

procedure TGlass.Left;
begin
  if not(FDeleteRow or FMoveAllCubesDown) then

    if _availablePosition(-1, 0, 0) then
      FFigure.Left;
end;

procedure TGlass.Right;
begin
  if not(FDeleteRow or FMoveAllCubesDown) then

    if _availablePosition(1, 0, 0) then
      FFigure.Right;
end;

procedure TGlass.Down;
begin
  if not(FDeleteRow or FMoveAllCubesDown) then

    if _availablePosition(0, 1, 0) then
      FFigure.Down
    else
    begin
      _addFigureToGlass;
      _startAnalysis;
    end;
end;

procedure TGlass.Pause;
begin

end;

procedure TGlass.Resume;
begin

end;

procedure TGlass.RotateLeft;
begin
  if not(FDeleteRow or FMoveAllCubesDown) then
  begin
    FFigure.RotateLeft;
    if not _availablePosition(0, 0, 0) then
      FFigure.RotateRight;
  end;
end;

procedure TGlass.RotateRight;
begin
  if not(FDeleteRow or FMoveAllCubesDown) then
  begin
    FFigure.RotateRight;
    if not _availablePosition(0, 0, 0) then
      FFigure.RotateLeft;
  end;
end;

procedure TGlass._startAnalysis;
var
  x, y: ShortInt;
  Count: Byte;
  dx, dy: ShortInt;
begin
  // calc rows for delete
  for y := 21 downto 0 do
  begin
    Count := 0;
    for x := 0 to 10 do
    begin
      if FGlass[x, y].Color <> 0 then
        inc(Count);
    end;
    // mark rows for delete
    if Count = 11 then
    begin
      for x := 0 to 10 do
        FGlass[x, y].Event := evtDelete;
      // set flag for delete row
      FDeleteRow := True;
    end;
    //

  end;
  if not(FDeleteRow or FMoveAllCubesDown) then
    _GetNextFigure;
end;

procedure TGlass.StartNewGame;
begin
// not released
end;

procedure TGlass.Update(const DeltaTimeMs: Double);
begin
  if FMoveAllCubesDown then
    _moveAllCubesDown(DeltaTimeMs);
  if FDeleteRow then
    _deletRow(DeltaTimeMs);
end;

procedure TGlass.Draw(const Canvas: TMZCanvas);
var
  width, height: integer;
  x, y: SmallInt;
  i, j: SmallInt;
  Alpha: Byte;
begin

  width := FRes.FigureTexture.width;
  height := FRes.FigureTexture.height;

  // Draw all cubes in glass
  for i := 0 to 10 do
    for j := 0 to 21 do
      if FGlass[i, j].Color <> 0 then
      begin
        x := i * width + FRes.offsetX;
        y := j * height + FRes.offsetY + trunc(FGlass[i, j].offsetY);
        Canvas.TextureColor := FGlass[i, j].Color;
        Alpha := trunc(FGlass[i, j].Alpha);
        Canvas.DrawSprite(FRes.FigureTexture, x, y, width, height, 0, Alpha, [efBlend, efColor]);
      end;
  // draw figure if possible
  if not(FDeleteRow or FMoveAllCubesDown) then
  begin
    _drawShadowFigure(Canvas);
    FFigure.DrawCurrentFigure(Canvas);
  end;
end;

procedure TGlass.DrawNextFigure(const Canvas: TMZCanvas);
begin
  FFigure.DrawNextFigure(Canvas);
end;

procedure TGlass._addFigureToGlass;
var
  i: integer;
  x: ShortInt;
  y: ShortInt;
begin
  for i := 0 to 3 do
  begin
    x := FFigure.posX[i] + FFigure.centerX;
    y := FFigure.posY[i] + FFigure.centerY;
    FGlass[x, y].Color := FFigure.CurrentColor;
  end;
end;

function TGlass._availablePosition(offsetX, offsetY, offsetR: ShortInt): Boolean;
var
  i: integer;
  x: ShortInt;
  y: ShortInt;
begin
  Result := false;
  for i := 0 to 3 do
  begin
    x := FFigure.posX[i] + FFigure.centerX + offsetX;
    y := FFigure.posY[i] + FFigure.centerY + offsetY;
    // check right border
    if x > 10 then
      exit;
    // check left
    if x < 0 then
      exit;
    // check down
    if y > 21 then
      exit;
    // check collision with cubes in glass
    if y >= 0 then
      if FGlass[x, y].Color <> 0 then
        exit;
  end;
  Result := True;
end;

procedure TGlass._deletRow(const DeltaTimeMs: Double);
var
  x, y: integer;
  tmpFlag: Boolean;
  dy: integer;
  Count: integer;
begin
  tmpFlag := false;
  for y := 0 to 21 do
    for x := 0 to 10 do
      if FGlass[x, y].Event = evtDelete then
      begin
        tmpFlag := True;
        FGlass[x, y].Alpha := FGlass[x, y].Alpha - (DeltaTimeMs * 255) / 200;
        if trunc(FGlass[x, y].Alpha) <= 0 then
        begin
          FGlass[x, y].Color := 0;
          FGlass[x, y].Event := evtNone;
          FGlass[x, y].Alpha := 255;
          for dy := y - 1 downto 0 do
            if FGlass[x, dy].Event <> evtDelete then
            begin
              FGlass[x, dy].DownCount := FGlass[x, dy].DownCount + 1;
              FGlass[x, dy].offsetY := FGlass[x, dy].offsetY - 27;
              FGlass[x, dy].Event := evtMoveDown;
              FDownSpeed := trunc(FGlass[x, dy].offsetY);
            end;
        end;
      end;

  if not tmpFlag then
  begin
    for y := 21 downto 0 do
      for x := 0 to 10 do
      begin
        Count := FGlass[x, y].DownCount;
        FGlass[x, y + Count].Color := FGlass[x, y].Color;
        FGlass[x, y + Count].offsetY := FGlass[x, y].offsetY;
        FGlass[x, y + Count].Event := FGlass[x, y].Event;
        FGlass[x, y + Count].DownCount := 0;
      end;

    FDeleteRow := false;
      // set flag for move top cubes down
    FMoveAllCubesDown := True;
  end;
end;

procedure TGlass._drawShadowFigure(const Canvas: TMZCanvas);
var
  width, height: integer;
  y: integer;
  i: integer;
  dx, dy: integer;

begin
  // calculate maximum y coordinate
  y := 0;
  while _availablePosition(0, y, 0) do
    inc(y);
  y := y - 1 + FFigure.centerY;

  dx := 0;
  dy := 0;
  width := FRes.FigureTexture.width;
  height := FRes.FigureTexture.height;
  for i := 0 to 3 do
  begin
    dx := FFigure.posX[i] + FFigure.centerX;
    dy := FFigure.posY[i] + y;
    dx := dx * width + FRes.offsetX;
    dy := dy * height + FRes.offsetY;
    Canvas.TextureColor := $FFFFFF;
    Canvas.DrawSprite(FRes.FigureTexture, dx, dy, width, height, 0, $2F, [efBlend, efColor]);

  end;
//
end;

procedure TGlass._GetNextFigure;
var
  i: integer;
begin
  //
  if True then
    FFigure.GetNextFigure;
  for i := 0 to 3 do
  begin
    if not _availablePosition(FFigure.posX[i], FFigure.posY[i], 0) then
      Clear;
  end;

end;

procedure TGlass._moveAllCubesDown(const DeltaTimeMs: Double);
var
  x, y: integer;
  tmpFlag: Boolean;
  dy: integer;
  Count: integer;
begin
  tmpFlag := false;
  for y := 21 downto 0 do
    for x := 0 to 10 do
      if FGlass[x, y].Event = evtMoveDown then
      begin
        tmpFlag := True;
        FGlass[x, y].offsetY := FGlass[x, y].offsetY - (DeltaTimeMs * FDownSpeed) / 200;
        if trunc(FGlass[x, y].offsetY) >= 0 then
        begin
          FGlass[x, y].offsetY := 0;
          FGlass[x, y].Event := evtNone;
          FGlass[x, y].DownCount := 0;
        end;
      end;
  if not tmpFlag then
  begin
    FMoveAllCubesDown := false;
      // set flag for move top cubes down
    _GetNextFigure;
  end;

end;

end.
