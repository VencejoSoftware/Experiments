unit Grid.Custom;

interface

uses
  System.Types,
  Grid2d.Custom.Intf,
  Vertex.Intf, Space2d;

type
  TGridCustom = class(TSpace2d)
  private
    iCellWidth: Integer;
    iCellHeight: Integer;
    iColumns: Integer;
    iRows: Integer;
  protected
    function GetHeight: TVertexValue; override;
    function GetWidth: TVertexValue; override;

    procedure SetCellWidth(const aCellWidth: Integer); virtual;
    procedure SetCellHeight(const aCellHeight: Integer); virtual;
    procedure SetColumns(const aColumns: Integer); virtual;
    procedure SetRows(const aRows: Integer); virtual;
  public
    function GetCellRect(const aColumn, aRow: Integer): TRect;

    constructor Create(const aColumns, aRows: Integer); virtual;

    property CellWidth: Integer read iCellWidth write SetCellWidth;
    property CellHeight: Integer read iCellHeight write SetCellHeight;
    property Columns: Integer read iColumns write SetColumns;
    property Rows: Integer read iRows write SetRows;
  end;

implementation

function TGridCustom.GetCellRect(const aColumn, aRow: Integer): TRect;
begin
  Result.Left := Round(Left) + CellWidth * aColumn;
  Result.Top := Round(Top) + CellHeight * aRow;
  Result.Width := CellWidth;
  Result.Height := CellHeight;
end;

function TGridCustom.GetHeight: TVertexValue;
begin
  Result := CellHeight * Rows;
end;

function TGridCustom.GetWidth: TVertexValue;
begin
  Result := CellWidth * Columns;
end;

procedure TGridCustom.SetCellHeight(const aCellHeight: Integer);
begin
  iCellHeight := aCellHeight;
end;

procedure TGridCustom.SetCellWidth(const aCellWidth: Integer);
begin
  iCellWidth := aCellWidth;
end;

procedure TGridCustom.SetColumns(const aColumns: Integer);
begin
  iColumns := aColumns;
end;

procedure TGridCustom.SetRows(const aRows: Integer);
begin
  iRows := aRows;
end;

constructor TGridCustom.Create(const aColumns, aRows: Integer);
begin
  inherited Create;
  SetColumns(aColumns);
  SetRows(aRows);
  iCellWidth := 40;
  iCellHeight := 40;
end;

end.
