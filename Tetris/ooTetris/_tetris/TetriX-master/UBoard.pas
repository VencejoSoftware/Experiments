unit UBoard;

interface

uses
  Classes, Windows, Graphics, Controls, Contnrs, ExtCtrls,
  Messages, Forms, SysUtils, Dialogs, UBrick, UShape, TetrixConst, Math,
  UMsg;

type
  TBoardLastEmptyRec = record
    EndPoint: TPoint;
    Res: Boolean;
    Distance: Integer;
  end;

type
  TBoard = class(TGraphicControl)
  private
    Board: TBitmap;
    OptionsWidth: Integer;
    Msg: TMsg;
    ShapeList: TObjectList;
    BrickList: TObjectList;

    GameTimer: TTimer;

    Positions: array[0 .. BoardYLines - 1] of string;

    GameLines: Integer;
    GameLevel: Integer;
    GameScore: Integer;

    DrawShapeEndPoint: Boolean;
    TipShapeDistance: Integer;
    ShowMessageFlag: Boolean;
    procedure OnMyTimer(Sender: TObject);
    function GetShapes(index: Integer): TShape;
    procedure SetShapes(index: Integer; const Value: TShape);
    function GetBoardShapes(x, y: Integer): TBrick;
    procedure SetBoardShapes(x, y: Integer; const Value: TBrick);
    function GetBricks(index: Integer): TBrick;
    procedure SetBricks(index: Integer; const Value: TBrick);
  protected
    procedure Paint; override;

    function ActiveShape: TShape;
    function WaitingShape: TShape;
    function ShapeCanMoveDown: Boolean;
    function ShapeCanMoveLeft: Boolean;
    function ShapeCanMoveRight: Boolean;

    function BoardGetLastEmpty(): TBoardLastEmptyRec;

    procedure PlaceShapeAtBoard;
    procedure SwitchNewShape;
    procedure AddRandomShape;
    procedure FindLinesAndDelete;
    procedure PlaceinBottom;
    procedure InitOptions;
    procedure DrawWaitingShape;
    procedure DrawOptions;

    procedure BoardShowMessage(Str:string);

    function CalcShapeEndPoint: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MyKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);

    procedure StartGame;
    procedure RestartGame;

    property Shapes[index: Integer]: TShape read GetShapes write SetShapes;
    property Bricks[index: Integer]: TBrick read GetBricks write SetBricks;
    property BoardShapes[x, y: Integer]: TBrick read GetBoardShapes write SetBoardShapes;
  published
  end;

implementation

uses
  UMain;
{TBoard}

function TBoard.ActiveShape: TShape;
begin
  Result := Shapes[0];
end;

procedure TBoard.AddRandomShape;
var
  ShapeRandom: Integer;
begin
  ShapeRandom := Random(ShapesCount);

  ShapeList.Add(TShape.Create(TShapeType(ShapeRandom)));

end;

function TBoard.BoardGetLastEmpty(): TBoardLastEmptyRec;
var
  I, Cnt: Integer;
  yBrick, xBrick: Integer;
begin
  Result.Res := False;
  Cnt := 1;
  repeat
    for I := 0 to ActiveShape.BricksCount - 1 do
    begin
      yBrick := (ActiveShape.Bricks[I].BrickPoint.y - 1) + (ActiveShape.BoardPoint.y);
      xBrick := (ActiveShape.Bricks[I].BrickPoint.x - 1) + (ActiveShape.BoardPoint.x);

      if (BoardShapes[xBrick, yBrick + Cnt] <> nil) then
      begin
        Result.EndPoint := Point(ActiveShape.BoardPoint.x,
           yBrick + Cnt - ActiveShape.Bricks[I].BrickPoint.y);

        if Result.EndPoint.y + ActiveShape.FindBricksMax(ftYMax) > BoardYLines - 1 then
          Result.EndPoint := Point(Result.EndPoint.x,
             Result.EndPoint.y - (ActiveShape.FindBricksMax(ftYMax) + Result.EndPoint.y -
             BoardYLines));
        Result.Distance := yBrick + Cnt;
        Result.Res := True;
        Exit;
      end;

    end;// end for

    Inc(Cnt);
  until (Cnt + yBrick > BoardYLines - 1);

  if (yBrick + Cnt = BoardYLines) then
  begin
    Result.EndPoint := Point(ActiveShape.BoardPoint.x,
       (yBrick + Cnt) - ActiveShape.FindBricksMax(ftYMax));
    Result.Distance := yBrick + Cnt;
    Result.Res := True;
    Exit;
  end;

end;

procedure TBoard.BoardShowMessage(Str: string);
begin
  Msg.Show(Str);
  ShowMessageFlag := True;
end;

function TBoard.CalcShapeEndPoint: Boolean;
var
  Rec: TBoardLastEmptyRec;
begin

  Rec := BoardGetLastEmpty;

  // Flag to show or hide the Shape Tips...
  // When ditance between current y, and minimum
  // empty point is less, hide.
  Result := (Rec.Distance - ActiveShape.BoardPoint.y) > BoardShapeTipMax;

  ActiveShape.BoardPointInEnd := Rec.EndPoint;
  TipShapeDistance := Rec.Distance - ActiveShape.BoardPoint.y;

  // formmain.Memo1.Lines.Add(inttostr( TipShapeDistance ))

end;

constructor TBoard.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Randomize;

  ControlStyle := ControlStyle + [csOpaque];
  ShapeList := TObjectList.Create;
  BrickList := TObjectList.Create;
  Msg := TMsg.Create(self, '');

  Parent := TWinControl(AOwner);

  Width := BoardXLines * BrickSize + 1;
  Height := BoardYLines * BrickSize + 1;

  OptionsWidth := Width div 2 + Width div 8;

  Width := Width + OptionsWidth;

  Board := TBitmap.Create;
  Board.Width := Width;
  Board.Height := Height;

  GameTimer := TTimer.Create(nil);
  GameTimer.Interval := 1000;
  GameTimer.Enabled := False;
  GameTimer.OnTimer := OnMyTimer;
  GameTimer.Tag := 1000;

  InitOptions;

  ShowMessageFlag := True;
  // Msg.Show('Starting Game');

end;

destructor TBoard.Destroy;
begin
  inherited;

  while ShapeList.Count > 0 do
    ShapeList.Remove(ShapeList.Items[0]);

  ShapeList.Free;

end;

procedure TBoard.DrawOptions;
begin

  with Board.Canvas do
  begin
    Font.Name := 'David';
    Font.Size := 20;
    Font.Color := ClBlue;

    TextOut(BoardXLines * BrickSize + 120, 220, inttostr(GameLines));

    TextOut(BoardXLines * BrickSize + 120, 268, inttostr(GameLevel));

    TextOut(BoardXLines * BrickSize + 120, 319, inttostr(GameScore));

  end;
end;

procedure TBoard.DrawWaitingShape;
var
  T: TRect;
  I: Integer;
  ActiveDiv: Integer;
begin
  InitOptions;

  ActiveDiv := ((4 * BrickSize) - (WaitingShape.FindBricksMax(ftXMax)* BrickSize)) div 2;

  for I := 0 to WaitingShape.BricksCount - 1 do
  begin
    T := Rect(ActiveDiv + BoardXLines * BrickSize + 2 + WaitingShape.Bricks[I].BrickPoint.x *
       BrickSize,
       60 + WaitingShape.Bricks[I].BrickPoint.y * BrickSize,
       ActiveDiv + BoardXLines * BrickSize + 2 + WaitingShape.Bricks[I].BrickPoint.x * BrickSize +
       BrickSize + 1,
       60 + WaitingShape.Bricks[I].BrickPoint.y * BrickSize + BrickSize + 1);
    WaitingShape.Bricks[I].DrawBrick(Board.Canvas, T);
  end;
  DrawOptions;
end;

procedure TBoard.FindLinesAndDelete;
var
  I, j: Integer;
begin

  for I := 0 to BoardYLines - 1 do
    if Pos('0', Positions[I]) = 0 then
    begin // remove line i

      for j := 0 to BoardXLines - 1 do // remove line
        BrickList.Remove(BoardShapes[j, I]);

      for j := 0 to BrickList.Count - 1 do
        if Bricks[j].BrickPoint.y < I then
          Bricks[j].BrickPoint := Point(Bricks[j].BrickPoint.x,
             Bricks[j].BrickPoint.y + 1);

      for j := I downto 1 do // update strings
        Positions[j]:= Positions[j - 1];

      Inc(GameLines);
      Inc(GameScore, GameLevel * GameLines);
      GameLevel := 1 + (GameLines div 5);
      GameTimer.Interval := 1000 - (GameLevel mod 10)* 100;
    end;

end;

function TBoard.GetBoardShapes(x, y: Integer): TBrick;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to BrickList.Count - 1 do
  begin
    if (Bricks[I].BrickPoint.x = x) and
       (Bricks[I].BrickPoint.y = y) then
    begin
      Result := Bricks[I];
      Exit;
    end;
  end;

end;

function TBoard.GetBricks(index: Integer): TBrick;
begin
  Result := TBrick(BrickList.Items[index]);
end;

function TBoard.GetShapes(index: Integer): TShape;
begin
  Result := TShape(ShapeList.Items[index]);
end;

procedure TBoard.InitOptions;
begin
  FormMain.Cursor := CrNone;

  with Board.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := ClSilver;
    FillRect(ClientRect);
  end;

  Board.Canvas.Draw(BoardXLines * BrickSize + 2, 0, FormMain.OptionsImage.Picture.Graphic);
end;

procedure TBoard.MyKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin

  if Key in [49 .. 51] then
  begin
    Repaint;
    DrawWaitingShape;
  end;

  if GameTimer.Enabled then
  begin
    case Key of
      VK_RIGHT:
        if ShapeCanMoveRight then
          ActiveShape.IncreaseBoardX(1);
      VK_LEFT:
        if ShapeCanMoveLeft then
          ActiveShape.IncreaseBoardX(- 1);
    end;
    if (ShapeCanMoveDown) then
    begin
      case Key of
        VK_UP:
          if ActiveShape.BoardPoint.x + ActiveShape.FindBricksMax(ftYMax) <= BoardXLines then
            ActiveShape.Rotate(1);
        VK_DOWN:
          ActiveShape.IncreaseBoardY(1);
        VK_SPACE:
          PlaceinBottom;
        VK_ESCAPE, VK_KeyQ:
          begin
            GameTimer.Tag := Key;
            BoardShowMessage('Game Over');
            GameTimer.Enabled := False;
          end;
        VK_KeyP:
          begin
            GameTimer.Tag := Key;
            BoardShowMessage('Poused.');
            GameTimer.Enabled := False;
          end;
      end;
      DrawShapeEndPoint := CalcShapeEndPoint;
    end
    else
      PlaceShapeAtBoard;
  end
  else
  begin
    case Key of
      VK_RETURN:
        begin
          case GameTimer.Tag of
            VK_KeyP:
              begin
                ShowMessageFlag := False;
                GameTimer.Enabled := True;
              end;
            B_EndGame, VK_KeyQ, VK_ESCAPE:
              begin
                GameTimer.Tag := B_InitStart;
                Msg.Show('Game Start');
              end;
            B_ReStart:
              begin
                GameTimer.Enabled := True;
                ShowMessageFlag := False;
                RestartGame;
              end;
            B_InitStart:
              begin
                GameTimer.Enabled := True;
                ShowMessageFlag := False;
                StartGame;
              end;
          end;
        end;
      VK_ESCAPE, VK_KeyQ:
        FormMain.Close;

    end;
  end;

  Repaint;

end;

procedure TBoard.OnMyTimer(Sender: TObject);
begin

  case ShapeCanMoveDown of
    False:
      PlaceShapeAtBoard;
    True:
      ActiveShape.IncreaseBoardY(1);
  end;

  // Form1.Caption:= Format('x=%d,y=%d',[ActiveShape.BoardPoint.X,ActiveShape.BoardPoint.Y]);
  DrawShapeEndPoint := CalcShapeEndPoint;
  Repaint;
end;

procedure TBoard.Paint;
var
  I, j: Integer;
  T: TRect;
begin
  inherited;

  if ActiveShape = nil then
    Exit;
  with Board.Canvas do
  begin
    Pen.Color := RGB(100, 100, 100);
    Pen.Style := psClear;
    Brush.Color := RGB(105, 105, 105);

    for I := 0 to BoardYLines - 1 do
      for j := 0 to BoardXLines - 1 do
      begin
        Rectangle(j * BrickSize, I * BrickSize,(j + 1)* BrickSize + 1,(I + 1)* BrickSize + 1);
      end;

    // Painting the curretn moving shape;
    for I := 0 to ActiveShape.BricksCount - 1 do
    begin
      T := Rect(ActiveShape.BoardPoint.x * BrickSize + (ActiveShape.Bricks[I].BrickPoint.x - 1)*
         BrickSize,
         ActiveShape.BoardPoint.y * BrickSize + (ActiveShape.Bricks[I].BrickPoint.y - 1)* BrickSize,
         ActiveShape.BoardPoint.x * BrickSize + (ActiveShape.Bricks[I].BrickPoint.x - 1)* BrickSize
         + BrickSize + 1,
         ActiveShape.BoardPoint.y * BrickSize + (ActiveShape.Bricks[I].BrickPoint.y - 1)* BrickSize
         + BrickSize + 1);

      ActiveShape.Bricks[I].DrawBrick(Board.Canvas, T);

      if DrawShapeEndPoint then
      begin
        T := Rect(ActiveShape.BoardPointInEnd.x * BrickSize + (ActiveShape.Bricks[I].BrickPoint.x -
           1)* BrickSize,
           ActiveShape.BoardPointInEnd.y * BrickSize + (ActiveShape.Bricks[I].BrickPoint.y - 1)*
           BrickSize,
           ActiveShape.BoardPointInEnd.x * BrickSize + (ActiveShape.Bricks[I].BrickPoint.x - 1)*
           BrickSize + BrickSize + 1,
           ActiveShape.BoardPointInEnd.y * BrickSize + (ActiveShape.Bricks[I].BrickPoint.y - 1)*
           BrickSize + BrickSize + 1);

        ActiveShape.Bricks[I].DrawBrickEx(Board.Canvas, T, TipShapeDistance - BoardShapeTipMax);
      end;
    end;

    for I := 0 to BrickList.Count - 1 do
    begin
      T := Rect(Bricks[I].BrickPoint.x * BrickSize,
         Bricks[I].BrickPoint.y * BrickSize,
         Bricks[I].BrickPoint.x * BrickSize + BrickSize + 1,
         Bricks[I].BrickPoint.y * BrickSize + BrickSize + 1);

      Bricks[I].DrawBrick(Board.Canvas, T);
    end;

  end; // end with

  if ShowMessageFlag then
    BitBlt(Board.Canvas.Handle, 10, 160, Msg.GetWidth, Msg.GetHeight, Msg.Canvas.Handle, 0,
       0, SrcCopy);

  BitBlt(Canvas.Handle, 0, 0, Width, Height, Board.Canvas.Handle, 0, 0, SrcCopy);

end;

procedure TBoard.PlaceinBottom;
begin

  while ShapeCanMoveDown do
  begin
    ActiveShape.BoardPoint := Point(ActiveShape.BoardPoint.x, ActiveShape.BoardPoint.y + 1);
    // FormMain.Memo1.Lines.Add(Format('x=%d,y=%d',[ActiveShape.BoardPoint.X,ActiveShape.BoardPoint.Y]));
  end;

  PlaceShapeAtBoard;

end;

procedure TBoard.PlaceShapeAtBoard;
var
  I: Integer;
  P: TPoint;
begin
  if ActiveShape.BoardPoint.y - ActiveShape.FindBricksMax(ftYMax) < 0 then
  begin
    GameTimer.Tag := B_EndGame;
    BoardShowMessage('Game Over');
    GameTimer.Enabled := False;
    Exit;
  end;

  for I := 0 to ActiveShape.BricksCount - 1 do
  begin
    P := Point((ActiveShape.BoardPoint.x + ActiveShape.Bricks[I].BrickPoint.x - 1),
       (ActiveShape.BoardPoint.y + ActiveShape.Bricks[I].BrickPoint.y - 1));
    BrickList.Add(TBrick.Create(self, P, Ord(ActiveShape.ShapeType)));

    Positions[P.y][P.x + 1]:= '1';
  end;

  FindLinesAndDelete;

  SwitchNewShape;

end;

procedure TBoard.RestartGame;
var
  j: Integer;
begin
  BrickList.Clear;

  GameLines := 0;
  GameLevel := 1;
  GameScore := 0;

  for j := 0 to BoardYLines - 1 do
    Positions[j]:= StringOfChar('0', BoardXLines);

  DrawWaitingShape;
  DrawOptions;
  DrawShapeEndPoint := CalcShapeEndPoint;

  GameTimer.Tag := 100;
  GameTimer.Interval := 1000;
  Msg.Show('Restart Game');

end;

procedure TBoard.SetBoardShapes(x, y: Integer; const Value: TBrick);
begin

end;

procedure TBoard.SetBricks(index: Integer; const Value: TBrick);
begin
  BrickList.Items[index]:= Value;
end;

procedure TBoard.SetShapes(index: Integer; const Value: TShape);
begin
  ShapeList.Items[index]:= Value;
end;

function TBoard.ShapeCanMoveDown: Boolean;
var
  I, xBrick, yBrick: Integer;
begin
  Result := True;

  if (ActiveShape.FindBricksMax(ftYMax)- 1 + ActiveShape.BoardPoint.y >= BoardYLines - 1) then
  begin
    Result := False;
    Exit;
  end;

  for I := 0 to ActiveShape.BricksCount - 1 do
  begin
    yBrick := (ActiveShape.Bricks[I].BrickPoint.y - 1) + (ActiveShape.BoardPoint.y);
    xBrick := (ActiveShape.Bricks[I].BrickPoint.x - 1) + (ActiveShape.BoardPoint.x);

    if BoardShapes[xBrick, yBrick + 1] <> nil then
    begin
      Result := False;
      Exit;
    end;
  end;

end;

function TBoard.ShapeCanMoveLeft: Boolean;
var
  I: Integer;
  yBrick, xBrick: Integer;
begin
  Result := True;
  if ActiveShape.BoardPoint.x = 0 then
  begin
    Result := False;
    Exit;
  end;

  for I := 0 to ActiveShape.BricksCount - 1 do
  begin
    yBrick := (ActiveShape.Bricks[I].BrickPoint.y - 1) + (ActiveShape.BoardPoint.y);
    xBrick := (ActiveShape.Bricks[I].BrickPoint.x - 1) + (ActiveShape.BoardPoint.x);

    if BoardShapes[xBrick - 1, yBrick] <> nil then
    begin
      Result := False;
      Exit;
    end;
  end;

end;

function TBoard.ShapeCanMoveRight: Boolean;
var
  I: Integer;
  yBrick, xBrick: Integer;
begin
  Result := True;
  if ActiveShape.BoardPoint.x + ActiveShape.FindBricksMax(ftXMax)- 1 = BoardXLines - 1 then
  begin
    Result := False;
    Exit;
  end;

  for I := 0 to ActiveShape.BricksCount - 1 do
  begin
    yBrick := (ActiveShape.Bricks[I].BrickPoint.y - 1) + (ActiveShape.BoardPoint.y);
    xBrick := (ActiveShape.Bricks[I].BrickPoint.x - 1) + (ActiveShape.BoardPoint.x);

    if BoardShapes[xBrick + 1, yBrick] <> nil then
    begin
      Result := False;
      Exit;
    end;
  end;

end;

procedure TBoard.StartGame;
var
  j: Integer;
begin
  BrickList.Clear;

  ShapeList.Clear;
  AddRandomShape;
  AddRandomShape;

  GameLines := 0;
  GameLevel := 1;
  GameScore := 0;


  // formmain.Memo1.Lines.Add(inttostr(GameTimer.Tag));

  // ShapeList.Add( TShape.Create( stDot )  ) ;
  // ShapeList.Add( TShape.Create( stZed2 )  );

  for j := 0 to BoardYLines - 1 do
    Positions[j]:= StringOfChar('0', BoardXLines);

  DrawWaitingShape;
  DrawOptions;
  DrawShapeEndPoint := CalcShapeEndPoint;

  GameTimer.Tag := B_ReStart;
  GameTimer.Interval := 1000;
  Msg.Show('Start Game');

end;

procedure TBoard.SwitchNewShape;
begin

  AddRandomShape;
  ShapeList.Delete(0);

  DrawWaitingShape;
  DrawOptions;
end;

function TBoard.WaitingShape: TShape;
begin
  Result := Shapes[1];
end;

end.
