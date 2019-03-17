unit Unit2;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  StrUtils,
  CoreTimeLapse,
  CoreTextStream;

type
  TRecordLineX = record
    RowType: String[1];
    Code: String[11];
    Value: Extended;
  end;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    strFileName: String;
    objLapse: TLapsedTimeX;
    procedure TestTTextStreamX;
    procedure TestTextFile;
  end;

var
  Form2: TForm2;

{$R *.dfm}

implementation

type
  TStringArray = array of AnsiString;

function SplitStr(const prmString: AnsiString; const prmSeparator: AnsiChar; var prmArray: TStringArray): Boolean;
var
  strSource: AnsiString;
  iOldPos, iPos: Integer;
  iCount: Integer;
begin
  Result := False;
  if (prmString = '') then
    Exit;
  strSource := prmString;
  iOldPos := 1;
  iCount := 0;
  if RightStr(strSource, 1) <> prmSeparator then
  begin
    strSource := strSource + prmSeparator;
  end;
  repeat
    iPos := PosEx(prmSeparator, strSource, iOldPos);
    if (iPos = 0) then
      Break;
    Inc(iCount);
    SetLength(prmArray, iCount);
    prmArray[iCount - 1] := Copy(strSource, iOldPos, (iPos - iOldPos));
    iOldPos := (iPos + 1);
    Result := True;
  until (iPos = 0);
end;

function StrToRecordLine(const prmLine: AnsiString): TRecordLineX;
var
  arrSplited: TStringArray;
  strValue: AnsiString;
begin
  try
    if SplitStr(prmLine, ',', arrSplited) then
    begin
      Result.RowType := arrSplited[0];
      Result.Code := arrSplited[1];
      strValue := arrSplited[2];
      strValue := StringReplace(strValue, ',', FormatSettings.DecimalSeparator, []);
      strValue := StringReplace(strValue, '.', FormatSettings.DecimalSeparator, []);
      Result.Value := StrToFloat(strValue);
    end;
  except
    ShowMessage('error: ' + prmLine);
  end;
  arrSplited := nil;
end;

function RandomText(PLen: Integer): AnsiString;
const
  str = '0123456789';
begin
  Randomize;
  Result := '';
  repeat
    Result := Result + str[Random(Length(str)) + 1];
  until (Length(Result) = PLen);
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  objFileStream: TFileStream;
  strLine: AnsiString;
  i: Integer;
begin
  objLapse.StartCounterTime;
  objFileStream := TFileStream.Create(strFileName, fmCreate);
  try
    for i := 0 to 500000 do
    begin
      strLine := RandomText(1) + ', ' + RandomText(10) + ', ' + RandomText(1) + '.' + RandomText(3) + sLineBreak;
      objFileStream.WriteBuffer(Pointer(strLine)^, (Length(strLine) * SizeOf(AnsiChar)));
    end;
  finally
    FreeAndNil(objFileStream);
  end;
  objLapse.StopCounterTime;
  Caption := objLapse.GetTimeLapseAsString;
end;

procedure TForm2.TestTTextStreamX;
var
  iPosLine: Integer;
  strLine: AnsiString;
  utpRecord: TRecordLineX;
  objStreamTmp: TFileStream;
  objFile: TTextStreamX;
begin
  objLapse.StartCounterTime;
  objStreamTmp := TFileStream.Create(strFileName, fmOpenRead or fmShareDenyWrite);
  objFile := TTextStreamX.Create(objStreamTmp);
  iPosLine := 0;
  Memo1.Lines.BeginUpdate;
  try
    try
      while objFile.ReadLn(strLine) do
      begin
        utpRecord := StrToRecordLine(strLine);
        Inc(iPosLine);
        if iPosLine mod 10000 = 2 then
          Caption := IntToStr(iPosLine);
        Memo1.Lines.Append(strLine);
      end;
    finally
      FreeAndNil(objFile);
      FreeAndNil(objStreamTmp);
    end;
  finally
    Memo1.Lines.EndUpdate;
  end;
  objLapse.StopCounterTime;
  Memo1.Lines.Append('TTextStreamX read: ' + objLapse.GetTimeLapseAsString);
end;

procedure TForm2.TestTextFile;
var
  iPosLine: Integer;
  strLine: String;
  utpRecord: TRecordLineX;
  objFile: TextFile;
begin
  objLapse.StartCounterTime;
  AssignFile(objFile, strFileName);
  iPosLine := 0;
  Reset(objFile);
  while not EOF(objFile) do
  begin
    ReadLn(objFile, strLine);
    utpRecord := StrToRecordLine(strLine);
    Inc(iPosLine);
    Memo1.Lines.Append(strLine);
  end;
  CloseFile(objFile);
  objLapse.StopCounterTime;
  Memo1.Lines.Append('TestTextFile read: ' + objLapse.GetTimeLapseAsString);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  TestTTextStreamX;
  Memo1.Lines.Append('-------------------------------------------');
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  strFileName := ExtractFilePath(Application.ExeName) + 'data.txt';
  objLapse := TLapsedTimeX.Create;
  Memo1.Clear;
end;

end.
