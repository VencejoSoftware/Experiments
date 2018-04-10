unit ooGrid.Row.List;

interface

uses
  Generics.Collections,
  ooEventHub.Event,
  ooEventHub.BroadcastHub,
  ooGrid.Row;

type
  IBroadcastHubRow = IBroadcastHub<IGridRow>;
  TBroadcastHubRow = TBroadcastHub<IGridRow>;

  IGridRowList = interface
    ['{CAB5B6AF-7377-48DC-B796-6FC7FE1A44EE}']
    function Add(const Row: IGridRow): Integer;
    function Remove(const Row: IGridRow): Integer;
    function RowByIndex(const Index: Integer): IGridRow;
    function Count: Integer;
  end;

  TGridRowList = class sealed(TInterfacedObject, IGridRowList)
  const
    BEFORE_ADD: TEventID = '{0A65804F-C5A7-4691-ACE6-0A921A7C7B52}';
    AFTER_ADD: TEventID = '{AC0965CF-ED8A-4B27-8B7F-F4A76AC0ACB5}';
    BEFORE_REMOVE: TEventID = '{3A3A010D-0E06-4965-8900-9D188D87508F}';
    AFTER_REMOVE: TEventID = '{3442D8A0-EA99-4915-BB7F-7560A603E898}';
  strict private
    _BroadcastHub: IBroadcastHubRow;
    _List: TList<IGridRow>;
  public
    function Add(const Row: IGridRow): Integer;
    function Remove(const Row: IGridRow): Integer;
    function RowByIndex(const Index: Integer): IGridRow;
    function Count: Integer;
    constructor Create(const BroadcastHub: IBroadcastHubRow);
    destructor Destroy; override;
    class function New(const BroadcastHub: IBroadcastHubRow): IGridRowList;
  end;

implementation

function TGridRowList.Count: Integer;
begin
  Result := _List.Count;
end;

function TGridRowList.Add(const Row: IGridRow): Integer;
begin
  _BroadcastHub.Send(Self, TEventRow.New(BEFORE_ADD, Row));
  Result := _List.Add(Row);
  _BroadcastHub.Send(Self, TEventRow.New(AFTER_ADD, Row));
end;

function TGridRowList.Remove(const Row: IGridRow): Integer;
begin
  _BroadcastHub.Send(Self, TEventRow.New(BEFORE_REMOVE, Row));
  Result := _List.Remove(Row);
  _BroadcastHub.Send(Self, TEventRow.New(AFTER_REMOVE, Row));
end;

function TGridRowList.RowByIndex(const Index: Integer): IGridRow;
begin
  Result := _List.Items[Index];
end;

constructor TGridRowList.Create(const BroadcastHub: IBroadcastHubRow);
begin
  _List := TList<IGridRow>.Create;
  _BroadcastHub := BroadcastHub;
end;

destructor TGridRowList.Destroy;
begin
  _List.Free;
  inherited;
end;

class function TGridRowList.New(const BroadcastHub: IBroadcastHubRow): IGridRowList;
begin
  Result := TGridRowList.Create(BroadcastHub);
end;

end.
