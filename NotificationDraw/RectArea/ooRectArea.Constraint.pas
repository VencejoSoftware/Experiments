unit ooRectArea.Constraint;

interface

uses
  ooRectArea.Transform,
  ooRectArea;

type
  TRectAreaConstraint = class sealed(TInterfacedObject, IRectAreaOperation)
  strict private
    _RectArea, _ConstraintArea: IRectArea;
  private
    function MaxValue(const ValueA, ValueB: Integer): Integer;
    function MinValue(const ValueA, ValueB: Integer): Integer;
  public
    function Apply: IRectArea;
    constructor Create(const RectArea: IRectArea; const ConstraintArea: IRectArea);
    class function New(const RectArea: IRectArea; const ConstraintArea: IRectArea): IRectAreaOperation;
  end;

implementation

function TRectAreaConstraint.MaxValue(const ValueA, ValueB: Integer): Integer;
begin
  if (ValueB <> 0) and (ValueA <> ValueB) then
    Result := ValueB
  else
    Result := ValueA;
end;

function TRectAreaConstraint.MinValue(const ValueA, ValueB: Integer): Integer;
begin
  if (ValueB <> 0) and (ValueA <> ValueB) then
    Result := ValueB
  else
    Result := ValueA;
end;

function TRectAreaConstraint.Apply: IRectArea;
var
  NewLeft, NewTop, NewRight, NewBottom: Integer;
begin
  NewLeft := MaxValue(_RectArea.Left, _ConstraintArea.Left);
  NewTop := MaxValue(_RectArea.Top, _ConstraintArea.Top);
  NewRight := MinValue(_RectArea.Right, _ConstraintArea.Right);
  NewBottom := MinValue(_RectArea.Bottom, _ConstraintArea.Bottom);
  Result := TRectArea.New(NewLeft, NewTop, NewRight, NewBottom);
end;

constructor TRectAreaConstraint.Create(const RectArea, ConstraintArea: IRectArea);
begin
  _RectArea := RectArea;
  _ConstraintArea := ConstraintArea;
end;

class function TRectAreaConstraint.New(const RectArea, ConstraintArea: IRectArea): IRectAreaOperation;
begin
  Result := TRectAreaConstraint.Create(RectArea, ConstraintArea);
end;

end.
