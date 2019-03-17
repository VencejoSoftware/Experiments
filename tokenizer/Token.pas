unit Token;

interface

uses
  SysUtils,
  Generics.Collections;

type
  TTokenKind = (tkUnknown, tkText, tkNumber, tkOpenItem, tkCloseItem, tkDelimiter, tkOperator, tkSeparator, tkToken,
    tkSpace, tkSpecialChar);

  IToken = interface
    ['{523A4465-20A8-4E34-84AF-82015E4D5387}']
    function Kind: TTokenKind;
    function Value: String;
    function StartPos: Integer;
    function EndPos: Integer;

    procedure AddLetter(const Letter: Char);
  end;

  TTokenList = class sealed(TList<IToken>)
  public
    function IsEmpty: Boolean;
  end;

  TToken = class sealed(TInterfacedObject, IToken)
  strict private
    _Text: String;
    _Kind: TTokenKind;
    _StartPos: Integer;
    _EndPos: Integer;
  public
    function Kind: TTokenKind;
    function Value: String;
    function StartPos: Integer;
    function EndPos: Integer;

    procedure AddLetter(const Letter: Char);

    constructor Create(const Kind: TTokenKind; const Position: Integer);

    class function New(const Kind: TTokenKind; const Position: Integer): IToken;
  end;

implementation

function TToken.StartPos: Integer;
begin
  Result := _StartPos;
end;

function TToken.EndPos: Integer;
begin
  Result := _EndPos;
end;

function TToken.Kind: TTokenKind;
begin
  Result := _Kind;
end;

function TToken.Value: String;
begin
  Result := _Text;
end;

procedure TToken.AddLetter(const Letter: Char);
begin
  inc(_EndPos);
  _Text := _Text + Letter;
end;

constructor TToken.Create(const Kind: TTokenKind; const Position: Integer);
begin
  _Text := EmptyStr;
  _Kind := Kind;
  _StartPos := Position;
  _EndPos := Pred(Position);
end;

class function TToken.New(const Kind: TTokenKind; const Position: Integer): IToken;
begin
  Result := TToken.Create(Kind, Position);
end;

{ TTokenList }

function TTokenList.IsEmpty: Boolean;
begin
  Result := Count < 1;
end;

end.
