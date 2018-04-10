unit ooGrid.Column.List.Events;

interface

uses
//  Notify.Publisher,
//  Notify.Subscriber,
//  Notify.Event,
  ooGrid.Column,
  ooGrid.Column.List;

//type
//  IColumnPublisher = IPublisher<IGridColumnList, IGridColumn>;
//  IColumnSubscriber = ISubscriber<IGridColumnList, IGridColumn>;
//  IColumnEvent = IEvent<IGridColumn>;
//
//  TGridColumnListEvents = class sealed(TInterfacedObject, IGridColumnList)
//  const
//    BEFORE_ADD: TEventID = '{FD88B760-5F40-40CE-9286-F0A2D6CE0C2E}';
//    AFTER_ADD: TEventID = '{6A7A54F9-D8CD-4965-8A30-835A8BA72F9B}';
//    BEFORE_REMOVE: TEventID = '{6663BDDD-402A-4C0B-8324-3B43333A3056}';
//    AFTER_REMOVE: TEventID = '{8F388C9B-AF3D-4869-B088-201A66450795}';
//  strict private
//    _ColumnList: IGridColumnList;
//    _Publisher: IColumnPublisher;
//  public
//    function Add(const Column: IGridColumn): Integer;
//    function Remove(const Column: IGridColumn): Integer;
//    function ColumnByIndex(const Index: Integer): IGridColumn;
//    function Count: Integer;
//    constructor Create(const ColumnList: IGridColumnList; const Publisher: IColumnPublisher);
//    class function New(const ColumnList: IGridColumnList; const Publisher: IColumnPublisher): IGridColumnList;
//  end;

implementation

//function TGridColumnListEvents.Add(const Column: IGridColumn): Integer;
//begin
//  _Publisher.Send(Self, TEvent<IGridColumn>.New(BEFORE_ADD, Column));
//  Result := _ColumnList.Add(Column);
//  _Publisher.Send(Self, TEvent<IGridColumn>.New(AFTER_ADD, Column));
//end;
//
//function TGridColumnListEvents.Remove(const Column: IGridColumn): Integer;
//begin
//  _Publisher.Send(Self, TEvent<IGridColumn>.New(BEFORE_REMOVE, Column));
//  Result := _ColumnList.Remove(Column);
//  _Publisher.Send(Self, TEvent<IGridColumn>.New(AFTER_REMOVE, Column));
//end;
//
//function TGridColumnListEvents.ColumnByIndex(const Index: Integer): IGridColumn;
//begin
//  Result := _ColumnList.ColumnByIndex(Index);
//end;
//
//function TGridColumnListEvents.Count: Integer;
//begin
//  Result := _ColumnList.Count;
//end;
//
//constructor TGridColumnListEvents.Create(const ColumnList: IGridColumnList; const Publisher: IColumnPublisher);
//begin
//  _ColumnList := ColumnList;
//  _Publisher := Publisher;
//end;
//
//class function TGridColumnListEvents.New(const ColumnList: IGridColumnList; const Publisher: IColumnPublisher)
//  : IGridColumnList;
//begin
//  Result := TGridColumnListEvents.Create(ColumnList, Publisher);
//end;

end.
