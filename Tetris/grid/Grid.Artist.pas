unit Grid.Artist;

interface

uses
  Types, Graphics,
  Grid.Column, Grid.Row;

type
  IGridArtist = interface
    ['{149E3835-B538-4913-A87F-C983DAD41216}']
    procedure DrawCell(const Offset: TPoint; const Canvas: TCanvas; const Column: IColumn; const Row: IRow);
    procedure DrawCells(const Offset: TPoint; const Canvas: TCanvas);
  end;

implementation

end.
