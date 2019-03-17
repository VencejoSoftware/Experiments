unit ArrayConstRecordTest;

interface

uses
  DataRecord;

function CountryNameByCode(const Code: String): String;
function CountryCodeByName(const Name: String): String;

implementation

function CountryNameByCode(const Code: String): String;
var
  Item: TCountry;
begin
  Result := '';
  for Item in ARRAY_COUNTRY do
    if Item.ID = Code then
      Exit(Item.Name);
end;

function CountryCodeByName(const Name: String): String;
var
  Item: TCountry;
begin
  Result := '';
  for Item in ARRAY_COUNTRY do
    if Item.Name = Name then
      Exit(Item.ID);
end;

end.
