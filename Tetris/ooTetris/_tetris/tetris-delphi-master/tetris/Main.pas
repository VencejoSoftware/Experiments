unit Main;
  {�������� ������: ���������� ���� "TETRIS-FLY"
   �����: ��������� ������, ��. 93491}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, Registry, ShellAPI;//��� ������ ��������;

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

  TTetr = Array [1..4, 1..4] of Byte;  //������ ������

const
  tetramino: Array [1..7, 1..4] of TTetr =      //������-���� ����� � ��
  (                                             //������������� ����������
  (((1,1,0,0),(0,1,1,0),(0,0,0,0),(0,0,0,0)),   //1 ������������� ������������ ��������
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
                                                 //������-���� ������������ ������ ������
  colors : Array [1..12] of Integer = (clAqua, clBlue, clFuchsia, clGreen,
  clLime, clMaroon, clNavy, clOlive, clPurple, clRed, clTeal, clYellow);

  stkw = 10;   //������ �������
  stkh = 20;   //������ �������
  sqrs = 15;   //������� ��������, ������������� ������

var
  Form1: TForm1;
  tetr, nexttetr : TTetr; //������, ��������� ������
  num, nextnum : Integer; //�������, ������� ��������� ������
  gen, nextgen : Integer; //��� ������, ��� ��������� ������
  fcl,nextfcl : Integer;  //���� ������
  x,y : Integer;          //���������� ������
  a,b : Integer;          //���������� ����
  fr,fl,f : Boolean;      //����� �������� ����
  scores : Integer;       //����
  lev: Integer;           //������� ���������
  h,g: Integer;           //������� ����� ��� ������������� ����
  stakan : Array [-3..stkh, 1..stkw] of Integer;   //������
  reg : TRegistry;        //��� ������ � ��������
  myxa : TBitmap;         //�������� ����


implementation

{$R *.DFM}

uses About, Records;

procedure setspeed(s : Byte);//������������� ��������
begin
  Form1.Label2.Caption := '��������: ' + IntToStr(s);
  Form1.Timer1.Interval := 500 - (s-1) * 100;
end;

procedure drawsquare(i,j,c : Integer; cnv : TCanvas);//������ �����
var
  x,y : Integer;
begin
  x := (j-1)*sqrs;
  y := (i-1)*sqrs;
  with cnv do
  begin
    Brush.Color := c; //������ ������� ���������
    FillRect(Bounds(x+2,y+2,sqrs-4,sqrs-4));
    Pen.Color := clActiveCaption; //������������ ������ � ����� ������ ����
    MoveTo(x,y);
    LineTo(x+sqrs,y);
    MoveTo(x,y);
    LineTo(x,y+sqrs);
    Pen.Color := clWhite;       //������������ ������ � ����� ����� ������
    MoveTo(x+1,y+1);
    LineTo(x+sqrs-2,y+1);
    MoveTo(x+1,y+1);
    LineTo(x+1,y+sqrs-2);
    Pen.Color := clBlack;       //������������ ����� � ������ ������ ������
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

procedure showfigure;//������ ������
var
  i,j : Integer;
begin
  for i:=1 to 4 do
    for j:=1 to 4 do
      if tetr[i,j]=1 then   //��� ������ ������� ������ ��������
       drawsquare(i+y-1,j+x-1,fcl,Form1.Image1.Canvas);
end;

procedure erasesquare(i,j : Integer);//�������� ��������
var x,y : Integer;
begin
  Form1.Image1.Canvas.Brush.Color := clActiveCaption;
  x := (j-1)*sqrs; // ������� ������������� ������ ����
  y := (i-1)*sqrs;
  Form1.Image1.Canvas.FillRect(Bounds(x,y,sqrs,sqrs));
end;

procedure drawfly(i,j : Integer; cnv : TCanvas);//������ ����
var
  x,y : Integer;
begin
  x := (j-1)*sqrs;
  y := (i-1)*sqrs;
  myxa := TBitmap.Create;//������� ������
  try                   //��������� � ���� ��������
    myxa.LoadFromFile('����.bmp');
    cnv.Draw(x, y, myxa);  //� ������ ��
  finally
    myxa.Free;     //����������� ������
  end;
end;


procedure hidefigure;//������� ������
var
  i,j: Integer;
begin
  for i:=1 to 4 do
    for j:=1 to 4 do
      if tetr[i,j]=1 then  //��� ������ ������� ������� �������
        erasesquare(i+y-1,j+x-1);
end;

procedure showfly(i,j: Integer);//���������� ����
begin
  drawfly(i,j,Form1.Image1.Canvas);
end;

procedure hidefly(i,j: Integer);//������ ����
begin
  erasesquare(i,j);
end;

function canrotate : Boolean;//���������, ����� �� ��������� ������
var i,j,k : Integer; t : TTetr;
begin
  result := true;
  k := num;
  if k < 4 then //����������� ������ ��������
    inc(k)
  else
    k := 1;
  t := tetramino[gen,k]; //�� �������-���� �������� ������ ������, ��������������� ����� ������
  for i := 1 to 4 do
    for j := 1 to 4 do  //��� ������ ������� ���� ������ �� ���� �� ����� ������� ������ ���
      if (t[i,j]=1) and ((stakan[i+y-1,j+x-1]>0) or (j-1+x-1<0) or (j+x>stkw+1)
        or (i+y>stkh+1)) then  //����� ������ ��� ����� ��� ������� ������ �������
      begin
        result := false;
        exit;
      end;
end;

procedure rotatefigure;//������������ ������
begin
  hidefigure;    //������� ������
  if num < 4 then //����������� ������ ��������
    inc(num)
  else
    num := 1;     //�� �������-���� �������� ������ ������, ��������������� ����� ������
  tetr := tetramino[gen,num];
  showfigure;   //������ ������
end;

procedure gennextfigure;//���������� ������ ��� ��������� ������
begin
  nextgen := random(7)+1; //���������� ��� ������
  nextnum := random(4)+1; //���������� ������� ������
  nexttetr := tetramino[nextgen,nextnum]; //�� �������-���� �������� ������ ������, ��������������� ����� ������
  nextfcl := colors[random(12)+1]; //���������� ����
end;

procedure nextfigure;// ���������� ��������� ������(��������������� ������)
var i,j : Integer;
begin
  gen := nextgen; //���������� ������
  num := nextnum;
  tetr := nexttetr;
  fcl := nextfcl;
  for i := 4 downto 1 do //��������� ����������� ���������� ������(��� ����� ��� ���������)
    for j := 1 to 4 do
      if tetr[i,j]=1 then
      begin
       y := -3+(4-i);
       break;
      end;
  x := 4;
  gennextfigure; //���������� ������ ��� ��������� ������
  Form1.Image2.Canvas.Brush.Color := clActiveCaption; //����������� ��������������� ������
  Form1.Image2.Canvas.FillRect(Bounds(0,0,sqrs*4,sqrs*4));
  for i := 1 to 4 do //������ ������ �� ��������������� ������
    for j := 1 to 4 do
      if nexttetr[i,j]=1 then
        drawsquare(i,j,nextfcl,Form1.Image2.Canvas);
end;

procedure newgame;//������� ����
var i,j : Integer;
  t: String;
  filename: textfile;
begin
  for i := -3 to stkh do
    for j := 1 to stkw do
      stakan[i,j] := 0; //�������� ������� �������
  Form1.Image1.Canvas.Brush.Color := clActiveCaption;//����������� ������
  Form1.Image1.Canvas.FillRect(Bounds(0,0,sqrs*stkw,sqrs*stkh));
  scores := 0;//�������� ����
  Form1.Label1.Caption := '����: ' + IntToStr(scores);
  setspeed(1);//������������� ��������
  randomize;
  gennextfigure;//���������� ������ ��� ��������� ������
  nextfigure; // ���������� ��������� ������(��������������� ������)
  showfigure; //������ ������
  lev:=3;     //������������� ������� "�����"
  a:=stkh;    //������������� �������������� ���������� ����
  b:=round(stkw/2);
  fr:=true;   //��������� ����� �������� ����
  fl:=true;
  f:=true;
  showfly(a,b); //���������� ����
  Form1.Label3.Caption := '';//����� ��� "�����" �����
  Form1.Timer1.Enabled := True; //�������� ������

  AssignFile(filename,'recrec.txt');
  Reset(filename);     //�� ����� �������� �������� ������ �������� �����
  readln(filename);    //� ���������� � �����
  readln(filename,t);
  Form1.Label5.Caption := '������: ' + t;
  CloseFile(filename);
end;

function canmoveleft : Boolean;//����� �� ��������� ������ �����
var i,j : Integer;
begin
  result := true;
  for i := 1 to 4 do
    for j := 1 to 4 do //��� ������ ������� ���� ����� ������ �� ���� ��� ��� �������
      if (tetr[i,j]=1) and ((stakan[i+y-1,j-1+x-1]>0) or (j-1+x-1=0)) then
      begin
        result := false;
        exit;
      end;
end;

function canmoveright : Boolean;//����� �� ��������� ������ ������
var i,j : Integer;
begin
  result := true;
  for i := 1 to 4 do
    for j := 1 to 4 do  //��� ������ ������� ���� ������ ������ �� ���� ��� ��� �������
      if (tetr[i,j]=1) and ((stakan[i+y-1,j+x]>0) or (j+x=stkw+1)) then
      begin
        result := false;
        exit;
      end;
end;

function canmovedown : Boolean;//����� �� ��������� ������ ����
var i,j : Integer;
begin
  result := true;
  for i := 4 downto 1 do
    for j := 1 to 4 do //��� ������ ������� ����� ������ �� ���� ��� ��� �������
      if (tetr[i,j]=1) and ((stakan[i+y,j+x-1]>0) or (i+y=stkh+1)) then
      begin
        result := false;
        exit;
      end;
end;

function fmoveleftable (i,j: integer) : Boolean;//����� �� ���� ��������� �����
begin
  result := true;//����� ������ �� ���� ��� ��� �������
  if (stakan[i,j-1]>0) or (j-1=0) then
    result := false;
end;

function fmoverightable (i,j: integer) : Boolean;//����� �� ���� ��������� �����
begin
  result := true;//������ ������ �� ���� ��� ��� �������
  if (stakan[i,j+1]>0) or (j+1=stkw+1) then
    result := false;
end;

function gameover : Boolean;//���������� ����� ����
var
  i,j : Integer;
begin
  Result := False;
  for i := 1 to stkw do //������ "����������"
    if stakan[0,i]>0 then
    begin
      Result := True;
      Exit;
    end;
  for i:= 1 to 4 do  //���� ����������
    for j:= 1 to 4 do
      if (tetr[i,j]=1) and (stakan[y+i,x+j-1]=1) then
      begin
        Result := True;
        Break;
      end;
  If g>5*lev then  //���� �����������(� ��������� �� ������ ���������)
    Result := True;
  Records.res := Result;
end;

procedure flycantmove (i,j: Integer);//���� �����������
var k: Integer;
begin
  for k:=0 to lev do //� ����������� �� ������ ���������, ���������, �� ����� �� ��������� ����
    If ((stakan[i-k,j-1]<>0) and (stakan[i-k,j+1]<>0)) or ((stakan[i-k,j-1]<>0)
      and (j+1=stkw+1)) or ((j-1=0)and (stakan[i-k,j+1]<>0)) then
      inc(h)
    else
    begin
      h:=0;
      break;
    end;
end;

procedure hmoveflyright (i,j : Integer);//(����� ������� moveflyright, ��� ��������� � ��� ������� moveflyleft)
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


procedure moveflyleft (i,j: Integer);//������� ���� �����
var x,y: Integer;
begin
  x:=i;    //���������� ���������� ��������� ����
  y:=j;
  fl:=true;       //��������� ���� �������� �����
  If Form1.Timer1.Enabled then       //���� ����� ������ ���� � �� ��� �������, � ����
    If (stakan[x+1,y]=0) and (x+1<>stkh+1) and f then  //�������� ���� ���� ������,
      inc(x)                         //�� ���������� ����
    else                           //�����
      If fmoveleftable(x,y) then   //���� ���� ����� ��������� �����
        If (x+1<>stkh+1) and (stakan[x+1,y-1]=0) then //���� ����� ��������� �� 1,
        begin
          inc(x);                  //�� ����������
          dec(y);
        end
        else                                          //�����
          dec(y)                    //��������� �����
      else
      If (y-1<>0) and (stakan[x-1,y-1]=0) then  //���������, ����� �� ���������� �� 1
        begin
          dec(x);           //���� ��, �� ����������� � ��������� ���� �������� ����
          dec(y);
          f:=true;
        end
        else
          If (lev>1) and (stakan[x-2,y-1]=0) and (stakan[x-1,y]=0) and (stakan[x-2,y]=0)
            and (y-1<>0) then                   //����� ���������, ����� �� ���������� �� 2
          begin
            dec(x);         //���� ��, �� ����������� � �������� ���� �������� ����
            f:=false;
          end
          else
            If (lev=3) and (stakan[x-3,y-1]=0) and (stakan[x-1,y]=0) and (stakan[x-2,y]=0)
              and (stakan[x-3,y]=0) and (y-1<>0) then
            begin                //����� ���������, ����� �� ���������� �� 2
              dec(x);              //���� ��, �� ����������� � �������� ���� �������� ����
              f:=false;
            end
            else         //�����
            begin
              fl:=false;  //�������� ���� �������� �����
              fr:=true;   //��������� ���� �������� ������
              hmoveflyright (i,j);  //��������� ������
              exit;       //������� �� ���������
            end;
  hidefly(i,j);  //������� ����
  stakan[i,j]:=0;//������� �� �������
  a:=x;        //���������� ����� ���������� � ���������� ����������
  b:=y;
  if stakan[a,b] = 0 then
  begin
    showfly(a,b); //���������� ����
    stakan[a,b]:=1; //���������� �� � ������
  end;
end;

procedure moveflyright (i,j : Integer);//������� ���� ������
var x,y: Integer; //�������� ���������� �������� �����
begin
  x:=i;
  y:=j;
  fr:=true;
  If (Form1.Timer1.Enabled) then
    If (stakan[x+1,y]=0) and (x+1<>stkh+1) and f then
      inc(x)
    else
      If fmoverightable(x,y) then //������� ������
        If (x+1<>stkh+1) and (stakan[x+1,y+1]=0) then //���� ����� ��������� - ����������
        begin
          inc(x);
          inc(y);
        end
        else                      //����� - ��������� ����� ������
          inc(y)
      else
        If (y+1<>stkw+1) and (stakan[x-1,y+1]=0) then  //���������, ����� �� ����������
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

procedure movefly(i,j: Integer);//������� ����
begin
  flycantmove(i,j);//���������, �� ����������� �� ����
  If fr then   //���� ���� �������� ������ ������,
    moveflyright(i,j) //�� ��������� ������
  else
  if fl then  //���� ������ ���� �������� �����,
    moveflyleft(i,j); //��������� �����
end;


procedure checkstakan;//��������� � ���������� ����������� ������
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
        inc(c);         //������� ���-�� ����������� ����� � ������
      if c = stkw then   //���� �� 10, �� ���������� ������
      begin
        Inc(l);
        for k := 1 to stkw do
          erasesquare(i,k);
        for k := 1 to i-1 do   //� �� �� ����� ������� ������� ������
          for j := 1 to stkw do
          begin
            stakan[i-k+1,j] := stakan[i-k,j];
            if stakan[i-k+1,j]>1 then //���� ������ ���� ���������, �������������� �� ����
              drawsquare(i-k+1,j,stakan[i-k+1,j],Form1.Image1.Canvas)
            else
              if stakan[i-k+1,j]=1 then //���� ������ ���� ��������� �����,
              begin                  //�������������� ���� ����, ��������� ���������� ����������
                a:=i-k+1;
                b:=j;
                drawfly(a,b,Form1.Image1.Canvas);
              end;
            stakan[i-k,j] := 0;   //� ������� ����������� ������ �����
            erasesquare(i-k,j);   //����������� �� ����������
          end;
      end;
    end;
    scores := scores + l * 10;  //����������� ����
    if (scores >= 300)  and (scores < 1000)  then//��������� ��������
      setspeed(2);
    if (scores >= 1000) and (scores < 3000)  then
      setspeed(3);
    if (scores >= 3000) and (scores < 10000) then
      setspeed(4);
    if (scores >= 10000) then
      setspeed(5);
    Form1.Label1.Caption := '����: '+IntToStr(scores); //����� ���� ���������� � �����
  end;
end;

procedure fixfigure;//��������� ������ � �������
var i,j : Integer;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      if tetr[i,j]=1 then //��� ������ ������� ��������� ��������� �����
        stakan[y+i-1,x+j-1] := fcl;
  If h<>0 then //���� ������� ��������������� ���� ���������, ����������� ������� ����
    inc(g);
end;

procedure stopmove;//������������ ��������� ������� ������
begin
  fixfigure; //��������� ������ � �������
  checkstakan; //��������� ������ �� ������� ����������� �����
  if not gameover then  //���� ���� �� ��������
  begin
    nextfigure; // ���������� ��������� ������(��������������� ������)
    showfigure; //������ ������
  end
  else
  begin    //���� ���� ��������,
    Form1.Timer1.Enabled := False;// ������������� ������
    Application.MessageBox(PChar('Game Over!'),PChar('������'),
    MB_ICONINFORMATION+MB_OK); //������� ��������� �� ��������� ����
    Records.lev := Main.lev; //�������� ������ ��������� � ����� �������� � ���� Records
    Records.scores := Main.scores; //���������� �������� ����� � ��� �����������
    If (lev = 3) and (StrToInt(Form4.ScoreA.Caption) < scores) then
      Form4.ShowModal;           //� ��������� ���� ��������, ���� ������
    If (lev = 2) and (StrToInt(Form4.ScoreB.Caption) < scores) then
      Form4.ShowModal;
    If (lev = 1) and (StrToInt(Form4.ScoreC.Caption) < scores) then
      Form4.ShowModal;
  end;
end;

procedure moveleft;//������� ������ �����
begin
  hidefigure;
  dec(x);
  showfigure;
end;

procedure moveright;//������� ������ ������
begin
  hidefigure;
  inc(x);
  showfigure;
end;

procedure movedown;//������� ������ ����
begin
  hidefigure;
  inc(y);
  showfigure;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);//������������ ������� ������
begin
  if not gameover then
  case key of
    37: if Timer1.Enabled and canmoveleft then  //������� �����
          moveleft;
    38: if Timer1.Enabled and canrotate then    //������� �����
          rotatefigure;
    39: if Timer1.Enabled and canmoveright then  //������� ������
          moveright;
    40: if Timer1.Enabled and canmovedown then   //������� ����
          movedown
        else
          stopmove;
    49..53: setspeed(Key - 48);      //"1"-"5"
    32: if Timer1.Enabled then                 //������
        begin
          while canmovedown do
            movedown;
          stopmove;
        end;
    19: if Timer1.Enabled then               //"Pause"
        begin
          Label3.Caption := '�����!';
          Timer1.Enabled := False;
        end
        else
        begin
          Label3.Caption := '';
          Timer1.Enabled := True;
        end;
  end;
end;

procedure TForm1.mnuNewClick(Sender: TObject); //���� "���� - �����"
var te : Boolean;
begin
  te := Timer1.Enabled; //���� ������ �������, ��������� ���
  if te then
    Timer1.Enabled := False;    //������� ����
  if Application.MessageBox(PChar('�� ������������� ������ ������ ����� ����?'),
  PChar('������'), MB_ICONQUESTION+MB_YESNO) = IDYES then
   newgame
  else
   Timer1.Enabled := te;
end;

procedure TForm1.Timer1Timer(Sender: TObject); //������������ ���������� ���������
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
  reg := TRegistry.Create; //������� ������ ��� ������ � ��������
  reg.RootKey := HKEY_CURRENT_USER; //��������� �������� ������ �������
  reg.OpenKey('\Control Panel\Desktop\WindowMetrics', True); //��������� ����
  mh := reg.ReadString('MenuHeight'); //������ ������ ������ ���� (-285 � "�������")
  reg.CloseKey;
  reg.Free;
  mnuLevA.Checked:=true; //������ "������" � ���� �� ������� ��������� "�����"
  Image1.Top := 2;       //���������� ��������� �������
  Image1.Left := 2;
  Image1.Width := stkw * sqrs;
  Image1.Height := stkh * sqrs;
  Panel1.Top := 5;
  Panel1.Left := 5;
  Panel1.Width := Image1.Width + 4;
  Panel1.Height := Image1.Height + 4;
  Image2.Top := 2;      // ���������� ��������� ���������������� ����
  Image2.Left := 2;
  Image2.Width := sqrs * 4;
  Image2.Height := Image2.Width;
  Panel2.Top := 5;
  Panel2.Left := Panel1.Left + Panel1.Width + 10;
  Panel2.Width := Image2.Width + 4;
  Panel2.Height := Panel2.Width;
  Label1.Top := Panel2.Top + Panel2.Height + 10;  //���������� ��������� �������
  Label2.Top := Label1.Top + Label1.Height + 10;
  Label4.Top := Label2.Top + Label2.Height + 10;
  Label5.Top := Label4.Top + Label4.Height + 10;
  Label3.Top := Label5.Top + Label5.Height + 10;
  Label1.Left := Panel2.Left;
  Label2.Left := Panel2.Left;
  Label3.Left := Panel2.Left;
  Label4.Left := Panel2.Left;
  Label5.Left := Panel2.Left;    //���������� ��������� �����
  Form1.Height := Panel1.Height + Panel1.Top - (StrToInt(mh) div 15) + 30;
  Form1.Width := Panel2.Left + Panel2.Width + 25;
  Image1.Parent.DoubleBuffered := True;  //������������� ������� ����������� ��� ���������� ��������
  newgame; //�������� ����
end;

procedure TForm1.mnuExitClick(Sender: TObject); //���� "���� - �����"
begin
  Close;
end;

procedure TForm1.mnuAboutClick(Sender: TObject); //���� "������� - � ���������"
begin
  Form2.ShowModal;
end;

procedure TForm1.mnuRecordsClick(Sender: TObject); //���� "���� - �������"
begin
 Form4.ShowModal;
end;

procedure TForm1.mnuHelpFileClick(Sender: TObject); //���� "������� - �������"
var
   Browser: string;
begin
   Browser := ''; //�������� ������� �� ��������� � ������� �������
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
     ShellExecute(0, 'open', PChar(Browser), PChar('�������.mht'), nil, SW_SHOWNORMAL) ;
   end;
end;

procedure TForm1.mnuLevAClick(Sender: TObject); //���� "��������� - �����"
begin
  lev:=3;
  mnuLevB.Checked := false;
  mnuLevC.Checked := false;
  mnuLevA.Checked := true;
  Label4.Caption := '�����';
  Label5.Caption := '������: ' + Form4.ScoreA.Caption;
end;

procedure TForm1.mnuLevBClick(Sender: TObject);//���� "��������� - ������"
begin
  lev:=2;
  mnuLevA.Checked := false;
  mnuLevC.Checked := false;
  mnuLevB.Checked := true;
  Label4.Caption := '������';
  Label5.Caption := '������: ' + Form4.ScoreB.Caption;
end;

procedure TForm1.mnuLevCClick(Sender: TObject); //���� "��������� - ����� ������"
begin
  lev:=1;
  mnuLevA.Checked := false;
  mnuLevB.Checked := false;
  mnuLevC.Checked := true;
  Label4.Left := Label4.Left - 2;
  Label4.Caption := '����� ������';
  Label5.Caption := '������: ' + Form4.ScoreC.Caption;
end;


end.
