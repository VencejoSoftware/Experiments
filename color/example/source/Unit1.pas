unit Unit1;

interface

uses
  SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs,
  uColor.RGB.Intf,
  uColor.RGB,
  uColor.RGBFromColor, uColor.RGBToColor,
  uColor.RGB.Greyscale,
  uColor.RGB.Invert,
  uColor.RGB.Lightness, uColor.RGB.Darkness,
  uColor.RGB.Contrast,
  Vcl.ExtCtrls,
  Vcl.StdCtrls;

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
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
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

end.
