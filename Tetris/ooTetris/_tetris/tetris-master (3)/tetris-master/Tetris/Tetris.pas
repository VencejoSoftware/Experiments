unit Tetris;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, math, Menus, ComCtrls;

const
  cWIDTH = 10;
  cHEIGTH = 20;
  cBrickSize = 15;
  c_Start_Default_Heigth = 1;
  c_Start_Default_Center = 5;
  c_GAME_START = 'press any key to start';
  c_GAME_OVER = 'GAME OVER!!!';

  type
  TPoint = record
    _iX : integer;
    _iY : integer;
  end;


type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    LbScore: TLabel;
    LbLevel: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    StatusBar1: TStatusBar;
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);

    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    function GetScore: Integer;
    procedure SetScore(const Value: Integer);
    procedure PreViewPrintBrick;


  private
    procedure PrintBrick(bShow : Boolean);
    procedure BrickDown;
    function CheckBrick(x,y,b,r : integer) : Boolean;
    procedure BrickLeft;
    procedure BrickRight;
    procedure CheckLines;
    procedure ShowStackBrick;
    procedure Init;
    procedure BrickChange;
    procedure DeleteLine;
    procedure DrawInit;
    property DrawScore: Integer read GetScore write SetScore;
    procedure CheckLevel(i_score : integer);
    { Private declarations }
  public

  end;

                                                         //A5D2E7
var
  FrmMain: TFrmMain;
  board : array[0..cWIDTH + 1, 0..cHEIGTH + 1, 0..1] of integer;      // 0..2 0은 색 index, 1은 쌓여있는지 여부
  iXY, iDown, iBrickIndex, iBrickRotation, i_previewBrickIndex : integer;
  bStoped : Boolean;
  i_score : integer;
  b_BlockCount : Boolean;
  FCanvas : TCanvas;
  MCanvas : TCanvas;


  // RGB가 아니라 BGR네....
  BlockColor : array [0..8] of TColor = ($00A5FF, $E96AE9, $09D9D9, $D9D909, $FF5900, $09D909, $4949EE, clBlack, clSilver );


  shape : array[0..6, 0..3, 0..3] of TPoint =
  (
     (
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 0; _iY : 2), (_iX : 1; _iY : 2) ), // L
         ( (_iX : 2; _iY : 0), (_iX : 2; _iY : 1), (_iX : 1; _iY : 1), (_iX : 0; _iY : 1) ),
         ( (_iX : 0; _iY : 0), (_iX : 1; _iY : 0), (_iX : 1; _iY : 1), (_iX : 1; _iY : 2) ),
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 1; _iY : 0), (_iX : 2; _iY : 0) )

     ),
     (
         ( (_iX : 1; _iY : 0), (_iX : 1; _iY : 1), (_iX : 0; _iY : 1), (_iX : 2; _iY : 1) ), // ┤
         ( (_iX : 0; _iY : 1), (_iX : 1; _iY : 0), (_iX : 1; _iY : 1), (_iX : 1; _iY : 2) ),
         ( (_iX : 0; _iY : 0), (_iX : 1; _iY : 0), (_iX : 2; _iY : 0), (_iX : 1; _iY : 1) ),
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 0; _iY : 2), (_iX : 1; _iY : 1) )
     ),
     (
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 1; _iY : 0), (_iX : 1; _iY : 1) ), // ㅁ
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 1; _iY : 0), (_iX : 1; _iY : 1) ),
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 1; _iY : 0), (_iX : 1; _iY : 1) ),
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 1; _iY : 0), (_iX : 1; _iY : 1) )
     ),
     (                                                                                      // I
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 0; _iY : 2), (_iX : 0; _iY : 3) ),
         ( (_iX : 0; _iY : 0), (_iX : 1; _iY : 0), (_iX : 2; _iY : 0), (_iX : 3; _iY : 0) ),
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 0; _iY : 2), (_iX : 0; _iY : 3) ),
         ( (_iX : 0; _iY : 0), (_iX : 1; _iY : 0), (_iX : 2; _iY : 0), (_iX : 3; _iY : 0) )
     ),
     (                                                                                     // ┚
         ( (_iX : 0; _iY : 2), (_iX : 1; _iY : 0), (_iX : 1; _iY : 1), (_iX : 1; _iY : 2) ),
         ( (_iX : 0; _iY : 0), (_iX : 1; _iY : 0), (_iX : 2; _iY : 0), (_iX : 2; _iY : 1) ),
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 0; _iY : 2), (_iX : 1; _iY : 0) ),
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 1; _iY : 1), (_iX : 2; _iY : 1) )
     ),
     (
         ( (_iX : 1; _iY : 0), (_iX : 2; _iY : 0), (_iX : 1; _iY : 1), (_iX : 0; _iY : 1) ),
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 1; _iY : 1), (_iX : 1; _iY : 2) ),
         ( (_iX : 1; _iY : 0), (_iX : 2; _iY : 0), (_iX : 1; _iY : 1), (_iX : 0; _iY : 1) ),
         ( (_iX : 0; _iY : 0), (_iX : 0; _iY : 1), (_iX : 1; _iY : 1), (_iX : 1; _iY : 2) )
     ),
     (                                                                                    // ㄹ
         ( (_iX : 0; _iY : 0), (_iX : 1; _iY : 0), (_iX : 1; _iY : 1), (_iX : 2; _iY : 1) ),
         ( (_iX : 1; _iY : 0), (_iX : 1; _iY : 1), (_iX : 0; _iY : 1), (_iX : 0; _iY : 2) ),
         ( (_iX : 0; _iY : 0), (_iX : 1; _iY : 0), (_iX : 1; _iY : 1), (_iX : 2; _iY : 1) ),
         ( (_iX : 1; _iY : 0), (_iX : 1; _iY : 1), (_iX : 0; _iY : 1), (_iX : 0; _iY : 2) )
     )
  );


implementation

uses
  uHelp;

{$R *.dfm}

procedure TFrmMain.FormShow(Sender: TObject);
begin
  DrawInit;

  // 화면 크기 고정
  FrmMain.Height := 395;
  FrmMain.Width  := 300;

  bStoped := False;

  i_score := 0;

  b_BlockCount := False;





  Randomize;

end;

procedure TFrmMain.FormPaint(Sender: TObject);
var
  i, j : Integer;
  BackColor : TColor;
begin
  // 벽만들기      10
  for i := 0 to cWIDTH + 1 do
  begin          // 20
    for j := 0 to cHEIGTH + 1 do
    begin
      if board[i][j][1] = 2 then
        BackColor := $E7D2A5
      else
        BackColor := clSilver;

      MCanvas.brush.Color :=  BackColor;
      MCanvas.Pen.Style := psClear;
      MCanvas.Rectangle(i * cBrickSize, j * cBrickSize,
                      (i+1) * cBrickSize, (j+1) * cBrickSize);
    end;

  end;

end;


// 블럭 표시
procedure TFrmMain.PrintBrick(bShow : Boolean);
var
  i : integer;

begin

   if (bShow) then
   begin
     for i := 0 to 3 do
     begin
       MCanvas.brush.Color := BlockColor[iBrickIndex];
       MCanvas.Pen.Style := psClear;
       MCanvas.Rectangle( (shape[iBrickIndex][iBrickRotation][i]._iX * cBrickSize) + iXY + ( cBrickSize * c_Start_Default_Center ),
                         (shape[iBrickIndex][iBrickRotation][i]._iY * cBrickSize) + iDown + cBrickSize,
                         (shape[iBrickIndex][iBrickRotation][i]._iX * cBrickSize) + cBrickSize + iXY + ( cBrickSize * c_Start_Default_Center ),
                         (shape[iBrickIndex][iBrickRotation][i]._iY * cBrickSize) + iDown + cBrickSize + cBrickSize
                       );

     end;


   end
   else
   begin
     for i := 0 to 3 do
     begin
       MCanvas.brush.Color := clSilver;
       MCanvas.Pen.Style := psClear;
       MCanvas.Rectangle( (shape[iBrickIndex][iBrickRotation][i]._iX * cBrickSize) + iXY + ( cBrickSize * c_Start_Default_Center ),
                         (shape[iBrickIndex][iBrickRotation][i]._iY * cBrickSize) + iDown + cBrickSize,
                         (shape[iBrickIndex][iBrickRotation][i]._iX * cBrickSize) + cBrickSize + iXY + ( cBrickSize * c_Start_Default_Center ),
                         (shape[iBrickIndex][iBrickRotation][i]._iY * cBrickSize) + iDown + cBrickSize + cBrickSize
                       );
     end;
   end;

end;


procedure TFrmMain.PreViewPrintBrick;
var
  i, j : integer;

begin

   for i := 0 to 7 do
   begin
     for j := 0 to 7 do
     begin
       FCanvas.brush.Color := clSilver;
       FCanvas.Pen.Style := psSolid;
       FCanvas.Pen.Color := clSilver;
       FCanvas.Rectangle(
                         j * cBrickSize
                        ,i * cBrickSize
                        ,(j+1) * cBrickSize
                        ,(i+1) * cBrickSize
                         );
//       (shape[i_previewBrickIndex][iBrickRotation][i]._iX * cBrickSize) + iXY + ( cBrickSize * c_Start_Default_Center ),
//                         (shape[i_previewBrickIndex][iBrickRotation][i]._iY * cBrickSize) + cBrickSize,
//                         (shape[i_previewBrickIndex][iBrickRotation][i]._iX * cBrickSize) + cBrickSize + iXY + ( cBrickSize * c_Start_Default_Center ),
//                         (shape[i_previewBrickIndex][iBrickRotation][i]._iY * cBrickSize) + cBrickSize + cBrickSize
//                       );
     end;
   end;

   for i := 0 to 3 do
   begin
     FCanvas.brush.Color := BlockColor[i_previewBrickIndex];
     FCanvas.Pen.Style := psClear;
     FCanvas.Rectangle( (shape[i_previewBrickIndex][iBrickRotation][i]._iX * cBrickSize) + ( 40 ),
                        (shape[i_previewBrickIndex][iBrickRotation][i]._iY * cBrickSize) + cBrickSize,
                        (shape[i_previewBrickIndex][iBrickRotation][i]._iX * cBrickSize) + cBrickSize + ( 40 ),
                        (shape[i_previewBrickIndex][iBrickRotation][i]._iY * cBrickSize) + cBrickSize + cBrickSize
                      );

   end;

end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
var
  i_for : integer;
begin
  BrickDown;
end;

// 한줄없애기
procedure TFrmMain.DeleteLine;
var
  i, j, k, p : Integer;
begin

  for j := 1 to cHEIGTH + 1 do
  begin
    for k := 1 to cWIDTH + 1 do
    begin
      if board[k][j][1] <> 1 then
      Break;
    end;

    if (k = cWIDTH + 1) then
    begin

      p := j;
      repeat

        for k := 1 to cWIDTH do
        begin
          board[k][p] := board[k][p-1];
        end;

        p := p - 1;

      until p = 1;

      Inc ( i_score, 10);
      setScore( i_score );

      Sleep(50);
      ShowStackBrick;
    end;
  end;

  CheckLevel(i_score);

end;


procedure TFrmMain.BrickDown;
begin
  // 블럭을 내릴수 있는지 아닌지 검사

  if not CheckBrick( 0, 15, 1, 1 ) then
  begin
    Timer1.Enabled := false;


    ShowMessage(c_GAME_OVER);
  


  end;


  if CheckBrick(iXY, iDown + cBrickSize, 1, 1) then
  begin
    PrintBrick(false);
    iDown := iDown + 15;
    PrintBrick(True);
  end
  else
  begin
    CheckLines;
    DeleteLine;
    Init;
  end;

end;

procedure TFrmMain.BrickLeft;
begin
  if CheckBrick(iXY - cBrickSize, iDown, 1, 1) then
  begin
    PrintBrick(false);
    iXY := iXY - cBrickSize;
    PrintBrick(True);
  end;
end;

procedure TFrmMain.BrickRight;
begin
  if CheckBrick(iXY + cBrickSize, iDown, 1, 1) then
  begin
    PrintBrick(false);
    iXY := iXY + cBrickSize;
    PrintBrick(True);
  end;
end;

// 블럭 모양 변경
procedure TFrmMain.BrickChange;
begin
  if CheckBrick(iXY + cBrickSize, iDown, 1, 1) then
  begin
    PrintBrick(false);
    if iBrickRotation = 3 then
      iBrickRotation := 0
    else
      inc(iBrickRotation);
    PrintBrick(True);
  end;
end;

// 전역변수 초기화
procedure TFrmMain.Init;
var
  i_Loop : integer;
begin
  iDown := 0; iXY := 0;  iBrickRotation := 0;

  if not b_BlockCount  then
  begin
    iBrickIndex := Random(7);
    i_previewBrickIndex := Random(7);
    b_BlockCount := true;
  end
  else
  begin
    iBrickIndex := i_previewBrickIndex;
    i_previewBrickIndex := Random(7);
  end;

  PreViewPrintBrick;

end;


// 현재 위치 블럭의 위치를 1로 세팅.
procedure TFrmMain.CheckLines;
var
  i,j,k : integer;
begin
  for i := 0 to 3 do
  begin
    board[ c_Start_Default_Center  + (iXY div cBrickSize) + shape[iBrickIndex][iBrickRotation][i]._iX ]
         [ c_Start_Default_Heigth  + (iDown div cBrickSize) + shape[iBrickIndex][iBrickRotation][i]._iY][0] := iBrickIndex;

    board[ c_Start_Default_Center  + (iXY div cBrickSize) + shape[iBrickIndex][iBrickRotation][i]._iX ]
         [ c_Start_Default_Heigth  + (iDown div cBrickSize) + shape[iBrickIndex][iBrickRotation][i]._iY][1] := 1;

  end;

  ShowStackBrick;

end;

// 블럭 모양 변경하거나 바로 밑이 블럭인지 아닌지 검사
function TFrmMain.CheckBrick(x,y,b,r : integer) : Boolean;
var
  i, j : integer;
begin

  j := 0;
  for i := 0 to 3 do
  begin
    j := max( j,
            board[ c_Start_Default_Center + (x div cBrickSize) + shape[iBrickIndex][iBrickRotation][i]._iX ]
                 [ c_Start_Default_Heigth + (y div cBrickSize) + shape[iBrickIndex][iBrickRotation][i]._iY ]
                 [ 1 ]
            );

  end;

  // board[][]에 c_Start_Default_Center과 c_Start_Default_Heigth을 더하는 이유는 중간에서 블럭이 시작하니까..

  // 벽돌이나 가장자리이면
  if (j = 1) or (j = 2) then
    result := False
  else
    result := True;

end;

// 쌓여있는 블럭을 표시
procedure TFrmMain.ShowStackBrick;
var
  i, j : Integer;
begin

  for i := 0 to cWIDTH + 1 do
  begin
    for j := 0 to cHEIGTH + 1 do
    begin
      if board[i][j][1] = 1 then
      begin
        MCanvas.brush.Color := BlockColor[    board[i][j][0]   ] ;
        MCanvas.Pen.Style := psClear;
        MCanvas.Rectangle(i * cBrickSize, j * cBrickSize,
                        (i+1) * cBrickSize, (j+1) * cBrickSize);
      end
      else if board[i][j][1] = 0 then
      begin
        MCanvas.brush.Color := clSilver;
        MCanvas.Pen.Style := psClear;
        MCanvas.Rectangle(i * cBrickSize, j * cBrickSize,
                        (i+1) * cBrickSize, (j+1) * cBrickSize);

      end;

    end;
  end;

end;


procedure TFrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

   if ( not bStoped ) and ( not Timer1.Enabled ) then
   begin
     DrawInit;
     FormPaint(Self);

     Init;

     Timer1.Enabled := True;
     SetScore(0);

   end;


   case Key of
     VK_LEFT :
     begin
       BrickLeft;
     end;

     VK_RIGHT :
     begin
       BrickRight;
     end;

     VK_DOWN :
     begin
       BrickDown;
     end;

     VK_UP :
     begin
       BrickChange;
     end;

     VK_SPACE :
     begin
      while ( iDown <> 0 ) do
      begin
        BrickDown;
      end;

     end;

     VK_F12 :
     begin
       Timer1.Enabled := not Timer1.Enabled;
       bStoped := not bStoped;
     end;

   end;


end;

// 벽부분 board배열에 2넣기
procedure TFrmMain.DrawInit;
var
  i, j : integer;
begin
  // 벽부분 board배열에 2넣기.
  for i := 0 to cWIDTH + 1 do
  begin
    for j := 0 to cHEIGTH + 1 do             //0,41,    0,20
    begin
      if (j = 0) or (j = cHEIGTH+1) or (i = 0) or (i = cWIDTH+1) then
        board[i][j][1] := 2
      else
      begin
        board[i][j][0] := 0;
        board[i][j][1] := 0;
      end;
    end;
  end;
end;


{

      if board[i][j][1] = 2 then
      begin
        MCanvas.brush.Color := $E7D2A5;
        MCanvas.Pen.Style := psClear;
        MCanvas.Rectangle(i * cBrickSize, j * cBrickSize,
                        (i+1) * cBrickSize, (j+1) * cBrickSize);
      end

}


function TFrmMain.GetScore: Integer;
begin
//
end;

procedure TFrmMain.SetScore(const Value: Integer);
begin
  LbScore.Caption := IntToStr(Value);
end;

procedure TFrmMain.CheckLevel(i_score: integer);
begin
  case ( i_score div 10 ) of
    0 .. 9 :   begin
                 Timer1.Interval := 500;
                 LbLevel.caption := '1';
               end;
    10 .. 19 : begin
                 Timer1.Interval := 400;
                 LbLevel.caption := '2';
               end;
    21 .. 29 : begin
                 Timer1.Interval := 300;
                 LbLevel.caption := '3';
               end;
    31 .. 39 : begin
                 Timer1.Interval := 200;
                 LbLevel.caption := '4';
               end;
    41 .. 49 : begin
                 Timer1.Interval := 100;
                 LbLevel.caption := '5';
               end;
    51 .. 59 : begin
                 Timer1.Interval := 50;
                 LbLevel.caption := '6';
               end;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Panel3;

  MCanvas := TControlCanvas.Create;
  TControlCanvas(MCanvas).Control := Panel4;
end;

procedure TFrmMain.N5Click(Sender: TObject);
begin
  ShowHelp;
end;

procedure TFrmMain.N4Click(Sender: TObject);
begin
  close;
end;

procedure TFrmMain.N3Click(Sender: TObject);
begin
     DrawInit;
     FormPaint(Self);

     Init;

     Timer1.Enabled := True;
     SetScore(0);
end;

end.


// Commit Test

