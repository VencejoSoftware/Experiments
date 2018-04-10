unit Weather;

interface

type
  IWeather = interface
    ['{7882E217-461F-4BC8-94EA-0EB0A3686940}']
    function Temperature: integer;
    function Humidity: integer;
    function Pression: integer;
  end;

  TWeather = class sealed(TInterfacedObject, IWeather)
  public
    function Temperature: integer;
    function Humidity: integer;
    function Pression: integer;

    class function New: IWeather;
  end;

implementation

function TWeather.Humidity: integer;
begin
  Result := 50 + random(40);
end;

function TWeather.Pression: integer;
begin
  Result := 1000 + random(100);
end;

function TWeather.Temperature: integer;
begin
  Result := 10 + random(20);
end;

class function TWeather.New: IWeather;
begin
  Result := TWeather.Create;
end;

end.
