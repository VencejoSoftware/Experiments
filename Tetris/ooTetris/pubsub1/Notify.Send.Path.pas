unit Notify.Send.Path;

interface

uses
  Generics.Collections,
  Notify.Event,
  Notify.Subscriber, Notify.Subscriber.List,
  Notify.Send.Filter;

type
  TContentPaths<TSender, TContent> = class sealed(TObjectDictionary < TEventID, TSubscriberList < TSender, TContent >> )
  public
    function MakeKeySubscribers(const ContentID: TEventID): TSubscriberList<TSender, TContent>;
    function SubscribersByID(const ContentID: TEventID): TSubscriberList<TSender, TContent>;
    function IsEmpty: Boolean;
    constructor Create; reintroduce;
  end;

implementation

function TContentPaths<TSender, TContent>.IsEmpty: Boolean;
begin
  Result := Count < 1;
end;

function TContentPaths<TSender, TContent>.MakeKeySubscribers(const ContentID: TEventID)
  : TSubscriberList<TSender, TContent>;
begin
  if ContainsKey(ContentID) then
  begin
    Result := SubscribersByID(ContentID);
  end
  else
  begin
    Result := TSubscriberList<TSender, TContent>.Create;
    Add(ContentID, Result);
  end;
end;

function TContentPaths<TSender, TContent>.SubscribersByID(const ContentID: TEventID)
  : TSubscriberList<TSender, TContent>;
begin
  if ContainsKey(ContentID) then
    Result := Items[ContentID];
end;

constructor TContentPaths<TSender, TContent>.Create;
begin
  inherited Create([doOwnsValues]);
end;

end.
