unit ArrayConstTest;

interface

uses
  Data;

function CountryNameByCode(const Code: String): String;
function CountryCodeByName(const Name: String): String;

implementation

function CountryNameByCode(const Code: String): String;
var
  i: Byte;
begin
  Result := '';
  for i := 0 to COUNTRY_COUNT do
    if COUNTRY_CODE[i] = Code then
      Exit(COUNTRY_NAME[i]);
end;

function CountryCodeByName(const Name: String): String;
var
  i: Byte;
begin
  Result := '';
  for i := 0 to COUNTRY_COUNT do
    if COUNTRY_NAME[i] = Name then
      Exit(COUNTRY_CODE[i]);
end;

end.
