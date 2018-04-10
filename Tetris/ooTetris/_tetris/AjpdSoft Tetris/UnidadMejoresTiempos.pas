unit UnidadMejoresTiempos;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TformPuntuaciones = class(TForm)
    btAceptar: TButton;
    Bevel1: TBevel;
    btReiniciar: TButton;
    txtP1: TEdit;
    txtP2: TEdit;
    txtP3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lP1: TLabel;
    lP2: TLabel;
    lP3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btReiniciarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type scor = record
  Name : String[15];
  Scor : Word;
end;

var
  formPuntuaciones : TformPuntuaciones;
  ABest : array[1..3] of Scor;
  F : textFile;

implementation

uses UnidadTetris;
{$R *.DFM}

procedure TformPuntuaciones.FormCreate(Sender: TObject);
var
  i, j : Byte;
begin
  for i := 1 to  3 do
    ABest[i].Name := 'AjpdSoft__';
  for i := 1 to  3 do
    ABest[i].Scor := 500;
  {$I-}
  assignFile(F, 'puntuaciones.ptu');
  FileMode := 0;
  Reset(F);
  if (IOResult = 0) then
  begin
    for i := 1 to 3 do
    begin
      readln(F, ABest[i].Name, ABest[i].Scor);
      j := 0;
      repeat inc(j) until (ABest[i].Name[j] <> ' ');
      ABest[i].Name := copy(ABest[i].Name, j, length(ABest[i].Name) - j + 1);
    end;
  end;
  CloseFile(F);
  {$I+}
  if ganador then
  begin
    i := 1;
    while ((ABest[i].Scor > puntuacion) and (i < 5)) do inc(i);
    if (i > 3) then
      exit;
    case i of
      1 : begin
        ABest[3].Name  := ABest[2].Name;
        ABest[2].Name  := ABest[1].Name;
        ABest[1].Name  := 'Anónimo';
        ABest[3].Scor  := ABest[2].Scor;
        ABest[2].Scor  := ABest[1].Scor;
        txtP1.ReadOnly := False;
        ABest[1].Scor  := puntuacion;
        ActiveControl  := txtP1;
      end;
      2 : begin
        ABest[3].Name  := ABest[2].Name;
        ABest[2].Name  := 'Anónimo';
        ABest[3].Scor  := ABest[2].Scor;
        txtP2.ReadOnly := False;
        ABest[2].Scor  := puntuacion;
        ActiveControl  := txtP2;
      end;
      3 : begin
        ABest[3].Name  := 'Anónimo';
        txtP3.ReadOnly := False;
        ABest[3].Scor  := puntuacion;
        ActiveControl  := txtP3;
      end;
    end;
  end;
  txtP1.Text     := ABest[1].Name;

  txtP2.Text     := ABest[2].Name;
  txtP3.Text     := ABest[3].Name;
  lP1.Caption := inttostr(ABest[1].Scor);
  lP2.Caption := inttostr(ABest[2].Scor);
  lP3.Caption := inttostr(ABest[3].Scor);
end;

procedure TformPuntuaciones.FormClose(Sender: TObject;
var
  Action: TCloseAction);
var
  i : Byte;
begin
  ABest[1].Name := txtP1.Text;
  ABest[2].Name := txtP2.Text;
  ABest[3].Name := txtP3.Text;
  {$I-}
  AssignFile(F, 'puntuaciones.ptu');
  FileMode := 1;
  reWrite(F);
  for i := 1 to 3 do Writeln(F, ABest[i].Name:15, ABest[i].Scor:3);
  CloseFile(F);
  {$I+}
end;

procedure TformPuntuaciones.btReiniciarClick(Sender: TObject);
var
  i : Byte;
begin
  for i := 1 to  3 do
    ABest[i].Name := 'AjpdSoft';
  for i := 1 to  3 do
    ABest[i].Scor := 500;
  txtP1.Text := ABest[1].Name;
  txtP2.Text := ABest[2].Name;
  txtP3.Text := ABest[3].Name;
  lP1.Caption := inttostr(ABest[1].Scor);
  lP2.Caption := inttostr(ABest[2].Scor);
  lP3.Caption := inttostr(ABest[3].Scor);
end;

end.

