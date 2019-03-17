unit CoreTimeLapse;

interface

uses
  Windows, SysUtils;

type
  TLapsedTimeX = class
  private
    dblFrequency: Double;
    iTime1: Int64;
    iTime2: Int64;
    dblMilliseconds: Extended;
    dblMicroseconds: Extended;
    dtTotalTime: TDateTime;
  private
    procedure CalculateCounterTime;
    procedure GetCPUTicks(var prmCount: Int64);
    procedure GetCPUclock;
  public
    function GetTimeLapseAsString: String;
    procedure StartCounterTime;
    procedure StopCounterTime;
    constructor Create;
  published
    property TotalTime: TDateTime read dtTotalTime;
    property Microseconds: Extended read dblMicroseconds;
  end;

implementation

procedure TLapsedTimeX.GetCPUTicks(var prmCount: Int64);
begin
  asm
    MOV ECX,prmCount;
    RDTSC;          // lower 32 bits --> EAX, upper 32 bits ---> EDX // RDTSC = DB $0F,$31
    MOV [ECX],EAX;
    ADD ECX,4;
    MOV [ECX],EDX;
  end;
end;

procedure TLapsedTimeX.GetCPUclock;
var
  iSysTick1, iSysTick2: Cardinal; // System clock ticks
  iCPUTick1, iCPUTick2: Int64; // CPU clock ticks
begin
  iSysTick1 := Windows.GetTickCount; // Get milliseconds clock
  while GetTickCount = iSysTick1 do; // Sync with start of 1 millisec interval
  GetCPUTicks(iCPUTick1); // Get CPU clock count
  iSysTick1 := GetTickCount;
  repeat
    GetCPUTicks(iCPUTick2); // Get CPU clock count
    iSysTick2 := GetTickCount;
  until (iSysTick2 - iSysTick1 >= 500);
  dblFrequency := (iCPUTick2 - iCPUTick1) / ((iSysTick2 - iSysTick1) * 1E3); // Set CPU clock in microsecs
end;

procedure TLapsedTimeX.StartCounterTime;
begin
  GetCPUTicks(iTime1);
end;

procedure TLapsedTimeX.StopCounterTime;
begin
  GetCPUTicks(iTime2);
end;

procedure TLapsedTimeX.CalculateCounterTime;
const
  SEC_PER_DAY = 86400;
  MS_CONVERT = 1000;
  MS_PER_DAY = (SEC_PER_DAY * MS_CONVERT);
begin
  dblMicroseconds := (iTime2 - iTime1) / dblFrequency;
  dblMilliseconds := dblMicroseconds / MS_CONVERT;
  dtTotalTime := dblMilliseconds / MS_PER_DAY;
// DecodeTime(dtTotalTime, iHours, iMinutes, iSeconds, iMsTemp);
end;

function TLapsedTimeX.GetTimeLapseAsString: String;
begin
  CalculateCounterTime;
  Result := FormatDateTime('hh:nn:ss,zzz', dtTotalTime) + FormatFloat('.###########', Frac(dblMilliseconds));
end;

constructor TLapsedTimeX.Create;
begin
  GetCPUclock;
end;

end.
