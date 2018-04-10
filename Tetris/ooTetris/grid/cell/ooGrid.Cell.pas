unit ooGrid.Cell;

interface

uses
  Graphics,
  ooEventHub.Event,
  ooEventHub.BroadcastHub,
  ooStyle,
  ooPosition,
  ooRectSize,
  ooShape.Render,
  ooShape,
  ooShape.Stamp;

type
  IGridCell = interface(IShapeStamp)
    ['{484BA713-3A37-4D91-8CFF-A70BC1CFB693}']
  end;

  IBroadcastHubCell = IBroadcastHub<IGridCell>;
  TBroadcastHubCell = TBroadcastHub<IGridCell>;
  TEventCell = TEvent<IGridCell>;

  TGridCell = class sealed(TShapeStamp, IGridCell)
  const
    ON_MOVE: TEventID = '{0F60FC62-3938-4A4D-968A-F24AE956662B}';
    ON_RESIZE: TEventID = '{FA5B69D7-2F78-4DA4-88FB-9655A611A498}';
    ON_SHOW: TEventID = '{C3A49598-40B5-4791-892D-691F0BD4B5F1}';
    ON_HIDE: TEventID = '{6935A755-A9BC-43C4-9532-0BA2726B133A}';
    ON_STYLE: TEventID = '{4644A290-99CC-4859-9D6A-1B98CC18E673}';
    ON_PAINT: TEventID = '{8FA0C8A7-BE1C-4066-97D9-83724F030801}';
  strict private
    _BroadcastHub: IBroadcastHubCell;
    _ShapeStamp: IShapeStamp;
  public
    function Stamp: TBitmap;
    function Position: IPosition;
    function Size: IRectSize;
    function Style: IStyle;
    function IsVisible: Boolean;
    procedure Show;
    procedure Hide;
    procedure Move(const Position: IPosition);
    procedure Resize(const Size: IRectSize);
    procedure ChangeStyle(const Style: IStyle);
    procedure Paint;
    procedure ChangeRender(const Render: IShapeRender);
    constructor Create(const BroadcastHub: IBroadcastHubCell; const ShapeStamp: IShapeStamp);
    class function New(const BroadcastHub: IBroadcastHubCell; const ShapeStamp: IShapeStamp): IGridCell;
    class function NewDefault(const BroadcastHub: IBroadcastHubCell): IGridCell;
  end;

implementation

function TGridCell.Position: IPosition;
begin
  Result := _ShapeStamp.Position;
end;

procedure TGridCell.Move(const Position: IPosition);
begin
  _ShapeStamp.Move(Position);
  _BroadcastHub.Send(Self, TEventCell.New(ON_MOVE, Self));
end;

function TGridCell.Size: IRectSize;
begin
  Result := _ShapeStamp.Size;
end;

procedure TGridCell.Resize(const Size: IRectSize);
begin
  _ShapeStamp.Resize(Size);
  _BroadcastHub.Send(Self, TEventCell.New(ON_RESIZE, Self));
end;

function TGridCell.IsVisible: Boolean;
begin
  Result := _ShapeStamp.IsVisible;
end;

procedure TGridCell.Show;
begin
  _ShapeStamp.Show;
  _BroadcastHub.Send(Self, TEventCell.New(ON_SHOW, Self));
end;

procedure TGridCell.Hide;
begin
  _ShapeStamp.Hide;
  _BroadcastHub.Send(Self, TEventCell.New(ON_HIDE, Self));
end;

function TGridCell.Style: IStyle;
begin
  Result := _ShapeStamp.Style;
end;

procedure TGridCell.ChangeRender(const Render: IShapeRender);
begin
  _ShapeStamp.ChangeRender(Render);
end;

procedure TGridCell.ChangeStyle(const Style: IStyle);
begin
  _ShapeStamp.ChangeStyle(Style);
  _BroadcastHub.Send(Self, TEventCell.New(ON_STYLE, Self));
end;

function TGridCell.Stamp: TBitmap;
begin
  Result := _ShapeStamp.Stamp;
end;

procedure TGridCell.Paint;
begin
  _ShapeStamp.Paint;
  _BroadcastHub.Send(Self, TEventCell.New(ON_PAINT, Self));
end;

constructor TGridCell.Create(const BroadcastHub: IBroadcastHubCell; const ShapeStamp: IShapeStamp);
begin
  _BroadcastHub := BroadcastHub;
  _ShapeStamp := ShapeStamp;
end;

class function TGridCell.New(const BroadcastHub: IBroadcastHubCell; const ShapeStamp: IShapeStamp): IGridCell;
begin
  Result := TGridCell.Create(BroadcastHub, ShapeStamp);
end;

class function TGridCell.NewDefault(const BroadcastHub: IBroadcastHubCell): IGridCell;
begin
  Result := TGridCell.New(BroadcastHub, TShapeStamp.NewDefault);
end;

end.
