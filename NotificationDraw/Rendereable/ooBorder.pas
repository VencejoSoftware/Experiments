unit ooBorder;

interface

uses
  ooColor;

type
  TBorderMode = (None, Solid, Doted, Dashed, DashDoted);

  IBorder = interface
    ['{CA27E6EE-B0A7-4875-9B62-AC0660D9AD6A}']
    function Mode: TBorderMode;
    function Color: IColor;
  end;

  TBorder = class sealed(TInterfacedObject, IBorder)
  strict private
    _Mode: TBorderMode;
    _Color: IColor;
  public
    function Mode: TBorderMode;
    function Color: IColor;
    constructor Create(const Color: IColor; const Mode: TBorderMode);
    class function New(const Color: IColor; const Mode: TBorderMode): IBorder;
  end;

implementation

function TBorder.Mode: TBorderMode;
begin
  Result := _Mode;
end;

function TBorder.Color: IColor;
begin
  Result := _Color;
end;

constructor TBorder.Create(const Color: IColor; const Mode: TBorderMode);
begin
  _Color := Color;
  _Mode := Mode;
end;

class function TBorder.New(const Color: IColor; const Mode: TBorderMode): IBorder;
begin
  Result := TBorder.Create(Color, Mode);
end;

end.
