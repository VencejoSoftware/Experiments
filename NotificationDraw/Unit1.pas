unit Unit1;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Vcl.ExtCtrls,
  ooRender, ooRender.Canvas,
  ooColor,
  ooFontStyle,
  ooBorder,
  ooFill,
  ooStyledText,
  ooStyle,
  ooMenuEntry.Text, ooMenuEntry.Text.Artist,
  ooGlyph,
  ooMenuEntry.Icon, ooMenuEntry.Icon.Artist,
  ooSize,
  ooPosition;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TestEntryText(const ID: Cardinal): IMenuEntryText;
var
  Style: IStyle;
  Fill: IFill;
  Border: IBorder;
begin
  Result := TMenuEntryText.New(ID);
  Result.ChangeTitle(TStyledText.New('Title Title Title Title Title'));
  Result.Title.ChangeFont(TFontStyle.New('Arial', 12, TColor.New(clNavy), [Bold]));
  Result.ChangeDescription(TStyledText.New('This is a description!' + sLineBreak + 'Second line' + sLineBreak +
    'End line. End line.End line.End line.End line.End line.End line.'));
  Result.Description.ChangeFont(TFontStyle.New('Arial', 10, TColor.New(clDkGray), [Italic]));
  Border := TBorder.New(TColor.New(clGray), TBorderMode.Solid);
  Fill := TFill.New(TColor.New(clInfoBk), TFillMode.Solid);
  Style := TStyle.New(Fill, Border);
  Result.ChangeStyle(Style);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  EntryText: IMenuEntryText;
begin
  EntryText := TestEntryText(0);
  TMenuEntryTextArtist.New(TCanvasRender.New(Canvas), TSize.New(150, 60)).Draw(EntryText, TPosition.New(10, 100));
  EntryText.Title.Hide;
  TMenuEntryTextArtist.New(TCanvasRender.New(Canvas), nil).Draw(EntryText, TPosition.New(10, 200));
  EntryText.Title.Show;
  EntryText.Description.Hide;
  TMenuEntryTextArtist.New(TCanvasRender.New(Canvas), nil).Draw(EntryText, TPosition.New(10, 280));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  EntryIcon: IMenuEntryIcon;
  Glyph: IGlyph;
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    Image2.Picture.SaveToStream(Stream);
    Glyph := TGlyph.New;
    Glyph.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
  EntryIcon := TMenuEntryIcon.New(TestEntryText(1), Glyph);
  TMenuEntryIconArtist.New(TCanvasRender.New(Canvas), nil).Draw(EntryIcon, TPosition.New(400, 100));

  Stream := TMemoryStream.Create;
  try
    Image1.Picture.SaveToStream(Stream);
    Glyph := TGlyph.New;
    Glyph.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
  EntryIcon := TMenuEntryIcon.New(TestEntryText(2), Glyph);
  TMenuEntryIconArtist.New(TCanvasRender.New(Canvas), TSize.New(150, 60)).Draw(EntryIcon, TPosition.New(400, 200));
  EntryIcon.Title.Hide;
  EntryIcon.Description.Hide;
// EntryIcon.Glyph.Hide;
  TMenuEntryIconArtist.New(TCanvasRender.New(Canvas), nil).Draw(EntryIcon, TPosition.New(400, 310));
end;

end.
