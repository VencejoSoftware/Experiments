unit Unit1;

interface

uses
  Classes, SysUtils, Controls, Forms, Dialogs, StdCtrls, Types,
  Mask, JvExMask, JvToolEdit,
  HackDateEdit;

type
  TForm1 = class(TForm)
    JvDateEdit1: TJvDateEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Text: String;
begin
  Text := InputBox('Hint for date', 'Text', 'Something');
  JvDateEdit1.AddTextDate(JvDateEdit1.Date, Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  JvDateEdit1.AddTextDate(EncodeDate(2018, 10, 12), 'Text 1');
  JvDateEdit1.AddTextDate(EncodeDate(2018, 10, 25), 'Text 2');
  JvDateEdit1.AddTextDate(EncodeDate(2018, 10, 26), 'Text 3');
  JvDateEdit1.AddTextDate(EncodeDate(2018, 9, 9), 'Text 5');
  JvDateEdit1.AddTextDate(EncodeDate(2018, 11, 11), 'Text 4');
end;

end.
