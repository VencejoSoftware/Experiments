unit Subscriber2.Filter;

interface

uses
  SysUtils,
  PubSub.Send.Filter, PubSub.Content, PubSub.Subscriber,
  Subscriber2;

type
  TSendFilter2 = class(TInterfacedObject, ISendFilter<String>)
  public
    function IsValid(const Source, Target: ISubscriber<String>; const Content: IContent<String>): Boolean;
    class function New: ISendFilter<String>;
  end;

implementation

function TSendFilter2.IsValid(const Source, Target: ISubscriber<String>; const Content: IContent<String>): Boolean;
begin
  Result := IsEqualGUID(Target.ID, TSubscriber2._ID);
end;

class function TSendFilter2.New: ISendFilter<String>;
begin
  Result := TSendFilter2.Create;
end;

end.
