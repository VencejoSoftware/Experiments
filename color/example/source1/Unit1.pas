unit Unit1;

interface

uses
  SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs,
  uRGB.Intf, uRGB,
  uRGB.FromColor, uRGB.ToColor,
  uRGB.Greyscale,
  uRGB.Invert,
  uRGB.Lightness, uRGB.Darkness,
  uRGB.Contrast,
  uHSV.Intf, uHSV,
  uHSV.FromRGB,
  ExtCtrls,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Button4: TButton;
    Shape4: TShape;
    Shape5: TShape;
    Button5: TButton;
    Shape6: TShape;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  RGB, RGBInverted: IRGB;
begin
  RGB := TRGBFromColor.New(Shape1.Brush.Color);
  RGBInverted := TRGBInvert.New(RGB);
  Shape1.Brush.Color := TRGBToColor.New(RGBInverted).ToColor;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  RGB, RGBGrey: IRGB;
begin
  RGB := TRGBFromColor.New(Shape2.Brush.Color);
  RGBGrey := TRGBGreyscale.New(RGB);
  Shape2.Brush.Color := TRGBToColor.New(RGBGrey).ToColor;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  RGB, RGBLight: IRGB;
begin
  RGB := TRGBFromColor.New(Shape3.Brush.Color);
  RGBLight := TRGBLightness.New(RGB, 20);
  Shape3.Brush.Color := TRGBToColor.New(RGBLight).ToColor;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  RGB, RGBDark: IRGB;
begin
  RGB := TRGBFromColor.New(Shape4.Brush.Color);
  RGBDark := TRGBDarkness.New(RGB, 20);
  Shape4.Brush.Color := TRGBToColor.New(RGBDark).ToColor;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  RGB, RGBContrast: IRGB;
begin
  RGB := TRGBFromColor.New(Shape5.Brush.Color);
  RGBContrast := TRGBContrast.New(RGB, 20);
  Shape5.Brush.Color := TRGBToColor.New(RGBContrast).ToColor;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  RGB: IRGB;
  HSV: IHSV;
begin
  RGB := TRGBFromColor.New(Shape6.Brush.Color);
  HSV := THSVFromRGB.New(RGB);
end;

end.
