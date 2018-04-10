unit ooFill;

interface

uses
  Graphics;

type
  TFillMode = (None, Solid);

  IFill = interface
    ['{DCA06A5C-915A-497F-B114-FF3E4B59252B}']
    function Color: TColor;
    function Mode: TFillMode;
  end;

  TFill = class sealed(TInterfacedObject, IFill)
  strict private
    _Color: TColor;
    _Mode: TFillMode;
  public
    function Color: TColor;
    function Mode: TFillMode;
    constructor Create(const Color: TColor; const Mode: TFillMode);
    class function New(const Color: TColor; const Mode: TFillMode): IFill;
    class function NewDefault: IFill;
  end;

implementation

function TFill.Color: TColor;
begin
  Result := _Color;
end;

function TFill.Mode: TFillMode;
begin
  Result := _Mode;
end;

constructor TFill.Create(const Color: TColor; const Mode: TFillMode);
begin
  _Color := Color;
  _Mode := Mode;
end;

class function TFill.New(const Color: TColor; const Mode: TFillMode): IFill;
begin
  Result := TFill.Create(Color, Mode);
end;

class function TFill.NewDefault: IFill;
begin
  Result := TFill.New(clWhite, TFillMode.Solid);
end;

end.
