unit ooMenuEntry.Text.Measure;

interface

uses
  ooRectArea,
  ooRectArea.Inflated, ooRectArea.Add, ooRectArea.Max, ooRectArea.Constraint,
  ooRender,
  ooSize,
  ooMenuEntry.Text;

type
  IMenuEntryTextMeasure = interface
    ['{5681E153-49D7-4F23-B47E-19F76F5ED98A}']
    function Calculate(const MenuEntry: IMenuEntryText): IRectArea;
  end;

  TMenuEntryTextMeasure = class sealed(TInterfacedObject, IMenuEntryTextMeasure)
  strict private
    _Render: IRender;
    _TitleSpace, _BorderSize: Byte;
    _Constraint: ISize;
  private
    function CalcMenuEntryRect(const MenuEntry: IMenuEntryText): IRectArea;
  public
    function Calculate(const MenuEntry: IMenuEntryText): IRectArea;
    constructor Create(const Render: IRender; const Constraint: ISize; const TitleSpace, BorderSize: Byte);
    class function New(const Render: IRender; const Constraint: ISize; const TitleSpace, BorderSize: Byte)
      : IMenuEntryTextMeasure;
  end;

implementation

function TMenuEntryTextMeasure.CalcMenuEntryRect(const MenuEntry: IMenuEntryText): IRectArea;
var
  TextRect: IRectArea;
begin
  Result := TRectArea.NewEmpty;
  if MenuEntry.Title.IsVisible then
  begin
    _Render.ChangeFont(MenuEntry.Title.Font);
    Result := _Render.TextArea(MenuEntry.Title.Text, False);
  end;
  if MenuEntry.Description.IsVisible then
  begin
    _Render.ChangeFont(MenuEntry.Description.Font);
    TextRect := _Render.TextArea(MenuEntry.Description.Text, True);
    Result := TRectAreaAdd.New(Result, TRectArea.New(0, 0, 0, _TitleSpace + TextRect.Height)).Apply;
    Result := TRectAreaMax.New(Result, TRectArea.New(0, 0, TextRect.Right, 0)).Apply;
  end;
end;

function TMenuEntryTextMeasure.Calculate(const MenuEntry: IMenuEntryText): IRectArea;
begin
  Result := CalcMenuEntryRect(MenuEntry);
  if Assigned(_Constraint) then
    Result := TRectAreaConstraint.New(Result, TRectArea.New(0, 0, _Constraint.Width, _Constraint.Height)).Apply;
  Result := TRectAreaInflate.New(Result, _BorderSize, _BorderSize).Apply;
end;

constructor TMenuEntryTextMeasure.Create(const Render: IRender; const Constraint: ISize;
  const TitleSpace, BorderSize: Byte);
begin
  _Render := Render;
  _Constraint := Constraint;
  _TitleSpace := TitleSpace;
  _BorderSize := BorderSize;
end;

class function TMenuEntryTextMeasure.New(const Render: IRender; const Constraint: ISize;
  const TitleSpace, BorderSize: Byte): IMenuEntryTextMeasure;
begin
  Result := TMenuEntryTextMeasure.Create(Render, Constraint, TitleSpace, BorderSize);
end;

end.
