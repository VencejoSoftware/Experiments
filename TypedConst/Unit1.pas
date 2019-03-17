unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  mime = record
  public const
    ApplicationJson = string('application/json');
    TextHTML = string('text/html');
  end;

const
  MyDefault = string('Oh noes');
  MyDefault2: string = 'Oh noes';

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    procedure LogError(const Msg: string = MyDefault);
    procedure LogError2(const Msg: string = MyDefault2);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.LogError(const Msg: string = MyDefault);
begin
  Caption := Format('Error: %s', [Msg]);
end;

procedure TForm1.LogError2(const Msg: string = MyDefault2);
begin
  Caption := Format('Error: %s', [Msg]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  LogError(mime.TextHTML);
end;

end.
