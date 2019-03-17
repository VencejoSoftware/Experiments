program test_items;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  SysUtils,
  Diagnostics, TimeSpan,
  ArrayConstRecordPointerTest in 'ArrayConstRecordPointerTest.pas',
  ArrayConstRecordTest in 'ArrayConstRecordTest.pas',
  ArrayConstTest in 'ArrayConstTest.pas',
  Data in 'Data.pas',
  DataRecord in 'DataRecord.pas',
  IfTest in 'IfTest.pas',
  ObjectTest in 'ObjectTest.pas',
  RecordPointerTest in 'RecordPointerTest.pas',
  RecordTest in 'RecordTest.pas';

const
  TEST_ROUNDS = 100000;

function RunIfTest: TTimeSpan;
var
  Stopwatch: TStopwatch;
  i: Cardinal;
  IDArt, NombreArt: String;
begin
  Stopwatch := TStopwatch.StartNew;
  for i := 0 to TEST_ROUNDS do
  begin
    NombreArt := IfTest.CountryNameByCode(COUNTRY_CODE[Random(COUNTRY_COUNT)]);
    IDArt := IfTest.CountryCodeByName(COUNTRY_NAME[Random(COUNTRY_COUNT)]);
  end;
  Result := Stopwatch.Elapsed;
end;

function RunArrayConstTest: TTimeSpan;
var
  Stopwatch: TStopwatch;
  i: Cardinal;
  IDArt, NombreArt: String;
begin
  Stopwatch := TStopwatch.StartNew;
  for i := 0 to TEST_ROUNDS do
  begin
    NombreArt := ArrayConstTest.CountryNameByCode(COUNTRY_CODE[Random(COUNTRY_COUNT)]);
    IDArt := ArrayConstTest.CountryCodeByName(COUNTRY_NAME[Random(COUNTRY_COUNT)]);
  end;
  Result := Stopwatch.Elapsed;
end;

function RunArrayConstRecordTest: TTimeSpan;
var
  Stopwatch: TStopwatch;
  i: Cardinal;
  IDArt, NombreArt: String;
begin
  Stopwatch := TStopwatch.StartNew;
  for i := 0 to TEST_ROUNDS do
  begin
    NombreArt := ArrayConstRecordTest.CountryNameByCode(COUNTRY_CODE[Random(COUNTRY_COUNT)]);
    IDArt := ArrayConstRecordTest.CountryCodeByName(COUNTRY_NAME[Random(COUNTRY_COUNT)]);
  end;
  Result := Stopwatch.Elapsed;
end;

function RunArrayConstRecordPointerTest: TTimeSpan;
var
  Stopwatch: TStopwatch;
  i: Cardinal;
  IDArt, NombreArt: String;
begin
  Stopwatch := TStopwatch.StartNew;
  for i := 0 to TEST_ROUNDS do
  begin
    NombreArt := ArrayConstRecordPointerTest.CountryNameByCode(COUNTRY_CODE[Random(COUNTRY_COUNT)]);
    IDArt := ArrayConstRecordPointerTest.CountryCodeByName(COUNTRY_NAME[Random(COUNTRY_COUNT)]);
  end;
  Result := Stopwatch.Elapsed;
end;

function RunRecordTest: TTimeSpan;
var
  Stopwatch: TStopwatch;
  i: Cardinal;
  IDArt, NombreArt: String;
  CountryList: RecordTest.ICountryList;
begin
  CountryList := RecordTest.TCountryList.NewPreloaded;
  Stopwatch := TStopwatch.StartNew;
  for i := 0 to TEST_ROUNDS do
  begin
    NombreArt := CountryList.ArtByID(COUNTRY_CODE[Random(COUNTRY_COUNT)]).Name;
    IDArt := CountryList.ArtByName(COUNTRY_NAME[Random(COUNTRY_COUNT)]).ID;
  end;
  Result := Stopwatch.Elapsed;
end;

function RunRecordPointerTest: TTimeSpan;
var
  Stopwatch: TStopwatch;
  i: Cardinal;
  IDArt, NombreArt: String;
  CountryList: RecordPointerTest.ICountryList;
begin
  CountryList := RecordPointerTest.TCountryList.NewPreloaded;
  Stopwatch := TStopwatch.StartNew;
  for i := 0 to TEST_ROUNDS do
  begin
    NombreArt := CountryList.ArtByID(COUNTRY_CODE[Random(COUNTRY_COUNT)]).Name;
    IDArt := CountryList.ArtByName(COUNTRY_NAME[Random(COUNTRY_COUNT)]).ID;
  end;
  Result := Stopwatch.Elapsed;
end;

function RunObjectTest: TTimeSpan;
var
  Stopwatch: TStopwatch;
  i: Cardinal;
  IDArt, NombreArt: String;
  CountryList: ObjectTest.ICountryList;
begin
  CountryList := ObjectTest.TCountryList.NewPreloaded;
  Stopwatch := TStopwatch.StartNew;
  for i := 0 to TEST_ROUNDS do
  begin
    NombreArt := CountryList.ArtByID(COUNTRY_CODE[Random(COUNTRY_COUNT)]).Name;
    IDArt := CountryList.ArtByName(COUNTRY_NAME[Random(COUNTRY_COUNT)]).ID;
  end;
  Result := Stopwatch.Elapsed;
end;

begin
  try
    Randomize;
    Writeln(Format('%-30s %7f ms', ['If test', RunIfTest.TotalMilliseconds]));
    Writeln(Format('%-30s %7f ms', ['ArrayConst test', RunArrayConstTest.TotalMilliseconds]));
    Writeln(Format('%-30s %7f ms', ['ArrayConstRecord test', RunArrayConstRecordTest.TotalMilliseconds]));
    Writeln(Format('%-30s %7f ms', ['ArrayConstRecordPointer test', RunArrayConstRecordPointerTest.TotalMilliseconds]));
    Writeln(Format('%-30s %7f ms', ['Record test', RunRecordTest.TotalMilliseconds]));
    Writeln(Format('%-30s %7f ms', ['RecordPointer test', RunRecordPointerTest.TotalMilliseconds]));
    Writeln(Format('%-30s %7f ms', ['Object test', RunObjectTest.TotalMilliseconds]));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
