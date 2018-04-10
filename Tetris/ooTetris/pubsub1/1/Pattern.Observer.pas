unit Pattern.Observer;

interface

uses
  Generics.Collections;

type
  ISubject = interface;

  IObservable = interface
    ['{28EB6C5C-493D-4CCC-88C6-347EDAF2F83B}']
    procedure Update(const Subject: ISubject);
  end;

  ISubject = interface
    ['{BEBDBA2B-A271-4105-A220-F7A081C2F9F7}']
    procedure Attach(const Observer: IObservable);
    procedure Detach(const Observer: IObservable);
    procedure Notify;
  end;

  TObservers = class(TList<IObservable>)
  public
    function Exists(const Observer: IObservable): Boolean;
    function Add(const Observer: IObservable): Integer;
    function Remove(const Observer: IObservable): Integer;

    procedure BroadCast(const Subject: ISubject);
  end;

implementation

function TObservers.Exists(const Observer: IObservable): Boolean;
begin
  Result := (IndexOf(Observer) > - 1);
end;

procedure TObservers.BroadCast(const Subject: ISubject);
var
  Observer: IObservable;
begin
  for Observer in Self do
    Observer.Update(Subject);
end;

function TObservers.Add(const Observer: IObservable): Integer;
begin
  if not Exists(Observer) then
    Result := inherited Add(Observer)
  else
    Result := - 1;
end;

function TObservers.Remove(const Observer: IObservable): Integer;
begin
  if Exists(Observer) then
    Result := inherited Remove(Observer)
  else
    Result := - 1;
end;

end.
