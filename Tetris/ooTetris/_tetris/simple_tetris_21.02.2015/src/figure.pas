unit figure;

interface

uses
  sysutils, resources,
  MondoZenGL;

const

  // Description all figures
  // 1 - number figure  0..6
  // 2 - rotate figure  0..3
  // 3 - cube number    0..3
  // 4 - position       0-x 1-y
  FigureLocation: array [0 .. 6, 0 .. 3, 0 .. 3, 0 .. 1] of ShortInt = ( // фигуры
    (((-1, 0), (0, 0), (1, 0), (2, 0)), ((0, -1), (0, 0), (0, 1), (0, 2)), ((-1, 0), (0, 0), (1, 0), (2, 0)),
    ((0, -1), (0, 0), (0, 1), (0, 2))), // I
    (((0, 0), (1, 0), (0, 1), (1, 1)), ((0, 0), (1, 0), (0, 1), (1, 1)), ((0, 0), (1, 0), (0, 1), (1, 1)),
    ((0, 0), (1, 0), (0, 1), (1, 1))), // O
    (((0, -1), (0, 0), (0, 1), (-1, 1)), ((-1, -1), (-1, 0), (0, 0), (1, 0)), ((0, -1), (1, -1), (0, 0), (0, 1)),
    ((-1, 0), (0, 0), (1, 0), (1, 1))), // J
    (((0, -1), (0, 0), (0, 1), (1, 1)), ((-1, 1), (-1, 0), (0, 0), (1, 0)), ((-1, -1), (0, -1), (0, 0), (0, 1)),
    ((-1, 0), (0, 0), (1, 0), (1, -1))), // L
    (((-1, 0), (0, 0), (0, -1), (1, -1)), ((0, -1), (0, 0), (1, 0), (1, 1)), ((-1, 0), (0, 0), (0, -1), (1, -1)),
    ((0, -1), (0, 0), (1, 0), (1, 1))), // S
    (((-1, -1), (0, -1), (0, 0), (1, 0)), ((1, -1), (1, 0), (0, 0), (0, 1)), ((-1, -1), (0, -1), (0, 0), (1, 0)),
    ((1, -1), (1, 0), (0, 0), (0, 1))), // Z
    (((-1, 0), (0, 0), (1, 0), (0, -1)), ((0, -1), (0, 0), (0, 1), (1, 0)), ((-1, 0), (0, 0), (1, 0), (0, 1)),
    ((-1, 0), (0, 0), (0, -1), (0, 1))) // T
    );

type
  { figure types
    [][][][] - 1  (I)

    [][]
    [][]  - 2      (O)

      []
      []    - 3      (J)
    [][]

    []
    []
    [][]   - 4     (L)

      [][]
    [][]    - 5    (S)

    [][]
      [][]  - 6     (Z)

      []
    [][][]  - 7     (T)
  }

{ Summary:
      Figure class
    Remarks:
      Figure class }
  TFigure = class
  private
    // позиция в стакане
    FposX: ShortInt;
    FposY: ShortInt;

    FRes: TTetrisResources;
    FCurrentFigure: byte;
    FCurrentRotate: ShortInt;
    FCurrentColor: Cardinal;
    FNextFigure: byte;
    FNextRotate: ShortInt;
    FNextColor: Cardinal;

    procedure SetPosX(const Value: ShortInt);
    procedure SetPosY(const Value: ShortInt);
    function GetPosX(itemIndex: byte): ShortInt;
    function GetPosY(itemIndex: byte): ShortInt;
    // figure collor
    function GetFigureColor(FigureNumber: byte): Cardinal;
  public
    constructor Create(const resources: TTetrisResources); overload;
    // Draw figure
    procedure DrawCurrentFigure(const Canvas: TMZCanvas);
    // Draw next figure
    procedure DrawNextFigure(const Canvas: TMZCanvas);
    // init new figure
    procedure GetNextFigure();
    // move left
    procedure Left();
    // move right
    procedure Right();
    // rotate left
    procedure RotateLeft();
    // rotate right
    procedure RotateRight();
    // move down 1;
    procedure Down();
    // move down 1;
    procedure Up();
  public
    property centerX: ShortInt read FposX write SetPosX;
    property centerY: ShortInt read FposY write SetPosY;
    property CurrentFigure: byte read FCurrentFigure;
    property CurrentRotate: ShortInt read FCurrentRotate;
    property CurrentColor: Cardinal read FCurrentColor;
    property NextFigure: byte read FNextFigure;
    property NextRotate: ShortInt read FNextRotate;
    property NextColor: Cardinal read FNextColor;
    property posX[itemIndex: byte]: ShortInt read GetPosX;
    property posY[itemIndex: byte]: ShortInt read GetPosY;
  end;

implementation

{ TFigure }

constructor TFigure.Create(const resources: TTetrisResources);
begin
  inherited Create;
  FRes := resources;
  FNextFigure := random(7);
  FNextRotate := random(4);
  FNextColor := GetFigureColor(NextFigure);
//  FTexture := resources.FigureTexture;
end;

procedure TFigure.Down;
begin
  centerY := centerY + 1;
end;

procedure TFigure.DrawCurrentFigure(const Canvas: TMZCanvas);
var
  width, height: integer;
  x, y: integer;
  i: integer;
begin
  //
  Canvas.TextureColor := CurrentColor;

  width := FRes.FigureTexture.width;
  height := FRes.FigureTexture.height;
  // draw current figure
  for i := 0 to 3 do
  begin
    // draw current figure
    x := centerX * width + FRes.OffsetX;
    y := centerY * height + FRes.OffsetY;
    x := x + width * FigureLocation[CurrentFigure, CurrentRotate, i, 0];
    y := y + height * FigureLocation[CurrentFigure, CurrentRotate, i, 1];
    Canvas.DrawSprite(FRes.FigureTexture, x, y, width, height, 0, $FF, [efBlend, efColor]);
  end;

end;

procedure TFigure.DrawNextFigure(const Canvas: TMZCanvas);
var
  width, height: Integer;
  x, y: Single;
  i: integer;
  Scale: Single;
begin
  //
  Canvas.TextureColor := NextColor;

  Scale := 0.6;
  width := trunc(FRes.FigureTexture.width * scale);
  height := Trunc(FRes.FigureTexture.height* scale);
  // draw current figure
  for i := 0 to 3 do
  begin
    // draw next figure
    x := FRes.NextOffsetX;
    y := FRes.NextOffsetY;
    x := x + width * FigureLocation[NextFigure, NextRotate, i, 0];
    y := y + height * FigureLocation[NextFigure, NextRotate, i, 1];
    Canvas.DrawSprite(FRes.FigureTexture, x, y, width, height, 0, $FF, [efBlend, efColor]);
  end;
end;

function TFigure.GetFigureColor(FigureNumber: byte): Cardinal;
begin
  case FigureNumber of
    0:
      Result := $FF0000;
    1:
      Result := $00FF00;
    2:
      Result := $0000FF;
    3:
      Result := $FFFF00;
    4:
      Result := $00FFFF;
    5:
      Result := $FF00FF;
    6:
      Result := $FFFFFF;
  end;
end;

function TFigure.GetPosX(itemIndex: byte): ShortInt;
begin
  Result := FigureLocation[CurrentFigure, CurrentRotate, itemIndex, 0];
end;

function TFigure.GetPosY(itemIndex: byte): ShortInt;
begin
  Result := FigureLocation[CurrentFigure, CurrentRotate, itemIndex, 1];
end;

procedure TFigure.Left;
begin
  centerX := centerX - 1;
end;

procedure TFigure.GetNextFigure;
begin
  centerX := 5;
  centerY := 0;
  FCurrentFigure := FNextFigure;
  FCurrentRotate := FNextRotate;
  FCurrentColor := FNextColor;
  FNextFigure := random(7);
  FNextRotate := random(4);
  FNextColor := GetFigureColor(FNextFigure);
end;

procedure TFigure.Right;
begin
  centerX := centerX + 1
end;

procedure TFigure.RotateLeft;
begin
  FCurrentRotate := FCurrentRotate - 1;
  if FCurrentRotate < 0 then
    FCurrentRotate := 3;
end;

procedure TFigure.RotateRight;
begin
  FCurrentRotate := FCurrentRotate + 1;
  if FCurrentRotate > 3 then
    FCurrentRotate := 0;
end;

procedure TFigure.SetPosX(const Value: ShortInt);
begin
  FposX := Value;
  if FposX < 0 then
    FposX := 0;
end;

procedure TFigure.SetPosY(const Value: ShortInt);
begin
  FposY := Value;
end;

procedure TFigure.Up;
begin
  centerY := centerY - 1;
end;

end.
