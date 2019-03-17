unit Token.Classify;

interface

uses
  Token;

type
  ITokenClassify = interface
    ['{AD7E929A-6356-44E1-85B1-5EF2C7170B78}']
    function IsFinishToken(const Token: IToken; const Kind: TTokenKind): Boolean;
    function Evaluate(const Letter: Char): TTokenKind;
  end;

  TTokenClassifier = class sealed(TInterfacedObject, ITokenClassify)
  public
    function IsFinishToken(const Token: IToken; const Kind: TTokenKind): Boolean;
    function Evaluate(const Letter: Char): TTokenKind;

    class function New: ITokenClassify;
  end;

implementation

function TTokenClassifier.IsFinishToken(const Token: IToken; const Kind: TTokenKind): Boolean;
begin
  Result := not ((Token.Kind in [tkText, tkNumber]) and (Kind in [tkText, tkNumber])) or (Token.Kind <> Kind);
end;

function TTokenClassifier.Evaluate(const Letter: Char): TTokenKind;
begin
  case Letter of
    'A' .. 'Z', 'a' .. 'z', 'ñ', 'Ñ', 'á', 'é', 'í', 'ó', 'ú', 'Á', 'É', 'Í', 'Ó', 'Ú': Result := tkText;
    '0' .. '9': Result := tkNumber;
    '(', '{', '[': Result := tkOpenItem;
    ')', '}', ']': Result := tkCloseItem;
    '''', '"': Result := tkDelimiter;
    '=', '<', '>', '+', '-', '*', '/', '^': Result := tkOperator;
    '_', '@', '$', '#', '!', '¡', '&', '?', '¿': Result := tkToken;
    '.', ',', ';', ':': Result := tkSeparator;
    ' ', #9: Result := tkSpace;
    #10, #13, #0: Result := tkSpecialChar;
  else Result := tkUnknown;
  end;
end;

class function TTokenClassifier.New: ITokenClassify;
begin
  Result := TTokenClassifier.Create;
end;

end.
