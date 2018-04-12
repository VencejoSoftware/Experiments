unit Grid.Style;

interface

uses
  Graphics,
  Draw.Pencil, Draw.Fill;

type
  IGridStyle = interface
    ['{9EBC93CF-CEFC-4E68-B282-038530235C7C}']
    function Pencil: IPencil;
    function Fill: IFill;
    procedure ApplyPencil(const Canvas: TCanvas);
    procedure ApplyFill(const Canvas: TCanvas);
    procedure ClearPencil(const Canvas: TCanvas);
    procedure ClearFill(const Canvas: TCanvas);
  end;

  TGridStyle = class sealed(TInterfacedObject, IGridStyle)
  strict private
    _Pencil: IPencil;
    _Fill: IFill;
  public
    function Pencil: IPencil;
    function Fill: IFill;
    procedure ApplyPencil(const Canvas: TCanvas);
    procedure ApplyFill(const Canvas: TCanvas);
    procedure ClearPencil(const Canvas: TCanvas);
    procedure ClearFill(const Canvas: TCanvas);
    constructor Create(const Pencil: IPencil; const Fill: IFill);
    class function New(const Pencil: IPencil; const Fill: IFill): IGridStyle;
  end;

implementation

function TGridStyle.Pencil: IPencil;
begin
  Result := _Pencil;
end;

function TGridStyle.Fill: IFill;
begin
  Result := _Fill;
end;

procedure TGridStyle.ApplyPencil(const Canvas: TCanvas);
begin
  case _Pencil.Pattern of
    TPencilPattern.Solid:
      Canvas.Pen.Style := psSolid;
    TPencilPattern.Dash:
      Canvas.Pen.Style := psDash;
    TPencilPattern.Dot:
      Canvas.Pen.Style := psDot;
    TPencilPattern.DashDot:
      Canvas.Pen.Style := psDashDot;
    TPencilPattern.None:
      Canvas.Pen.Style := psClear;
  end;
  Canvas.Pen.Color := _Pencil.Color;
  Canvas.Pen.Width := _Pencil.Size;
end;

procedure TGridStyle.ClearPencil(const Canvas: TCanvas);
begin
  Canvas.Pen.Style := psClear;
end;

procedure TGridStyle.ApplyFill(const Canvas: TCanvas);
begin
  case _Fill.Kind of
    TFillKind.None:
      Canvas.Brush.Style := bsClear;
    TFillKind.Solid:
      begin
        Canvas.Brush.Style := bsSolid;
        Canvas.Brush.Color := _Fill.Color;
      end;
  end;
end;

procedure TGridStyle.ClearFill(const Canvas: TCanvas);
begin
  Canvas.Brush.Style := bsClear;
end;

constructor TGridStyle.Create(const Pencil: IPencil; const Fill: IFill);
begin
  _Pencil := Pencil;
  _Fill := Fill;
end;

class function TGridStyle.New(const Pencil: IPencil; const Fill: IFill): IGridStyle;
begin
  Result := TGridStyle.Create(Pencil, Fill);
end;

end.
