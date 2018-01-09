unit ooMenuEntry.Icon.Measure;

interface

uses
  ooRectArea,
  ooRectArea.Add, ooRectArea.Max, ooRectArea.Constraint,
  ooRender,
  ooSize,
  ooMenuEntry.Text.Measure,
  ooMenuEntry.Icon;

type
  IMenuEntryIconMeasure = interface
    ['{393F31BF-AADB-40E7-AC70-9DC48ECF52C9}']
    function Calculate(const MenuEntry: IMenuEntryIcon): IRectArea;
  end;

  TMenuEntryIconMeasure = class sealed(TInterfacedObject, IMenuEntryIconMeasure)
  strict private
    _Render: IRender;
    _TitleSpace, _BorderSize: Byte;
    _Constraint: ISize;
  public
    function Calculate(const MenuEntry: IMenuEntryIcon): IRectArea;
    constructor Create(const Render: IRender; const Constraint: ISize; const TitleSpace, BorderSize: Byte);
    class function New(const Render: IRender; const Constraint: ISize; const TitleSpace, BorderSize: Byte)
      : IMenuEntryIconMeasure;
  end;

implementation

function TMenuEntryIconMeasure.Calculate(const MenuEntry: IMenuEntryIcon): IRectArea;
var
  GlyphWidth: Cardinal;
begin
  Result := TMenuEntryTextMeasure.New(_Render, nil, _TitleSpace, _BorderSize).Calculate(MenuEntry);
  if MenuEntry.Glyph.IsVisible then
  begin
    GlyphWidth := MenuEntry.Glyph.Size + (_BorderSize div 2);
    if MenuEntry.Title.IsVisible or MenuEntry.Description.IsVisible then
      Result := TRectAreaAdd.New(Result, TRectArea.New(0, 0, GlyphWidth, _TitleSpace)).Apply;
    Result := TRectAreaMax.New(Result, TRectArea.New(0, 0, GlyphWidth, GlyphWidth)).Apply;
  end;
  if Assigned(_Constraint) then
    Result := TRectAreaConstraint.New(Result, TRectArea.New(0, 0, _Constraint.Width, _Constraint.Height)).Apply;
end;

constructor TMenuEntryIconMeasure.Create(const Render: IRender; const Constraint: ISize;
  const TitleSpace, BorderSize: Byte);
begin
  _Render := Render;
  _Constraint := Constraint;
  _TitleSpace := TitleSpace;
  _BorderSize := BorderSize;
end;

class function TMenuEntryIconMeasure.New(const Render: IRender; const Constraint: ISize;
  const TitleSpace, BorderSize: Byte): IMenuEntryIconMeasure;
begin
  Result := TMenuEntryIconMeasure.Create(Render, Constraint, TitleSpace, BorderSize);
end;

end.
