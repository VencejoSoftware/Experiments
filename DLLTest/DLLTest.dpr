library DLLTest;

uses
  SysUtils,
  VCL.Dialogs;

{$R *.res}

function UpperCaseX(const s: PAnsiChar): Boolean; stdcall; cdecl;
begin
  Showmessage(s);
end;

function MeuIntToStr(const Numero: Integer): String; stdcall; cdecl;
begin
  Result := IntToStr(Numero);
end;

function MeuUpperCase(const s: String): String; stdcall; cdecl;
begin
  Result := UpperCase(s);
end;

function MeuLowerCase(const s: String): String; stdcall; cdecl;
begin
  Result := LowerCase(s);
end;

exports
  MeuUpperCase,
  MeuLowerCase,
  MeuIntToStr,
  UpperCaseX;

end.
