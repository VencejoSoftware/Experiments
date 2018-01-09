unit ooStyledText;

interface

uses
  ooFontStyle,
  ooDisplayable;

type
  IStyledText = interface(IDisplayable)
    ['{AA1FC99E-829A-4ADC-8352-D78A7F27908B}']
    function Text: String;
    function Font: IFontStyle;
    procedure ChangeFont(const Font: IFontStyle);
  end;

  TStyledText = class sealed(TInterfacedObject, IStyledText, IDisplayable)
  strict private
    _Text: String;
    _Font: IFontStyle;
    _Visible: Boolean;
  public
    function Text: String;
    function Font: IFontStyle;
    function IsVisible: Boolean;
    procedure Show;
    procedure Hide;
    procedure ChangeFont(const Font: IFontStyle);
    constructor Create(const Text: String);
    class function New(const Text: String): IStyledText;
  end;

implementation

procedure TStyledText.Hide;
begin
  _Visible := False;
end;

procedure TStyledText.Show;
begin
  _Visible := True;
end;

function TStyledText.IsVisible: Boolean;
begin
  Result := _Visible;
end;

function TStyledText.Text: String;
begin
  Result := _Text;
end;

function TStyledText.Font: IFontStyle;
begin
  Result := _Font;
end;

procedure TStyledText.ChangeFont(const Font: IFontStyle);
begin
  _Font := Font;
end;

constructor TStyledText.Create(const Text: String);
begin
  _Text := Text;
  Show;
end;

class function TStyledText.New(const Text: String): IStyledText;
begin
  Result := TStyledText.Create(Text);
end;

end.
