unit UnImplicita;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Spin, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtTexto: TEdit;
    btnMaiusculas: TButton;
    btnMinusculas: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    SpinEdit1: TSpinEdit;
    Button1: TButton;
    procedure btnMaiusculasClick(Sender: TObject);
    procedure btnMinusculasClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  end;

function MeuUpperCase(const s: String): String; stdcall; cdecl; external 'DLLTest.dll' name 'MeuUpperCase';
function MeuLowerCase(const s: String): String; stdcall; cdecl; external 'DLLTest.dll' name 'MeuLowerCase';
function MeuIntToStr(const Numero: Integer): String; stdcall; cdecl; external 'DLLTest.dll' name 'MeuIntToStr';

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnMaiusculasClick(Sender: TObject);
begin
  edtTexto.Text := MeuUpperCase(edtTexto.Text);
end;

procedure TForm1.btnMinusculasClick(Sender: TObject);
begin
  edtTexto.Text := MeuLowerCase(edtTexto.Text);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Text := MeuIntToStr(SpinEdit1.Value);
end;

end.
