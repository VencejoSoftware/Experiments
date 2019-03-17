unit Unit1;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

// Written by Lars Fosdal, September 2018
function PrettyFormat(const s: String; const AsHTML: Boolean): String;
var
  sEOL: string;
  sINDENT: string;
  LIndent: string;
  nIndent: Cardinal;
  procedure Dent;
  var
    ix: Cardinal;
  begin
    LIndent := '';
    for ix := 1 to nIndent do
      LIndent := LIndent + sINDENT;
  end;
  procedure Indent;
  begin
    Inc(nIndent);
    Dent;
  end;
  procedure Outdent;
  begin
    Dec(nIndent);
    Dent;
  end;

var
  Letter: char;
  isInString: Boolean;
  isEscape: Boolean;
  isUnhandled: Boolean;
begin
  Result := '';
  nIndent := 0;
  if AsHTML then
  begin
    sEOL := '<br>';
    sINDENT := '&nbsp;&nbsp;';
  end
  else
  begin
    sEOL := #13#10;
    sINDENT := '  ';
  end;
  isInString := false;
  isEscape := false;
  LIndent := '';
  for Letter in s do
  begin
    if not isInString then
    begin
      isUnhandled := True;
      if CharInSet(Letter, ['{', '[']) then
      begin
        Indent;
        Result := Result + Letter + sEOL + LIndent;
        isUnhandled := false;
      end
      else if (Letter = ':') then
      begin
        Result := Result + Letter + ' ';
         isUnhandled := false;
      end
      else if (Letter = ',') then
      begin
        Result := Result + Letter + sEOL + LIndent;
        isUnhandled := false;
      end
      else if CharInSet(Letter, ['}', ']']) then
      begin
        Outdent;
        Result := Result + sEOL + LIndent + Letter;
        isUnhandled := false;
      end;
      if isUnhandled and not(Letter = ' ') then
        Result := Result + Letter;
    end
    else
      Result := Result + Letter;
    if not isEscape and (Letter = '"') then
      isInString := not isInString;
    isEscape := (Letter = '\') and not isEscape;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
const
  JSON = '{"id": "0001","type": "donut","name": "Cake","ppu": 0.55,"batters":	{"batter":[{ "id": "1001", ' +
    '"type": "Regular" },				{ "id": "1002", "type": "Chocolate" },' +
    '{"id": "1003", "type": "Blueberry" },{ "id": "1004", "type": "Devil''s Food" }]},' +
    '"topping":[{ "id": "5001", "type": "None" },{ "id": "5002", "type": "Glazed" },' +
    '{"id": "5005", "type": "Sugar" },{"id": "5007", "type": "Powdered Sugar" },' +
    '{"id": "5006", "type": "Chocolate with Sprinkles" },{"id": "5003", "type": "Chocolate" },' +
    '{"id": "5004", "type": "Maple" }]}';
begin
  showmessage(PrettyFormat(JSON, false));
end;

end.
