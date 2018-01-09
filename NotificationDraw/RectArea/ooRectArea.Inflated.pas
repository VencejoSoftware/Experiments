unit ooRectArea.Inflated;

interface

uses
  ooRectArea.Transform,
  ooRectArea;

type
  TRectAreaInflate = class sealed(TInterfacedObject, IRectAreaOperation)
  strict private
    _RectArea: IRectArea;
    _AmountX, _AmountY: Integer;
  public
    function Apply: IRectArea;
    constructor Create(const RectArea: IRectArea; const AmountX, AmountY: Integer);
    class function New(const RectArea: IRectArea; const AmountX, AmountY: Integer): IRectAreaOperation;
  end;

implementation

function TRectAreaInflate.Apply: IRectArea;
begin
  Result := TRectArea.New(_RectArea.Left - _AmountX, _RectArea.Top - _AmountY, _RectArea.Right + _AmountX,
    _RectArea.Bottom + _AmountY);
end;

constructor TRectAreaInflate.Create(const RectArea: IRectArea; const AmountX, AmountY: Integer);
begin
  _RectArea := RectArea;
  _AmountX := AmountX;
  _AmountY := AmountY;
end;

class function TRectAreaInflate.New(const RectArea: IRectArea; const AmountX, AmountY: Integer): IRectAreaOperation;
begin
  Result := TRectAreaInflate.Create(RectArea, AmountX, AmountY);
end;

end.
