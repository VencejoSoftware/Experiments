unit Subscriber2;

interface

uses
  SysUtils,
  PubSub.Content, PubSub.Subscriber,
  Dialogs;

type
  TSubscriber2 = class(TInterfacedObject, ISubscriber<String>)
  const
    _ID: TGUID = '{4F219209-112E-4092-9660-650351F74886}';
  public
    function ID: TSubscriberID;
    procedure ContentHandler(const Content: IContent<String>; const From: ISubscriber<String>);

    class function New: ISubscriber<String>;
  end;

implementation

function TSubscriber2.ID: TSubscriberID;
begin
  Result := _ID;
end;

procedure TSubscriber2.ContentHandler(const Content: IContent<String>; const From: ISubscriber<String>);
begin
  ShowMessage('2 ' + Content.Value);
end;

class function TSubscriber2.New: ISubscriber<String>;
begin
  Result := TSubscriber2.Create;
end;

end.
