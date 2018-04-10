unit Piece.Shapes;

interface

uses
  Piece.Tetris;

const
  PTR_SQUARE: TPiecePattern =
     ((0, 0, 0, 0),
     (0, 1, 1, 0),
     (0, 1, 1, 0),
     (0, 0, 0, 0));
  PTR_BAR: TPiecePattern =
     ((0, 0, 0, 0),
     (1, 1, 1, 1),
     (0, 0, 0, 0),
     (0, 0, 0, 0));
  PTR_LEFT_L: TPiecePattern =
     ((0, 1, 1, 0),
     (0, 1, 0, 0),
     (0, 1, 0, 0),
     (0, 0, 0, 0));
  PTR_RIGHT_L: TPiecePattern =
     ((0, 1, 0, 0),
     (0, 1, 0, 0),
     (0, 1, 1, 0),
     (0, 0, 0, 0));
  PTR_SQUAD: TPiecePattern =
     ((0, 0, 0, 0),
     (0, 1, 1, 0),
     (0, 1, 0, 0),
     (0, 0, 0, 0));
  PTR_T: TPiecePattern =
     ((0, 1, 0, 0),
     (0, 1, 1, 0),
     (0, 1, 0, 0),
     (0, 0, 0, 0));
  PTR_CROSS: TPiecePattern =
     ((0, 1, 0, 0),
     (1, 1, 1, 1),
     (0, 0, 0, 0),
     (0, 0, 0, 0));
  PTR_SPECIAL: TPiecePattern =
     ((0, 1, 0, 0),
     (0, 1, 1, 0),
     (0, 0, 1, 1),
     (0, 0, 0, 0));
  PTR_LEFT_S: TPiecePattern =
     ((0, 0, 1, 0),
     (0, 1, 1, 0),
     (0, 1, 0, 0),
     (0, 0, 0, 0));
  PTR_RIGHT_S: TPiecePattern =
     ((0, 1, 0, 0),
     (0, 1, 1, 0),
     (0, 0, 1, 0),
     (0, 0, 0, 0));

implementation

end.
