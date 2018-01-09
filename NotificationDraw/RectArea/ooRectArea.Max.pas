unit ooRectArea.Max;

interface

uses
  ooRectArea.Transform,
  ooRectArea;

type
  TRectAreaMax = class sealed(TInterfacedObject, IRectAreaOperation)
  strict private
    _RectArea, _MaxArea: IRectArea;
  private
    function MaxValue(const ValueA, ValueB: Integer): Integer;
  public
    function Apply: IRectArea;
    constructor Create(const RectArea: IRectArea; const MaxArea: IRectArea);
    class function New(const RectArea: IRectArea; const MaxArea: IRectArea): IRectAreaOperation;
  end;

implementation

function TRectAreaMax.MaxValue(const ValueA, ValueB: Integer): Integer;
begin
  if (ValueB <> 0) and (ValueA < ValueB) then
    Result := ValueB
  else
    Result := ValueA;
end;

function TRectAreaMax.Apply: IRectArea;
var
  NewLeft, NewTop, NewRight, NewBottom: Integer;
begin
  NewLeft := MaxValue(_RectArea.Left, _MaxArea.Left);
  NewTop := MaxValue(_RectArea.Top, _MaxArea.Top);
  NewRight := MaxValue(_RectArea.Right, _MaxArea.Right);
  NewBottom := MaxValue(_RectArea.Bottom, _MaxArea.Bottom);
  Result := TRectArea.New(NewLeft, NewTop, NewRight, NewBottom);
end;

constructor TRectAreaMax.Create(const RectArea, MaxArea: IRectArea);
begin
  _RectArea := RectArea;
  _MaxArea := MaxArea;
end;

class function TRectAreaMax.New(const RectArea, MaxArea: IRectArea): IRectAreaOperation;
begin
  Result := TRectAreaMax.Create(RectArea, MaxArea);
end;

end.
