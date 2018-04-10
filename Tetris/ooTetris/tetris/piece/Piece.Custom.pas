unit Piece.Custom;

interface

uses
  VCL.Graphics,
  Vertex.Intf,
  Draw.Shape2d;

type
  TPieceCustom = class(TShape2d)
  private
    iColor: TColor;
  public
    function SetLeft(const aLeft: TVertexValue): TPieceCustom;
    function SetTop(const aTop: TVertexValue): TPieceCustom;

    property Color: TColor read iColor write iColor;
  end;

implementation

function TPieceCustom.SetLeft(const aLeft: TVertexValue): TPieceCustom;
begin
  Result := Self;
  if not IsInsideContainer then
    Exit;
  Left := aLeft;
end;

function TPieceCustom.SetTop(const aTop: TVertexValue): TPieceCustom;
begin
  Result := Self;
  Top := aTop;
end;

end.
