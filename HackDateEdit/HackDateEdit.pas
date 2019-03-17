unit HackDateEdit;

interface

uses
  Classes, SysUtils, Windows, Forms, ExtCtrls, Buttons, Graphics, Controls, StdCtrls,
  Variants, Math, Grids, DateUtils,
  Generics.Collections,
  JvJCLUtils, JvResources, JclSysUtils,
  JvExMask, JvPickDate, JvToolEdit, JvSpeedButton;

type
  TJvDateEdit = class sealed(JvToolEdit.TJvDateEdit)
  protected
    procedure HidePopup; override;
  public
    procedure ClearTextDates;
    procedure AddTextDate(const Date: TDate; const Text: String);
    function IsEmpty: Boolean;
    constructor Create(Owner: TComponent); override;
  end;

implementation

type
  TTextDate = record
    Date: TDate;
    Text: String;
  end;

  TJvCalendar = class(JvPickDate.TJvCalendar)
  protected
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
  end;

  TJvLocCalendar = class sealed(TJvCalendar)
  strict private
    _Hint: THintWindow;
  private
    function IsTextDate(const Date: TDate): Boolean;
    function DateFromColRow(const Col, Row: Longint): TDate;
    function TextDateHint(const Date: TDate): String;
  protected
    TextDates: TList<TTextDate>;
    procedure EnabledChanged; override;
    procedure ParentColorChanged; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    procedure HideHint;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
    property GridLineWidth;
    property DefaultColWidth;
    property DefaultRowHeight;
  end;

  TJvPopupCalendar = class sealed(TJvPopupWindow)
  private
    FCalendar: TJvCalendar;
    FTitleLabel: TLabel;
    FFourDigitYear: Boolean;
    FBtns: array [0 .. 3] of TJvSpeedButton;
    procedure CalendarMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PrevMonthBtnClick(Sender: TObject);
    procedure NextMonthBtnClick(Sender: TObject);
    procedure PrevYearBtnClick(Sender: TObject);
    procedure NextYearBtnClick(Sender: TObject);
    procedure CalendarChange(Sender: TObject);
    procedure TopPanelDblClick(Sender: TObject);
    procedure SetDate(Index: Integer; Value: TDateTime);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function GetValue: Variant; override;
    procedure SetValue(const Value: Variant); override;
    procedure CheckButton;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Invalidate; override;
    procedure Update; override;
    property MinDate: TDateTime index 0 { read GetDate } write SetDate;
    property MaxDate: TDateTime index 1 { read GetDate } write SetDate;
  end;

  TJvTimerSpeedButton = class(TJvSpeedButton)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AllowTimer default True;
    property Style default bsWin31;
  end;
  { TJvCalendar }

procedure TJvCalendar.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
begin
  inherited;
end;

constructor TJvLocCalendar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  _Hint := THintWindow.Create(Self);
  _Hint.Parent := Self;
  _Hint.Color := Application.HintColor;
  TextDates := TList<TTextDate>.Create;
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks];
  ControlStyle := ControlStyle + [csReplicatable];
  Ctl3D := False;
  Enabled := False;
  BorderStyle := bsNone;
  ParentColor := True;
  CalendarDate := Trunc(Now);
  UseCurrentDate := False;
  FixedColor := Self.Color;
  Options := [goFixedHorzLine];
  TabStop := False;
end;

procedure TJvLocCalendar.HideHint;
begin
  _Hint.Caption := EmptyStr;
  _Hint.ReleaseHandle;
end;

destructor TJvLocCalendar.Destroy;
begin
  HideHint;
  _Hint.Free;
  TextDates.Free;
  inherited;
end;

procedure TJvLocCalendar.ParentColorChanged;
begin
  inherited ParentColorChanged;
  if ParentColor then
    FixedColor := Self.Color;
end;

procedure TJvLocCalendar.EnabledChanged;
begin
  inherited EnabledChanged;
  if HandleAllocated and not(csDesigning in ComponentState) then
    EnableWindow(Handle, True);
end;

procedure TJvLocCalendar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style and not(WS_BORDER or WS_TABSTOP or WS_DISABLED);
end;

procedure TJvLocCalendar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
  ColRowDate: TDate;
  DateHint: String;
  CellArea, HintRect: TRect;
  Pos: TPoint;
begin
  inherited;
  Cell := MouseCoord(X, Y);
  if (Cell.X >= 0) and (Cell.Y >= 0) then
  begin
    ColRowDate := DateFromColRow(Cell.X, Cell.Y);
    DateHint := TextDateHint(ColRowDate);
    ShowHint := (DateHint = EmptyStr);
    if ShowHint then
    begin
      HideHint;
    end
    else
    begin
      Application.HideHint;
      if _Hint.Caption <> DateHint then
      begin
        CellArea := CellRect(Cell.X, Cell.Y);
        Pos := ClientToScreen(Point(CellArea.Right, CellArea.Bottom));
        HintRect := _Hint.CalcHintRect(600, DateHint, nil);
        _Hint.ActivateHint(Rect(Pos.X, Pos.Y, Pos.X + HintRect.Width, Pos.Y + HintRect.Height), DateHint);
      end;
    end;
  end;
end;

procedure TJvLocCalendar.MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
var
  Coord: TGridCoord;
begin
  Coord := MouseCoord(X, Y);
  ACol := Coord.X;
  ARow := Coord.Y;
end;

function TJvLocCalendar.TextDateHint(const Date: TDate): String;
var
  Item: TTextDate;
begin
  Result := EmptyStr;
  for Item in TextDates do
    if Trunc(Item.Date) = Date then
    begin
      if Length(Result) > 0 then
        Result := Result + sLineBreak;
      Result := Result + Item.Text;
    end;
end;

function TJvLocCalendar.IsTextDate(const Date: TDate): Boolean;
var
  Item: TTextDate;
begin
  Result := False;
  for Item in TextDates do
    if Item.Date = Date then
      Exit(True);
end;

function TJvLocCalendar.DateFromColRow(const Col, Row: Longint): TDate;
var
  D, M, Y: Word;
begin
  DecodeDate(CalendarDate, Y, M, D);
  D := StrToIntDef(CellText[Col, Row], 0);
  if D > 0 then
    Result := EncodeDate(Y, M, D)
  else
    Result := 0.0;
end;

procedure TJvLocCalendar.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  ColRowDate: TDate;
begin
  ColRowDate := DateFromColRow(ACol, ARow);
  if IsTextDate(ColRowDate) then
    Canvas.Font.Style := [fsBold];
  inherited DrawCell(ACol, ARow, ARect, AState);
  if (ColRowDate > 0) and (DayOf(ColRowDate) <= DaysPerMonth(YearOf(ColRowDate), MonthOf(ColRowDate))) then
    if ColRowDate = SysUtils.Date then
      Frame3D(Canvas, ARect, clBtnShadow, clBtnHighlight, 1);
end;

procedure FontSetDefault(AFont: TFont);
var
  NonClientMetrics: TNonClientMetrics;
begin
{$IFDEF RTL210_UP}
  NonClientMetrics.cbSize := TNonClientMetrics.SizeOf;
{$ELSE}
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
{$ENDIF RTL210_UP}
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, NonClientMetrics.cbSize, @NonClientMetrics, 0) then
    AFont.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont)
  else
  begin
    AFont.Color := clWindowText;
    AFont.Name := 'MS Sans Serif';
    AFont.Size := 8;
    AFont.Style := [];
  end;
end;

procedure CreateButtonGlyph(Glyph: TBitmap; Idx: Integer);
type
  TPointList = array [0 .. 3] of TPoint;
const
  PointsLeft: TPointList = ((X: 2; Y: 0), (X: 2; Y: 5), (X: 0; Y: 3), (X: 0; Y: 2));
  PointsRight: TPointList = ((X: 0; Y: 0), (X: 0; Y: 5), (X: 2; Y: 3), (X: 2; Y: 2));
var
  Points: TPointList;

  function OffsetPoints(const Points: TPointList; Offs: Integer): TPointList;
  var
    I: Integer;
  begin
    Result := Points;
    for I := Low(TPointList) to High(TPointList) do
      Inc(Result[I].X, Offs);
  end;

begin
  Glyph.Width := 8;
  Glyph.Height := 6;
  Glyph.PixelFormat := pf1bit;
  Glyph.Canvas.Brush.Color := clBtnFace;
  Glyph.Canvas.FillRect(Rect(0, 0, 8, 6));
  Glyph.Transparent := True;
  Glyph.Canvas.Brush.Color := clBtnText;
  Glyph.Canvas.Pen.Color := clBtnText;
  case Idx of
    0:
      begin
        Glyph.Canvas.Polygon(PointsLeft);
        Points := OffsetPoints(PointsLeft, 4);
        Glyph.Canvas.Polygon(Points);
      end;
    1:
      begin
        Points := OffsetPoints(PointsLeft, 2);
        Glyph.Canvas.Polygon(Points);
      end;
    2:
      begin
        Points := OffsetPoints(PointsRight, 3);
        Glyph.Canvas.Polygon(Points);
      end;
    3:
      begin
        Points := OffsetPoints(PointsRight, 1);
        Glyph.Canvas.Polygon(Points);
        Points := OffsetPoints(PointsRight, 5);
        Glyph.Canvas.Polygon(Points);
      end;
  end;
end;

constructor TJvTimerSpeedButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := bsWin31;
  AllowTimer := True;
  ControlStyle := ControlStyle + [csReplicatable];
end;

constructor TJvPopupCalendar.Create(AOwner: TComponent);
{$IFDEF JVCLThemesEnabled}
var
  BtnSide: Integer;
  VertOffset: Integer;
  HorzOffset: Integer;
  Control, BackPanel: TWinControl;
{$ELSE}
const
  BtnSide = 14;
  VertOffset = -1;
  HorzOffset = 1;
var
  Control, BackPanel: TWinControl;
{$ENDIF JVCLThemesEnabled}
begin
  inherited Create(AOwner);
  FFourDigitYear := IsFourDigitYear;
  Height := Max(PopupCalendarSize.Y, 120);
  Width := Max(PopupCalendarSize.X, 180);
  Color := clBtnFace;
  FontSetDefault(Font);
  if AOwner is TControl then
    ShowHint := TControl(AOwner).ShowHint
  else
    ShowHint := True;
  if csDesigning in ComponentState then
    Exit;

{$IFDEF JVCLThemesEnabled}
  if StyleServices.Enabled then
  begin
    VertOffset := 0;
    HorzOffset := 0;
    BtnSide := 16
  end
  else
  begin
    VertOffset := -1;
    HorzOffset := 1;
    BtnSide := 14;
  end;
{$ENDIF JVCLThemesEnabled}
  BackPanel := TPanel.Create(Self);
  with BackPanel as TPanel do
  begin
    Parent := Self;
    Align := alClient;
    ParentColor := True;
    ControlStyle := ControlStyle + [csReplicatable];
    BevelOuter := bvNone;
    BevelInner := bvNone;
  end;
  Control := TPanel.Create(Self);
  with Control as TPanel do
  begin
    Parent := BackPanel;
    Align := alTop;
    Width := Self.Width - 4;
    Height := 18;
    BevelOuter := bvNone;
    ParentColor := True;
    ControlStyle := ControlStyle + [csReplicatable];
  end;
  FCalendar := TJvLocCalendar.Create(Self);
  with TJvLocCalendar(FCalendar) do
  begin
    Parent := BackPanel;
    Align := alClient;
    OnChange := CalendarChange;
    OnMouseUp := CalendarMouseUp;
  end;
  FBtns[0] := TJvTimerSpeedButton.Create(Self);
  with FBtns[0] do
  begin
    Parent := Control;
    SetBounds(0 - HorzOffset, VertOffset, BtnSide, BtnSide);
    CreateButtonGlyph(Glyph, 0);
    OnClick := PrevYearBtnClick;
    Hint := RsPrevYearHint;
  end;
  FBtns[1] := TJvTimerSpeedButton.Create(Self);
  with FBtns[1] do
  begin
    Parent := Control;
    SetBounds(BtnSide - 1 - HorzOffset, VertOffset, BtnSide, BtnSide);
    CreateButtonGlyph(Glyph, 1);
    OnClick := PrevMonthBtnClick;
    Hint := RsPrevMonthHint;
  end;
  FTitleLabel := TLabel.Create(Self);
  with FTitleLabel do
  begin
    Parent := Control;
    AutoSize := False;
    Alignment := taCenter;
    SetBounds(BtnSide * 2 + 1, 1, Control.Width - 4 * BtnSide - 2, 14);
    Transparent := True;
    OnDblClick := TopPanelDblClick;
    ControlStyle := ControlStyle + [csReplicatable];
  end;
  FBtns[2] := TJvTimerSpeedButton.Create(Self);
  with FBtns[2] do
  begin
    Parent := Control;
    SetBounds(Control.Width - 2 * BtnSide + 1 + HorzOffset, VertOffset, BtnSide, BtnSide);
    CreateButtonGlyph(Glyph, 2);
    OnClick := NextMonthBtnClick;
    Hint := RsNextMonthHint;
  end;
  FBtns[3] := TJvTimerSpeedButton.Create(Self);
  with FBtns[3] do
  begin
    Parent := Control;
    SetBounds(Control.Width - BtnSide + HorzOffset, VertOffset, BtnSide, BtnSide);
    CreateButtonGlyph(Glyph, 3);
    OnClick := NextYearBtnClick;
    Hint := RsNextYearHint;
  end;
  CheckButton;
end;

procedure TJvPopupCalendar.CheckButton;
var
  AYear, AMonth, ADay: Word;
begin
  if not Assigned(FCalendar) then
    Exit;
  if TJvLocCalendar(FCalendar).MinDate = NullDate then
    for AYear := 0 to 1 do
      FBtns[AYear].Enabled := True
  else
  begin
    DecodeDate(TJvLocCalendar(FCalendar).MinDate, AYear, AMonth, ADay);
    FBtns[0].Enabled := TJvLocCalendar(FCalendar).Year > AYear;
    FBtns[1].Enabled := (TJvLocCalendar(FCalendar).Year > AYear) or
      ((TJvLocCalendar(FCalendar).Year = AYear) and (TJvLocCalendar(FCalendar).Month > AMonth));
  end;
  if TJvLocCalendar(FCalendar).MaxDate = NullDate then
    for AYear := 2 to 3 do
      FBtns[AYear].Enabled := True
  else
  begin
    DecodeDate(TJvLocCalendar(FCalendar).MaxDate, AYear, AMonth, ADay);
    FBtns[2].Enabled := (TJvLocCalendar(FCalendar).Year < AYear) or
      ((TJvLocCalendar(FCalendar).Year = AYear) and (TJvLocCalendar(FCalendar).Month < AMonth));
    FBtns[3].Enabled := TJvLocCalendar(FCalendar).Year < AYear;
  end;
end;

procedure TJvPopupCalendar.Invalidate;
begin
  CheckButton;
  inherited Invalidate;
end;

procedure TJvPopupCalendar.Update;
begin
  CheckButton;
  inherited Update;
end;

procedure TJvPopupCalendar.SetDate(Index: Integer; Value: TDateTime);
begin
  case Index of
    0:
      TJvLocCalendar(FCalendar).MinDate := Value;
    1:
      TJvLocCalendar(FCalendar).MaxDate := Value;
  end;
end;

procedure TJvPopupCalendar.CalendarMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Col, Row: Longint;
begin
  if (Button = mbLeft) and (Shift - [ssLeft] = []) then
  begin
    TJvLocCalendar(FCalendar).MouseToCell(X, Y, Col, Row);
    if (Row > 0) and (FCalendar.CellText[Col, Row] <> '') then
      CloseUp(True);
  end;
end;

procedure TJvPopupCalendar.TopPanelDblClick(Sender: TObject);
begin
  FCalendar.CalendarDate := Trunc(Now);
end;

procedure TJvPopupCalendar.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if FCalendar <> nil then
    case Key of
      VK_NEXT:
        if ssCtrl in Shift then
          FCalendar.NextYear
        else
          FCalendar.NextMonth;
      VK_PRIOR:
        if ssCtrl in Shift then
          FCalendar.PrevYear
        else
          FCalendar.PrevMonth;
      VK_RETURN:
        Click;
    else
      TJvLocCalendar(FCalendar).KeyDown(Key, Shift);
    end;
end;

procedure TJvPopupCalendar.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (FCalendar <> nil) and (Key <> #0) then
    FCalendar.KeyPress(Key);
end;

function TJvPopupCalendar.GetValue: Variant;
begin
  if csDesigning in ComponentState then
    Result := VarFromDateTime(SysUtils.Date)
  else
    Result := VarFromDateTime(FCalendar.CalendarDate);
end;

procedure TJvPopupCalendar.SetValue(const Value: Variant);
begin
  if not(csDesigning in ComponentState) then
  begin
    try
      if (Trim(ReplaceStr(VarToStr(Value), JclFormatSettings.DateSeparator, '')) = '') or VarIsNullEmpty(Value) then
        FCalendar.CalendarDate := VarToDateTime(SysUtils.Date)
      else
        FCalendar.CalendarDate := VarToDateTime(Value);
      CalendarChange(nil);
    except
      FCalendar.CalendarDate := VarToDateTime(SysUtils.Date);
    end;
  end;
end;

procedure TJvPopupCalendar.PrevYearBtnClick(Sender: TObject);
begin
  FCalendar.PrevYear;
end;

procedure TJvPopupCalendar.NextYearBtnClick(Sender: TObject);
begin
  FCalendar.NextYear;
end;

procedure TJvPopupCalendar.PrevMonthBtnClick(Sender: TObject);
begin
  FCalendar.PrevMonth;
end;

procedure TJvPopupCalendar.NextMonthBtnClick(Sender: TObject);
begin
  FCalendar.NextMonth;
end;

procedure TJvPopupCalendar.CalendarChange(Sender: TObject);
begin
  FTitleLabel.Caption := FormatDateTime('MMMM, YYYY', FCalendar.CalendarDate);
  CheckButton; // Polaris
end;

{ TJvDateEdit }

procedure TJvDateEdit.AddTextDate(const Date: TDate; const Text: String);
var
  TextDate: TTextDate;
  Calendar: TJvLocCalendar;
begin
  TextDate.Date := Date;
  TextDate.Text := Text;
  Calendar := TJvLocCalendar(TJvPopupCalendar(FPopup).FCalendar);
  Calendar.TextDates.Add(TextDate);
end;

procedure TJvDateEdit.ClearTextDates;
var
  Calendar: TJvLocCalendar;
begin
  Calendar := TJvLocCalendar(TJvPopupCalendar(FPopup).FCalendar);
  Calendar.TextDates.Clear;
end;

procedure TJvDateEdit.HidePopup;
var
  Calendar: TJvLocCalendar;
begin
  Calendar := TJvLocCalendar(TJvPopupCalendar(FPopup).FCalendar);
  Calendar.HideHint;
  inherited;
end;

function TJvDateEdit.IsEmpty: Boolean;
begin
  Result := Date = 0;
end;

constructor TJvDateEdit.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FPopup.Free;
  FPopup := TJvPopupCalendar.Create(Self);
  TJvPopupWindow(FPopup).OnCloseUp := PopupCloseUp;
end;

end.
