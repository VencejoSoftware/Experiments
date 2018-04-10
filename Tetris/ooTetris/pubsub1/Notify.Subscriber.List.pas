unit Notify.Subscriber.List;

interface

uses
  SysUtils,
  Generics.Collections,
  Notify.Subscriber;

type
  ISubscriberList<TSender, TContent> = interface
    ['{9D79B003-9867-4078-908B-BB3D3973BB7A}']
    function Exists(const Subscriber: ISubscriber<TSender, TContent>): Boolean;
    function Add(const Subscriber: ISubscriber<TSender, TContent>): Integer;
    function Remove(const Subscriber: ISubscriber<TSender, TContent>): Integer;
  end;

  TSubscriberList<TSender, TContent> = class sealed(TInterfacedObject, ISubscriberList<TSender, TContent>)
  strict private
    _List: TList<ISubscriber<TSender, TContent>>;
  public
    function Exists(const Subscriber: ISubscriber<TSender, TContent>): Boolean;
    function Add(const Subscriber: ISubscriber<TSender, TContent>): Integer;
    function Remove(const Subscriber: ISubscriber<TSender, TContent>): Integer;
    constructor Create;
    destructor Destroy; override;
    class function New: ISubscriberList<TSender, TContent>;
  end;

implementation

function TSubscriberList<TSender, TContent>.Add(const Subscriber: ISubscriber<TSender, TContent>): Integer;
begin
  Result := _List.Add(Subscriber);
end;

function TSubscriberList<TSender, TContent>.Remove(const Subscriber: ISubscriber<TSender, TContent>): Integer;
begin
  Result := _List.Remove(Subscriber);
end;

function TSubscriberList<TSender, TContent>.Exists(const Subscriber: ISubscriber<TSender, TContent>): Boolean;
var
  Item: ISubscriber<TSender, TContent>;
begin
  Result := False;
  for Item in _List do
  begin
    Result := IsEqualGUID(Item.ID, Subscriber.ID);
    if Result then
      Break;
  end;
end;

constructor TSubscriberList<TSender, TContent>.Create;
begin
  _List := TList < ISubscriber < TSender, TContent >>.Create;
end;

destructor TSubscriberList<TSender, TContent>.Destroy;
begin
  _List.Free;
  inherited;
end;

class function TSubscriberList<TSender, TContent>.New: ISubscriberList<TSender, TContent>;
begin
  Result := TSubscriberList<TSender, TContent>.Create;
end;

end.
