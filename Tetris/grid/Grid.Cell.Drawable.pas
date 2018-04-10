unit Grid.Cell.Drawable;

interface

uses
  Types, Graphics,
  Grid.Column, Grid.Row;

type
  ICellDrawable = interface
    ['{9B7F5C5C-52FD-4165-8277-65485974B855}']
    function Column: IColumn;
    function Row: IRow;
    function Area: TRect;
  end;

implementation

end.
