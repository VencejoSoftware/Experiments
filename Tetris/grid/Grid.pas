unit Grid;

interface

uses
  Grid.Column, Grid.Row,
  Grid.Cell;

type
  IGrid = interface
    ['{C3875DC1-563F-494A-B924-B79B8DE9AFD2}']
    function Columns: TColumnList;
    function Rows: TRowList;
    function Cells: TCellList;
  end;

  TGrid = class sealed(TInterfacedObject, IGrid)
  strict private
    _Columns: TColumnList;
    _Rows: TRowList;
    _Cells: TCellList;
  public
    function Columns: TColumnList;
    function Rows: TRowList;
    function Cells: TCellList;
    constructor Create;
    destructor Destroy; override;
    class function New: IGrid;
  end;

implementation

function TGrid.Cells: TCellList;
begin
  Result := _Cells;
end;

function TGrid.Columns: TColumnList;
begin
  Result := _Columns;
end;

function TGrid.Rows: TRowList;
begin
  Result := _Rows;
end;

constructor TGrid.Create;
begin
  _Cells := TCellList.Create;
  _Columns := TColumnList.Create;
  _Rows := TRowList.Create;
end;

destructor TGrid.Destroy;
begin
  _Cells.Free;
  _Columns.Free;
  _Rows.Free;
  inherited;
end;

class function TGrid.New: IGrid;
begin
  Result := TGrid.Create;
end;

end.
