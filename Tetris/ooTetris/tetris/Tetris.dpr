program Tetris;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Piece.Custom in 'piece\Piece.Custom.pas',
  Piece.Tetris in 'piece\Piece.Tetris.pas',
  Grid.Custom in 'grid\Grid.Custom.pas',
  Grid.Tetris in 'grid\Grid.Tetris.pas',
  Grid.Value in 'grid\Grid.Value.pas',
  Tetris.Board in 'game\Tetris.Board.pas',
  Piece.Shapes in 'piece\Piece.Shapes.pas',
  ThreadTimer in 'common\ThreadTimer.pas',
  Rect.Transform in 'common\Rect.Transform.pas',
  Draw.Polygon in 'common\shape\Draw.Polygon.pas',
  Draw.Polygon.Intf in 'common\shape\Draw.Polygon.Intf.pas',
  Space.Intf in 'common\space\Space.Intf.pas',
  Draw.Shape.Intf in 'common\shape\Draw.Shape.Intf.pas',
  Draw.Shape in 'common\shape\Draw.Shape.pas',
  Vertex.Intf in 'common\position\Vertex.Intf.pas',
  Vertex2d in 'common\position\Vertex2d.pas',
  Vertex2d.Intf in 'common\position\Vertex2d.Intf.pas',
  Vertex3d.Intf in 'common\position\Vertex3d.Intf.pas',
  Vertex3d in 'common\position\Vertex3d.pas',
  Vertex.List in 'common\position\Vertex.List.pas',
  Space2d in 'common\space\Space2d.pas',
  Draw.Shape2d in 'common\shape\Draw.Shape2d.pas',
  Space2d.Intf in 'common\space\Space2d.Intf.pas',
  Grid2d.Custom.Intf in 'grid\Grid2d.Custom.Intf.pas',
  Rect2d.Intf in 'common\position\Rect2d.Intf.pas',
  Rect2d in 'common\position\Rect2d.pas';

{$R *.RES}


begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
