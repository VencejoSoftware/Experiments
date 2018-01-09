unit ooRectArea.Offset;

interface

uses
  ooRectArea.Transform,
  ooRectArea;

type
  TRectAreaOffset = class sealed(TInterfacedObject, IRectAreaOperation)
  strict private
    _RectArea: IRectArea;
    _AmountX, _AmountY: Integer;
  public
    function Apply: IRectArea;
    constructor Create(const RectArea: IRectArea; const AmountX, AmountY: Integer);
    class function New(const RectArea: IRectArea; const AmountX, AmountY: Integer): IRectAreaOperation;
  end;

implementation

function TRectAreaOffset.Apply: IRectArea;
begin
  Result := TRectArea.New(_RectArea.Left + _AmountX, _RectArea.Top + _AmountY, _RectArea.Right + _AmountX,
    _RectArea.Bottom + _AmountY);
end;

constructor TRectAreaOffset.Create(const RectArea: IRectArea; const AmountX, AmountY: Integer);
begin
  _RectArea := RectArea;
  _AmountX := AmountX;
  _AmountY := AmountY;
end;

class function TRectAreaOffset.New(const RectArea: IRectArea; const AmountX, AmountY: Integer): IRectAreaOperation;
begin
  Result := TRectAreaOffset.Create(RectArea, AmountX, AmountY);
end;

end.
