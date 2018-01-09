unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  RegExpr, StdCtrls;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
  private
    StrL: TStringList;
    procedure OnExtractCallback(const Value: String);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

type
  TOnExtractPatternCallback = reference to procedure(const Value: String);

function ExtractFromPattern(const Source, Pattern: string; const Callback: TOnExtractPatternCallback): Boolean;
var
  RegExpr: TRegExpr;
begin
  Result := False;
  RegExpr := TRegExpr.Create;
  try
    RegExpr.Expression := Pattern;
    if RegExpr.Exec(Source) then
    begin
      Result := True;
      repeat
        if Assigned(Callback) then
          Callback(RegExpr.Match[0]);
      until not RegExpr.ExecNext;
    end;
  finally
    RegExpr.Free;
  end;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  StrL.Free;
end;

procedure TForm2.OnExtractCallback(const Value: String);
begin
  Memo1.Lines.Append(Value);
end;

procedure TForm2.ComboBox1Click(Sender: TObject);
const
  EMAIL_PATTERN = '[_a-zA-Z\d\-\.]+@[_a-zA-Z\d\-]+(\.[_a-zA-Z\d\-]+)+';
  URL_PATTERN = '([a-zA-Z]{3,})://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?';
  IP_PATTERN = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b';
  TEXT_PATTERN = '[A-Z][-a-zA-Z]{6,30}';
// TEXT_PATTERN = '[ A-Za-z0-9_@./#&+-]{6,30}';
// TEXT_PATTERN = '[A-Za-z]+((\s)?((\''|\-|\.)?([A-Za-z])+)){6,30}';
  ITEMS: array [0 .. 3] of string = (EMAIL_PATTERN, URL_PATTERN, IP_PATTERN, TEXT_PATTERN);
var
  i: integer;
begin
  Memo1.Clear;
  for i := 0 to Pred(StrL.Count) do
    ExtractFromPattern(StrL.Strings[i], ITEMS[ComboBox1.ItemIndex], OnExtractCallback);
  Caption := Format('Count: %d', [Memo1.Lines.Count]);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  StrL := TStringList.Create;
  StrL.LoadFromFile('data.txt');
end;

end.
