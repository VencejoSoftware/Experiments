unit Colors.Lightness.Test;

interface

uses
  DUnitX.TestFramework,
  Colors.RGB.Intf, Colors.ColorX, Colors.Lightness;

type

  [TestFixture]
  [Category('ColorX')]
  TColorLightnessTest = class
  public
    [Test]
    [Category('methods')]
    procedure TestLightness;
  end;

implementation

procedure TColorLightnessTest.TestLightness;
begin
  with TColorLightness.New(TColorX.New(200, 200, 200, 255), 15) do
  begin
    Assert.AreEqual<Byte>(203, Red);
    Assert.AreEqual<Byte>(203, Green);
    Assert.AreEqual<Byte>(203, Blue);
    Assert.AreEqual<Byte>(255, Alpha);
  end;
end;

initialization

TDUnitX.RegisterTestFixture(TColorLightnessTest);

end.
