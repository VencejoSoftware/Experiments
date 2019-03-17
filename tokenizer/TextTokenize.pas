unit TextTokenize;

interface

uses
  Token.Classify,
  Token;

type
  ITextTokenize = interface
    ['{244B17D2-7E14-48C3-919A-CB63F1CDA226}']
    function Evaluate(const Text: String): Boolean;
    function TokenList: TTokenList;
  end;

  TTextTokenize = class sealed(TInterfacedObject, ITextTokenize)
  strict private
    _TokenList: TTokenList;
    _CurrentToken: IToken;
    _TokenClassify: ITokenClassify;
  private
    function IsNewToken(const Kind: TTokenKind): Boolean;
    function ProcessLetter(const Letter: Char; const Position: Integer): Boolean;
  public
    function Evaluate(const Text: String): Boolean;
    function TokenList: TTokenList;

    constructor Create(const TokenClassify: ITokenClassify);
    destructor Destroy; override;

    class function New(const TokenClassify: ITokenClassify): ITextTokenize;
  end;

implementation

function TTextTokenize.TokenList: TTokenList;
begin
  Result := _TokenList;
end;

function TTextTokenize.IsNewToken(const Kind: TTokenKind): Boolean;
begin
  Result := TokenList.IsEmpty or _TokenClassify.IsFinishToken(_CurrentToken, Kind);
end;

function TTextTokenize.ProcessLetter(const Letter: Char; const Position: Integer): Boolean;
var
  Kind: TTokenKind;
begin
  Kind := _TokenClassify.Evaluate(Letter);
  if IsNewToken(Kind) then
  begin
    _CurrentToken := TToken.New(Kind, Position);
    TokenList.Add(_CurrentToken);
  end;
  _CurrentToken.AddLetter(Letter);
  Result := True;
end;

function TTextTokenize.Evaluate(const Text: String): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to Length(Text) do
    Result := ProcessLetter(Text[i], i);
end;

constructor TTextTokenize.Create(const TokenClassify: ITokenClassify);
begin
  inherited Create;
  _TokenList := TTokenList.Create;
  _TokenClassify := TokenClassify;
end;

destructor TTextTokenize.Destroy;
begin
  _TokenList.Free;
  inherited;
end;

class function TTextTokenize.New(const TokenClassify: ITokenClassify): ITextTokenize;
begin
  Result := TTextTokenize.Create(TokenClassify);
end;

end.
