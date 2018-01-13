unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

type
  TRGB32 = packed record
    B, G, R, A: Byte;
  end;

  TRGB32Array = packed array [0 .. MaxInt div SizeOf(TRGB32) - 1] of TRGB32;
  PRGB32Array = ^TRGB32Array;

function BitmapsSimilarity(const Bitmap1, Bitmap2: TBitmap; const Threshold: Double): Double;
var
  x, y: Cardinal;
  Line1, Line2: PRGB32Array;
// PixelDiff,
  TotalDiff: Cardinal;
  RGBDist: Double;
begin
  Result := 0;
  if (Bitmap1.Height <> Bitmap2.Height) or (Bitmap1.Width <> Bitmap2.Width) then
    Exit;
  TotalDiff := 0;
  for y := 0 to Pred(Bitmap1.Height) do
  begin
    Line1 := Bitmap1.Scanline[y];
    Line2 := Bitmap2.Scanline[y];
    for x := 0 to Pred(Bitmap1.Width) do
    begin
// PixelDiff := Abs(Line2[x].R - Line1[x].R) + Abs(Line2[x].G - Line1[x].G) + Abs(Line2[x].B - Line1[x].B);
// Inc(TotalDiff, PixelDiff);
      RGBDist := Sqrt(Sqr(Line2[x].R - Line1[x].R) + Sqr(Line2[x].G - Line1[x].G) + Sqr(Line2[x].B - Line1[x].B));
      if RGBDist > Threshold then
        Inc(TotalDiff);
    end;
  end;
// Result := ((TotalDiff / 255 * 100) / (Bitmap1.Width * Bitmap1.Height * 3));
// 1.6255507126
  Result := 100 - ((TotalDiff * 100) / (Bitmap1.Width * Bitmap1.Height));
end;

function IsSameBitmap(const Bitmap1, Bitmap2: TBitmap): Boolean;
var
  Stream1, Stream2: TMemoryStream;
begin
  Result := False;
  if (Bitmap1.Height <> Bitmap2.Height) or (Bitmap1.Width <> Bitmap2.Width) then
    Exit;
  Stream1 := TMemoryStream.Create;
  try
    Bitmap1.SaveToStream(Stream1);
    Stream2 := TMemoryStream.Create;
    try
      Bitmap2.SaveToStream(Stream2);
      if Stream1.Size = Stream2.Size Then
        Result := CompareMem(Stream1.Memory, Stream2.Memory, Stream1.Size);
    finally
      Stream2.Free;
    end;
  finally
    Stream1.Free;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  Bmp1, Bmp2: TBitmap;
begin
  Bmp1 := TBitmap.Create;
  Bmp2 := TBitmap.Create;
  try
// Bmp1.LoadFromFile('C:\Users\APOLTI\Desktop\bmpdiff\Lenna50.bmp');
// Bmp2.LoadFromFile('C:\Users\APOLTI\Desktop\bmpdiff\Lenna50a.bmp');
// Bmp2.LoadFromFile('C:\Users\APOLTI\Desktop\bmpdiff\Lenna100.bmp');
    Bmp1.LoadFromFile('C:\Users\APOLTI\Desktop\bmpdiff\SummaryReport.bmp');
    Bmp2.LoadFromFile('C:\Users\APOLTI\Desktop\bmpdiff\SummaryReport1.bmp');
    Bmp1.PixelFormat := pf32bit;
    Bmp2.PixelFormat := pf32bit;
    Caption := FloatToStr(BitmapsSimilarity(Bmp1, Bmp2, 0));
  finally
    Bmp1.Free;
    Bmp2.Free;
  end;
end;

end.
