unit Grid.Value;

interface

uses
  Grid.Custom;

type
  TGridValue<T> = class(TGridCustom)
  private
    arrCells: array of array of T;
  protected
    procedure UpdateArrayCells; virtual;
    procedure SetColumns(const aColumns: Integer); override;
    procedure SetRows(const aRows: Integer); override;
    procedure ChangeCellState(const aColumn, aRow: Integer; const aState: T);
  public
    function GetCellValue(const aColumn, aRow: Integer): T;

    procedure SetCellValue(const aColumn, aRow: Integer; const aValue: T);

    destructor Destroy; override;
  end;

implementation

procedure TGridValue<T>.ChangeCellState(const aColumn, aRow: Integer; const aState: T);
begin
  arrCells[aColumn, aRow] := aState;
end;

procedure TGridValue<T>.SetCellValue(const aColumn, aRow: Integer; const aValue: T);
begin
  ChangeCellState(aColumn, aRow, aValue);
end;

function TGridValue<T>.GetCellValue(const aColumn, aRow: Integer): T;
begin
  Result := arrCells[aColumn, aRow];
end;

procedure TGridValue<T>.SetColumns(const aColumns: Integer);
begin
  inherited;
  UpdateArrayCells;
end;

procedure TGridValue<T>.SetRows(const aRows: Integer);
begin
  inherited;
  UpdateArrayCells;
end;

procedure TGridValue<T>.UpdateArrayCells;
begin
  SetLength(arrCells, Columns, Rows);
  FillChar(arrCells, SizeOf(arrCells), False);
end;

destructor TGridValue<T>.Destroy;
begin
  arrCells := nil;
  inherited;
end;

end.
