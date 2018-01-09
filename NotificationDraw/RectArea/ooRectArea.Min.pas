unit ooRectArea.Min;

interface

uses
  ooRectArea.Transform,
  ooRectArea;

type
  TRectAreaMin = class sealed(TInterfacedObject, IRectAreaOperation)
  strict private
    _RectArea, _MinArea: IRectArea;
  private
    function MinValue(const ValueA, ValueB: Integer): Integer;
  public
    function Apply: IRectArea;
    constructor Create(const RectArea: IRectArea; const MinArea: IRectArea);
    class function New(const RectArea: IRectArea; const MinArea: IRectArea): IRectAreaOperation;
  end;

implementation

function TRectAreaMin.MinValue(const ValueA, ValueB: Integer): Integer;
begin
  if (ValueB <> 0) and (ValueA > ValueB) then
    Result := ValueB
  else
    Result := ValueA;
end;

function TRectAreaMin.Apply: IRectArea;
var
  NewLeft, NewTop, NewRight, NewBottom: Integer;
begin
  NewLeft := MinValue(_RectArea.Left, _MinArea.Left);
  NewTop := MinValue(_RectArea.Top, _MinArea.Top);
  NewRight := MinValue(_RectArea.Right, _MinArea.Right);
  NewBottom := MinValue(_RectArea.Bottom, _MinArea.Bottom);
  Result := TRectArea.New(NewLeft, NewTop, NewRight, NewBottom);
end;

constructor TRectAreaMin.Create(const RectArea, MinArea: IRectArea);
begin
  _RectArea := RectArea;
  _MinArea := MinArea;
end;

class function TRectAreaMin.New(const RectArea, MinArea: IRectArea): IRectAreaOperation;
begin
  Result := TRectAreaMin.Create(RectArea, MinArea);
end;

end.
