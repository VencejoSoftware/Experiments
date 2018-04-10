unit ooGrid.Style;

interface

uses
//  ooShape.Style,
  ooPosition,
  ooRectSize,
  ooStyle,
  ooGrid.Row.List,
  ooGrid.Column.List,
  ooGrid;

type
  IGridStyle = interface//(IShapeStyle)
    ['{6FEF4B04-1275-4E6A-AB34-41513F7A7BC0}']
    function Columns: IGridColumnList;
    function Rows: IGridRowList;
    function Cells: TGridCellList;
  end;

//  TGridStyle = class sealed(TInterfacedObject, IGridStyle)
//  strict private
//    _ShapeStyle: IShapeStyle;
//    _Grid: IGrid;
//  public
//    function Position: IPosition;
//    function Size: IRectSize;
//    function Style: IStyle;
//    function IsVisible: Boolean;
//    function Columns: IGridColumnList;
//    function Rows: IGridRowList;
//    function Cells: TGridCellList;
//    procedure Show;
//    procedure Hide;
//    procedure Move(const Position: IPosition);
//    procedure Resize(const Size: IRectSize);
//    procedure ChangeStyle(const Style: IStyle);
//    constructor Create(const Grid: IGrid);
//    class function New(const Grid: IGrid): IGridStyle;
//  end;

implementation
//
//function TGridStyle.Position: IPosition;
//begin
//  Result := _ShapeStyle.Position;
//end;
//
//function TGridStyle.Size: IRectSize;
//begin
//  Result := _ShapeStyle.Size;
//end;
//
//procedure TGridStyle.Resize(const Size: IRectSize);
//begin
//  _ShapeStyle.Resize(Size);
//end;
//
//procedure TGridStyle.Show;
//begin
//  _ShapeStyle.Show;
//end;
//
//procedure TGridStyle.Hide;
//begin
//  _ShapeStyle.Hide;
//end;
//
//function TGridStyle.IsVisible: Boolean;
//begin
//  Result := _ShapeStyle.IsVisible;
//end;
//
//procedure TGridStyle.Move(const Position: IPosition);
//begin
//  _ShapeStyle.Move(Position);
//end;
//
//function TGridStyle.Style: IStyle;
//begin
//  Result := _ShapeStyle.Style;
//end;
//
//procedure TGridStyle.ChangeStyle(const Style: IStyle);
//begin
//  _ShapeStyle.ChangeStyle(Style);
//end;
//
//function TGridStyle.Cells: TGridCellList;
//begin
//  Result := _Grid.Cells;
//end;
//
//function TGridStyle.Columns: IGridColumnList;
//begin
//  Result := _Grid.Columns;
//end;
//
//function TGridStyle.Rows: IGridRowList;
//begin
//  Result := _Grid.Rows;
//end;
//
//constructor TGridStyle.Create(const Grid: IGrid);
//begin
//  _ShapeStyle := TShapeStyle.New(Grid);
//  _Grid := Grid;
//  Show;
//end;
//
//class function TGridStyle.New(const Grid: IGrid): IGridStyle;
//begin
//  Result := TGridStyle.Create(Grid);
//end;

end.
