unit UnidadTetris;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls, Buttons, UnidadMejoresTiempos, ImgList, ComCtrls, shellapi;

type
  TformTetris = class(TForm)
    Panel1: TPanel;
    Image: TImage;
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    mnuNuevaPartida: TMenuItem;
    N1: TMenuItem;
    Quitter1: TMenuItem;
    ImageList: TImageList;
    B_fond: TSpeedButton;
    tmTemporizador: TTimer;
    mnuPausa: TMenuItem;
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
    MeilleursScores1: TMenuItem;
    N01: TMenuItem;
    Panel2: TPanel;
    Image1: TImage;
    Panel3: TPanel;
    Label1: TLabel;
    lbPuntos: TLabel;
    Label3: TLabel;
    lbNivel: TLabel;
    MotifLst: TImageList;
    Label2: TLabel;
    lbLineas: TLabel;
    N2: TMenuItem;
    Panel4: TPanel;
    LWEB: TLabel;
    be: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure mnuNuevaPartidaClick(Sender: TObject);
    procedure mnuPausaClick(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
              Shift: TShiftState);
    procedure tmTemporizadorTimer(Sender: TObject);
    procedure crearPieza;
    procedure dibujarPieza;
    function  Rotate : boolean;
    function  Move(x,y : integer) : boolean;
    procedure eliminarLinea;
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
    procedure LWEBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type tipoPieza = record
  X : Byte;
  Y : Byte;
  Num : Byte;
  estado : Byte;
  forma : array[1..16] of Boolean;
end;

const
  arPieza : array[0..27] of word = (52224, 52224, 52224, 52224,
    50240, 59392, 35008, 11776, 51328, 36352, 17600, 57856, 35904, 27648,
    35904, 27648, 19584, 50688, 19584, 50688, 19968, 19520, 3648, 17984,
    17476, 61440, 17476, 61440);
  arVelocidad : array[1..10] of word = (350, 320, 290, 260, 230, 200,
    170, 140, 110, 80);
  arPuntos : array[0..4]  of word = (0, 100, 300, 600, 1000);
  T_Clig   : array[0..1]  of Word = (100, 150);
var
  formTetris : TformTetris;
  pieza : tipoPieza;
  piezaSiguiente : tipoPieza;
  animacion : byte;
  Nbsup : byte;
  dificultad : byte;
  NivelDep : byte;
  nbLineas : word;
  puntuacion : word;
  ganador : boolean;
  partidaEmpezada : boolean;
  T_sup : array[1..4] of byte;
  T_juego : array[0..11,0..19] of byte;
  T_anim : array[1..4,0..10] of byte;

implementation

{$R *.DFM}

procedure TformTetris.FormCreate(Sender: TObject);
var
  i : byte;
begin
  partidaEmpezada := False;
  Application.onActivate := mnuPausaClick;
  Application.onDeActivate := mnuPausaClick;
  Clientwidth := 408;
  Clientheight := 408 + be.Height;
  top := 0;
  left := 0;
  NivelDep := 1;
  dificultad := 0;
  randomize;
  image.canvas.Draw (0, 0, b_fond.glyph);
  for i := 1 to 18 do
    T_juego[0 ,i ] := 9;
  for i := 1 to 18 do
    T_juego[11,i ] := 9;
  for i := 0 to 11 do
    T_juego[i ,18] := 9;
  tmTemporizador.Interval := arVelocidad[nbLineas div 10 + NivelDep];
  lbPuntos.caption := inttostr(puntuacion);
  lbNivel.Caption := inttostr(nbLineas div 10 + NivelDep);
  lbLineas.Caption := inttostr(nbLineas);
end;


procedure TformTetris.mnuNuevaPartidaClick(Sender : TObject);
var
  i, j : byte;
  w : word;
begin
  partidaEmpezada := True;
  puntuacion := 500 * (dificultad + NivelDep - 1);
  nbLineas := 0;
  for i := 0 to 27 do
    for j := 0 to 25 do
       MotifLst.Draw (Canvas, 16*i, 16*j, (nbLineas div 10 + NivelDep - 1) mod 9);
  lbPuntos.caption := inttostr(puntuacion);
  lbNivel.Caption := inttostr(nbLineas div 10 + NivelDep);
  lbLineas.Caption := inttostr(nbLineas);
  tmTemporizador.Interval := arVelocidad[nbLineas div 10 + NivelDep];
  tmTemporizador.Enabled := true;
  for i := 1 to 10 do
    for j := 1 to 17 do
      T_juego[i,j] := 0;
  for i := 1 to 7 * dificultad do
    T_juego[Random(10) + 1, 17 - Random(dificultad)] := random(8);
  piezaSiguiente.num := random(7);
  pieza.y := 1;
  w := arPieza[4 * piezaSiguiente.num];
  for i := 0 to 15 do
  begin
    piezaSiguiente.forma[16 - i] := (w mod 2 = 1);
    w := w div 2;
  end;
  crearPieza;
end;


procedure TformTetris.mnuPausaClick(Sender: TObject);
begin
  if not(partidaEmpezada) then
    exit;
  mnuPausa.Checked := Not(mnuPausa.Checked);
  tmTemporizador.Enabled := Not(mnuPausa.Checked);
end;


procedure TformTetris.Quitter1Click(Sender: TObject);
begin
  close;
end;

procedure TformTetris.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  if ((animacion > 0) or (not(partidaEmpezada) and (key <> 27))) then
    exit;
  {VK_Left  := 37}  {VK_Right := 39}
  {VK_Up    := 38}  {VK_Down  := 40}  {Vk_Esc   := 27}
  case key of
    27 : close; //Escape
    37 : move(-1,0); //Izquierda
    38 : rotate; //Arriba
    39 : move(1,0); //Derecha
    40 : move(0,1); //Abajo
  end;
end;


procedure TformTetris.tmTemporizadorTimer(Sender: TObject);
var
  i, j, k : byte;
begin
  if (animacion > 0) then
  begin
    tmTemporizador.Interval := T_Clig[animacion mod 2];
    if (animacion mod 2 = 1) then
    begin
      for i := 1 to nbsup do
        for j := 1 to 10 do
           T_juego[j, T_sup[i]] := T_anim[i, j];
    end
    else
    begin
      for i := 1 to nbsup do
        for j := 1 to 10 do
           T_juego[j, T_sup[i]] := 0;
    end;
    dec(animacion);
    if (animacion = 0) then
    begin
      image.canvas.Draw (0,0,b_fond.glyph);
      for k := 1 to nbsup do
        for j := T_sup[k] downto 2 do
          for i := 1 to 10 do
            T_juego[i,j] := T_juego[i,j-1];
      inc(puntuacion, arPuntos[nbsup]);
      inc(nbLineas, nbsup);
      lbPuntos.caption := inttostr(puntuacion);
      lbNivel.Caption := inttostr(nbLineas div 10 + NivelDep);
      lbLineas.Caption := inttostr(nbLineas);
      tmTemporizador.Interval := arVelocidad[nbLineas div 10 + NivelDep];
      for i := 0 to 27 do
        for j := 0 to 25 do
          MotifLst.Draw (Canvas, 16*i, 16*j, (nbLineas div 10 + NivelDep - 1) mod 9);
      crearPieza;
    end;
    dibujarPieza;
    exit;
  end;
  if not(move(0,1)) then
  begin
    for i := 0 to 15 do
      if pieza.forma[i + 1] then
        T_juego[pieza.x + i mod 4, pieza.y + i div 4] := pieza.num + 1;
    eliminarLinea;
  end;
end;


procedure TformTetris.crearPieza;
var
  i : byte;
  w : word;
begin
  if (pieza.y = 0) then
  begin
    tmTemporizador.enabled := false;
    ganador := true;
    with TformPuntuaciones.Create(Self) do
    try
       ShowModal;
    finally
       Free;
    end;
    ganador := false;
    partidaEmpezada := False;
    pieza.y := 5;
    exit;
  end;
  pieza.Num := piezaSiguiente.num;
  piezaSiguiente.num := random(7);
  w := arPieza[4 * piezaSiguiente.num];
  for i := 0 to 15 do
  begin
    piezaSiguiente.forma[16 - i] := (w mod 2 = 1);
    w := w div 2;
  end;
  Image1.canvas.Brush.color := clblack;
  Image1.canvas.fillrect(rect(0, 0, 60, 80));
  for i := 0 to 15 do
     if piezaSiguiente.forma[i + 1] then
       imagelist.DrawOverlay(Image1.Canvas, 20 * (i mod 4), 20 * (i div 4), piezaSiguiente.num, 1);
  w := arPieza[4 * pieza.num];
  pieza.estado := 0;
  pieza.x := 4;
  pieza.y := 0;
  for i := 0 to 15 do
  begin
    pieza.forma[16 - i] := (w mod 2 = 1);
    w := w div 2;
  end;
  dibujarPieza;
end;


procedure TformTetris.dibujarPieza;
var
  m, n : byte;
begin
  image.canvas.Draw (0, 0, b_fond.glyph);
  for m := 1 to 10 do
    for n := 1 to 17 do
      if (T_juego[m,n] > 0) then
        imagelist.DrawOverlay(Image.Canvas, 20 * m, 20 * n , T_juego[m,n] - 1, 1);
  for m := 0 to 15 do
    if (pieza.forma[m + 1] and (animacion = 0)) then
      imagelist.DrawOverlay(Image.Canvas, 20 * (pieza.x + m mod 4), 20
          * (pieza.y + m div 4), pieza.num, 1);
end;

function  TformTetris.Rotate : boolean;
var
  formesav : array[1..16] of boolean;
  i : byte;
  w : word;
begin
  for i := 1 to 16 do
    formesav[i] := pieza.forma[i];
  inc(pieza.estado);
  w := arPieza[4 * pieza.num + pieza.estado mod 4];
  for i := 0 to 15 do
  begin
    pieza.forma[16 - i] := (w mod 2 = 1);
    w := w div 2;
  end;
  result := true;
  for i := 0 to 15 do
    if (pieza.forma[i+1] and  (T_juego[pieza.x + i mod 4, pieza.y + i div 4] > 0)) then
      result := false;
  if result then
    dibujarPieza
  else
  begin
    dec(pieza.estado);
    for i := 1 to 16 do
      pieza.forma[i] := formesav[i];
  end;
end;


function  TformTetris.Move(x,y : integer) : boolean;
var
  i : byte;
begin
  result := true;
  for i := 0 to 15 do
    if (pieza.forma[i + 1] and  (T_juego[pieza.x + x + i mod 4, pieza.y + y + i div 4] > 0)) then
      result := false;
  if result then
  begin
    inc(pieza.x, x);
    inc(pieza.y, y);
    dibujarPieza;
  end;
end;

procedure TformTetris.eliminarLinea;
var
  sup : boolean;
  i, j : byte;
begin
  nbsup := 0;
  for i := 1 to 4 do
    T_sup[i] := 0;
  for j := 1 to 17 do
  begin
    sup := true;
    for i := 1 to 10 do if (T_juego[i,j] = 0) then
      sup := false;
    if sup then inc(nbsup);
      if sup then T_sup[nbsup] := j;
  end;
  if (nbsup > 0) then
  begin
    animacion := 6;
    tmTemporizador.interval := 20;
    for i := 1 to nbsup do
    for j := 1 to 10 do
      T_anim[i, j] := T_juego[j, T_sup[i]];
  end
  else
    crearPieza;
end;


procedure TformTetris.CheckedRefresh;
begin
  N11.checked := false;
  N21.checked := false;
  N31.checked := false;
  N41.checked := false;
  N51.checked := false;
  N61.checked := false;
  N71.checked := false;
  N81.checked := false;
  N91.checked := false;
  N01.checked := false;
  N12.checked := false;
  N22.checked := false;
  N32.checked := false;
  N42.checked := false;
  N52.checked := false;
  N62.checked := false;
  N72.checked := false;
  N82.checked := false;
  N92.checked := false;
  case NivelDep of
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
  case dificultad of
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

procedure TformTetris.N11Click(Sender: TObject);
begin
  NivelDep := 1;
  CheckedRefresh;
end;

procedure TformTetris.N21Click(Sender: TObject);
begin
  NivelDep := 2;
  CheckedRefresh;
end;

procedure TformTetris.N31Click(Sender: TObject);
begin
  NivelDep := 3;
  CheckedRefresh;
end;

procedure TformTetris.N41Click(Sender: TObject);
begin
  NivelDep := 4;
  CheckedRefresh;
end;

procedure TformTetris.N51Click(Sender: TObject);
begin
  NivelDep := 5;
  CheckedRefresh;
end;

procedure TformTetris.N61Click(Sender: TObject);
begin
  NivelDep := 6;
  CheckedRefresh;
end;

procedure TformTetris.N71Click(Sender: TObject);
begin
  NivelDep := 7;
  CheckedRefresh;
end;

procedure TformTetris.N81Click(Sender: TObject);
begin
  NivelDep := 8;
  CheckedRefresh;
end;
procedure TformTetris.N91Click(Sender: TObject);
begin
  NivelDep := 9;
  CheckedRefresh;
end;

procedure TformTetris.N01Click(Sender: TObject);
begin
  dificultad := 0;
  CheckedRefresh;
end;

procedure TformTetris.N12Click(Sender: TObject);
begin
  dificultad := 1;
  CheckedRefresh;
end;

procedure TformTetris.N22Click(Sender: TObject);
begin
  dificultad := 2;
  CheckedRefresh;
end;

procedure TformTetris.N32Click(Sender: TObject);
begin
  dificultad := 3;
  CheckedRefresh;
end;

procedure TformTetris.N42Click(Sender: TObject);
begin
  dificultad := 4;
  CheckedRefresh;
end;

procedure TformTetris.N52Click(Sender: TObject);
begin
  dificultad := 5;
  CheckedRefresh;
end;

procedure TformTetris.N62Click(Sender: TObject);
begin
  dificultad := 6;
  CheckedRefresh;
end;

procedure TformTetris.N72Click(Sender: TObject);
begin
  dificultad := 7;
  CheckedRefresh;
end;

procedure TformTetris.N82Click(Sender: TObject);
begin
  dificultad := 8;
  CheckedRefresh;
end;

procedure TformTetris.N92Click(Sender: TObject);
begin
  dificultad := 9;
  CheckedRefresh;
end;

procedure TformTetris.MeilleursScores1Click(Sender: TObject);
var
  reprise : boolean;
begin
  reprise := tmTemporizador.Enabled;
  tmTemporizador.Enabled := false;
  ganador := false;
  with TformPuntuaciones.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
  tmTemporizador.Enabled := reprise;
end;

procedure TformTetris.LWEBClick(Sender: TObject);
begin
  ShellExecute(Handle, Nil, PChar('http://www.ajpdsoft.com'),
      Nil, Nil, SW_SHOWNORMAL);
end;

end.


