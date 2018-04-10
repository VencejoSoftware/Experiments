unit Records;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, ComCtrls, TabNotBk, Grids, ValEdit;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    XPManifest1: TXPManifest;
    LevA: TLabel;
    NameA: TLabel;
    ScoreA: TLabel;
    LevB: TLabel;
    ScoreB: TLabel;
    LevC: TLabel;
    NameC: TLabel;
    ScoreC: TLabel;
    NameB: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  lev, scores: Integer;
  filename: textfile;
  res: Boolean;


implementation

{$R *.dfm}

uses Main;

procedure editrecords;//обновляем запись рекордов
begin
  If res then
  If lev = 3 then
    If StrToInt(Form4.ScoreA.Caption) <= scores then
    begin
      Form4.NameA.Caption := InputBox('Новая запись','Введите свое имя','Неизвестный');
      Form4.ScoreA.Caption := IntToStr(scores);
    end;
  If lev = 2 then
    If StrToInt(Form4.ScoreB.Caption) <= scores then
    begin
      Form4.NameB.Caption := InputBox('Новая запись','Введите свое имя','Неизвестный');
      Form4.ScoreB.Caption := IntToStr(scores);
    end;
  If lev = 1 then
    If StrToInt(Form4.ScoreC.Caption) <= scores then
    begin
      Form4.NameC.Caption := InputBox('Новая запись','Введите свое имя','Неизвестный');
      Form4.ScoreC.Caption := IntToStr(scores);
    end;

end;

procedure TForm4.Button1Click(Sender: TObject);//сохраняем данные и выходим
var  t: String;
begin
  AssignFile(filename,'recrec.txt');
  Rewrite(filename);
  t := Form4.NameA.Caption;
  writeln (filename, t);
  t := Form4.ScoreA.Caption;
  writeln (filename, t);
  t := Form4.NameB.Caption;
  writeln (filename, t);
  t := Form4.ScoreB.Caption;
  writeln (filename, t);
  t := Form4.NameC.Caption;
  writeln (filename, t);
  t := Form4.ScoreC.Caption;
  writeln (filename, t);
  CloseFile (filename);
  Close;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  editrecords;
end;

procedure TForm4.Button2Click(Sender: TObject);//обнуляем показатели
begin
  Form4.NameA.Caption := 'Неизвестный';
  Form4.ScoreA.Caption := '0';
  Form4.NameB.Caption := 'Неизвестный';
  Form4.ScoreB.Caption := '0';
  Form4.NameC.Caption := 'Неизвестный';
  Form4.ScoreC.Caption := '0';

end;

procedure TForm4.FormCreate(Sender: TObject);//вносим сохраненные данные на  форму
var  t: String;
begin
  AssignFile(filename,'recrec.txt');
  Reset(filename);
  readln (filename, t);
  Form4.NameA.Caption := t;
  readln (filename, t);
  Form4.ScoreA.Caption := t;
  readln (filename, t);
  Form4.NameB.Caption := t;
  readln (filename, t);
  Form4.ScoreB.Caption := t;
  readln (filename, t);
  Form4.NameC.Caption := t;
  readln (filename, t);
  Form4.ScoreC.Caption := t;
  CloseFile (filename);
end;

end.
