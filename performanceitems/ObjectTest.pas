unit ObjectTest;

interface

uses
  SysUtils,
  Generics.Collections,
  Data;

type
  ICountry = interface
    ['{647A8D63-53E1-40B3-8F73-F08BFE1630E0}']
    function ID: String;
    function Name: String;
  end;

  TCountry = class sealed(TInterfacedObject, ICountry)
  strict private
    _ID, _Name: String;
  public
    function ID: String;
    function Name: String;
    constructor Create(const ID, Name: String);
    class function New(const ID, Name: String): ICountry;
  end;

  ICountryList = interface
    ['{B31622EC-F23A-4DFD-BC62-9CEB37482C49}']
    procedure Add(const ART: ICountry);
    function ArtByID(const ID: String): ICountry;
    function ArtByName(const Name: String): ICountry;
  end;

  TCountryList = class sealed(TInterfacedObject, ICountryList)
  strict private
    _ARTList: TList<ICountry>;
  public
    procedure Add(const ART: ICountry);
    function ArtByID(const ID: String): ICountry;
    function ArtByName(const Name: String): ICountry;
    constructor Create;
    destructor Destroy; override;
    class function New: ICountryList;
    class function NewPreloaded: ICountryList;
  end;

implementation

function TCountry.ID: String;
begin
  Result := _ID;
end;

function TCountry.Name: String;
begin
  Result := _Name;
end;

constructor TCountry.Create(const ID, Name: String);
begin
  _ID := ID;
  _Name := Name;
end;

class function TCountry.New(const ID, Name: String): ICountry;
begin
  Result := TCountry.Create(ID, Name);
end;

function TCountryList.ArtByID(const ID: String): ICountry;
var
  Item: ICountry;
begin
  Result := nil;
  for Item in _ARTList do
    if Item.ID = ID then
      Exit(Item);
end;

function TCountryList.ArtByName(const Name: String): ICountry;
var
  Item: ICountry;
begin
  Result := nil;
  for Item in _ARTList do
    if CompareText(Item.Name, Name) = 0 then
      Exit(Item);
end;

procedure TCountryList.Add(const ART: ICountry);
begin
  _ARTList.Add(ART);
end;

constructor TCountryList.Create;
begin
  _ARTList := TList<ICountry>.Create;
end;

destructor TCountryList.Destroy;
begin
  _ARTList.Free;
  inherited;
end;

class function TCountryList.New: ICountryList;
begin
  Result := TCountryList.Create;
end;

class function TCountryList.NewPreloaded: ICountryList;
var
  i: Cardinal;
begin
  Result := TCountryList.New;
  for i := 0 to COUNTRY_COUNT do
    Result.Add(TCountry.New(COUNTRY_CODE[i], COUNTRY_NAME[i]));
end;

end.
