unit Form.WeatherStatics;

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, Controls, ExtCtrls,
  Forms,
  Pattern.Observer, Weather, Weather.Subject,
  Series, TeEngine, TeeProcs, Chart;

type
  TWeatherStatics = class(TForm, IObservable)
    HumiditeChart: TChart;
    LineSeries2: TLineSeries;
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    chbxTemp: TCheckBox;
    chbxHumidite: TCheckBox;
    chbxPression: TCheckBox;
    PressionChart: TChart;
    Series2: TFastLineSeries;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    TempChart: TChart;
    FastLineSeries1: TFastLineSeries;
    procedure FormDestroy(Sender: TObject);
    procedure chbxTempClick(Sender: TObject);
    procedure chbxHumiditeClick(Sender: TObject);
    procedure chbxPressionClick(Sender: TObject);
  private
    _Subject: ISubject;
    procedure Update(const Subject: ISubject);
  public
    constructor CreateObserver(const Subject: ISubject);
  end;

implementation

{$R *.dfm}

procedure TWeatherStatics.Update(const Subject: ISubject);
var
  i: integer;
  T: TDateTime;
var
  WeatherSubject: IWeatherSubject;
begin
  WeatherSubject := IWeatherSubject(Subject);
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TChart then
      with Components[i] as TChart do
        while Series[0].Count > UpDown1.Position do
          Series[0].Delete(0);
  T := Time;
  if chbxTemp.Checked then
    TempChart.Series[0].AddXY(T, WeatherSubject.Weather.Temperature, TimeToStr(T));
  if chbxHumidite.Checked then
    HumiditeChart.Series[0].AddXY(T, WeatherSubject.Weather.Humidity, TimeToStr(T));
  if chbxPression.Checked then
    PressionChart.Series[0].AddXY(T, WeatherSubject.Weather.Pression, TimeToStr(T));
end;

procedure TWeatherStatics.chbxTempClick(Sender: TObject);
begin
  TempChart.Visible := chbxTemp.Checked;
end;

procedure TWeatherStatics.chbxHumiditeClick(Sender: TObject);
begin
  HumiditeChart.Visible := chbxHumidite.Checked;
end;

procedure TWeatherStatics.chbxPressionClick(Sender: TObject);
begin
  PressionChart.Visible := chbxPression.Checked;
end;

constructor TWeatherStatics.CreateObserver(const Subject: ISubject);
begin
  inherited Create(Application);
  _Subject := Subject;
  Subject.Attach(Self);
end;

procedure TWeatherStatics.FormDestroy(Sender: TObject);
begin
  _Subject.Detach(Self);
end;

end.
