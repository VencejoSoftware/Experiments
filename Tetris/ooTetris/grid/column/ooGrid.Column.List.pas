unit ooGrid.Column.List;

interface

uses
  Generics.Collections,
  ooEventHub.Event,
  ooEventHub.BroadcastHub,
  ooGrid.Column;

type
  IBroadcastHubColumn = IBroadcastHub<IGridColumn>;
  TBroadcastHubColumn = TBroadcastHub<IGridColumn>;

  IGridColumnList = interface
    ['{CAB5B6AF-7377-48DC-B796-6FC7FE1A44EE}']
    function Add(const Column: IGridColumn): Integer;
    function Remove(const Column: IGridColumn): Integer;
    function ColumnByIndex(const Index: Integer): IGridColumn;
    function Count: Integer;
  end;

  TGridColumnList = class sealed(TInterfacedObject, IGridColumnList)
  const
    BEFORE_ADD: TEventID = '{FD88B760-5F40-40CE-9286-F0A2D6CE0C2E}';
    AFTER_ADD: TEventID = '{6A7A54F9-D8CD-4965-8A30-835A8BA72F9B}';
    BEFORE_REMOVE: TEventID = '{6663BDDD-402A-4C0B-8324-3B43333A3056}';
    AFTER_REMOVE: TEventID = '{8F388C9B-AF3D-4869-B088-201A66450795}';
  strict private
  type
    _TGridColumnList = TList<IGridColumn>;
  strict private
    _BroadcastHub: IBroadcastHubColumn;
    _List: _TGridColumnList;
    function NextLeftPosition: Integer;
  public
    function Add(const Column: IGridColumn): Integer;
    function Remove(const Column: IGridColumn): Integer;
    function ColumnByIndex(const Index: Integer): IGridColumn;
    function Count: Integer;
    constructor Create(const BroadcastHub: IBroadcastHubColumn);
    destructor Destroy; override;
    class function New(const BroadcastHub: IBroadcastHubColumn): IGridColumnList;
  end;

implementation

function TGridColumnList.ColumnByIndex(const Index: Integer): IGridColumn;
begin
  Result := _List.Items[Index];
end;

function TGridColumnList.Count: Integer;
begin
  Result := _List.Count;
end;

function TGridColumnList.NextLeftPosition: Integer;
var
  i: Integer;
  Column: IGridColumn;
begin
  Result := 0;
  for i := 0 to Pred(Count) do
  begin
    Column := ColumnByIndex(i);
    Inc(Result, Column.Width);
  end;
end;

function TGridColumnList.Add(const Column: IGridColumn): Integer;
begin
  _BroadcastHub.Send(Self, TEventColumn.New(BEFORE_ADD, Column));
  Column.Move(NextLeftPosition);
  Result := _List.Add(Column);
  _BroadcastHub.Send(Self, TEventColumn.New(AFTER_ADD, Column));
end;

function TGridColumnList.Remove(const Column: IGridColumn): Integer;
begin
  _BroadcastHub.Send(Self, TEventColumn.New(BEFORE_REMOVE, Column));
  Result := _List.Remove(Column);
  _BroadcastHub.Send(Self, TEventColumn.New(AFTER_REMOVE, Column));
end;

constructor TGridColumnList.Create(const BroadcastHub: IBroadcastHubColumn);
begin
  _List := _TGridColumnList.Create;
  _BroadcastHub := BroadcastHub;
end;

destructor TGridColumnList.Destroy;
begin
  _List.Free;
  inherited;
end;

class function TGridColumnList.New(const BroadcastHub: IBroadcastHubColumn): IGridColumnList;
begin
  Result := TGridColumnList.Create(BroadcastHub);
end;

end.
