unit Form.WeatherLog;

interface

uses
  Classes, SysUtils, StdCtrls, Controls, Forms,
  Pattern.Observer,
  Weather.Subject;

type
  TWeatherLogForm = class(TForm, IObservable)
    Memo1: TMemo;
    btnReinit: TButton;
    btnClose: TButton;
    procedure btnReinitClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    iMinTemperature: integer;
    iMaxTemperature: integer;
    iMinHumidity: integer;
    iMaxHumidity: integer;
    iMinPression: integer;
    iMaxPression: integer;
    _Subject: ISubject;
    procedure Update(const Subject: ISubject);
  public
    constructor CreateObserver(const Subject: ISubject);
  end;

implementation

{$R *.dfm}

procedure TWeatherLogForm.btnReinitClick(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TWeatherLogForm.Update(const Subject: ISubject);
var
  WeatherSubject: IWeatherSubject;
begin
  WeatherSubject := IWeatherSubject(Subject);
  if WeatherSubject.Weather.Temperature < iMinTemperature then
    iMinTemperature := WeatherSubject.Weather.Temperature;
  if WeatherSubject.Weather.Temperature > iMaxTemperature then
    iMaxTemperature := WeatherSubject.Weather.Temperature;
  if WeatherSubject.Weather.Humidity < iMinHumidity then
    iMinHumidity := WeatherSubject.Weather.Humidity;
  if WeatherSubject.Weather.Humidity > iMaxHumidity then
    iMaxHumidity := WeatherSubject.Weather.Humidity;
  if WeatherSubject.Weather.Pression < iMinPression then
    iMinPression := WeatherSubject.Weather.Pression;
  if WeatherSubject.Weather.Pression > iMaxPression then
    iMaxPression := WeatherSubject.Weather.Pression;
  with Memo1.Lines do
  begin
    Append('Report time : ' + DateTimeToStr(now));
    Append('Const value / min / max');
    Append(Format('Temperature : %d / %d / %d', [WeatherSubject.Weather.Temperature, iMinTemperature, iMaxTemperature])
      );
    Append(Format('Humidity :    %d / %d / %d', [WeatherSubject.Weather.Humidity, iMinHumidity, iMaxHumidity]));
    Append(Format('Pression :    %d / %d / %d', [WeatherSubject.Weather.Pression, iMinPression, iMaxPression]));
    Append('---');
  end;
end;

procedure TWeatherLogForm.btnCloseClick(Sender: TObject);
begin
  Release;
end;

constructor TWeatherLogForm.CreateObserver(const Subject: ISubject);
begin
  inherited Create(Application);
  iMinTemperature := 20;
  iMinHumidity := 60;
  iMinPression := 1015;
  _Subject := Subject;
  _Subject.Attach(Self);
end;

procedure TWeatherLogForm.FormDestroy(Sender: TObject);
begin
  _Subject.Detach(Self);
end;

end.
