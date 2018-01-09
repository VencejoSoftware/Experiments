unit ooTextSplitter;

interface

uses
  SysUtils,
  Generics.Collections;

type
  ITextSplitter = interface
    ['{0D48FBA6-FEEB-4A78-BBD5-E5C884F97C8A}']
    function Split(const Text: String): TArray<String>;
  end;

  TTextSplitter = class sealed(TInterfacedObject, ITextSplitter)
  type
    TStringArray = TArray<String>;
  strict private
    _Breaker: String;
    procedure AddItem(var List: TStringArray; const Item: String);
  public
    function Split(const Text: String): TArray<String>;
    constructor Create(const Breaker: String);
    class function New(const Breaker: String): ITextSplitter;
  end;

implementation

procedure TTextSplitter.AddItem(var List: TStringArray; const Item: String);
begin
  SetLength(List, Succ(Length(List)));
  List[High(List)] := Item;
end;

function TTextSplitter.Split(const Text: String): TArray<String>;
var
  BreakPos, LastBreakPos: Integer;
  Item: String;
begin
  BreakPos := 1;
  LastBreakPos := 1;
  while BreakPos > 0 do
  begin
    BreakPos := Pos(_Breaker, Text, LastBreakPos);
    if BreakPos < 1 then
    begin
      Item := Copy(Text, LastBreakPos);
    end
    else
    begin
      Item := Copy(Text, LastBreakPos, (BreakPos) - LastBreakPos);
      LastBreakPos := BreakPos + Length(_Breaker);
    end;
    AddItem(Result, Item);
  end;
end;

constructor TTextSplitter.Create(const Breaker: String);
begin
  _Breaker := Breaker;
end;

class function TTextSplitter.New(const Breaker: String): ITextSplitter;
begin
  Result := TTextSplitter.Create(Breaker);
end;

end.
