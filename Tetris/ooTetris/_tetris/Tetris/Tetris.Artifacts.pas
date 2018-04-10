unit Tetris.Artifacts;

interface
uses System.Classes, System.Types, FMX.Types, Tetris.Pieces, FMX.Graphics, System.Diagnostics, System.SyncObjs,
  System.UITypes;

type
TCurrentPiece = record
  Column     : integer;
  Row        : integer;
  PieceType  : TPieceType;
  FaceNumber : integer;
end;

TScreen = class
  private
    FHeight: single;
    Fwidth: single;
    FPieceHeight: single;
    FPieceWidth: single;
    FNextPiece: TPieceType;
    FRowsCount: integer;
    FColumnsCount: integer;
    FCurrentPiece: TCurrentPiece;
    FTimeStep: integer;
    FLastRefreshOperation: Int64;
    FCriticalSection: TCriticalSection;
    FPlayGround: array of byte;
    FOnGameOver: TNotifyEvent;
    FStopped: boolean;
    FScore: integer;
    FNextPieceBmp: TBitmap;
    function getRows(index: integer): single;
    function getColumns(index: integer): single;
    procedure CalculateNextPiece;
    function IsAPossibleMovement(piece: TCurrentPiece): boolean;
    function PlayGroundFull(piece: TCurrentPiece): boolean;
    procedure SetNextPiece(piece: TCurrentPiece);
    procedure SearchForCompleteRows;
    function getNextPieceBmp: TBitmap;
    function SetCanvasBrushColor(data: Byte; bitmap: TBitmap): Boolean;
  public
    property Height: single read FHeight write FHeight;
    property Width: single read Fwidth write Fwidth;
    property PieceHeight: single read FPieceHeight write FPieceHeight;
    property PieceWidth: single read FPieceWidth write FPieceWidth;
    property RowsCount: integer read FRowsCount;
    property ColumnsCount: integer read FColumnsCount;
    property Rows[index: integer]: single read getRows;
    property Columns[index: integer]: single read getColumns;
    property NextPiece: TPieceType read FNextPiece;
    property NextPieceBmp: TBitmap read getNextPieceBmp;
    property CurrentPiece: TCurrentPiece read FCurrentPiece;
    property TimeStep: integer read FTimeStep;
    property Score: integer read FScore;
    property OnGameOver: TNotifyEvent read FOnGameOver write FOnGameOver;
    constructor Create(Height, Width, PieceHeight, PieceWidth: single; TimeStep: Integer);
    destructor Destroy; override;
    procedure Refresh;
    function Render: TBitmap;
    procedure MoveLeft;
    procedure MoveRight;
    procedure RotateLeft;
    procedure RotateRight;
    procedure Descend;
end;

implementation

uses System.Bindings.Helper, System.SysUtils;

{ TScreen }

procedure TScreen.CalculateNextPiece;
begin
  FCurrentPiece.Column := 0;
  FCurrentPiece.Row := 0;
  FCurrentPiece.PieceType := FNextPiece;
  FCurrentPiece.FaceNumber := 0;
  FNextPiece := TPieceType(Trunc(Random(6)));
  TBindings.Notify(self, 'NextPiece');
  TBindings.Notify(self, 'NextPieceBmp');
end;

constructor TScreen.Create(Height, Width, PieceHeight, PieceWidth: single;
  TimeStep: Integer);
begin
  FHeight := Height;
  Fwidth := Width;
  FPieceHeight := PieceHeight;
  FPieceWidth := PieceWidth;
  FTimeStep := TimeStep;
  FColumnsCount := Trunc(Width / PieceWidth);
  FRowsCount := Trunc(Height / PieceHeight);
  SetLength(FPlayGround, FColumnsCount * FRowsCount);
  FLastRefreshOperation := 0;
  FCriticalSection := TCriticalSection.Create;
  FStopped := false;
  FNextPieceBmp := nil;
  CalculateNextPiece;
end;

procedure TScreen.Descend;
var
  followingPiece: TCurrentPiece;
begin
  FCriticalSection.Acquire;
  followingPiece := CurrentPiece;
  try
     followingPiece.Row := followingPiece.Row + 1;
    if IsAPossibleMovement(followingPiece) then
      FCurrentPiece := followingPiece;
  finally
    FCriticalSection.Release;
  end;
end;

destructor TScreen.Destroy;
begin
  inherited;
  FCriticalSection.Free;
end;

function TScreen.getColumns(index: integer): single;
begin
  Result := PieceWidth * index;
end;

function TScreen.getNextPieceBmp: TBitmap;
var
  face: TPieceFace;
  i: Integer;
  j: Integer;
  rect: TRectF;
begin
  if assigned(FNextPieceBmp) then
    FreeAndNil(FNextPieceBmp);
  FNextPieceBmp := TBitmap.Create(40, 40);
  FNextPieceBmp.Canvas.BeginScene;
  try
    FNextPieceBmp.Canvas.Clear(TAlphaColors.Null);
    face := TPieces[NextPiece][0];
    for i := 0 to 3 do
      for j := 0 to 3 do
      begin
        rect.Top := j * 10;
        rect.Left := i * 10;
        rect.Right := (i + 1) * 10;
        rect.Bottom := (j + 1) * 10;
        if SetCanvasBrushColor(face[i,j], FNextPieceBmp) then
          FNextPieceBmp.Canvas.FillRect(rect, 0, 0, AllCorners, 100);
      end;
  finally
    FNextPieceBmp.Canvas.EndScene;
    Result := FNextPieceBmp;
  end;
end;

function TScreen.getRows(index: integer): single;
begin
  Result := PieceHeight * index;
end;

function TScreen.IsAPossibleMovement(piece: TCurrentPiece): boolean;
var
  i: integer;
  j: integer;
  face: TPieceFace;
begin
  Result := true;
  face := TPieces[piece.PieceType][piece.FaceNumber];
  for i := 0 to 3 do
  begin
    for j := 0 to 3 do
    begin
      if (face[i, j] > 0) and ((FPlayGround[((piece.Row + j) * FColumnsCount) + piece.Column + i] > 0) or
        ((piece.Column + i < 0) or (piece.Column + i >= FColumnsCount) or
        (piece.Row + j < 0) or (piece.Row + j >= FRowsCount)))
      then exit(False);
    end;
  end;
end;

procedure TScreen.MoveLeft;
var
  followingPiece: TCurrentPiece;
begin
  FCriticalSection.Acquire;
  followingPiece := CurrentPiece;
  try
    followingPiece.Column := followingPiece.Column - 1;
    if IsAPossibleMovement(followingPiece) then
      FCurrentPiece := followingPiece;
  finally
    FCriticalSection.Release;
  end;
end;

procedure TScreen.MoveRight;
var
  followingPiece: TCurrentPiece;
begin
  FCriticalSection.Acquire;
  followingPiece := CurrentPiece;
  try
    followingPiece.Column := followingPiece.Column + 1;
    if IsAPossibleMovement(followingPiece) then
      FCurrentPiece := followingPiece;
  finally
    FCriticalSection.Release;
  end;
end;

function TScreen.PlayGroundFull(piece: TCurrentPiece): boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FColumnsCount - 1 do
    if FPlayGround[13 + i] <> 0 then
      Exit(true);
end;

procedure TScreen.Refresh;
var
  followingPiece: TCurrentPiece;
begin
  if (not FStopped) and (((TStopwatch.GetTimeStamp - FLastRefreshOperation) * 0.0001) > FTimeStep)  then
  begin
    FLastRefreshOperation := TStopwatch.GetTimeStamp;
    followingPiece := FCurrentPiece;
    followingPiece.Row := followingPiece.Row + 1;
    FCriticalSection.Acquire;
    try
      if IsAPossibleMovement(followingPiece) then
        FCurrentPiece := followingPiece
      else if PlayGroundFull(followingPiece) then
      begin
        FStopped := true;
        if assigned(FOnGameOver) then FOnGameOver(self);
      end
      else
      begin
        SetNextPiece(FCurrentPiece);
      end;
      SearchForCompleteRows;
    finally
      FCriticalSection.Release;
    end;
  end;
end;

function TScreen.Render: TBitmap;
var
  i: Integer;
  j: Integer;
  rect: TRectF;
  face: TPieceFace;
begin
  FCriticalSection.Acquire;
  try
    Result := TBitmap.Create(Trunc(FWidth), Trunc(FHeight));
    if Result.Canvas.BeginScene then
    try
      Result.Canvas.Clear(TAlphaColors.Null);
      for i := 0 to FColumnsCount - 1 do
      begin
        for j := 0 to FRowsCount - 1 do
        begin
          if not SetCanvasBrushColor(FPlayGround[(j * FColumnsCount) + i], Result) then Continue;
          rect.Top := j * FPieceHeight;
          rect.Left := i * FPieceWidth;
          rect.Right := (i + 1) * FPieceWidth;
          rect.Bottom := (j + 1) * FPieceHeight;
          Result.Canvas.FillRect(rect, 0, 0, AllCorners, 100);
        end;
      end;
      face := TPieces[CurrentPiece.PieceType][CurrentPiece.FaceNumber];
      for i := 0 to 3 do
      begin
        for j := 0 to 3 do
        begin
          if ((CurrentPiece.Column + i < 0) or (CurrentPiece.Column + i >= FColumnsCount) or
              (CurrentPiece.Row + j < 0) or (CurrentPiece.Row + j >= FRowsCount)) then Continue;
          rect.Top := (CurrentPiece.Row + j) * FPieceHeight;
          rect.Left := (CurrentPiece.Column + i) * FPieceWidth;
          rect.Right := (CurrentPiece.Column + i + 1) * FPieceWidth;
          rect.Bottom := (CurrentPiece.Row + j + 1) * FPieceHeight;
          if SetCanvasBrushColor(face[i, j], Result) then
            Result.Canvas.FillRect(rect, 0, 0, AllCorners, 100);
        end;
      end;
    finally
      Result.Canvas.EndScene;
    end;
  finally
    FCriticalSection.Release;
  end;
end;

procedure TScreen.RotateLeft;
var
  followingPiece: TCurrentPiece;
begin
  FCriticalSection.Acquire;
  followingPiece := CurrentPiece;
  try
     if followingPiece.FaceNumber < 3 then
      followingPiece.FaceNumber := followingPiece.FaceNumber + 1
     else
      followingPiece.FaceNumber := 0;
    if IsAPossibleMovement(followingPiece) then
      FCurrentPiece := followingPiece;
  finally
    FCriticalSection.Release;
  end;
end;

procedure TScreen.RotateRight;
var
  followingPiece: TCurrentPiece;
begin
  FCriticalSection.Acquire;
  followingPiece := CurrentPiece;
  try
     if followingPiece.FaceNumber > 0 then
      followingPiece.FaceNumber := followingPiece.FaceNumber - 1
     else
      followingPiece.FaceNumber := 3;
    if IsAPossibleMovement(followingPiece) then
      FCurrentPiece := followingPiece;
  finally
    FCriticalSection.Release;
  end;
end;

procedure TScreen.SearchForCompleteRows;
  procedure FallDown(index: integer);
  var
    j: Integer;
    i: Integer;
  begin
    for j := index downto 1 do
      for i := 0 to FColumnsCount - 1 do
        FPlayGround[(j * FColumnsCount) + i] := FPlayGround[((j - 1) * FColumnsCount) + i];
    for i := 0 to FColumnsCount - 1 do
      FPlayGround[i] := 0;
  end;
var
  i: Integer;
  j: Integer;
  e: boolean;
begin
  for j := FRowsCount - 1 downto 0 do
  begin
    e := True;
    for i := 0 to FColumnsCount - 1 do
      if FPlayGround[(j * FColumnsCount) + i] = 0 then
      begin
        e := false;
        break;
      end;
    if e then
    begin
      FallDown(j);
      FScore := FScore + 1;
      TBindings.Notify(self, 'Score');
      if (fScore mod 50 = 0) then
        FTimeStep := Trunc(0.9 * FTimeStep);
    end;
  end;
end;

function TScreen.SetCanvasBrushColor(data: Byte; bitmap: TBitmap): Boolean;
begin
  Result := true;
  case data of
    1:
      bitmap.Canvas.Fill.Color := TAlphaColors.Red;
    2:
      bitmap.Canvas.Fill.Color := TAlphaColors.Blue;
    3:
      bitmap.Canvas.Fill.Color := TAlphaColors.Green;
    4:
      bitmap.Canvas.Fill.Color := TAlphaColors.Yellow;
    5:
      bitmap.Canvas.Fill.Color := TAlphaColors.Orange;
    6:
      bitmap.Canvas.Fill.Color := TAlphaColors.Brown
    else
      Result := false;
  end;
end;

procedure TScreen.SetNextPiece(piece: TCurrentPiece);
var
  i: integer;
  j: integer;
  face: TPieceFace;
begin
  FCriticalSection.Acquire;
  face := TPieces[piece.PieceType][piece.FaceNumber];
  for j := 0 to 3 do
    for i := 0 to 3 do
      if (piece.Column + i >= 0) and (piece.Column + i < FColumnsCount) and
        (piece.Row + j >= 0) and (piece.Row + j < FRowsCount) then
      begin
        if face[i, j] = 0 then Continue;
        FPlayGround[((piece.Row + j) * FColumnsCount) + piece.Column + i] := face[i, j];
      end;
  CalculateNextPiece;
  FCriticalSection.Release;
end;

end.
