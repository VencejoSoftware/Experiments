unit Grid.Cell;

interface

uses
  Grid.Column, Grid.Row;

type
  TOnGetCellValue = procedure();

  ICell = interface
    ['{DEA24DCE-9251-4705-8378-65350F90F657}']
    function Column: IColumn;
    function Row: IRow;
  end;

  TCell = class sealed(TInterfacedObject, ICell)
  strict private
    _Column: IColumn;
    _Row: IRow;
  public
    function Column: IColumn;
    function Row: IRow;
    constructor Create(const Column: IColumn; const Row: IRow);
    class function New(const Column: IColumn; const Row: IRow): ICell;
  end;

implementation

function TCell.Column: IColumn;
begin
  Result := _Column;
end;

function TCell.Row: IRow;
begin
  Result := _Row;
end;

constructor TCell.Create(const Column: IColumn; const Row: IRow);
begin
  _Column := Column;
  _Row := Row;
end;

class function TCell.New(const Column: IColumn; const Row: IRow): ICell;
begin
  Result := TCell.Create(Column, Row);
end;

end.
