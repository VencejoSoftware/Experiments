unit Unit1;

interface

uses
  Classes, SysUtils, Graphics, Controls, Forms, StdCtrls, Types, Grids,
  Diagnostics, TimeSpan,
  Contnrs,
  Generics.Collections;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    function TestList(const Iterations: Cardinal): Double;
    function TestListGenerics(const Iterations: Cardinal): Double;
  end;

  TFoo = class
    Name: string;
  end;

  TFooObjects = class
  private
    FList: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(Obj: TObject): TFooObjects;
    function Get(Index: Integer): TFoo;
    function Count: Integer;
  end;

  TFooObjectsGeneric = class(TObjectList<TFoo>);

var
  Form1: TForm1;

implementation

{$R *.dfm}

constructor TFooObjects.Create;
begin
  FList := TObjectList.Create(True);
end;

destructor TFooObjects.Destroy;
begin
  FList.Free;
  inherited;
end;

function TFooObjects.Add(Obj: TObject): TFooObjects;
begin
  Result := Self;
  FList.Add(Obj);
end;

function TFooObjects.Get(Index: Integer): TFoo;
begin
  Result := FList.Items[Index] as TFoo;
end;

function TFooObjects.Count: Integer;
begin
  Result := FList.Count;
end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Grid: TStringGrid;
  Text: String;
begin
  if ARow < 1 then
    Exit;
  Grid := TStringGrid(Sender);
  if (Grid.Cells[2, ARow] <> EmptyStr) then
  begin
    if StrToInt(Grid.Cells[2, ARow]) = ACol then
    begin
      Grid.Canvas.Font.Color := clBlack;
      Grid.Canvas.Font.Style := [fsBold];
    end
    else
    begin
      Grid.Canvas.Font.Color := clGray;
      Grid.Canvas.Font.Style := [];
    end;
    Grid.Canvas.FillRect(Rect);
    Text := Grid.Cells[ACol, ARow];
    Grid.Canvas.TextRect(Rect, Text, [tfLeft, tfVerticalCenter, tfSingleLine]);
  end;
end;

function TForm1.TestList(const Iterations: Cardinal): Double;
var
  F: TFoo;
  OL: TFooObjects;
  i: Cardinal;
  Name: String;
  Stopwatch: TStopwatch;
  Elapsed: TTimeSpan;
begin
  Stopwatch := TStopwatch.StartNew;
  OL := TFooObjects.Create;
  try
    for i := 0 to Iterations do
    begin
      F := TFoo.Create;
      F.Name := 'Bar' + IntToStr(i);
      OL.Add(F);
    end;
    for i := 0 to Iterations do
    begin
      F := OL.Get(i);
      Name := F.Name;
    end;
  finally
    OL.Free;
  end;
  Elapsed := Stopwatch.Elapsed;
  Result := Elapsed.TotalMilliseconds;
end;

function TForm1.TestListGenerics(const Iterations: Cardinal): Double;
var
  F: TFoo;
  OL: TFooObjectsGeneric;
  i: Cardinal;
  Name: String;
  Stopwatch: TStopwatch;
  Elapsed: TTimeSpan;
begin
  Stopwatch := TStopwatch.StartNew;
  OL := TFooObjectsGeneric.Create(True);
  try
    for i := 0 to Iterations do
    begin
      F := TFoo.Create;
      F.Name := 'Bar' + IntToStr(i);
      OL.Add(F);
    end;
    for i := 0 to Iterations do
    begin
      F := OL.Items[i];
      Name := F.Name;
    end;
  finally
    OL.Free;
  end;
  Elapsed := Stopwatch.Elapsed;
  Result := Elapsed.TotalMilliseconds;
end;

procedure TForm1.Button1Click(Sender: TObject);
const
  Iterations = 100000;
  Cycles = 40;
var
  i: Cardinal;
  Elapsed1, Elapsed2: Double;
begin
  StringGrid1.RowCount := Succ(Cycles);
  StringGrid1.ColCount := 3;
  StringGrid1.Cells[0, 0] := 'List';
  StringGrid1.Cells[1, 0] := 'ListGenerics';
  StringGrid1.ColWidths[0] := 180;
  StringGrid1.ColWidths[1] := 180;
  StringGrid1.ColWidths[2] := 0;
  for i := 1 to Succ(Cycles) do
  begin
    StringGrid1.Cells[0, i] := EmptyStr;
    StringGrid1.Cells[1, i] := EmptyStr;
    StringGrid1.Cells[2, i] := EmptyStr;
  end;
  for i := 0 to Cycles do
  begin
    Elapsed1 := TestList(Iterations);
    Elapsed2 := TestListGenerics(Iterations);
    StringGrid1.Cells[0, Succ(i)] := FloatToStr(Elapsed1);
    StringGrid1.Cells[1, Succ(i)] := FloatToStr(Elapsed2);
    if Elapsed1 < Elapsed2 then
      StringGrid1.Cells[2, Succ(i)] := '0'
    else
      StringGrid1.Cells[2, Succ(i)] := '1';
  end;
end;

end.
