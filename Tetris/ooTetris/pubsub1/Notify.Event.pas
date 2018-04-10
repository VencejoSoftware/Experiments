unit Notify.Event;

interface

uses
  SysUtils;

type
  TEventID = String;

  IEvent<T> = interface
    ['{04104543-8BB2-41D3-85C6-0B926D5C3D07}']
    function ID: TEventID;
    function Content: T;
    function TimeStamp: TDateTime;
  end;

  TEvent<T> = class sealed(TInterfacedObject, IEvent<T>)
  strict private
    _ID: TEventID;
    _Content: T;
    _TimeStamp: TDateTime;
  public
    function ID: TEventID;
    function Content: T;
    function TimeStamp: TDateTime;
    constructor Create(const ID: TEventID; const Content: T);
    class function New(const ID: TEventID; const Content: T): IEvent<T>;
  end;

implementation

function TEvent<T>.ID: TEventID;
begin
  Result := _ID;
end;

function TEvent<T>.Content: T;
begin
  Result := _Content;
end;

function TEvent<T>.TimeStamp: TDateTime;
begin
  Result := _TimeStamp;
end;

constructor TEvent<T>.Create(const ID: TEventID; const Content: T);
begin
  _ID := ID;
  _Content := Content;
  _TimeStamp := Now;
end;

class function TEvent<T>.New(const ID: TEventID; const Content: T): IEvent<T>;
begin
  Result := TEvent<T>.Create(ID, Content);
end;

end.
