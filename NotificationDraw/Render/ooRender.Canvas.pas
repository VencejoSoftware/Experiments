unit ooRender.Canvas;

interface

uses
  Graphics, Types,
  ooRectArea,
  ooTextSplitter,
  ooBorder,
  ooFill,
  ooFontStyle,
  ooRender;

type
  TCanvasRender = class sealed(TInterfacedObject, IRender)
  strict private
    _Canvas: TCanvas;
  public
    function TextHeight(const Text: String): Word;
    function TextArea(const Text: String; const MultiLine: Boolean): IRectArea;
    procedure ChangeBorder(const Border: IBorder);
    procedure ChangeFill(const Fill: IFill);
    procedure ChangeFont(const Font: IFontStyle);
    procedure MultiLineText(const RectArea: IRectArea; const Text: String);
    procedure RoundedRect(const RectArea: IRectArea; const CornerX, CornerY: Byte);
    procedure DrawGraphic(const X, Y: Integer; const Graphic: TGraphic);
    constructor Create(const Canvas: TCanvas);
    class function New(const Canvas: TCanvas): IRender;
  end;

implementation

procedure TCanvasRender.ChangeBorder(const Border: IBorder);
const
  PEN_STYLE: array [TBorderMode] of TPenStyle = (psClear, psSolid, psDot, psDash, psDashDot);
begin
  _Canvas.Pen.Style := PEN_STYLE[Border.Mode];
  if Border.Mode <> TBorderMode.None then
    _Canvas.Pen.Color := Border.Color.AsTColor;
end;

procedure TCanvasRender.ChangeFill(const Fill: IFill);
begin
  if Fill.Mode = TFillMode.Solid then
  begin
    _Canvas.Brush.Style := bsSolid;
    _Canvas.Brush.Color := Fill.Color.AsTColor;
  end
  else
  begin
    _Canvas.Brush.Style := bsClear;
  end;
end;

procedure TCanvasRender.ChangeFont(const Font: IFontStyle);
var
  FontStyles: TFontStyles;
begin
  _Canvas.Font.Name := Font.Name;
  _Canvas.Font.Size := Font.Size;
  _Canvas.Font.Color := Font.Color.AsTColor;
  FontStyles := [];
  if Bold in Font.Mode then
    Include(FontStyles, fsBold);
  if Italic in Font.Mode then
    Include(FontStyles, fsItalic);
  if Underline in Font.Mode then
    Include(FontStyles, fsUnderline);
  if StrikeOut in Font.Mode then
    Include(FontStyles, fsStrikeOut);
  _Canvas.Font.Style := FontStyles;
end;

procedure TCanvasRender.MultiLineText(const RectArea: IRectArea; const Text: String);
var
  LineTextRect: TRect;
  Splitted: TTextSplitter.TStringArray;
  i: Integer;
  TextHeight: Integer;
  ItemText: String;
  RestOfLines: 1 .. 2;
begin
  Splitted := TTextSplitter.New(sLineBreak).Split(Text);
  LineTextRect := Types.Rect(RectArea.Left, RectArea.Top, RectArea.Right, RectArea.Bottom);
  TextHeight := _Canvas.TextHeight('A');
  for i := Low(Splitted) to High(Splitted) do
  begin
    if (i = High(Splitted)) then
      RestOfLines := 1
    else
      RestOfLines := 2;
    if (LineTextRect.Top + (TextHeight * RestOfLines)) > LineTextRect.Bottom then
    begin
      ItemText := '...';
      _Canvas.TextRect(LineTextRect, ItemText, [tfTop, tfLeft, tfSingleLine]);
      Break;
    end
    else
    begin
      ItemText := Splitted[i];
      _Canvas.TextRect(LineTextRect, ItemText, [tfTop, tfLeft, tfSingleLine, tfEndEllipsis]);
      LineTextRect.Top := LineTextRect.Top + TextHeight;
    end;
  end;
end;

procedure TCanvasRender.RoundedRect(const RectArea: IRectArea; const CornerX, CornerY: Byte);
var
  Rect: TRect;
begin
  Rect := Types.Rect(RectArea.Left, RectArea.Top, RectArea.Right, RectArea.Bottom);
  _Canvas.RoundRect(Rect, CornerX, CornerY);
end;

function TCanvasRender.TextHeight(const Text: String): Word;
begin
  Result := _Canvas.TextHeight(Text);
end;

function TCanvasRender.TextArea(const Text: String; const MultiLine: Boolean): IRectArea;
var
  InternText: String;
  InternRect: TRect;
begin
  InternRect := TRect.Empty;
  InternText := Text;
  if MultiLine then
  begin
    InternRect.Right := 9999;
    _Canvas.TextRect(InternRect, InternText, [tfWordBreak, tfCalcRect]);
  end
  else
    _Canvas.TextRect(InternRect, InternText, [tfSingleLine, tfCalcRect]);
  Result := TRectArea.New(InternRect.Left, InternRect.Top, InternRect.Right, InternRect.Bottom);
end;

procedure TCanvasRender.DrawGraphic(const X, Y: Integer; const Graphic: TGraphic);
begin
  _Canvas.Draw(X, Y, Graphic);
end;

constructor TCanvasRender.Create(const Canvas: TCanvas);
begin
  _Canvas := Canvas;
end;

class function TCanvasRender.New(const Canvas: TCanvas): IRender;
begin
  Result := TCanvasRender.Create(Canvas);
end;

end.
