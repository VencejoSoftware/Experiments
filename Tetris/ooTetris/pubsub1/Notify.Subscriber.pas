unit Notify.Subscriber;

interface

uses
  SysUtils,
  Notify.Event;

type
  TSubscriberID = TGuid;

  ISubscriber<TSender, TContent> = interface
    ['{12D6DFBA-BED2-4C15-845C-0D68AC7C094A}']
    function ID: TSubscriberID;
    procedure EventHandler(const Sender: TSender; const Event: IEvent<TContent>);
  end;

  TSubscriber<TSender, TContent> = class sealed(TInterfacedObject, ISubscriber<TSender, TContent>)
  strict private
  type
    _TCalback = reference to procedure(const Sender: TSender; const Event: IEvent<TContent>);
  strict private
    _ID: TSubscriberID;
    _Callback: _TCalback;
  public
    function ID: TSubscriberID;
    procedure EventHandler(const Sender: TSender; const Event: IEvent<TContent>);
    constructor Create(const ID: TSubscriberID; const Callback: _TCalback);
    class function New(const Callback: _TCalback): ISubscriber<TSender, TContent>; static;
    class function NewWithID(const ID: TSubscriberID; const Callback: _TCalback): ISubscriber<TSender, TContent>;
  end;

implementation

function TSubscriber<TSender, TContent>.ID: TSubscriberID;
begin
  Result := _ID;
end;

procedure TSubscriber<TSender, TContent>.EventHandler(const Sender: TSender; const Event: IEvent<TContent>);
begin
  if Assigned(_Callback) then
    _Callback(Sender, Event);
end;

constructor TSubscriber<TSender, TContent>.Create(const ID: TSubscriberID; const Callback: _TCalback);
begin
  _ID := ID;
  _Callback := Callback;
end;

class function TSubscriber<TSender, TContent>.New(const Callback: _TCalback): ISubscriber<TSender, TContent>;
var
  ID: TGuid;
begin
  CreateGuid(ID);
  Result := TSubscriber<TSender, TContent>.Create(ID, Callback);
end;

class function TSubscriber<TSender, TContent>.NewWithID(const ID: TSubscriberID; const Callback: _TCalback)
  : ISubscriber<TSender, TContent>;
begin
  Result := TSubscriber<TSender, TContent>.Create(ID, Callback);
end;

end.
