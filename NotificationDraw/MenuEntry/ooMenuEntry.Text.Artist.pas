unit ooMenuEntry.Text.Artist;

interface

uses
  ooRender,
  ooPosition,
  ooSize,
  ooRectArea,
  ooRectArea.Inflated, ooRectArea.Offset,
  ooMenuEntry.Text,
  ooMenuEntry.Text.Measure,
  ooMenuEntry.Text.Draw;

type
  IMenuEntryTextArtist = interface
    ['{003CA0F7-FD37-4F31-9366-8E5D20E203CD}']
    procedure Draw(const MenuEntry: IMenuEntryText; const Position: IPosition);
  end;

  TMenuEntryTextArtist = class sealed(TInterfacedObject, IMenuEntryTextArtist)
  strict private
    _Render: IRender;
    _MenuEntryDraw: IMenuEntryTextDraw;
    _MenuEntryMeasure: IMenuEntryTextMeasure;
    _Constraint: ISize;
  public
    procedure Draw(const MenuEntry: IMenuEntryText; const Position: IPosition);
    constructor Create(const Render: IRender; const Constraint: ISize);
    class function New(const Render: IRender; const Constraint: ISize): IMenuEntryTextArtist;
  end;

implementation

procedure TMenuEntryTextArtist.Draw(const MenuEntry: IMenuEntryText; const Position: IPosition);
var
  RectArea: IRectArea;
begin
  RectArea := _MenuEntryMeasure.Calculate(MenuEntry);
  RectArea := TRectAreaOffset.New(RectArea, Position.Left, Position.Top).Apply;
  _MenuEntryDraw.DrawBody(RectArea, MenuEntry);
  RectArea := TRectAreaInflate.New(RectArea, -TMenuEntryTextDraw.CORNER_ROUND, -TMenuEntryTextDraw.CORNER_ROUND).Apply;
  _MenuEntryDraw.DrawText(RectArea, MenuEntry);
end;

constructor TMenuEntryTextArtist.Create(const Render: IRender; const Constraint: ISize);
begin
  _Render := Render;
  _Constraint := Constraint;
  _MenuEntryMeasure := TMenuEntryTextMeasure.New(_Render, _Constraint, TMenuEntryTextDraw.TITLE_SPACE,
    TMenuEntryTextDraw.CORNER_ROUND);
  _MenuEntryDraw := TMenuEntryTextDraw.New(Render);
end;

class function TMenuEntryTextArtist.New(const Render: IRender; const Constraint: ISize): IMenuEntryTextArtist;
begin
  Result := TMenuEntryTextArtist.Create(Render, Constraint);
end;

end.
