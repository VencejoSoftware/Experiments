unit ooGlyph;

interface

uses
  Classes,
  Graphics,
  ooDisplayable;

type
  IGlyph = interface(IDisplayable)
    ['{6295072E-8A7B-4195-8527-D8352FA86899}']
    function Graphic: TGraphic;
    function Size: Cardinal;
    procedure LoadFromStream(const Stream: TStream);
  end;

  TGlyph = class sealed(TInterfacedObject, IGlyph, IDisplayable)
  strict private
    _Bitmap: TBitmap;
    _Visible: Boolean;
  public
    function Graphic: TGraphic;
    function Size: Cardinal;
    function IsVisible: Boolean;
    procedure Show;
    procedure Hide;
    procedure LoadFromStream(const Stream: TStream);
    constructor Create;
    destructor Destroy; override;
    class function New: IGlyph;
  end;

implementation

procedure TGlyph.Show;
begin
  _Visible := True;
end;

procedure TGlyph.Hide;
begin
  _Visible := False;
end;

function TGlyph.IsVisible: Boolean;
begin
  Result := _Visible;
end;

function TGlyph.Size: Cardinal;
begin
  if Graphic.Width > Graphic.Height then
    Result := Graphic.Width
  else
    Result := Graphic.Height;
end;

function TGlyph.Graphic: TGraphic;
begin
  Result := _Bitmap;
end;

procedure TGlyph.LoadFromStream(const Stream: TStream);
begin
  Stream.Position := 0;
  _Bitmap.LoadFromStream(Stream);
end;

constructor TGlyph.Create;
begin
  _Bitmap := TBitmap.Create;
  _Bitmap.Transparent := True;
  Show;
end;

destructor TGlyph.Destroy;
begin
  _Bitmap.Free;
  inherited;
end;

class function TGlyph.New: IGlyph;
begin
  Result := TGlyph.Create;
end;

end.
