unit UnExplicita;

interface

uses
  Windows, Classes, SysUtils, Controls, Forms, Spin, StdCtrls;

type
  TMeuUpperCase = function(const s: String): String; cdecl;
  TMeuLowerCase = function(const s: String): String; cdecl;
  TMeuIntToStr = function(const Numero: Integer): String; cdecl;

type
  TForm2 = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Handle: THandle;
    mUpperCase: TMeuUpperCase;
    mLowerCase: TMeuLowerCase;
    mIntToStr: TMeuIntToStr;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btnMaiusculasClick(Sender: TObject);
begin
  if Assigned(mUpperCase) then
    edtTexto.Text := mUpperCase(edtTexto.Text);
end;

procedure TForm2.btnMinusculasClick(Sender: TObject);
begin
  if Assigned(mLowerCase) then
    edtTexto.Text := mLowerCase(edtTexto.Text);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  if Assigned(mIntToStr) then
    Edit1.Text := mIntToStr(SpinEdit1.Value);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Handle := LoadLibrary('DLLTest.dll');
  if Handle <> 0 then
  begin
    mLowerCase := GetProcAddress(Handle, 'MeuLowerCase');
    mIntToStr := GetProcAddress(Handle, 'MeuIntToStr');
    mUpperCase := GetProcAddress(Handle, 'MeuUpperCase');
  end;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  if Handle <> 0 then
    FreeLibrary(Handle);
end;

end.
