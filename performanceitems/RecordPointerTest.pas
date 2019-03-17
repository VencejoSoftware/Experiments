unit RecordPointerTest;

interface

uses
  SysUtils,
  Data, DataRecord;

type
  PCountry = ^TCountry;
  TPCountryArray = array of PCountry;
  PPCountryArray = ^TPCountryArray;

  ICountryList = interface
    ['{5A4D2932-7ECB-49F8-991B-56B93DF6F014}']
    procedure Add(const ART: TCountry);
    function ArtByID(const ID: String): TCountry;
    function ArtByName(const Name: String): TCountry;
  end;

  TCountryList = class sealed(TInterfacedObject, ICountryList)
  strict private
  const
    Empty: TCountry = (ID: ''; Name: '');
  strict private
    _ARTList: array of TCountry;
  public
    procedure Add(const ART: TCountry);
    function ArtByID(const ID: String): TCountry;
    function ArtByName(const Name: String): TCountry;
    constructor Create;
    destructor Destroy; override;
    class function New: ICountryList;
    class function NewPreloaded: ICountryList;
  end;

implementation

function TCountryList.ArtByID(const ID: String): TCountry;
var
  i: Byte;
  Country: PCountry;
begin
  Result := Empty;
  for i := 0 to High(_ARTList) do
  begin
    Country := PCountry(@_ARTList[i]);
    if Country.ID = ID then
      Exit(TCountry(Country^));
  end;
end;

function TCountryList.ArtByName(const Name: String): TCountry;
var
  i: Byte;
  Country: PCountry;
begin
  Result := Empty;
  for i := 0 to High(_ARTList) do
  begin
    Country := PCountry(@_ARTList[i]);
    if Country.Name = Name then
      Exit(TCountry(Country^));
  end;
end;

procedure TCountryList.Add(const ART: TCountry);
begin
  SetLength(_ARTList, Succ(Length(_ARTList)));
  _ARTList[High(_ARTList)] := ART;
end;

constructor TCountryList.Create;
begin
  SetLength(_ARTList, 0);
end;

destructor TCountryList.Destroy;
begin
  SetLength(_ARTList, 0);
  _ARTList := nil;
  inherited;
end;

class function TCountryList.New: ICountryList;
begin
  Result := TCountryList.Create;
end;

class function TCountryList.NewPreloaded: ICountryList;
var
  i: Cardinal;
  Item: TCountry;
begin
  Result := TCountryList.New;
  for i := 0 to COUNTRY_COUNT do
  begin
    Item.ID := COUNTRY_CODE[i];
    Item.Name := COUNTRY_NAME[i];
    Result.Add(Item);
  end;
end;

end.
