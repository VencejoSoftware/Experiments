unit ooMenuEntry.Text.Draw;

interface

uses
  ooRender,
  ooFill,
  ooRectArea, ooRectArea.Add,
  ooMenuEntry.Text;

type
  IMenuEntryTextDraw = interface
    ['{3464D4AD-4B74-4F30-8BDE-1500B116F964}']
    procedure DrawBody(const RectArea: IRectArea; const MenuEntry: IMenuEntryText);
    procedure DrawText(const RectArea: IRectArea; const MenuEntry: IMenuEntryText);
  end;

  TMenuEntryTextDraw = class sealed(TInterfacedObject, IMenuEntryTextDraw)
  const
    TITLE_SPACE = 2;
    CORNER_ROUND = 6;
  strict private
    _Render: IRender;
  public
    procedure DrawBody(const RectArea: IRectArea; const MenuEntry: IMenuEntryText);
    procedure DrawText(const RectArea: IRectArea; const MenuEntry: IMenuEntryText);
    constructor Create(const Render: IRender);
    class function New(const Render: IRender): IMenuEntryTextDraw;
  end;

implementation

procedure TMenuEntryTextDraw.DrawBody(const RectArea: IRectArea; const MenuEntry: IMenuEntryText);
begin
  _Render.ChangeFill(MenuEntry.Style.Fill);
  _Render.ChangeBorder(MenuEntry.Style.Border);
  _Render.RoundedRect(RectArea, CORNER_ROUND, CORNER_ROUND);
end;

procedure TMenuEntryTextDraw.DrawText(const RectArea: IRectArea; const MenuEntry: IMenuEntryText);
var
  TextRectArea: IRectArea;
begin
  TextRectArea := RectArea;
  _Render.ChangeFill(TFill.New(nil, TFillMode.None));
  if MenuEntry.Title.IsVisible then
  begin
    _Render.ChangeFont(MenuEntry.Title.Font);
    _Render.MultiLineText(TextRectArea, MenuEntry.Title.Text);
    TextRectArea := TRectAreaAdd.New(TextRectArea, TRectArea.New(0, _Render.TextHeight(MenuEntry.Title.Text) +
      TITLE_SPACE, 0, 0)).Apply;
  end;
  if MenuEntry.Description.IsVisible then
  begin
    _Render.ChangeFont(MenuEntry.Description.Font);
    _Render.MultiLineText(TextRectArea, MenuEntry.Description.Text);
  end;
end;

constructor TMenuEntryTextDraw.Create(const Render: IRender);
begin
  _Render := Render;
end;

class function TMenuEntryTextDraw.New(const Render: IRender): IMenuEntryTextDraw;
begin
  Result := TMenuEntryTextDraw.Create(Render);
end;

end.
