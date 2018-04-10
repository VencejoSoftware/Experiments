unit Unit1;

interface

uses
  Windows,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons,
  Piece.Tetris,
  Tetris.Board;

const
  CellWidth          = 14;
  CellHeight         = 14;
  Columns            = 20;
  Rows               = 20;
  PreviewBlockWidth  = 6;
  PreviewBlockHeight = 6;

type
  TForm1 = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    Timer1: TTimer;
    Image1: TImage;
    Edit1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Dessiner;
    procedure FlipPiece;
    procedure Verif;
    procedure Fin;
    function PieceFormY: integer;
    function PieceFormX: integer;
    function Possible: Boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
  private
    objTetris: TTetris;
    procedure OnChangeTetris(Sender: TObject);
  end;

  TGrid = array [1 .. Columns, 1 .. Rows] of Byte;
  TPiece = array [1 .. 4, 1 .. 4] of Byte;

var
  JVerif: integer;
  Couleur, CouleurNow: integer;
  Couleurs: array [1 .. 10] of Tcolor =
     (
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
  Couleurcourante: Tcolor;
  Score: integer;
  CouleurSuivante: Tcolor;
  Level: integer = 1;
  KeyPressed: Boolean = False;
  Nouvelle: Boolean;
  Form1: TForm1;
  PiecePosY, PiecePosX, PieceFormY, PieceFormX: integer;
  PlateauCours, PlateauAncien: TGrid;

  PieceCourante: TPiece;
  PieceSuivante: TPiece =
     ((0, 0, 0, 0),
     (0, 0, 0, 0),
     (0, 0, 0, 0),
     (0, 0, 0, 0));
  Piece: TPiece =
     ((0, 0, 0, 0),
     (0, 0, 0, 0),
     (0, 0, 0, 0),
     (0, 0, 0, 0));
  Croix: TPiece =
     ((0, 1, 0, 0),
     (1, 1, 1, 1),
     (0, 0, 0, 0),
     (0, 0, 0, 0));
  Barre: TPiece =
     ((0, 0, 0, 0),
     (1, 1, 1, 1),
     (0, 0, 0, 0),
     (0, 0, 0, 0));
  LGauche: TPiece =
     ((0, 1, 1, 0),
     (0, 1, 0, 0),
     (0, 1, 0, 0),
     (0, 0, 0, 0));
  LDroite: TPiece =
     ((0, 1, 0, 0),
     (0, 1, 0, 0),
     (0, 1, 1, 0),
     (0, 0, 0, 0));
  Carre: TPiece =
     ((0, 0, 0, 0),
     (0, 1, 1, 0),
     (0, 1, 1, 0),
     (0, 0, 0, 0));
  GrosCarre: TPiece =
     ((0, 0, 0, 0),
     (0, 1, 1, 0),
     (0, 1, 0, 0),
     (0, 0, 0, 0));
  T: TPiece =
     ((0, 1, 0, 0),
     (0, 1, 1, 0),
     (0, 1, 0, 0),
     (0, 0, 0, 0));
  CarreSpe: TPiece =
     ((0, 1, 0, 0),
     (0, 1, 1, 0),
     (0, 0, 1, 1),
     (0, 0, 0, 0));
  SGauche: TPiece =
     ((0, 0, 1, 0),
     (0, 1, 1, 0),
     (0, 1, 0, 0),
     (0, 0, 0, 0));
  SDroite: TPiece =
     ((0, 1, 0, 0),
     (0, 1, 1, 0),
     (0, 0, 1, 0),
     (0, 0, 0, 0));

implementation

{$R *.DFM}


function TForm1.PieceFormX: integer;
begin
  PieceFormX := PiecePosX * CellWidth + Bevel1.left;
end;

function TForm1.PieceFormY: integer;
begin
  PieceFormY := PiecePosY * CellHeight + Bevel1.Top;
end;

function TForm1.Possible: Boolean;
var
  I, J: integer;
begin
  KeyPressed := False;
  for I := 1 to 4 do
    for J := 1 to 4 do
    begin
      if PieceCourante[I, J] <> 0 then
        if PiecePosY + J > Rows then
        begin
          Possible := False;
          Exit;
        end
        else if PiecePosX + I > Columns then
        begin
          dec(PiecePosX);
          Possible;
          Possible := True;
          Exit;
        end
        else if PiecePosX + I < 1 then
        begin
          Inc(PiecePosX);
          Possible;
          Possible := True;
          Exit;
        end
        else if PlateauCours[I + PiecePosX, J + PiecePosY] > 0 then
        begin
          Possible := False;
          Exit;
        end;
    end;
  Possible := True;
  KeyPressed := True;
end;

procedure TForm1.Fin;
begin
  KeyPressed := False;
  Timer1.Enabled := False;
  ShowMessage('Perdu, votre score est de: ' + IntToStr(Score));
end;

procedure TForm1.Verif;
var
  I, J, K, L, M, N, O, S: integer;
begin
  KeyPressed := False;
  S := 5;
  Timer1.Enabled := False;
  for I := 1 to Rows do
  begin
    K := 0;
    for J := 1 to Columns do
      if PlateauCours[J, I] > 0 then
        Inc(K);
    if K = Columns then
    begin
      S := S * 5;
      for L := I - 1 downto 1 do
        for M := 1 to Columns do
          PlateauCours[M, L + 1] := PlateauCours[M, L];
      for N := 1 to Rows do
        for O := 1 to Columns do
        begin
          if PlateauCours[O, N] = 0 then
          begin
            Canvas.brush.Color := clBlack;
            Canvas.Pen.Color := clBlack;
            Canvas.Rectangle(Bevel1.left + (O - 1) * CellWidth, Bevel1.Top + (N - 1) * CellHeight,
               Bevel1.left + (O) * CellWidth, Bevel1.Top + (N) * CellHeight);
          end
          else
          begin
            Canvas.brush.Color := Couleurs[PlateauCours[O, N]];
            Canvas.Pen.Color := clBlack;
            Canvas.Rectangle(Bevel1.left + (O - 1) * CellWidth, Bevel1.Top + (N - 1) * CellHeight,
               Bevel1.left + (O) * CellWidth, Bevel1.Top + (N) * CellHeight);

          end;
        end;
    end;
  end;
  Score := Score + S;
  KeyPressed := True;
end;

procedure NouvellePiece;
var
  I, J: integer;
begin
  Form1.Timer1.Enabled := False;
  Nouvelle := True;
  KeyPressed := False;
  PiecePosX := 2;
  PiecePosY := 0;
  Form1.Verif;
  Form1.Timer1.Enabled := True;
  Couleurcourante := CouleurSuivante;
  Move(PieceSuivante, PieceCourante, SizeOf(PieceCourante));
  Randomize;
  CouleurNow := Couleur;
  Randomize;
  Randomize;
  I := Random(10) + 1;
  Couleur := Random(10) + 1;
  CouleurSuivante := Couleurs[Couleur];
  case I of
    1:
      Move(Barre, PieceSuivante, SizeOf(PieceSuivante));
    2:
      Move(Croix, PieceSuivante, SizeOf(PieceSuivante));
    3:
      Move(GrosCarre, PieceSuivante, SizeOf(PieceSuivante));
    4:
      Move(LGauche, PieceSuivante, SizeOf(PieceSuivante));
    5:
      Move(LDroite, PieceSuivante, SizeOf(PieceSuivante));
    6:
      Move(T, PieceSuivante, SizeOf(PieceSuivante));
    7:
      Move(CarreSpe, PieceSuivante, SizeOf(PieceSuivante));
    8:
      Move(SDroite, PieceSuivante, SizeOf(PieceSuivante));
    9:
      Move(SGauche, PieceSuivante, SizeOf(PieceSuivante));
    10:
      Move(Carre, PieceSuivante, SizeOf(PieceSuivante));
  end;
  Form1.Image1.Canvas.Pen.Width := 0;
  Form1.Image1.Canvas.Pen.Color := Form1.Color;
  Form1.Image1.Canvas.brush.Color := Form1.Color;
  Form1.Image1.Canvas.Rectangle(0, 0, Form1.Image1.Width, Form1.Image1.Height);
  Form1.Image1.Canvas.brush.Color := CouleurSuivante;
  Form1.Image1.Canvas.Pen.Color := clBlack;
  Form1.Image1.Canvas.Pen.Width := 1;

  for J := 1 to 4 do
    for I := 1 to 4 do
      if PieceSuivante[I, J] > 0 then
      begin
        Form1.Image1.Canvas.Rectangle((I - 1) * PreviewBlockWidth, (J - 1) * PreviewBlockHeight,
           (I) * PreviewBlockWidth, (J) * PreviewBlockHeight);
      end;
  FillChar(PlateauAncien, SizeOf(PlateauAncien), 0);
  if not Form1.Possible then
  begin
    Form1.Fin;
    Exit;
  end;
  KeyPressed := True;
  Nouvelle := False;
  Form1.Timer1.Enabled := True;
end;

procedure TForm1.FlipPiece;
var
  I, J: integer;
begin
  for I := 4 downto 1 do
    for J := 1 to 4 do
      Piece[J, 5 - I] := PieceCourante[I, J];
  Move(Piece, PieceCourante, SizeOf(PieceCourante));
end;

procedure TForm1.Dessiner;
var
  I, J: integer;
begin
  KeyPressed := False;
  if Possible then
  begin
    Canvas.Refresh;
    Canvas.brush.Color := clBLue;
    Canvas.Pen.Color := clBLue;
    for J := 1 to Rows do
      for I := 1 to Columns do
      begin
        if PlateauCours[I, J] <> PlateauAncien[I, J] then
          if PlateauCours[I, J] = 0 then
          begin
            Canvas.brush.Color := clBlack;
            Canvas.Pen.Color := clBlack;
            Canvas.Rectangle(Bevel1.left + (I - 1) * CellWidth, Bevel1.Top + (J - 1) * CellHeight,
               Bevel1.left + (I) * CellWidth, Bevel1.Top + (J) * CellHeight);
          end
          else
          begin
            Canvas.brush.Color := Couleurs[PlateauCours[I, J]];
            Canvas.Pen.Color := Couleurs[PlateauCours[I, J]];
            Canvas.Rectangle(Bevel1.left + (I - 1) * CellWidth, Bevel1.Top + (J - 1) * CellHeight,
               Bevel1.left + (I) * CellWidth, Bevel1.Top + (J) * CellHeight);
            Canvas.Pen.Width := 1;
            Canvas.MoveTo(Bevel1.left + (I - 1) * CellWidth + 1,
               Bevel1.Top + (J - 1) * CellHeight + 1);
            Canvas.Pen.Color := clWhite;
            Canvas.LineTo(Bevel1.left + (I - 1) * CellWidth + 1, Bevel1.Top + (J) * CellHeight - 2);
            Canvas.Pen.Color := clBlack;
            Canvas.LineTo(Bevel1.left + (I) * CellWidth - 2, Bevel1.Top + (J) * CellHeight - 2);
            Canvas.LineTo(Bevel1.left + (I) * CellWidth - 2, Bevel1.Top + (J - 1) * CellHeight + 1);
            Canvas.Pen.Color := clWhite;
            Canvas.LineTo(Bevel1.left + (I - 1) * CellWidth + 1,
               Bevel1.Top + (J - 1) * CellHeight + 1);

          end;
      end;
    Move(PlateauCours, PlateauAncien, SizeOf(PlateauAncien));
    for J := 1 to 4 do
      for I := 1 to 4 do
        if PieceCourante[I, J] > 0 then
        begin
          Canvas.brush.Color := Couleurcourante;
          Canvas.Pen.Color := Couleurcourante;
          Canvas.Rectangle(PieceFormX + (I - 1) * CellWidth, PieceFormY + (J - 1) * CellHeight,
             PieceFormX + (I) * CellWidth, PieceFormY + (J) * CellHeight);
          Canvas.Pen.Width := 1;
          Canvas.MoveTo(PieceFormX + (I - 1) * CellWidth + 1,
             PieceFormY + (J - 1) * CellHeight + 1);
          Canvas.Pen.Color := clWhite;
          Canvas.LineTo(PieceFormX + (I - 1) * CellWidth + 1, PieceFormY + (J) * CellHeight - 2);
          Canvas.Pen.Color := clBlack;
          Canvas.LineTo(PieceFormX + (I) * CellWidth - 2, PieceFormY + (J) * CellHeight - 2);
          Canvas.LineTo(PieceFormX + (I) * CellWidth - 2, PieceFormY + (J - 1) * CellHeight + 1);
          Canvas.Pen.Color := clWhite;
          Canvas.LineTo(PieceFormX + (I - 1) * CellWidth + 1,
             PieceFormY + (J - 1) * CellHeight + 1);
          PlateauAncien[(PiecePosX + I), (PiecePosY + J)] := CouleurNow;
        end;
  end
  else
  begin
    Move(PlateauAncien, PlateauCours, SizeOf(PlateauCours));
    NouvellePiece;
  end;
  KeyPressed := True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if Score > Level * 1000 then
  begin
    Inc(Level);
    Timer1.interval := 500 - 81 * (Level - 1);
  end;
  Score := Score + 5;
  Edit1.Caption := IntToStr(Score);
  Inc(PiecePosY);
  Dessiner;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  J, I: integer;
begin
  BitBtn1.Enabled := False;
  I := Random(10) + 1;
  Couleur := Random(10) + 1;
  CouleurSuivante := Couleurs[Couleur];
  case I of
    1:
      Move(Barre, PieceSuivante, SizeOf(PieceSuivante));
    2:
      Move(Croix, PieceSuivante, SizeOf(PieceSuivante));
    3:
      Move(GrosCarre, PieceSuivante, SizeOf(PieceSuivante));
    4:
      Move(LGauche, PieceSuivante, SizeOf(PieceSuivante));
    5:
      Move(LDroite, PieceSuivante, SizeOf(PieceSuivante));
    6:
      Move(T, PieceSuivante, SizeOf(PieceSuivante));
    7:
      Move(CarreSpe, PieceSuivante, SizeOf(PieceSuivante));
    8:
      Move(SDroite, PieceSuivante, SizeOf(PieceSuivante));
    9:
      Move(SGauche, PieceSuivante, SizeOf(PieceSuivante));
    10:
      Move(Carre, PieceSuivante, SizeOf(PieceSuivante));
  end;
  Canvas.Refresh;
  Canvas.brush.Color := clBLue;
  Canvas.Pen.Color := clBLue;
  for J := 1 to Rows do
    for I := 1 to Columns do
      if PlateauCours[I, J] = 0 then
      begin
        Canvas.brush.Color := clBlack;
        Canvas.Pen.Color := clBlack;
        Canvas.Rectangle(Bevel1.left + (I - 1) * CellWidth, Bevel1.Top + (J - 1) * CellHeight,
           Bevel1.left + (I) * CellWidth, Bevel1.Top + (J) * CellHeight);
      end;

  NouvellePiece;
  KeyPressed := True;
  Timer1.Enabled := True;

end;

procedure TForm1.FormKeyDown
   (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if KeyPressed then
  begin
    KeyPressed := False;
    case Key of
      VK_RIGHT:
        objTetris.MovePiece(pmRight);
      VK_LEFT:
        objTetris.MovePiece(pmLeft);
      VK_UP, VK_SPACE:
        objTetris.MovePiece(pmRotate);
      VK_DOWN:
        objTetris.MovePiece(pmDown);
    end;
    objTetris.CurrentPiece.Draw(Canvas);
    Invalidate;
  end;
  KeyPressed := True;

  Exit;

  if not Nouvelle then
    if KeyPressed then
    begin
      KeyPressed := False;
      case Key of
        VK_RIGHT:
          begin
            if Possible then
              Inc(PiecePosX);
          end;
        VK_LEFT:
          begin
            if Possible then
              dec(PiecePosX);
          end;
        VK_UP, VK_SPACE:
          FlipPiece;
        VK_DOWN:
          begin
            if Possible then
              Inc(PiecePosY);
          end;
      end;
      Dessiner;
    end;
  KeyPressed := True;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  objTetris.Draw(Canvas);
end;

procedure TForm1.OnChangeTetris(Sender: TObject);
begin
  Invalidate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  objTetris := TTetris.Create;
  objTetris.Grid.Left := Width - 500;
  objTetris.Grid.Top := 10;
  objTetris.OnChange := OnChangeTetris;
  objTetris.Start;

  Bevel1.Width := Columns * CellWidth;
  Bevel1.Height := Rows * CellHeight;
  FillChar(PlateauCours, SizeOf(PlateauCours), 0);
  FillChar(PlateauAncien, SizeOf(PlateauAncien), 0);
  BitBtn1.left := Bevel1.left + Bevel1.Width + 30;
  Image1.left := BitBtn1.left;
  Edit1.left := BitBtn1.left;
end;

end.
