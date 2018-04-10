unit Notify.Publisher;

interface

uses
  Notify.Event, Notify.Subscriber, Notify.Send.Path, Notify.Send.Filter;

type
  IPublisher<TSender, TContent> = interface
    ['{6E5D444A-1C9B-408B-899A-90A59C7F0496}']
    procedure Attach(const EventID: TEventID; const Subscriber: ISubscriber<TSender, TContent>);
    procedure Deattach(const EventID: TEventID; const Subscriber: ISubscriber<TSender, TContent>);
    procedure Send(const Sender: TSender; const Event: IEvent<TContent>);
    procedure SendWithFilter(const Sender: TSender; const Event: IEvent<TContent>;
      const Filter: ISendFilter<TSender, TContent>);
  end;

  TPublisher<TSender, TContent> = class sealed(TInterfacedObject, IPublisher<TSender, TContent>)
  strict private
    _EventPaths: TContentPaths<TSender, TContent>;
  public
    procedure Attach(const EventID: TEventID; const Subscriber: ISubscriber<TSender, TContent>);
    procedure Deattach(const EventID: TEventID; const Subscriber: ISubscriber<TSender, TContent>);
    procedure Send(const Sender: TSender; const Event: IEvent<TContent>);
    procedure SendWithFilter(const Sender: TSender; const Event: IEvent<TContent>;
      const Filter: ISendFilter<TSender, TContent>);
    constructor Create;
    destructor Destroy; override;
    class function New: IPublisher<TSender, TContent>;
  end;

implementation

procedure TPublisher<TSender, TContent>.Attach(const EventID: TEventID;
  const Subscriber: ISubscriber<TSender, TContent>);
begin
  _EventPaths.MakeKeySubscribers(EventID).Add(Subscriber);
end;

procedure TPublisher<TSender, TContent>.Deattach(const EventID: TEventID;
  const Subscriber: ISubscriber<TSender, TContent>);
begin
  if _EventPaths.IsEmpty then
    Exit;
  _EventPaths.SubscribersByID(EventID).Remove(Subscriber);
end;

procedure TPublisher<TSender, TContent>.Send(const Sender: TSender; const Event: IEvent<TContent>);
var
  Subscriber: ISubscriber<TSender, TContent>;
begin
  if _EventPaths.IsEmpty then
    Exit;
  for Subscriber in _EventPaths.SubscribersByID(Event.ID) do
    Subscriber.EventHandler(Sender, Event);
end;

procedure TPublisher<TSender, TContent>.SendWithFilter(const Sender: TSender; const Event: IEvent<TContent>;
  const Filter: ISendFilter<TSender, TContent>);
var
  Subscriber: ISubscriber<TSender, TContent>;
  CanHandle: Boolean;
begin
  if _EventPaths.IsEmpty then
    Exit;
  for Subscriber in _EventPaths.SubscribersByID(Event.ID) do
  begin
    CanHandle := not Assigned(Filter) or (Assigned(Filter) and Filter.IsValid(Sender, Subscriber, Event));
    if CanHandle then
      Subscriber.EventHandler(Sender, Event);
  end;
end;

constructor TPublisher<TSender, TContent>.Create;
begin
  _EventPaths := TContentPaths<TSender, TContent>.Create;
end;

destructor TPublisher<TSender, TContent>.Destroy;
begin
  _EventPaths.Free;
  inherited;
end;

class function TPublisher<TSender, TContent>.New: IPublisher<TSender, TContent>;
begin
  Result := TPublisher<TSender, TContent>.Create;
end;

end.
