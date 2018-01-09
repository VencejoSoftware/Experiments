unit ColorX.Test;

interface

uses
  SysUtils, Graphics,
  DUnitX.TestFramework,
  Colors.RGB.Intf, Colors.ColorX;

type

  [TestFixture]
  [Category('ColorX')]
  TColorXTest = class
  public
    [Test]
    [Category('methods')]
    procedure TestNew;
    [Test]
    [Category('methods')]
    procedure TestNewFromColor;
    [Test]
    [Category('methods')]
    procedure TestToColor;
  end;

implementation

procedure TColorXTest.TestNew;
begin
  with TColorX.New(200, 210, 220, 230) do
  begin
    Assert.AreEqual<Byte>(200, Red);
    Assert.AreEqual<Byte>(210, Green);
    Assert.AreEqual<Byte>(220, Blue);
    Assert.AreEqual<Byte>(230, Alpha);
  end;
end;

procedure TColorXTest.TestNewFromColor;
begin
  with TColorX.NewFromColor(clGray) do
  begin
    Assert.AreEqual<Byte>(128, Red);
    Assert.AreEqual<Byte>(128, Green);
    Assert.AreEqual<Byte>(128, Blue);
    Assert.AreEqual<Byte>(255, Alpha);
  end;
end;

procedure TColorXTest.TestToColor;
var
  objColor: IColorX;
begin
  objColor := TColorX.New(128, 128, 128);
  Assert.AreEqual<TColor>(clGray, objColor.ToColor);
end;

initialization

TDUnitX.RegisterTestFixture(TColorXTest);

end.
