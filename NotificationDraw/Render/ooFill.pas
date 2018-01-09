unit ooFill;

interface

uses
  ooColor;

type
  TFillMode = (None, Solid);

  IFill = interface
    ['{7EBFEDE7-25D7-401E-908A-31F688EDAC31}']
    function Mode: TFillMode;
    function Color: IColor;
  end;

  TFill = class sealed(TInterfacedObject, IFill)
  strict private
    _Mode: TFillMode;
    _Color: IColor;
  public
    function Mode: TFillMode;
    function Color: IColor;
    constructor Create(const Color: IColor; const Mode: TFillMode);
    class function New(const Color: IColor; const Mode: TFillMode): IFill;
  end;

implementation

function TFill.Mode: TFillMode;
begin
  Result := _Mode;
end;

function TFill.Color: IColor;
begin
  Result := _Color;
end;

constructor TFill.Create(const Color: IColor; const Mode: TFillMode);
begin
  _Color := Color;
  _Mode := Mode;
end;

class function TFill.New(const Color: IColor; const Mode: TFillMode): IFill;
begin
  Result := TFill.Create(Color, Mode);
end;

end.
