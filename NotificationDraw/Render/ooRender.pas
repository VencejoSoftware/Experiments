unit ooRender;

interface

uses
  Graphics,
  ooRectArea,
  ooBorder,
  ooFill,
  ooFontStyle;

type
  IRender = interface
    ['{BD980F73-6FCA-4D87-882B-9DF39DED29A7}']
    function TextHeight(const Text: String): Word;
    function TextArea(const Text: String; const MultiLine: Boolean): IRectArea;
    procedure ChangeBorder(const Border: IBorder);
    procedure ChangeFill(const Fill: IFill);
    procedure ChangeFont(const Font: IFontStyle);
    procedure MultiLineText(const RectArea: IRectArea; const Text: String);
    procedure RoundedRect(const RectArea: IRectArea; const CornerX, CornerY: Byte);
    procedure DrawGraphic(const X, Y: Integer; const Graphic: TGraphic);
  end;

implementation

end.
