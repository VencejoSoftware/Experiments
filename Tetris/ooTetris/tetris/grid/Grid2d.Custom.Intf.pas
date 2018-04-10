unit Grid2d.Custom.Intf;

interface

uses
  Rect2d.Intf, Vertex2d.Intf,
  Space2d.Intf;

type
  IGrid2dCustom = interface(ISpace2d)
    ['{2F7A21CA-5125-48B0-BF4A-2DDB4E99D16F}']
    function ColumnWidth: Integer;
    function RowHeight: Integer;
    function Columns: Integer;
    function Rows: Integer;
    function CellRect(const aRow, aColumn: Integer): IRect2d;
    function ColumnFromVertex(const aVertex: IVertex2d): Integer;
    function RowFromVertex(const aVertex: IVertex2d): Integer;
    function IsVertexInCell(const aVertex: IVertex2d): Boolean;

    procedure ChangeColumnWidth(const aColumnWidth: Integer);
    procedure ChangeRowHeight(const aRowHeight: Integer);
  end;

implementation

end.
