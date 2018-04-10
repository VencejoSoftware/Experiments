unit Utetris;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls, Buttons, BestScor, ImgList, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Image: TImage;
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    Nouveau1: TMenuItem;
    N1: TMenuItem;
    Quitter1: TMenuItem;
    ImageList: TImageList;
    B_fond: TSpeedButton;
    TimerChute: TTimer;
    Pause1: TMenuItem;
    Jeu1: TMenuItem;
    Niveaudedpart1: TMenuItem;
    Dificult1: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N51: TMenuItem;
    N61: TMenuItem;
    N71: TMenuItem;
    N81: TMenuItem;
    N91: TMenuItem;
    N12: TMenuItem;
    N22: TMenuItem;
    N32: TMenuItem;
    N42: TMenuItem;
    N52: TMenuItem;
    N62: TMenuItem;
    N72: TMenuItem;
    N82: TMenuItem;
    N92: TMenuItem;
    N4: TMenuItem;
    MeilleursScores1: TMenuItem;
    N01: TMenuItem;
    Panel2: TPanel;
    Image1: TImage;
    Panel3: TPanel;
    Label1: TLabel;
    L_Score: TLabel;
    Label3: TLabel;
    L_Niveau: TLabel;
    MotifLst: TImageList;
    Label2: TLabel;
    L_Lignes: TLabel;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure Nouveau1Click(Sender: TObject);
    procedure Pause1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
              Shift: TShiftState);
    procedure TimerChuteTimer(Sender: TObject);
    procedure Createpiece;
    procedure Draw;
    function  Rotate : boolean;
    function  Move(x,y : integer) : boolean;
    procedure SupprimeLigne;
    procedure CheckedRefresh;
    procedure N11Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure N61Click(Sender: TObject);
    procedure N71Click(Sender: TObject);
    procedure N81Click(Sender: TObject);
    procedure N91Click(Sender: TObject);
    procedure N01Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure N42Click(Sender: TObject);
    procedure N52Click(Sender: TObject);
    procedure N62Click(Sender: TObject);
    procedure N72Click(Sender: TObject);
    procedure N82Click(Sender: TObject);
    procedure N92Click(Sender: TObject);
    procedure MeilleursScores1Click(Sender: TObject);
{    procedure APropos1Click(Sender: TObject);
    procedure AlAide1Click(Sender: TObject);
    procedure LeJeu1Click(Sender: TObject);}
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type PieceType = record
                       X         :      Byte;
                       Y         :      Byte;
                       Num       :      Byte;
                       Etat      :      Byte;
                       Forme     :      array[1..16] of Boolean;
                       FormePrec :      array[1..16] of Boolean;
                 end;

const T_piece  : array[0..27] of word = (52224,52224,52224,52224,
                                         50240,59392,35008,11776,
                                         51328,36352,17600,57856,
                                         35904,27648,35904,27648,
                                         19584,50688,19584,50688,
                                         19968,19520, 3648,17984,
                                         17476,61440,17476,61440);
      T_Speed  : array[1..10] of word = (350,320,290,260,230,200,170,140,110,80);
      T_Points : array[0..4]  of word = (0,100,300,600,1000);
      T_Clig   : array[0..1]  of Word = (100,150);

var
  Form1      : TForm1;
  Piece      : PieceType;
  PieceSuiv  : PieceType;
  anim       : byte;
  Nbsup      : byte;
  Difficult  : byte;
  NiveauDep  : byte;
  nblignes   : word;
  score      : word;
  winner     : boolean;
  EnPartie   : boolean;
  T_sup      : array[1..4] of byte;
  T_jeu      : array[0..11,0..19] of byte;
  T_anim     : array[1..4,0..10] of byte;

implementation

{$R *.DFM}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure TForm1.FormCreate(Sender: TObject);
          var i : byte;
          begin
               EnPartie := False;
               Application.onActivate   := Pause1Click;
               Application.onDeActivate := Pause1Click;
               Clientwidth  := 408;
               Clientheight := 408 + StatusBar1.Height;
               top          := 0;
               left         := 0;
               NiveauDep    := 1;
               Difficult    := 0;
               randomize;
               image.canvas.draw(0,0,b_fond.glyph);
               for i := 1 to 18 do T_jeu[0 ,i ] := 9;
               for i := 1 to 18 do T_jeu[11,i ] := 9;
               for i := 0 to 11 do T_jeu[i ,18] := 9;
               TimerChute.Interval := T_Speed[Nblignes div 10 + NiveauDep];
               L_Score.caption     := inttostr(score);
               L_Niveau.Caption    := inttostr(nblignes div 10 + NiveauDep);
               L_lignes.Caption    := inttostr(nblignes);
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure TForm1.Nouveau1Click(Sender : TObject);
          var i, j : byte;
              w    : word;
          begin
               EnPartie := True;
               Score    := 500 * (Difficult + NiveauDep - 1);
               NbLignes := 0;
               for i := 0 to 27 do
               for j := 0 to 25 do
                   MotifLst.Draw(Canvas, 16*i, 16*j, (nblignes div 10 + NiveauDep - 1) mod 9);
               L_Score.caption     := inttostr(score);
               L_Niveau.Caption    := inttostr(nblignes div 10 + NiveauDep);
               L_lignes.Caption    := inttostr(nblignes);
               TimerChute.Interval := T_Speed[Nblignes div 10 + NiveauDep];
               TimerChute.Enabled  := true;
               for i := 1 to 10 do
               for j := 1 to 17 do
                   T_jeu[i,j] := 0;
               for i := 1 to 7 * Difficult do
                   T_jeu[Random(10) + 1, 17 - Random(Difficult)] := random(8);
               piecesuiv.num := random(7);
               piece.y := 1;
               w := T_piece[4 * piecesuiv.num];
               for i := 0 to 15 do
                   begin
                        piecesuiv.forme[16 - i] := (w mod 2 = 1);
                        w := w div 2;
                   end;
               createpiece;
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure TForm1.Pause1Click(Sender: TObject);
          begin
               if not(EnPartie) then exit;
               Pause1.Checked     := Not(Pause1.Checked);
               TimerChute.Enabled := Not(Pause1.Checked);
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure TForm1.Quitter1Click(Sender: TObject);
          begin
               close;
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
          begin
               if ((anim > 0) or (not(EnPartie) and (key <> 27))) then exit;
               {VK_Left  := 37}  {VK_Right := 39}
               {VK_Up    := 38}  {VK_Down  := 40}  {Vk_Esc   := 27}
               case key of
               {esc}    27 : close;
               {left}   37 : move(-1,0);
               {up}     38 : rotate;
               {right}  39 : move(1,0);
               {bottom} 40 : move(0,1);
               end;
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure TForm1.TimerChuteTimer(Sender: TObject);
          var i, j, k : byte;
          begin
               if (anim > 0) then
                  begin
                       TimerChute.Interval := T_Clig[anim mod 2];
                       if (anim mod 2 = 1) then
                          begin
                               for i := 1 to nbsup do
                               for j := 1 to 10 do
                                   T_jeu[j, T_sup[i]] := T_anim[i, j];
                          end
                       else
                          begin
                               for i := 1 to nbsup do
                               for j := 1 to 10 do
                                   T_jeu[j, T_sup[i]] := 0;
                          end;
                       dec(anim);
                       if (anim = 0) then
                          begin
                               image.canvas.draw(0,0,b_fond.glyph);
                               for k := 1 to nbsup do
                                   for j := T_sup[k] downto 2 do
                                   for i := 1 to 10 do T_jeu[i,j] := T_jeu[i,j-1];
                               inc(score, T_points[nbsup]);
                               inc(nblignes, nbsup);
                               L_Score.caption     := inttostr(score);
                               L_Niveau.Caption    := inttostr(nblignes div 10 + NiveauDep);
                               L_lignes.Caption    := inttostr(nblignes);
                               TimerChute.Interval := T_Speed[Nblignes div 10 + NiveauDep];
                               for i := 0 to 27 do
                               for j := 0 to 25 do
                                   MotifLst.Draw(Canvas, 16*i, 16*j, (nblignes div 10 + NiveauDep - 1) mod 9);
                               CreatePiece;
                          end;
                       draw;
                       exit;
                  end;
               if not(move(0,1)) then
                  begin
                       for i := 0 to 15 do
                           if Piece.Forme[i + 1] then T_jeu[piece.x + i mod 4, piece.y + i div 4] := piece.num + 1;
                       SupprimeLigne;
                  end;
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure TForm1.Createpiece;
          var i: byte;
              w    : word;
          begin
               if (piece.y = 0) then
                  begin
                       TimerChute.enabled := false;
                       winner := true;
                       with TBestScorDlg.Create(Self) do
                            try
                               ShowModal;
                            finally
                               Free;
                       end;
                       winner := false;
                       EnPartie := False;
                       piece.y := 5;
                       exit;
                  end;
               piece.Num     := piecesuiv.num;
               piecesuiv.num := random(7);
               w := T_piece[4 * piecesuiv.num];
               for i := 0 to 15 do
                   begin
                        piecesuiv.forme[16 - i] := (w mod 2 = 1);
                        w := w div 2;
                   end;
               Image1.canvas.Brush.color := clblack;
               Image1.canvas.fillrect(rect(0,0,60,80));
               for i := 0 to 15 do
                   if piecesuiv.forme[i + 1] then imagelist.DrawOverlay(Image1.Canvas, 20 * (i mod 4), 20 * (i div 4), piecesuiv.num, 1);
               w := T_piece[4 * piece.num];
               piece.etat := 0;
               piece.x    := 4;
               piece.y    := 0;
               for i := 0 to 15 do
                   begin
                        piece.forme[16 - i] := (w mod 2 = 1);
                        w := w div 2;
                   end;
               draw;
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure TForm1.Draw;
          var m, n : byte;
          begin
               image.canvas.draw(0,0,b_fond.glyph);
               for m := 1 to 10 do
               for n := 1 to 17 do
                   if (T_jeu[m,n] > 0) then imagelist.DrawOverlay(Image.Canvas, 20 * m, 20 * n , T_jeu[m,n] - 1, 1);
               for m := 0 to 15 do
                   if (piece.forme[m + 1] and (anim = 0)) then imagelist.DrawOverlay(Image.Canvas, 20 * (piece.x + m mod 4), 20 * (piece.y + m div 4), piece.num, 1);
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
function  TForm1.Rotate : boolean;
          var formesav : array[1..16] of boolean;
              i        : byte;
              w        : word;
          begin
               for i := 1 to 16 do
                   formesav[i] := piece.forme[i];
               inc(piece.etat);
               w := T_piece[4 * piece.num + piece.etat mod 4];
               for i := 0 to 15 do
                   begin
                        piece.forme[16 - i] := (w mod 2 = 1);
                        w := w div 2;
                   end;
               result := true;
               for i := 0 to 15 do
                   if (piece.forme[i+1] and  (T_jeu[piece.x + i mod 4, piece.y + i div 4] > 0)) then result := false;
               if result then
                  draw
               else
                  begin
                       dec(piece.etat);
                       for i := 1 to 16 do
                           piece.forme[i] := formesav[i];
                  end;
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
function  TForm1.Move(x,y : integer) : boolean;
          var i : byte;
          begin
               result := true;
               for i := 0 to 15 do
                   if (piece.forme[i + 1] and  (T_jeu[piece.x + x + i mod 4, piece.y + y + i div 4] > 0)) then result := false;
               if result then
                  begin
                       inc(piece.x, x);
                       inc(piece.y, y);
                       Draw;
                  end;
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure Tform1.SupprimeLigne;
          var sup           : boolean;
              i, j          : byte;
          begin
               nbsup := 0;
               for i := 1 to 4 do T_sup[i] := 0;
               for j := 1 to 17 do
                  begin
                       sup := true;
                       for i := 1 to 10 do if (T_jeu[i,j] = 0) then sup := false;
                       if sup then inc(nbsup);
                       if sup then T_sup[nbsup] := j;
                  end;
               if (nbsup > 0) then
                  begin
                       anim := 6;
                       TimerChute.interval := 20;
                       for i := 1 to nbsup do
                       for j := 1 to 10 do
                           T_anim[i, j] := T_jeu[j, T_sup[i]];
                  end
               else
                  createpiece;
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure TForm1.CheckedRefresh;
          begin
               N11.checked := false; N21.checked := false; N31.checked := false;
               N41.checked := false; N51.checked := false; N61.checked := false;
               N71.checked := false; N81.checked := false; N91.checked := false;
               N01.checked := false; N12.checked := false; N22.checked := false;
               N32.checked := false; N42.checked := false; N52.checked := false;
               N62.checked := false; N72.checked := false; N82.checked := false; N92.checked := false;
               case NiveauDep of
                    1 : N11.Checked := true;
                    2 : N21.Checked := true;
                    3 : N31.Checked := true;
                    4 : N41.Checked := true;
                    5 : N51.Checked := true;
                    6 : N61.Checked := true;
                    7 : N71.Checked := true;
                    8 : N81.Checked := true;
                    9 : N91.Checked := true;
                    end;
               case Difficult of
                    0 : N01.Checked := true;
                    1 : N12.Checked := true;
                    2 : N22.Checked := true;
                    3 : N32.Checked := true;
                    4 : N42.Checked := true;
                    5 : N52.Checked := true;
                    6 : N62.Checked := true;
                    7 : N72.Checked := true;
                    8 : N82.Checked := true;
                    9 : N92.Checked := true;
                    end;
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure TForm1.N11Click(Sender: TObject);
          begin NiveauDep := 1; CheckedRefresh; end;
procedure TForm1.N21Click(Sender: TObject);
          begin NiveauDep := 2; CheckedRefresh; end;
procedure TForm1.N31Click(Sender: TObject);
          begin NiveauDep := 3; CheckedRefresh; end;
procedure TForm1.N41Click(Sender: TObject);
          begin NiveauDep := 4; CheckedRefresh; end;
procedure TForm1.N51Click(Sender: TObject);
          begin NiveauDep := 5; CheckedRefresh; end;
procedure TForm1.N61Click(Sender: TObject);
          begin NiveauDep := 6; CheckedRefresh; end;
procedure TForm1.N71Click(Sender: TObject);
          begin NiveauDep := 7; CheckedRefresh; end;
procedure TForm1.N81Click(Sender: TObject);
          begin NiveauDep := 8; CheckedRefresh; end;
procedure TForm1.N91Click(Sender: TObject);
          begin NiveauDep := 9; CheckedRefresh; end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure TForm1.N01Click(Sender: TObject);
          begin Difficult := 0; CheckedRefresh; end;
procedure TForm1.N12Click(Sender: TObject);
          begin Difficult := 1; CheckedRefresh; end;
procedure TForm1.N22Click(Sender: TObject);
          begin Difficult := 2; CheckedRefresh; end;
procedure TForm1.N32Click(Sender: TObject);
          begin Difficult := 3; CheckedRefresh; end;
procedure TForm1.N42Click(Sender: TObject);
          begin Difficult := 4; CheckedRefresh; end;
procedure TForm1.N52Click(Sender: TObject);
          begin Difficult := 5; CheckedRefresh; end;
procedure TForm1.N62Click(Sender: TObject);
          begin Difficult := 6; CheckedRefresh; end;
procedure TForm1.N72Click(Sender: TObject);
          begin Difficult := 7; CheckedRefresh; end;
procedure TForm1.N82Click(Sender: TObject);
          begin Difficult := 8; CheckedRefresh; end;
procedure TForm1.N92Click(Sender: TObject);
          begin Difficult := 9; CheckedRefresh; end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------
procedure TForm1.APropos1Click(Sender: TObject);
          begin
               Pause1Click(sender);
               with TAProposDlg.Create(Self) do
                 try
                    ShowModal;
                 finally
                    Free;
               end;
               Pause1Click(sender);
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------
procedure TForm1.AlAide1Click(Sender: TObject);
          begin
               Pause1Click(sender);
               with TReglesDlg.Create(Self) do
                 try
                    ShowModal;
                 finally
                    Free;
               end;
               Pause1Click(sender);
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
procedure TForm1.MeilleursScores1Click(Sender: TObject);
          var reprise : boolean;
          begin
               reprise := TimerChute.Enabled;
               TimerChute.Enabled := false;
               winner := false;
               with TBestScorDlg.Create(Self) do
                 try
                    ShowModal;
                 finally
                    Free;
               end;
               TimerChute.Enabled := reprise;
          end;
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------}
{----------------------------------------------------------------------------------------------
procedure TForm1.LeJeu1Click(Sender: TObject);
          begin
               Pause1Click(sender);
               with TLeJeuDlg.Create(Self) do
                 try
                    ShowModal;
                 finally
                    Free;
               end;
               Pause1Click(sender);
          end;
}

end.


