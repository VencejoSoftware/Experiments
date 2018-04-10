unit ooGrid.Row.List.Events;

interface

uses
//  Notify.Publisher,
//  Notify.Subscriber,
//  Notify.Event,
  ooGrid.Row,
  ooGrid.Row.List;

//type
//  IRowPublisher = IPublisher<IGridRowList, IGridRow>;
//  IRowSubscriber = ISubscriber<IGridRowList, IGridRow>;
//  IRowEvent = IEvent<IGridRow>;
//
//  TGridRowListEvents = class sealed(TInterfacedObject, IGridRowList)
//  const
//    BEFORE_ADD: TEventID = '{0A65804F-C5A7-4691-ACE6-0A921A7C7B52}';
//    AFTER_ADD: TEventID = '{AC0965CF-ED8A-4B27-8B7F-F4A76AC0ACB5}';
//    BEFORE_REMOVE: TEventID = '{3A3A010D-0E06-4965-8900-9D188D87508F}';
//    AFTER_REMOVE: TEventID = '{3442D8A0-EA99-4915-BB7F-7560A603E898}';
//  strict private
//    _RowList: IGridRowList;
//    _Publisher: IRowPublisher;
//  public
//    function Add(const Row: IGridRow): Integer;
//    function Remove(const Row: IGridRow): Integer;
//    function RowByIndex(const Index: Integer): IGridRow;
//    function Count: Integer;
//    constructor Create(const RowList: IGridRowList; const Publisher: IRowPublisher);
//    class function New(const RowList: IGridRowList; const Publisher: IRowPublisher): IGridRowList;
//  end;

implementation
//
//function TGridRowListEvents.Add(const Row: IGridRow): Integer;
//begin
//  _Publisher.Send(Self, TEvent<IGridRow>.New(BEFORE_ADD, Row));
//  Result := _RowList.Add(Row);
//  _Publisher.Send(Self, TEvent<IGridRow>.New(AFTER_ADD, Row));
//end;
//
//function TGridRowListEvents.Remove(const Row: IGridRow): Integer;
//begin
//  _Publisher.Send(Self, TEvent<IGridRow>.New(BEFORE_REMOVE, Row));
//  Result := _RowList.Remove(Row);
//  _Publisher.Send(Self, TEvent<IGridRow>.New(AFTER_REMOVE, Row));
//end;
//
//function TGridRowListEvents.RowByIndex(const Index: Integer): IGridRow;
//begin
//  Result := _RowList.RowByIndex(Index);
//end;
//
//function TGridRowListEvents.Count: Integer;
//begin
//  Result := _RowList.Count;
//end;
//
//constructor TGridRowListEvents.Create(const RowList: IGridRowList; const Publisher: IRowPublisher);
//begin
//  _RowList := RowList;
//  _Publisher := Publisher;
//end;
//
//class function TGridRowListEvents.New(const RowList: IGridRowList; const Publisher: IRowPublisher): IGridRowList;
//begin
//  Result := TGridRowListEvents.Create(RowList, Publisher);
//end;

end.
