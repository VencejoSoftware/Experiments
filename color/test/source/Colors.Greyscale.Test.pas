unit Colors.Greyscale.Test;

interface

uses
  DUnitX.TestFramework,
  Colors.RGB.Intf, Colors.ColorX, Colors.Greyscale;

type

  [TestFixture]
  [Category('ColorX')]
  TColorGreyscaleTest = class
  public
    [Test]
    [Category('methods')]
    procedure TestGreyscale;
  end;

implementation

procedure TColorGreyscaleTest.TestGreyscale;
begin
  with TColorGreyscale.New(TColorX.New(200, 200, 200, 255), 15) do
  begin
    Assert.AreEqual<Byte>(203, Red);
    Assert.AreEqual<Byte>(203, Green);
    Assert.AreEqual<Byte>(203, Blue);
    Assert.AreEqual<Byte>(255, Alpha);
  end;
end;

initialization

TDUnitX.RegisterTestFixture(TColorGreyscaleTest);

end.
