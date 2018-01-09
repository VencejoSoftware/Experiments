unit ooRectArea.Add;

interface

uses
  ooRectArea.Transform,
  ooRectArea;

type
  TRectAreaAdd = class sealed(TInterfacedObject, IRectAreaOperation)
  strict private
    _RectArea, _AddArea: IRectArea;
  public
    function Apply: IRectArea;
    constructor Create(const RectArea: IRectArea; const AddArea: IRectArea);
    class function New(const RectArea: IRectArea; const AddArea: IRectArea): IRectAreaOperation;
  end;

implementation

function TRectAreaAdd.Apply: IRectArea;
begin
  Result := TRectArea.New(_RectArea.Left + _AddArea.Left, _RectArea.Top + _AddArea.Top,
    _RectArea.Right + _AddArea.Right, _RectArea.Bottom + _AddArea.Bottom);
end;

constructor TRectAreaAdd.Create(const RectArea, AddArea: IRectArea);
begin
  _RectArea := RectArea;
  _AddArea := AddArea;
end;

class function TRectAreaAdd.New(const RectArea, AddArea: IRectArea): IRectAreaOperation;
begin
  Result := TRectAreaAdd.Create(RectArea, AddArea);
end;

end.
