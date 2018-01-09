unit ooStyle;

interface

uses
  ooFill,
  ooBorder;

type
  IStyle = interface
    ['{E803904F-F536-41AB-94A3-F604CFB88E5E}']
    function Fill: IFill;
    function Border: IBorder;
  end;

  TStyle = class sealed(TInterfacedObject, IStyle)
  strict private
    _Fill: IFill;
    _Border: IBorder;
  public
    function Fill: IFill;
    function Border: IBorder;
    constructor Create(const Fill: IFill; const Border: IBorder);
    class function New(const Fill: IFill; const Border: IBorder): IStyle;
  end;

implementation

function TStyle.Border: IBorder;
begin
  Result := _Border;
end;

function TStyle.Fill: IFill;
begin
  Result := _Fill;
end;

constructor TStyle.Create(const Fill: IFill; const Border: IBorder);
begin
  _Fill := Fill;
  _Border := Border;
end;

class function TStyle.New(const Fill: IFill; const Border: IBorder): IStyle;
begin
  Result := TStyle.Create(Fill, Border);
end;

end.
