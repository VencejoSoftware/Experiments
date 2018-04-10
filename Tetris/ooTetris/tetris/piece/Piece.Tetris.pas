unit Piece.Tetris;

interface

uses
  VCL.Graphics, System.Types,
  Vertex.Intf, Grid.Tetris,
  Rect.Transform, Piece.Custom;

type
  TPieceDim = 1 .. 4;
  TPiecePattern = array [TPieceDim, TPieceDim] of Byte;

  TPieceMovement = (pmLeft, pmRight, pmDown, pmRotate);

  // Class to define a tetris piece
  TTetrisPiece = class(TPieceCustom)
  private
    arrShape: TPiecePattern;
    iBrickSize: Integer;
    procedure Rotate;
  protected
    function GetBrickRect(const aLeft, aTop: Integer): TRect;
    function IsBrickInPattern(const aDimensionX, aDimensionY: Integer): Boolean;
    function GetWidth: TVertexValue; override;
    function GetHeight: TVertexValue; override;

    procedure DoDrawBrick(aCanvas: TCanvas; const aLeft, aTop: TVertexValue); virtual;
  public
    function SetShape(const aShape: TPiecePattern): TTetrisPiece;
    function SetColor(const aColor: TColor): TTetrisPiece;
    function SetBrickSize(const aBrickSize: Integer): TTetrisPiece;
    function SetGridParent(aGridParent: TGridTetris): TTetrisPiece;
    function CanMoveToPos(const aX, aY: Integer): Boolean;
    function IsVisible: Boolean;

    procedure ConsumeBrick(const aDimX, aDimY: TPieceDim);
    procedure Draw(aCanvas: TCanvas); virtual;
    procedure ChangePosition(const aMovement: TPieceMovement);

    property BrickSize: Integer read iBrickSize write iBrickSize;
  end;

implementation

function TTetrisPiece.SetBrickSize(const aBrickSize: Integer): TTetrisPiece;
begin
  iBrickSize := aBrickSize;
  Result := Self;
end;

function TTetrisPiece.SetColor(const aColor: TColor): TTetrisPiece;
begin
  Color := aColor;
  Result := Self;
end;

function TTetrisPiece.SetGridParent(aGridParent: TGridTetris): TTetrisPiece;
begin
//  SetContainer(aGridParent);
  Result := Self;
end;

function TTetrisPiece.SetShape(const aShape: TPiecePattern): TTetrisPiece;
begin
  arrShape := aShape;
  Result := Self;
end;

function TTetrisPiece.GetBrickRect(const aLeft, aTop: Integer): TRect;
begin
  Result.Left := aLeft - 1;
  Result.Top := aTop - 1;
  Result.Width := BrickSize + 2;
  Result.Height := BrickSize + 2;
end;

function TTetrisPiece.GetHeight: TVertexValue;
begin
  Result := BrickSize * 4;
end;

function TTetrisPiece.GetWidth: TVertexValue;
begin
  Result := BrickSize * 4;
end;

procedure Draw3d(aCanvas: TCanvas; const aRect: TRect);
begin
  aCanvas.Pen.Style := psSolid;
  aCanvas.Pen.Width := 1;
  aCanvas.Brush.Style := bsClear;
  // Dark
  aCanvas.Pen.Color := clBlack;
  aCanvas.MoveTo(aRect.Right, aRect.Top);
  aCanvas.LineTo(aRect.Right, aRect.Bottom);
  aCanvas.LineTo(aRect.Left, aRect.Bottom);
  // Light
  aCanvas.Pen.Color := clWhite;
  aCanvas.MoveTo(aRect.Left, aRect.Bottom);
  aCanvas.LineTo(aRect.Left, aRect.Top);
  aCanvas.LineTo(aRect.Right + 1, aRect.Top);
end;

procedure TTetrisPiece.DoDrawBrick(aCanvas: TCanvas; const aLeft, aTop: TVertexValue);
const
  OFFSET_3D = 1;
var
  utpBrickRect: TRect;
begin
  // Revisar
  // utpBrickRect := GetBrickRect(aLeft, aTop);
  // aCanvas.Pen.Style := psClear;
  // aCanvas.Brush.Color := Color;
  // aCanvas.Brush.Style := bsSolid;
  // aCanvas.Rectangle(utpBrickRect);
  // ReduceRect(utpBrickRect, OFFSET_3D, OFFSET_3D);
  // Draw3d(aCanvas, utpBrickRect);
end;

function TTetrisPiece.IsBrickInPattern(const aDimensionX, aDimensionY: Integer): Boolean;
begin
  Result := (arrShape[aDimensionX, aDimensionY] = 1);
end;

procedure TTetrisPiece.Rotate;
var
  iDimX, iDimY, iMaxX: Integer;
  arrEmpty: TPiecePattern;
begin
  iMaxX := high(arrShape[1]);
  for iDimX := iMaxX downto low(arrShape[1]) do
    for iDimY := low(arrShape[2]) to high(arrShape[2]) do
      arrEmpty[iDimY, iMaxX + 1 - iDimX] := arrShape[iDimX, iDimY];
  Move(arrEmpty, arrShape, SizeOf(arrShape));
end;

procedure TTetrisPiece.ChangePosition(const aMovement: TPieceMovement);
begin
  case aMovement of
    pmLeft:
      SetLeft(Left - BrickSize);
    pmRight:
      SetLeft(Left + BrickSize);
    pmDown:
      SetTop(Top + BrickSize);
    pmRotate:
      Rotate;
  end;
end;

function TTetrisPiece.IsVisible: Boolean;
begin

end;

function TTetrisPiece.CanMoveToPos(const aX, aY: Integer): Boolean;
begin

end;

procedure TTetrisPiece.ConsumeBrick(const aDimX, aDimY: TPieceDim);
begin

end;

procedure TTetrisPiece.Draw(aCanvas: TCanvas);
var
  iDimX, iDimY: Integer;
begin
  for iDimX := low(arrShape[1]) to high(arrShape[1]) do
    for iDimY := low(arrShape[2]) to high(arrShape[2]) do
      if IsBrickInPattern(iDimX, iDimY) then
        DoDrawBrick(aCanvas, Left + BrickSize * Pred(iDimX), Top + BrickSize * Pred(iDimY));
end;

end.
