unit Tetris.Board;

interface

uses
  System.Classes, VCL.Graphics,
  System.Generics.Collections,
  Grid.Tetris, Piece.Tetris, Piece.Shapes,
  ThreadTimer;

const
  PIECE_COLORS: array [1 .. 10] of Tcolor = (
     clLime,
     clRed,
     clYellow,
     clSilver,
     clAqua,
     clGreen,
     clFuchsia,
     clOlive,
     clMaroon,
     $000080FF
     );

type
  TTetris = class(TObject)
  strict private
  type
    TPiecePatternList = TList<TPiecePattern>;
  private
    objTimer: TThreadTimer;
    objGrid: TGridTetris;
    objCurrentPiece: TTetrisPiece;
    objPatterns: TPiecePatternList;
    evOnChange: TNotifyEvent;
  protected
    function GetGrid: TGridTetris;
    function CreateRandomPiece: TTetrisPiece;

    procedure OnTimerEvent(Sender: TObject);
    procedure DoChange;
    procedure DoLoadPatterns; virtual;
  public
    procedure MovePiece(const aMovement: TPieceMovement);
    procedure Start;
    procedure Draw(aCanvas: TCanvas); virtual;

    constructor Create; virtual;
    destructor Destroy; override;

    property Grid: TGridTetris read GetGrid write objGrid;
    property CurrentPiece: TTetrisPiece read objCurrentPiece write objCurrentPiece;
    property OnChange: TNotifyEvent read evOnChange write evOnChange;
  end;

implementation

function TTetris.GetGrid: TGridTetris;
begin
  if not Assigned(objGrid) then
  begin
    objGrid := TGridTetris.Create(10, 18);
    objGrid.CellWidth := 20;
    objGrid.CellHeight := objGrid.CellWidth;
  end;
  Result := objGrid;
end;

procedure TTetris.MovePiece(const aMovement: TPieceMovement);
begin
  CurrentPiece.ChangePosition(aMovement);
end;

procedure TTetris.DoChange;
begin
  if Assigned(evOnChange) then
    evOnChange(Self);
end;

procedure TTetris.OnTimerEvent(Sender: TObject);
begin
  MovePiece(pmDown);
  DoChange;
end;

function TTetris.CreateRandomPiece: TTetrisPiece;
var
  utpShape: TPiecePattern;
begin
  Result := TTetrisPiece.Create;
  Randomize;
  utpShape := objPatterns[Random(10)];
  Result
     .SetColor(PIECE_COLORS[Random(10) + 1])
     .SetBrickSize(Grid.CellWidth)
     .SetShape(utpShape)
     .SetGridParent(objGrid)
     .SetLeft(Grid.Left)
     .SetTop(Grid.Top);
end;

procedure TTetris.Draw(aCanvas: TCanvas);
begin
  Grid.Draw(aCanvas);
  CurrentPiece.Draw(aCanvas);
end;

procedure TTetris.Start;
begin
  CurrentPiece := CreateRandomPiece;
  objTimer.Enabled := True;
end;

procedure TTetris.DoLoadPatterns;
begin
  objPatterns.Add(PTR_SQUARE);
  objPatterns.Add(PTR_BAR);
  objPatterns.Add(PTR_LEFT_L);
  objPatterns.Add(PTR_RIGHT_L);
  objPatterns.Add(PTR_SQUAD);
  objPatterns.Add(PTR_T);
  objPatterns.Add(PTR_CROSS);
  objPatterns.Add(PTR_SPECIAL);
  objPatterns.Add(PTR_LEFT_S);
  objPatterns.Add(PTR_RIGHT_S);
end;

constructor TTetris.Create;
begin
  inherited;
  objPatterns := TPiecePatternList.Create;
  objTimer := TThreadTimer.Create;
  objTimer.OnTimer := OnTimerEvent;
  DoLoadPatterns;
end;

destructor TTetris.Destroy;
begin
  if Assigned(objGrid) then
    objGrid.Free;
  objTimer.Free;
  objPatterns.Free;
  inherited;
end;

end.
