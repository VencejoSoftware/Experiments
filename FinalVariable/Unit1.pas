unit Unit1;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FinalVariable;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$WRITEABLECONST ON}

function TypedConstTest: Boolean;
const
  TYPED_CONST: integer = 1;
begin
  if TYPED_CONST = 1 then
    TYPED_CONST := TYPED_CONST + 1;
  if TYPED_CONST = 2 then
    Result := True;
end;
{$WRITEABLECONST OFF}

function MakeStr(const Args: array of const): string;
var
  I: integer;
begin
  Result := EmptyStr;
  for I := 0 to High(Args) do
    with Args[I] do
      case VType of
        vtInteger:
          Result := Result + IntToStr(VInteger);
        vtBoolean:
          Result := Result + BoolToStr(VBoolean);
        vtChar:
          Result := Result + VChar;
        vtExtended:
          Result := Result + FloatToStr(VExtended^);
        vtString:
          Result := Result + VString^;
        vtPChar:
          Result := Result + VPChar;
        vtObject:
          Result := Result + VObject.ClassName;
        vtClass:
          Result := Result + VClass.ClassName;
        vtAnsiString:
          Result := Result + string(VAnsiString);
        vtUnicodeString:
          Result := Result + string(VUnicodeString);
        vtCurrency:
          Result := Result + CurrToStr(VCurrency^);
        vtVariant:
          Result := Result + string(VVariant^);
        vtInt64:
          Result := Result + IntToStr(VInt64^);
      end;
end;

procedure Check(S: OpenString);
begin

end;

function Equal(var Source, Dest; Size: integer): Boolean;
type
  TBytes = array [0 .. MaxInt - 1] of Byte;
var
  N: integer;
begin
  N := 0;
  while (N < Size) and (TBytes(Dest)[N] = TBytes(Source)[N]) do
    Inc(N);
  Equal := N = Size;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  FinalValue: Final<integer>;
begin
  Caption := BoolToStr(TypedConstTest, True);
  Caption := MakeStr(['test', 100, ' ', True, 3.14159, TForm, Self]);
  FinalValue := 10;
  FinalValue := 12;
end;

end.
