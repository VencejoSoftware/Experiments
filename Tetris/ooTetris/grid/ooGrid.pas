unit ooGrid;

interface

uses
  Generics.Collections,
  ooEventHub.Event,
  ooEventHub.BroadcastHub,
  ooEventHub.Subscriber,
  ooPosition,
  ooRectSize,
  ooGrid.Cell,
  ooGrid.Row, ooGrid.Row.List,
  ooGrid.Column, ooGrid.Column.List,
  ooShape.Render,
  ooShape.Stamp;

type
  TGridCellList = class sealed(TList<IGridCell>)
  end;

  IGrid = interface(IShapeStamp)
    ['{37CBBDDB-57D0-4459-88F1-393C8DD41E9F}']
    function Columns: IGridColumnList;
    function Rows: IGridRowList;
    function Cells: TGridCellList;
  end;

  TGrid = class sealed(TShapeStamp, IGrid)
  strict private
    _Columns: IGridColumnList;
    _Rows: IGridRowList;
    _Cells: TGridCellList;
    _ColumnSubscriber: ISubscriber<IGridColumn>;
    _RowSubscriber: ISubscriber<IGridRow>;
  private
    procedure OnColumnEvent(const Event: IEvent<IGridColumn>);
    procedure OnRowEvent(const Event: IEvent<IGridRow>);
  public
    function Columns: IGridColumnList;
    function Rows: IGridRowList;
    function Cells: TGridCellList;
    constructor Create(const BroadcastHubColumn: IBroadcastHubColumn; const BroadcastHubRow: IBroadcastHubRow);
    destructor Destroy; override;
    class function New(const BroadcastHubColumn: IBroadcastHubColumn; const BroadcastHubRow: IBroadcastHubRow): IGrid;
  end;

implementation

function TGrid.Cells: TGridCellList;
begin
  Result := _Cells;
end;

function TGrid.Columns: IGridColumnList;
begin
  Result := _Columns;
end;

function TGrid.Rows: IGridRowList;
begin
  Result := _Rows;
end;

procedure TGrid.OnColumnEvent(const Event: IEvent<IGridColumn>);
var
  Row: IGridRow;
  Cell: IGridCell;
  CellPosition: IPosition;
  CellRectSize: IRectSize;
  CurLeft, CurTop: Integer;
  i: Integer;
begin
  if Event.ID = TGridColumnList.AFTER_ADD then
  begin
    CurLeft := Position.Left + Event.Content.Left;
    CurTop := Position.Top;
    for i := 0 to Pred(_Rows.Count) do
    begin
      Row := _Rows.RowByIndex(i);
      CellPosition := TPosition.New(CurLeft, CurTop);
      CellRectSize := TRectSize.New(Row.Height, Event.Content.Width);
//      Cell := TGridCell.NewDefault;
      Cell.Move(CellPosition);
      Cell.Resize(CellRectSize);
      _Cells.Add(Cell);
      Inc(CurTop, Row.Height);
    end;
  end;
end;

procedure TGrid.OnRowEvent(const Event: IEvent<IGridRow>);
var
  Column: IGridColumn;
  Cell: IGridCell;
  i: Integer;
begin
  if Event.ID = TGridRowList.AFTER_ADD then
  begin
    for i := 0 to Pred(_Columns.Count) do
    begin
      Column := _Columns.ColumnByIndex(i);
//      Cell := TGridCell.NewDefault;
      Cell.Move(TPosition.New(Pred(_Rows.Count), i));
      Cell.Resize(TRectSize.New(Event.Content.Height, Column.Width));
      _Cells.Add(Cell);
    end;
  end;
end;

constructor TGrid.Create(const BroadcastHubColumn: IBroadcastHubColumn; const BroadcastHubRow: IBroadcastHubRow);
begin
  inherited Create(nil);
  _Cells := TGridCellList.Create;
  _Rows := TGridRowList.New(BroadcastHubRow);
  _Columns := TGridColumnList.New(BroadcastHubColumn);
  _ColumnSubscriber := TSubscriber<IGridColumn>.New(OnColumnEvent);
  _RowSubscriber := TSubscriber<IGridRow>.New(OnRowEvent);
  BroadcastHubColumn.Attach(TGridColumnList.AFTER_ADD, _ColumnSubscriber);
  BroadcastHubRow.Attach(TGridRowList.AFTER_ADD, _RowSubscriber);
end;

destructor TGrid.Destroy;
begin
  Cells.Free;
  inherited;
end;

class function TGrid.New(const BroadcastHubColumn: IBroadcastHubColumn; const BroadcastHubRow: IBroadcastHubRow): IGrid;
begin
  Result := TGrid.Create(BroadcastHubColumn, BroadcastHubRow);
end;

end.
