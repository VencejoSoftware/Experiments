unit ooStyle;

interface

uses
  ooBorder,
  ooFill;

type
  IStyle = interface
    ['{7C0E578C-A131-4B55-B0FB-5B0CA4ED073F}']
    function Border: IBorder;
    function Fill: IFill;
  end;

  TStyle = class sealed(TInterfacedObject, IStyle)
  strict private
    _Border: IBorder;
    _Fill: IFill;
  public
    function Border: IBorder;
    function Fill: IFill;
    constructor Create(const Border: IBorder; const Fill: IFill);
    class function New(const Border: IBorder; const Fill: IFill): IStyle;
    class function NewDefault: IStyle;
  end;

implementation

function TStyle.Fill: IFill;
begin
  Result := _Fill;
end;

function TStyle.Border: IBorder;
begin
  Result := _Border;
end;

constructor TStyle.Create(const Border: IBorder; const Fill: IFill);
begin
  _Border := Border;
  _Fill := Fill;
end;

class function TStyle.New(const Border: IBorder; const Fill: IFill): IStyle;
begin
  Result := TStyle.Create(Border, Fill);
end;

class function TStyle.NewDefault: IStyle;
begin
  Result := TStyle.New(TBorder.NewDefault, TFill.NewDefault);
end;

end.
