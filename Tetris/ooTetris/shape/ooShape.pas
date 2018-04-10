unit ooShape;

interface

uses
  Graphics,
  ooStyle,
  ooPosition,
  ooRectSize;

type
  IShape = interface
    ['{03878BD9-9141-47D9-93B6-05ADFBAEDE84}']
    function Position: IPosition;
    function Size: IRectSize;
    function Style: IStyle;
    function IsVisible: Boolean;
    procedure Show;
    procedure Hide;
    procedure Move(const Position: IPosition);
    procedure Resize(const Size: IRectSize);
    procedure ChangeStyle(const Style: IStyle);
  end;

  TShape = class sealed(TInterfacedObject, IShape)
  strict private
    _Position: IPosition;
    _Size: IRectSize;
    _Style: IStyle;
    _Visible: Boolean;
  public
    function Position: IPosition;
    function Size: IRectSize;
    function Style: IStyle;
    function IsVisible: Boolean;
    procedure Show;
    procedure Hide;
    procedure Move(const Position: IPosition);
    procedure Resize(const Size: IRectSize);
    procedure ChangeStyle(const Style: IStyle);
    constructor Create;
    class function New: IShape;
  end;

implementation

function TShape.Position: IPosition;
begin
  if not Assigned(_Position) then
    _Position := TPosition.NewDefault;
  Result := _Position;
end;

procedure TShape.Move(const Position: IPosition);
begin
  _Position := Position;
end;

function TShape.Size: IRectSize;
begin
  if not Assigned(_Size) then
    _Size := TRectSize.NewDefault;
  Result := _Size;
end;

procedure TShape.Resize(const Size: IRectSize);
begin
  _Size := Size;
end;

function TShape.Style: IStyle;
begin
  if not Assigned(_Style) then
    _Style := TStyle.NewDefault;
  Result := _Style;
end;

procedure TShape.ChangeStyle(const Style: IStyle);
begin
  _Style := Style;
end;

procedure TShape.Show;
begin
  _Visible := True;
end;

procedure TShape.Hide;
begin
  _Visible := False;
end;

function TShape.IsVisible: Boolean;
begin
  Result := _Visible;
end;

constructor TShape.Create;
begin
  Show;
end;

class function TShape.New: IShape;
begin
  Result := TShape.Create;
end;

end.
