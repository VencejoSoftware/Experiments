unit ArrayConstRecordPointerTest;

interface

uses
  Data,
  DataRecord;

type
  PCountry = ^TCountry;
  TPCountryArray = array of PCountry;
  PPCountryArray = ^TPCountryArray;

function CountryNameByCode(const Code: String): String;
function CountryCodeByName(const Name: String): String;

implementation

function CountryNameByCode(const Code: String): String;
var
  i: Byte;
  Country: PCountry;
begin
  Result := '';
  for i := 0 to COUNTRY_COUNT do
  begin
    Country := PCountry(@ARRAY_COUNTRY[i]);
    if Country.ID = Code then
      Exit(Country.Name);
  end;
end;

function CountryCodeByName(const Name: String): String;
var
  i: Byte;
  Country: PCountry;
begin
  Result := '';
  for i := 0 to COUNTRY_COUNT do
  begin
    Country := PCountry(@ARRAY_COUNTRY[i]);
    if Country.Name = Name then
      Exit(Country.ID);
  end;
end;

end.
