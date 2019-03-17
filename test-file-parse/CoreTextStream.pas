unit CoreTextStream;
{$O+}

interface

uses
  Classes, SysUtils;

type
  TTextStreamX = class
  private
    objStream: TStream;
    iOffset: Integer;
    iSize: Integer;
    arrBuffer: array [0 .. 1023] of AnsiChar;
    bEOF: Boolean;
    function FillBuffer: Boolean;
  public
    function ReadLn: AnsiString; overload;
    function ReadLn(var prmLine: AnsiString): Boolean; overload;
    constructor Create(prmStream: TStream);
  published
    property EOF: Boolean read bEOF;
    property Stream: TStream read objStream;
    property Offset: Integer read iOffset write iOffset;
  end;

implementation

function TTextStreamX.ReadLn(var prmLine: AnsiString): Boolean;
var
  iLen, iStart: Integer;
  chrEOL: AnsiChar;
begin
  prmLine := EmptyStr;
  Result := False;
  repeat
    if (iOffset >= iSize) then
    begin
      if not FillBuffer then
      begin
        Exit; // no more prmLine to read from stream -> exit
      end;
    end;
    Result := True;
    iStart := iOffset;
    while (iOffset < iSize) and (not (arrBuffer[iOffset] in [#13, #10])) do
    begin
      Inc(iOffset);
    end;
    iLen := (iOffset - iStart);
    if (iLen > 0) then
    begin
      SetLength(prmLine, Length(prmLine) + iLen);
      Move(arrBuffer[iStart], prmLine[Succ(Length(prmLine) - iLen)], iLen);
    end
    else
    begin
      prmLine := EmptyStr;
    end;
  until (iOffset <> iSize); // EOL char found
  chrEOL := arrBuffer[iOffset];
  Inc(iOffset);
  if (iOffset = iSize) then
  begin
    if not FillBuffer then
    begin
      Exit;
    end;
  end;
  if arrBuffer[iOffset] in ([#13, #10] - [chrEOL]) then
  begin
    Inc(iOffset);
    if (iOffset = iSize) then
      FillBuffer;
  end;
end;

function TTextStreamX.ReadLn: AnsiString;
begin
  ReadLn(Result);
end;

function TTextStreamX.FillBuffer: Boolean;
begin
  iOffset := 0;
  iSize := objStream.Read(arrBuffer, SizeOf(arrBuffer));
  Result := iSize > 0;
  bEOF := Result;
end;

constructor TTextStreamX.Create(prmStream: TStream);
begin
  objStream := prmStream;
  FillBuffer;
end;

end.
