unit Notify.Send.Filter;

interface

uses
  Notify.Event, Notify.Subscriber;

type
  ISendFilter<TSender, TContent> = interface
    ['{21E3564E-B8BF-4A58-B82E-8D56FCD0B93E}']
    function IsValid(const Sender: TSender; const Subscriber: ISubscriber<TSender, TContent>;
      const Content: IEvent<TContent>): Boolean;
  end;

implementation

end.
