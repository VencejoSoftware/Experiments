unit Colors.Invert.Test;

interface

uses
  DUnitX.TestFramework,
  Colors.RGB.Intf, Colors.ColorX, Colors.Invert;

type

  [TestFixture]
  [Category('ColorX')]
  TColorInvertTest = class
  public
    [Test]
    [Category('methods')]
    procedure TestInvert;
  end;

implementation

procedure TColorInvertTest.TestInvert;
begin
  with TColorInverted.New(TColorX.New(200, 200, 200, 255)) do
  begin
    Assert.AreEqual<Byte>(55, Red);
    Assert.AreEqual<Byte>(55, Green);
    Assert.AreEqual<Byte>(55, Blue);
    Assert.AreEqual<Byte>(255, Alpha);
  end;
end;

initialization

TDUnitX.RegisterTestFixture(TColorInvertTest);

end.
