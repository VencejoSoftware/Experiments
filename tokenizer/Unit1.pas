unit Unit1;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, Dialogs, StdCtrls, DateUtils,
  TypInfo,
  Token.Classify, Token.Breacket.Classify, Token, TextTokenize;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure DisplayResults(const TokenList: TTokenList);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  TextTokenize: ITextTokenize;
begin
  TextTokenize := TTextTokenize.New(TTokenClassifier.New);
  TextTokenize.Evaluate('123.456');
  Memo1.Clear;
  DisplayResults(TextTokenize.TokenList);
end;

procedure TForm1.DisplayResults(const TokenList: TTokenList);
var
  Token: IToken;
begin
  Memo1.Lines.BeginUpdate;
  for Token in TokenList do
    Memo1.Lines.Add(Format('%3d - %3d (%-12s) %s', [Token.StartPos, Token.EndPos, GetEnumName(TypeInfo(TTokenKind),
          Ord(Token.Kind)), Token.Value]));
  Memo1.Lines.EndUpdate;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  TextTokenize: ITextTokenize;
begin
  TextTokenize := TTextTokenize.New(TTokenBreacketClassify.New);
  TextTokenize.Evaluate('Current date: {{D}}-{{M}}-{{Y}} or [{{dAtE}}]');
  Memo1.Clear;
  DisplayResults(TextTokenize.TokenList);
end;

end.
