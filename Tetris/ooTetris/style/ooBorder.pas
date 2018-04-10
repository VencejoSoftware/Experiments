unit ooBorder;

interface

uses
  Graphics;

type
  TBorderMode = (None, Line, Dash, Dot);

  IBorder = interface
    ['{7C2CCFD1-C1F9-46A9-B47D-297624364FCD}']
    function Color: TColor;
    function Mode: TBorderMode;
  end;

  TBorder = class sealed(TInterfacedObject, IBorder)
  strict private
    _Color: TColor;
    _Mode: TBorderMode;
  public
    function Color: TColor;
    function Mode: TBorderMode;
    constructor Create(const Color: TColor; const Mode: TBorderMode);
    class function New(const Color: TColor; const Mode: TBorderMode): IBorder;
    class function NewDefault: IBorder;
  end;

implementation

function TBorder.Color: TColor;
begin
  Result := _Color;
end;

function TBorder.Mode: TBorderMode;
begin
  Result := _Mode;
end;

constructor TBorder.Create(const Color: TColor; const Mode: TBorderMode);
begin
  _Color := Color;
  _Mode := Mode;
end;

class function TBorder.New(const Color: TColor; const Mode: TBorderMode): IBorder;
begin
  Result := TBorder.Create(Color, Mode);
end;

class function TBorder.NewDefault: IBorder;
begin
  Result := TBorder.New(clBlack, TBorderMode.Line);
end;

end.
