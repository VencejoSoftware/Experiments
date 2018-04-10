unit Form.Main;

interface

uses
  Classes, SysUtils, Controls, StdCtrls, Forms,
  Pattern.Observer,
  Weather, Weather.Subject;

type
  TMainForm = class(TForm, IObservable)
    btnStats: TButton;
    lblInfo: TLabel;
    Label1: TLabel;
    btnListing: TButton;
    Label2: TLabel;
    Label3: TLabel;
    lblTemperature: TLabel;
    lblHumidity: TLabel;
    lblPression: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStatsClick(Sender: TObject);
    procedure btnListingClick(Sender: TObject);
  private
    WeatherSubject: IWeatherSubject;
    procedure Update(const Subject: ISubject);
  end;

var
  MainForm: TMainForm;

implementation

uses
  Form.WeatherLog, Form.WeatherStatics;
{$R *.dfm}

procedure TMainForm.btnStatsClick(Sender: TObject);
var
  WeatherStatics: TWeatherStatics;
begin
  WeatherStatics := TWeatherStatics.CreateObserver(WeatherSubject);
  WeatherStatics.Show;
end;

procedure TMainForm.btnListingClick(Sender: TObject);
var
  WeatherLogForm: TWeatherLogForm;
begin
  WeatherLogForm := TWeatherLogForm.CreateObserver(WeatherSubject);
  WeatherLogForm.Show;
end;

procedure TMainForm.Update(const Subject: ISubject);
var
  WeatherSubject: IWeatherSubject;
begin
  WeatherSubject := IWeatherSubject(Subject);
  lblTemperature.Caption := IntToStr(WeatherSubject.Weather.Temperature);
  lblHumidity.Caption := IntToStr(WeatherSubject.Weather.Humidity);
  lblPression.Caption := IntToStr(WeatherSubject.Weather.Pression);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  WeatherSubject := TWeatherSubject.New;
  WeatherSubject.Attach(Self);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  WeatherSubject.Detach(Self);
end;

end.
