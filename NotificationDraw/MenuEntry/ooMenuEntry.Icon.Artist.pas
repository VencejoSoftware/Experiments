unit ooMenuEntry.Icon.Artist;

interface

uses
  ooRender,
  ooPosition,
  ooSize,
  ooRectArea,
  ooRectArea.Inflated, ooRectArea.Offset, ooRectArea.Add,
  ooMenuEntry.Icon,
  ooMenuEntry.Icon.Measure,
  ooMenuEntry.Text.Draw;

type
  IMenuEntryIconArtist = interface
    ['{BE914C18-E405-40C6-B2F8-9B06F03FA213}']
    procedure Draw(const MenuEntry: IMenuEntryIcon; const Position: IPosition);
  end;

  TMenuEntryIconArtist = class sealed(TInterfacedObject, IMenuEntryIconArtist)
  strict private
    _Render: IRender;
    _MenuEntryDraw: IMenuEntryTextDraw;
    _MenuEntryMeasure: IMenuEntryIconMeasure;
    _Constraint: ISize;
  private
    procedure DrawGlyph(const MenuEntry: IMenuEntryIcon; const RectArea: IRectArea);
  public
    procedure Draw(const MenuEntry: IMenuEntryIcon; const Position: IPosition);
    constructor Create(const Render: IRender; const Constraint: ISize);
    class function New(const Render: IRender; const Constraint: ISize): IMenuEntryIconArtist;
  end;

implementation

procedure TMenuEntryIconArtist.DrawGlyph(const MenuEntry: IMenuEntryIcon; const RectArea: IRectArea);
var
  X, Y, GlyphWidth: Integer;
begin
  GlyphWidth := MenuEntry.Glyph.Size + (TMenuEntryTextDraw.CORNER_ROUND * 2);
  X := RectArea.Left + (GlyphWidth div 2) - Integer(MenuEntry.Glyph.Size div 2);
  Y := RectArea.Top + (RectArea.Height div 2) - Integer(MenuEntry.Glyph.Size div 2);
  _Render.DrawGraphic(X, Y, MenuEntry.Glyph.Graphic);
end;

procedure TMenuEntryIconArtist.Draw(const MenuEntry: IMenuEntryIcon; const Position: IPosition);
var
  RectArea: IRectArea;
  NewRight: Integer;
begin
  NewRight := 0;
  RectArea := _MenuEntryMeasure.Calculate(MenuEntry);
  RectArea := TRectAreaOffset.New(RectArea, Position.Left, Position.Top).Apply;
  _MenuEntryDraw.DrawBody(RectArea, MenuEntry);
  if MenuEntry.Glyph.IsVisible then
  begin
    DrawGlyph(MenuEntry, RectArea);
    NewRight := MenuEntry.Glyph.Size + (TMenuEntryTextDraw.CORNER_ROUND div 2);
    RectArea := TRectAreaOffset.New(RectArea, NewRight, 0).Apply;
  end;
  RectArea := TRectAreaAdd.New(RectArea, TRectArea.New(0, 0, -NewRight, 0)).Apply;
  RectArea := TRectAreaInflate.New(RectArea, -TMenuEntryTextDraw.CORNER_ROUND, -TMenuEntryTextDraw.CORNER_ROUND).Apply;
  _MenuEntryDraw.DrawText(RectArea, MenuEntry);
end;

constructor TMenuEntryIconArtist.Create(const Render: IRender; const Constraint: ISize);
begin
  _Render := Render;
  _Constraint := Constraint;
  _MenuEntryMeasure := TMenuEntryIconMeasure.New(_Render, _Constraint, TMenuEntryTextDraw.TITLE_SPACE,
    TMenuEntryTextDraw.CORNER_ROUND);
  _MenuEntryDraw := TMenuEntryTextDraw.New(Render);
end;

class function TMenuEntryIconArtist.New(const Render: IRender; const Constraint: ISize): IMenuEntryIconArtist;
begin
  Result := TMenuEntryIconArtist.Create(Render, Constraint);
end;

end.
