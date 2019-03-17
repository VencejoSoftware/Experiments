unit Token.Breacket.Classify;

interface

uses
  Token,
  Token.Classify;

type
  TTokenBreacketClassify = class sealed(TInterfacedObject, ITokenClassify)
  public
    function IsFinishToken(const Token: IToken; const Kind: TTokenKind): Boolean;
    function Evaluate(const Letter: Char): TTokenKind;

    class function New: ITokenClassify;
  end;

implementation

function TTokenBreacketClassify.IsFinishToken(const Token: IToken; const Kind: TTokenKind): Boolean;
begin
  Result := not ((Token.Kind in [tkOpenItem, tkCloseItem]) and (Kind in [tkOpenItem, tkCloseItem])) and not
    ((Token.Kind = tkToken) and (Kind = tkToken)) or (Token.Kind <> Kind);
end;

function TTokenBreacketClassify.Evaluate(const Letter: Char): TTokenKind;
begin
  case Letter of
    'A' .. 'Z', 'a' .. 'z', '0' .. '9', '_': Result := tkToken;
    '{': Result := tkOpenItem;
    '}': Result := tkCloseItem;
  else Result := tkUnknown;
  end;
end;

class function TTokenBreacketClassify.New: ITokenClassify;
begin
  Result := TTokenBreacketClassify.Create;
end;

end.
