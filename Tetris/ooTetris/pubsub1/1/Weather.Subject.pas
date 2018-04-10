unit Weather.Subject;

interface

uses
  ExtCtrls,
  Pattern.Observer,
  Weather;

type
  IWeatherSubject = interface(ISubject)
    ['{78F05B49-CEA4-4260-B651-92C785CD8A11}']
    function Weather: IWeather;
  end;

  TWeatherSubject = class sealed(TInterfacedObject, IWeatherSubject, ISubject)
  strict private
    _Timer: TTimer;
    _Observables: TObservers;
    _Weather: IWeather;
  private
    procedure TimerOnTimer(Sender: TObject);
  public
    function Weather: IWeather;

    procedure Attach(const Observable: IObservable);
    procedure Detach(const Observable: IObservable);
    procedure Notify;

    constructor Create;
    destructor Destroy; override;

    class function New: IWeatherSubject;
  end;

implementation

procedure TWeatherSubject.Notify;
begin
  _Observables.BroadCast(Self);
end;

procedure TWeatherSubject.Attach(const Observable: IObservable);
begin
  _Observables.Add(Observable);
end;

procedure TWeatherSubject.Detach(const Observable: IObservable);
begin
  _Observables.Remove(Observable);
end;

function TWeatherSubject.Weather: IWeather;
begin
  if not Assigned(_Weather) then
    _Weather := TWeather.New;
  Result := _Weather;
end;

procedure TWeatherSubject.TimerOnTimer(Sender: TObject);
begin
  Notify;
end;

constructor TWeatherSubject.Create;
begin
  _Observables := TObservers.Create;
  _Timer := TTimer.Create(nil);
  _Timer.OnTimer := TimerOnTimer;
  _Timer.Enabled := True;
end;

destructor TWeatherSubject.Destroy;
begin
  _Timer.Enabled := False;
  _Timer.Free;
  _Observables.Free;
  inherited;
end;

class function TWeatherSubject.New: IWeatherSubject;
begin
  Result := TWeatherSubject.Create;
end;

end.
