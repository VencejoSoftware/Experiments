unit ooFontStyle;

interface

uses
  ooColor;

type
  TFontMode = (Bold, Italic, Underline, StrikeOut);
  TFontModeSet = set of TFontMode;

  IFontStyle = interface
    ['{27795ECA-23E3-4C06-9D5A-5117B2CD41FC}']
    function Name: String;
    function Size: Byte;
    function Color: IColor;
    function Mode: TFontModeSet;
  end;

  TFontStyle = class sealed(TInterfacedObject, IFontStyle)
  strict private
    _Name: String;
    _Size: Byte;
    _Color: IColor;
    _Mode: TFontModeSet;
  public
    function Name: String;
    function Size: Byte;
    function Color: IColor;
    function Mode: TFontModeSet;
    constructor Create(const Name: String; const Size: Byte; const Color: IColor; const Mode: TFontModeSet);
    class function New(const Name: String; const Size: Byte; const Color: IColor; const Mode: TFontModeSet): IFontStyle;
  end;

implementation

function TFontStyle.Name: String;
begin
  Result := _Name;
end;

function TFontStyle.Color: IColor;
begin
  Result := _Color;
end;

function TFontStyle.Mode: TFontModeSet;
begin
  Result := _Mode;
end;

function TFontStyle.Size: Byte;
begin
  Result := _Size;
end;

constructor TFontStyle.Create(const Name: String; const Size: Byte; const Color: IColor; const Mode: TFontModeSet);
begin
  _Name := Name;
  _Size := Size;
  _Color := Color;
  _Mode := Mode;
end;

class function TFontStyle.New(const Name: String; const Size: Byte; const Color: IColor; const Mode: TFontModeSet)
  : IFontStyle;
begin
  Result := TFontStyle.Create(Name, Size, Color, Mode);
end;

end.
