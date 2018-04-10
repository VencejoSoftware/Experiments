unit Main;
  {Курсовой проект: реализация игры "TETRIS-FLY"
   Автор: Фрейдлина Полина, гр. 93491}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, Registry, ShellAPI;//для вызова браузера;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    mnuGame: TMenuItem;
    mnuNew: TMenuItem;
    mnuS1: TMenuItem;
    mnuExit: TMenuItem;
    Timer1: TTimer;
    Label1: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    Image2: TImage;
    Label2: TLabel;
    mnuHelp: TMenuItem;
    mnuAbout: TMenuItem;
    Label3: TLabel;
    mnuRecords: TMenuItem;
    mnuS2: TMenuItem;
    mnuHelpFile: TMenuItem;
    mnuLev: TMenuItem;
    mnuLevA: TMenuItem;
    mnuLevB: TMenuItem;
    mnuLevC: TMenuItem;
    Label4: TLabel;
    Label5: TLabel;
    procedure mnuNewClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuAboutClick(Sender: TObject);
    procedure mnuRecordsClick(Sender: TObject);
    procedure mnuHelpFileClick(Sender: TObject);
    procedure mnuLevAClick(Sender: TObject);
    procedure mnuLevBClick(Sender: TObject);
    procedure mnuLevCClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TTetr = Array [1..4, 1..4] of Byte;  //массив фигуры

const
  tetramino: Array [1..7, 1..4] of TTetr =      //массив-база фигур с их
  (                                             //всевозможными поворотами
  (((1,1,0,0),(0,1,1,0),(0,0,0,0),(0,0,0,0)),   //1 соответствует закрашенному квадрату
   ((0,1,0,0),(1,1,0,0),(1,0,0,0),(0,0,0,0)),
   ((1,1,0,0),(0,1,1,0),(0,0,0,0),(0,0,0,0)),
   ((0,1,0,0),(1,1,0,0),(1,0,0,0),(0,0,0,0))),
  (((0,1,1,0),(1,1,0,0),(0,0,0,0),(0,0,0,0)),
   ((1,0,0,0),(1,1,0,0),(0,1,0,0),(0,0,0,0)),
   ((0,1,1,0),(1,1,0,0),(0,0,0,0),(0,0,0,0)),
   ((1,0,0,0),(1,1,0,0),(0,1,0,0),(0,0,0,0))),
  (((0,1,0,0),(1,1,1,0),(0,0,0,0),(0,0,0,0)),
   ((0,1,0,0),(0,1,1,0),(0,1,0,0),(0,0,0,0)),
   ((0,0,0,0),(1,1,1,0),(0,1,0,0),(0,0,0,0)),
   ((0,1,0,0),(1,1,0,0),(0,1,0,0),(0,0,0,0))),
  (((0,0,0,0),(1,1,1,1),(0,0,0,0),(0,0,0,0)),
   ((0,1,0,0),(0,1,0,0),(0,1,0,0),(0,1,0,0)),
   ((0,0,0,0),(1,1,1,1),(0,0,0,0),(0,0,0,0)),
   ((0,1,0,0),(0,1,0,0),(0,1,0,0),(0,1,0,0))),
  (((1,1,0,0),(1,1,0,0),(0,0,0,0),(0,0,0,0)),
   ((1,1,0,0),(1,1,0,0),(0,0,0,0),(0,0,0,0)),
   ((1,1,0,0),(1,1,0,0),(0,0,0,0),(0,0,0,0)),
   ((1,1,0,0),(1,1,0,0),(0,0,0,0),(0,0,0,0))),
  (((1,1,0,0),(0,1,0,0),(0,1,0,0),(0,0,0,0)),
   ((0,0,1,0),(1,1,1,0),(0,0,0,0),(0,0,0,0)),
   ((1,0,0,0),(1,0,0,0),(1,1,0,0),(0,0,0,0)),
   ((1,1,1,0),(1,0,0,0),(0,0,0,0),(0,0,0,0))),
  (((1,1,0,0),(1,0,0,0),(1,0,0,0),(0,0,0,0)),
   ((1,1,1,0),(0,0,1,0),(0,0,0,0),(0,0,0,0)),
   ((0,1,0,0),(0,1,0,0),(1,1,0,0),(0,0,0,0)),
   ((1,0,0,0),(1,1,1,0),(0,0,0,0),(0,0,0,0))));
                                                 //массив-база всевозможных цветов фигуры
  colors : Array [1..12] of Integer = (clAqua, clBlue, clFuchsia, clGreen,
  clLime, clMaroon, clNavy, clOlive, clPurple, clRed, clTeal, clYellow);

  stkw = 10;   //ширина стакана
  stkh = 20;   //высота стакана
  sqrs = 15;   //сторона квадрата, составляющего фигуры

var
  Form1: TForm1;
  tetr, nexttetr : TTetr; //фигура, следующая фигура
  num, nextnum : Integer; //поворот, поворот следующей фигуры
  gen, nextgen : Integer; //вид фигуры, вид следующей фигуры
  fcl,nextfcl : Integer;  //свет фигуры
  x,y : Integer;          //координаты фигуры
  a,b : Integer;          //координаты мухи
  fr,fl,f : Boolean;      //флаги движения мухи
  scores : Integer;       //очки
  lev: Integer;           //уровень сложности
  h,g: Integer;           //счетчик ходов при обездвиженной мухе
  stakan : Array [-3..stkh, 1..stkw] of Integer;   //стакан
  reg : TRegistry;        //для работы с реестром
  myxa : TBitmap;         //картинка мухи


implementation

{$R *.DFM}

uses About, Records;

procedure setspeed(s : Byte);//устанавливаем скорость
begin
  Form1.Label2.Caption := 'Скорость: ' + IntToStr(s);
  Form1.Timer1.Interval := 500 - (s-1) * 100;
end;

procedure drawsquare(i,j,c : Integer; cnv : TCanvas);//рисуем кубик
var
  x,y : Integer;
begin
  x := (j-1)*sqrs;
  y := (i-1)*sqrs;
  with cnv do
  begin
    Brush.Color := c; //рисуем цветной квадратик
    FillRect(Bounds(x+2,y+2,sqrs-4,sqrs-4));
    Pen.Color := clActiveCaption; //обрисовываем сверху и слева цветом фона
    MoveTo(x,y);
    LineTo(x+sqrs,y);
    MoveTo(x,y);
    LineTo(x,y+sqrs);
    Pen.Color := clWhite;       //обрисовываем сверху и слева белым цветом
    MoveTo(x+1,y+1);
    LineTo(x+sqrs-2,y+1);
    MoveTo(x+1,y+1);
    LineTo(x+1,y+sqrs-2);
    Pen.Color := clBlack;       //обрисовываем снизу и справа черным цветом
    MoveTo(x+sqrs-1,y+sqrs-1);
    LineTo(x,y+sqrs-1);
    MoveTo(x+sqrs-1,y+sqrs-1);
    LineTo(x+sqrs-1,y);
    MoveTo(x+sqrs-2,y+sqrs-2);
    LineTo(x+1,y+sqrs-2);
    MoveTo(x+sqrs-2,y+sqrs-2);
    LineTo(x+sqrs-2,y+1);
  end;
end;

procedure showfigure;//рисуем фигуру
var
  i,j : Integer;
begin
  for i:=1 to 4 do
    for j:=1 to 4 do
      if tetr[i,j]=1 then   //для каждой единицы рисуем квадатик
       drawsquare(i+y-1,j+x-1,fcl,Form1.Image1.Canvas);
end;

procedure erasesquare(i,j : Integer);//удаление квадрата
var x,y : Integer;
begin
  Form1.Image1.Canvas.Brush.Color := clActiveCaption;
  x := (j-1)*sqrs; // квадрат перекрашиваем цветом фона
  y := (i-1)*sqrs;
  Form1.Image1.Canvas.FillRect(Bounds(x,y,sqrs,sqrs));
end;

procedure drawfly(i,j : Integer; cnv : TCanvas);//рисуем муху
var
  x,y : Integer;
begin
  x := (j-1)*sqrs;
  y := (i-1)*sqrs;
  myxa := TBitmap.Create;//создаем объект
  try                   //закружаем в него картинку
    myxa.LoadFromFile('муха.bmp');
    cnv.Draw(x, y, myxa);  //и рисуем ее
  finally
    myxa.Free;     //освобождаем объект
  end;
end;


procedure hidefigure;//стираем фигуру
var
  i,j: Integer;
begin
  for i:=1 to 4 do
    for j:=1 to 4 do
      if tetr[i,j]=1 then  //для каждой единицы удаляем квадрат
        erasesquare(i+y-1,j+x-1);
end;

procedure showfly(i,j: Integer);//показываем муху
begin
  drawfly(i,j,Form1.Image1.Canvas);
end;

procedure hidefly(i,j: Integer);//прячем муху
begin
  erasesquare(i,j);
end;

function canrotate : Boolean;//проверяем, можно ли повернуть фигуру
var i,j,k : Integer; t : TTetr;
begin
  result := true;
  k := num;
  if k < 4 then //увеличиваем индекс поворота
    inc(k)
  else
    k := 1;
  t := tetramino[gen,k]; //из массива-базы выбираем массив фигуры, соответствующий новым данным
  for i := 1 to 4 do
    for j := 1 to 4 do  //для каждой единицы если стакан не пуст на месте массива фигуры или
      if (t[i,j]=1) and ((stakan[i+y-1,j+x-1]>0) or (j-1+x-1<0) or (j+x>stkw+1)
        or (i+y>stkh+1)) then  //возле правой или левой или верхней границ стакана
      begin
        result := false;
        exit;
      end;
end;

procedure rotatefigure;//поворачиваем фигуру
begin
  hidefigure;    //стираем фигуру
  if num < 4 then //увеличиваем индекс поворота
    inc(num)
  else
    num := 1;     //из массива-базы выбираем массив фигуры, соответствующий новым данным
  tetr := tetramino[gen,num];
  showfigure;   //рисуем фигуру
end;

procedure gennextfigure;//генерируем данные для следующей фигуры
begin
  nextgen := random(7)+1; //генерируем вид фигуры
  nextnum := random(4)+1; //генерируем поворот фигуры
  nexttetr := tetramino[nextgen,nextnum]; //из массива-базы выбираем массив фигуры, соответствующий новым данным
  nextfcl := colors[random(12)+1]; //генерируем цвет
end;

procedure nextfigure;// генерируем следующую фигуру(вспомогательное окошко)
var i,j : Integer;
begin
  gen := nextgen; //запоминаем данные
  num := nextnum;
  tetr := nexttetr;
  fcl := nextfcl;
  for i := 4 downto 1 do //вычисляем изначальные координаты фигуры(так чтобы она выплывала)
    for j := 1 to 4 do
      if tetr[i,j]=1 then
      begin
       y := -3+(4-i);
       break;
      end;
  x := 4;
  gennextfigure; //генерируем данные для следующей фигуры
  Form1.Image2.Canvas.Brush.Color := clActiveCaption; //освобождаем вспомогательное окошко
  Form1.Image2.Canvas.FillRect(Bounds(0,0,sqrs*4,sqrs*4));
  for i := 1 to 4 do //рисуем фигуру во вспомогательном окошке
    for j := 1 to 4 do
      if nexttetr[i,j]=1 then
        drawsquare(i,j,nextfcl,Form1.Image2.Canvas);
end;

procedure newgame;//создаем игру
var i,j : Integer;
  t: String;
  filename: textfile;
begin
  for i := -3 to stkh do
    for j := 1 to stkw do
      stakan[i,j] := 0; //обнуляем матрицу стакана
  Form1.Image1.Canvas.Brush.Color := clActiveCaption;//освобождаем стакан
  Form1.Image1.Canvas.FillRect(Bounds(0,0,sqrs*stkw,sqrs*stkh));
  scores := 0;//обнуляем счет
  Form1.Label1.Caption := 'Очки: ' + IntToStr(scores);
  setspeed(1);//устанавливаем скорость
  randomize;
  gennextfigure;//генерируем данные для следующей фигуры
  nextfigure; // генерируем следующую фигуру(вспомогательное окошко)
  showfigure; //рисуем фигуру
  lev:=3;     //устанавливаем уровень "Легко"
  a:=stkh;    //устанавливаем порвоначальные координаты мухи
  b:=round(stkw/2);
  fr:=true;   //поднимаем флаги движения мухи
  fl:=true;
  f:=true;
  showfly(a,b); //показываем муху
  Form1.Label3.Caption := '';//место для "Паузы" пусто
  Form1.Timer1.Enabled := True; //включаем таймер

  AssignFile(filename,'recrec.txt');
  Reset(filename);     //из файла рекордов выбираем лучшее значение очков
  readln(filename);    //и записываем в лейбл
  readln(filename,t);
  Form1.Label5.Caption := 'Лучший: ' + t;
  CloseFile(filename);
end;

function canmoveleft : Boolean;//может ли двигаться фигура влево
var i,j : Integer;
begin
  result := true;
  for i := 1 to 4 do
    for j := 1 to 4 do //для каждой единицы если слева стакан не пуст или его граница
      if (tetr[i,j]=1) and ((stakan[i+y-1,j-1+x-1]>0) or (j-1+x-1=0)) then
      begin
        result := false;
        exit;
      end;
end;

function canmoveright : Boolean;//может ли двигаться фигура вправо
var i,j : Integer;
begin
  result := true;
  for i := 1 to 4 do
    for j := 1 to 4 do  //для каждой единицы если справа стакан не пуст или его граница
      if (tetr[i,j]=1) and ((stakan[i+y-1,j+x]>0) or (j+x=stkw+1)) then
      begin
        result := false;
        exit;
      end;
end;

function canmovedown : Boolean;//может ли двигаться фигура вниз
var i,j : Integer;
begin
  result := true;
  for i := 4 downto 1 do
    for j := 1 to 4 do //для каждой единицы снизу стакан не пуст или его граница
      if (tetr[i,j]=1) and ((stakan[i+y,j+x-1]>0) or (i+y=stkh+1)) then
      begin
        result := false;
        exit;
      end;
end;

function fmoveleftable (i,j: integer) : Boolean;//может ли муха двигаться влево
begin
  result := true;//слева стакан не пуст или его граница
  if (stakan[i,j-1]>0) or (j-1=0) then
    result := false;
end;

function fmoverightable (i,j: integer) : Boolean;//может ли муха двигаться влево
begin
  result := true;//справа стакан не пуст или его граница
  if (stakan[i,j+1]>0) or (j+1=stkw+1) then
    result := false;
end;

function gameover : Boolean;//определяем конец игры
var
  i,j : Integer;
begin
  Result := False;
  for i := 1 to stkw do //стакан "застроился"
    if stakan[0,i]>0 then
    begin
      Result := True;
      Exit;
    end;
  for i:= 1 to 4 do  //муха раздавлена
    for j:= 1 to 4 do
      if (tetr[i,j]=1) and (stakan[y+i,x+j-1]=1) then
      begin
        Result := True;
        Break;
      end;
  If g>5*lev then  //муха задохнулась(в зависисти от уровня сложности)
    Result := True;
  Records.res := Result;
end;

procedure flycantmove (i,j: Integer);//муха обездвижена
var k: Integer;
begin
  for k:=0 to lev do //в зависимости от уровня сложности, проверяем, не может ли двигаться муха
    If ((stakan[i-k,j-1]<>0) and (stakan[i-k,j+1]<>0)) or ((stakan[i-k,j-1]<>0)
      and (j+1=stkw+1)) or ((j-1=0)and (stakan[i-k,j+1]<>0)) then
      inc(h)
    else
    begin
      h:=0;
      break;
    end;
end;

procedure hmoveflyright (i,j : Integer);//(копия функции moveflyright, для обращения к ней функции moveflyleft)
var x,y: Integer;
begin
  x:=i;
  y:=j;
  fr:=true;
  If (Form1.Timer1.Enabled) then
    If (stakan[x+1,y]=0) and (x+1<>stkh+1) and f then
      inc(x)
    else
      If fmoverightable(x,y) then
        If (x+1<>stkh+1) and (stakan[x+1,y+1]=0) then
        begin
          inc(x);
          inc(y);
        end
        else
          inc(y)
      else
       If (y+1<>stkw+1) and (stakan[x-1,y+1]=0) then
        begin
          dec(x);
          inc(y);
          f:=true;
        end
        else
          If (lev>1) and (stakan[x-2,y+1]=0) and (stakan[x-1,y]=0) and (stakan[x-2,y]=0)
            and (y+1<>stkw+1) then
          begin
            dec(x);
            f:=false;
          end
          else
            If (lev=3) and (stakan[x-3,y+1]=0) and (stakan[x-1,y]=0) and (stakan[x-2,y]=0)
              and (stakan[x-3,y]=0) and (y+1<>stkw+1) then
            begin
              dec(x);
              f:=false;
            end
            else
            begin
              fr:=false;
              fl:=true;
              exit;
            end;
  hidefly(i,j);
  stakan[i,j]:=0;
  a:=x;
  b:=y;
  if stakan[a,b] = 0 then
  begin
    showfly(a,b);
    stakan[a,b]:=1;
  end;
end;


procedure moveflyleft (i,j: Integer);//двигаем муху влево
var x,y: Integer;
begin
  x:=i;    //запоминаем изачальное положение мухи
  y:=j;
  fl:=true;       //поднимаем флаг движения влево
  If Form1.Timer1.Enabled then       //если снизу стакан пуст и не его граница, а флаг
    If (stakan[x+1,y]=0) and (x+1<>stkh+1) and f then  //движения мухи вниз поднят,
      inc(x)                         //то спускаемся вниз
    else                           //иначе
      If fmoveleftable(x,y) then   //если муха может двигаться влево
        If (x+1<>stkh+1) and (stakan[x+1,y-1]=0) then //если можно спрыгнуть на 1,
        begin
          inc(x);                  //то спрыгиваем
          dec(y);
        end
        else                                          //иначе
          dec(y)                    //двигаемся влево
      else
      If (y-1<>0) and (stakan[x-1,y-1]=0) then  //проверяем, можно ли запрыгнуть на 1
        begin
          dec(x);           //если да, то запрыгиваем и поднимаем флаг движения вниз
          dec(y);
          f:=true;
        end
        else
          If (lev>1) and (stakan[x-2,y-1]=0) and (stakan[x-1,y]=0) and (stakan[x-2,y]=0)
            and (y-1<>0) then                   //иначе проверяем, можно ли запрыгнуть на 2
          begin
            dec(x);         //если да, то запрыгиваем и опускаем флаг движения вниз
            f:=false;
          end
          else
            If (lev=3) and (stakan[x-3,y-1]=0) and (stakan[x-1,y]=0) and (stakan[x-2,y]=0)
              and (stakan[x-3,y]=0) and (y-1<>0) then
            begin                //иначе проверяем, можно ли запрыгнуть на 2
              dec(x);              //если да, то запрыгиваем и опускаем флаг движения вниз
              f:=false;
            end
            else         //иначе
            begin
              fl:=false;  //опускаем флаг движения влево
              fr:=true;   //поднимаем флаг двыжения вправо
              hmoveflyright (i,j);  //двигаемся вправо
              exit;       //выходим из процедуры
            end;
  hidefly(i,j);  //убираем муху
  stakan[i,j]:=0;//убираем из стакана
  a:=x;        //записываем новые координаты в глобальные переменные
  b:=y;
  if stakan[a,b] = 0 then
  begin
    showfly(a,b); //показываем муху
    stakan[a,b]:=1; //записываем ее в стакан
  end;
end;

procedure moveflyright (i,j : Integer);//двигаем муху вправо
var x,y: Integer; //алгоритм аналогичен движению влево
begin
  x:=i;
  y:=j;
  fr:=true;
  If (Form1.Timer1.Enabled) then
    If (stakan[x+1,y]=0) and (x+1<>stkh+1) and f then
      inc(x)
    else
      If fmoverightable(x,y) then //двигаем вправо
        If (x+1<>stkh+1) and (stakan[x+1,y+1]=0) then //если можно спрыгнуть - спрыгиваем
        begin
          inc(x);
          inc(y);
        end
        else                      //иначе - двигаемся далее вправо
          inc(y)
      else
        If (y+1<>stkw+1) and (stakan[x-1,y+1]=0) then  //проверяем, можно ли запрыгнуть
        begin
          dec(x);
          inc(y);
          f:=true;
        end
        else
          If (lev>1) and (stakan[x-2,y+1]=0) and (stakan[x-1,y]=0) and (stakan[x-2,y]=0)
            and (y+1<>stkw+1) then
          begin
            dec(x);
            f:=false;
          end
          else
            If (lev=3) and (stakan[x-3,y+1]=0) and (stakan[x-1,y]=0) and (stakan[x-2,y]=0)
              and (stakan[x-3,y]=0) and (y+1<>stkw+1) then
            begin
              dec(x);
              f:=false;
            end
            else
            begin
              fr:=false;
              fl:=true;
              moveflyleft (i,j);
              exit;
            end;
  hidefly(i,j);
  stakan[i,j]:=0;
  a:=x;
  b:=y;
  if stakan[a,b]=0 then
  begin
    showfly(a,b);
    stakan[a,b]:=1;
  end;
end;

procedure movefly(i,j: Integer);//двигаем муху
begin
  flycantmove(i,j);//проверяем, не обездвижена ли муха
  If fr then   //если флаг движения вправо поднят,
    moveflyright(i,j) //то двигаемся вправо
  else
  if fl then  //если поднят флаг движения влево,
    moveflyleft(i,j); //двигаемся влево
end;


procedure checkstakan;//проверяем и уничтожаем заполненные строки
var i,j,k,l,c : Integer;
begin
  with Form1.Image1.Canvas do
  begin
    l := 0;
    for i := 1 to stkh do
    begin
      c := 0;
      for j := 1 to stkw do
       if stakan[i,j]>1 then
        inc(c);         //считаем кол-во заполненных ячеек в строке
      if c = stkw then   //если их 10, то уничтожаем строку
      begin
        Inc(l);
        for k := 1 to stkw do
          erasesquare(i,k);
        for k := 1 to i-1 do   //а на ее место смещаем верхние строки
          for j := 1 to stkw do
          begin
            stakan[i-k+1,j] := stakan[i-k,j];
            if stakan[i-k+1,j]>1 then //если ячейка была заполнена, перерисовываем ее ниже
              drawsquare(i-k+1,j,stakan[i-k+1,j],Form1.Image1.Canvas)
            else
              if stakan[i-k+1,j]=1 then //если ячейка была заполнена мухой,
              begin                  //перерисовываем муху ниже, обновляем глобальные координаты
                a:=i-k+1;
                b:=j;
                drawfly(a,b,Form1.Image1.Canvas);
              end;
            stakan[i-k,j] := 0;   //в стакане освобождаем старые места
            erasesquare(i-k,j);   //освобождаем их графически
          end;
      end;
    end;
    scores := scores + l * 10;  //увелисиваем счет
    if (scores >= 300)  and (scores < 1000)  then//обновляем скорость
      setspeed(2);
    if (scores >= 1000) and (scores < 3000)  then
      setspeed(3);
    if (scores >= 3000) and (scores < 10000) then
      setspeed(4);
    if (scores >= 10000) then
      setspeed(5);
    Form1.Label1.Caption := 'Очки: '+IntToStr(scores); //новый счет записываем в лейбл
  end;
end;

procedure fixfigure;//фиксируем фигуру в стакане
var i,j : Integer;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      if tetr[i,j]=1 then //для каждой единицы заполняем значением цвета
        stakan[y+i-1,x+j-1] := fcl;
  If h<>0 then //если счетчик обездвиженности мухи ненулевой, увеличиваем счетчик хода
    inc(g);
end;

procedure stopmove;//обрабатываем окончание падения фигуры
begin
  fixfigure; //фиксируем фигуру в стакане
  checkstakan; //проверяем стакан на наличие заполненных строк
  if not gameover then  //если игра не окончена
  begin
    nextfigure; // генерируем следующую фигуру(вспомогательное окошко)
    showfigure; //рисуем фигуру
  end
  else
  begin    //если игра окончена,
    Form1.Timer1.Enabled := False;// останавливаем таймер
    Application.MessageBox(PChar('Game Over!'),PChar('Тетрис'),
    MB_ICONINFORMATION+MB_OK); //выводим сообщение об окончании игры
    Records.lev := Main.lev; //значения уровня сложности и счета передаем в юнит Records
    Records.scores := Main.scores; //сравниваем значения счета с уже записанными
    If (lev = 3) and (StrToInt(Form4.ScoreA.Caption) < scores) then
      Form4.ShowModal;           //и открываем окно рекордов, если больше
    If (lev = 2) and (StrToInt(Form4.ScoreB.Caption) < scores) then
      Form4.ShowModal;
    If (lev = 1) and (StrToInt(Form4.ScoreC.Caption) < scores) then
      Form4.ShowModal;
  end;
end;

procedure moveleft;//двигаем фигуру влево
begin
  hidefigure;
  dec(x);
  showfigure;
end;

procedure moveright;//двигаем фигуру вправо
begin
  hidefigure;
  inc(x);
  showfigure;
end;

procedure movedown;//двигаем фигуру вниз
begin
  hidefigure;
  inc(y);
  showfigure;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);//обрабатываем нажатие клавиш
begin
  if not gameover then
  case key of
    37: if Timer1.Enabled and canmoveleft then  //стрелка влево
          moveleft;
    38: if Timer1.Enabled and canrotate then    //стрелка вверх
          rotatefigure;
    39: if Timer1.Enabled and canmoveright then  //стрелка вправо
          moveright;
    40: if Timer1.Enabled and canmovedown then   //стрелка вниз
          movedown
        else
          stopmove;
    49..53: setspeed(Key - 48);      //"1"-"5"
    32: if Timer1.Enabled then                 //пробел
        begin
          while canmovedown do
            movedown;
          stopmove;
        end;
    19: if Timer1.Enabled then               //"Pause"
        begin
          Label3.Caption := 'Пауза!';
          Timer1.Enabled := False;
        end
        else
        begin
          Label3.Caption := '';
          Timer1.Enabled := True;
        end;
  end;
end;

procedure TForm1.mnuNewClick(Sender: TObject); //меню "Игра - Новая"
var te : Boolean;
begin
  te := Timer1.Enabled; //если таймер включен, выключаем его
  if te then
    Timer1.Enabled := False;    //выводим окно
  if Application.MessageBox(PChar('Вы действительно хотите начать новую игру?'),
  PChar('Тетрис'), MB_ICONQUESTION+MB_YESNO) = IDYES then
   newgame
  else
   Timer1.Enabled := te;
end;

procedure TForm1.Timer1Timer(Sender: TObject); //периодически обращаемая процедура
begin
  if canmovedown then
    movedown
  else
    stopmove;
  movefly(a,b);
end;

procedure TForm1.FormCreate(Sender: TObject);
var mh: String;
begin
  {HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics, MenuHeight}
  reg := TRegistry.Create; //создаем объект для работы с реестром
  reg.RootKey := HKEY_CURRENT_USER; //указываем корневой раздел реестра
  reg.OpenKey('\Control Panel\Desktop\WindowMetrics', True); //открываем ключ
  mh := reg.ReadString('MenuHeight'); //читаем высоту строки меню (-285 в "семерке")
  reg.CloseKey;
  reg.Free;
  mnuLevA.Checked:=true; //ставим "птичку" в меню на уровень сложности "Легко"
  Image1.Top := 2;       //определяем параметры стакана
  Image1.Left := 2;
  Image1.Width := stkw * sqrs;
  Image1.Height := stkh * sqrs;
  Panel1.Top := 5;
  Panel1.Left := 5;
  Panel1.Width := Image1.Width + 4;
  Panel1.Height := Image1.Height + 4;
  Image2.Top := 2;      // определяем параметры вспомогательного окна
  Image2.Left := 2;
  Image2.Width := sqrs * 4;
  Image2.Height := Image2.Width;
  Panel2.Top := 5;
  Panel2.Left := Panel1.Left + Panel1.Width + 10;
  Panel2.Width := Image2.Width + 4;
  Panel2.Height := Panel2.Width;
  Label1.Top := Panel2.Top + Panel2.Height + 10;  //определяем параметры лейблов
  Label2.Top := Label1.Top + Label1.Height + 10;
  Label4.Top := Label2.Top + Label2.Height + 10;
  Label5.Top := Label4.Top + Label4.Height + 10;
  Label3.Top := Label5.Top + Label5.Height + 10;
  Label1.Left := Panel2.Left;
  Label2.Left := Panel2.Left;
  Label3.Left := Panel2.Left;
  Label4.Left := Panel2.Left;
  Label5.Left := Panel2.Left;    //определяем параметры формы
  Form1.Height := Panel1.Height + Panel1.Top - (StrToInt(mh) div 15) + 30;
  Form1.Width := Panel2.Left + Panel2.Width + 25;
  Image1.Parent.DoubleBuffered := True;  //устанавливаем двойную буферизацию для исключения мерцания
  newgame; //начинаем игру
end;

procedure TForm1.mnuExitClick(Sender: TObject); //меню "Игра - Выход"
begin
  Close;
end;

procedure TForm1.mnuAboutClick(Sender: TObject); //меню "Справка - О программе"
begin
  Form2.ShowModal;
end;

procedure TForm1.mnuRecordsClick(Sender: TObject); //меню "Игра - Рекорды"
begin
 Form4.ShowModal;
end;

procedure TForm1.mnuHelpFileClick(Sender: TObject); //меню "Справка - Справка"
var
   Browser: string;
begin
   Browser := ''; //выясняем браузер по умолчанию с помощью реестра
   with TRegistry.Create do
   try
     RootKey := HKEY_CLASSES_ROOT;
     Access := KEY_QUERY_VALUE;
     if OpenKey('\HTTP\shell\open\command', False) then
       Browser := ReadString('');
     CloseKey;
   finally
     Free;
   end;
   if Browser <> '' then
   begin
     Browser := Copy(Browser, Pos(':\', Browser) - 1, Length(Browser)) ;
     if (Pos('.exe', Browser)>0) then
       Browser := Copy(Browser, 1, Pos('.exe', Browser) + 3) ;
     if (Pos('.EXE', Browser)>0) then
       Browser := Copy(Browser, 1, Pos('.EXE', Browser) + 3) ;
     ShellExecute(0, 'open', PChar(Browser), PChar('справка.mht'), nil, SW_SHOWNORMAL) ;
   end;
end;

procedure TForm1.mnuLevAClick(Sender: TObject); //меню "Сложность - Легко"
begin
  lev:=3;
  mnuLevB.Checked := false;
  mnuLevC.Checked := false;
  mnuLevA.Checked := true;
  Label4.Caption := 'Легко';
  Label5.Caption := 'Лучший: ' + Form4.ScoreA.Caption;
end;

procedure TForm1.mnuLevBClick(Sender: TObject);//меню "Сложность - Сложно"
begin
  lev:=2;
  mnuLevA.Checked := false;
  mnuLevC.Checked := false;
  mnuLevB.Checked := true;
  Label4.Caption := 'Сложно';
  Label5.Caption := 'Лучший: ' + Form4.ScoreB.Caption;
end;

procedure TForm1.mnuLevCClick(Sender: TObject); //меню "Сложность - Очень сложно"
begin
  lev:=1;
  mnuLevA.Checked := false;
  mnuLevB.Checked := false;
  mnuLevC.Checked := true;
  Label4.Left := Label4.Left - 2;
  Label4.Caption := 'Очень сложно';
  Label5.Caption := 'Лучший: ' + Form4.ScoreC.Caption;
end;


end.
