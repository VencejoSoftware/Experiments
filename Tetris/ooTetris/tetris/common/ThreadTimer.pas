unit ThreadTimer;

interface

uses
  Windows, SysUtils, Classes;

const
  DEFAULT_INTERVAL = 1000;

type
  // Thread timer component
  TThreadTimer = class(TObject)
  strict private
  type
    TTimerThreadX = class(TThread)
    private
      objOwner: TThreadTimer;
      iInterval: Cardinal;
      hwndStop: THandle;
    protected
      procedure Execute; override;
    end;
  private
    objTimerThread: TTimerThreadX;
    bEnabled: Boolean;
    bAllowZero: Boolean;
    evOnTimer: TNotifyEvent;
    function GetInterval: Cardinal;
    function GetThreadPriority: TThreadPriority;
    procedure SetEnabled(const prmEnabled: Boolean);
    procedure SetInterval(const prmInterval: Cardinal);
    procedure SetThreadPriority(const prmPriority: TThreadPriority);
  protected
    procedure DoTimer;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property AllowZero: Boolean read bAllowZero write bAllowZero default False;
    property Enabled: Boolean read bEnabled write SetEnabled default False;
    property Interval: Cardinal read GetInterval write SetInterval default DEFAULT_INTERVAL;
    property ThreadPriority: TThreadPriority read GetThreadPriority write SetThreadPriority default tpNormal;
    property OnTimer: TNotifyEvent read evOnTimer write evOnTimer;
  end;

implementation

procedure TThreadTimer.TTimerThreadX.Execute;
begin
  repeat
    if (Windows.WaitForSingleObject(hwndStop, iInterval) = WAIT_TIMEOUT) then
    begin
      Synchronize(objOwner.DoTimer);
    end;
  until Terminated;
end;

procedure TThreadTimer.SetEnabled(const prmEnabled: Boolean);
begin
  if (prmEnabled = bEnabled) then
    Exit;
  bEnabled := prmEnabled;
  if bEnabled then
  begin
    if (objTimerThread.iInterval > 0) or
       ((objTimerThread.iInterval = 0) and bAllowZero) then
    begin
      Windows.SetEvent(objTimerThread.hwndStop);
      objTimerThread.Resume;
    end;
  end
  else
    objTimerThread.Suspend;
end;

function TThreadTimer.GetInterval: Cardinal;
begin
  Result := objTimerThread.iInterval;
end;

procedure TThreadTimer.SetInterval(const prmInterval: Cardinal);
var
  bPrevEnabled: Boolean;
begin
  if (prmInterval = objTimerThread.iInterval) then
    Exit;
  bPrevEnabled := bEnabled;
  Enabled := False;
  objTimerThread.iInterval := prmInterval;
  Enabled := bPrevEnabled;
end;

function TThreadTimer.GetThreadPriority: TThreadPriority;
begin
  Result := objTimerThread.Priority;
end;

procedure TThreadTimer.SetThreadPriority(const prmPriority: TThreadPriority);
begin
  objTimerThread.Priority := prmPriority;
end;

procedure TThreadTimer.DoTimer;
begin
  if bEnabled and Assigned(evOnTimer) then
    try
      evOnTimer(Self);
    except
    end;
end;

constructor TThreadTimer.Create;
begin
  inherited Create;
  objTimerThread := TTimerThreadX.Create(True);
  with objTimerThread do
  begin
    objOwner := Self;
    iInterval := DEFAULT_INTERVAL;
    Priority := tpNormal;
    // Event is completely manipulated by TThreadTimer object
    hwndStop := Windows.CreateEvent(nil, False, False, nil);
  end;
end;

destructor TThreadTimer.Destroy;
begin
  with objTimerThread do
  begin
    bEnabled := False;
    Terminate;
    // When this method is called we must be confident that the event handle was not closed
    Windows.SetEvent(hwndStop);
    if Suspended then
      Resume;
    WaitFor;
    // Close event handle in the primary thread
    Windows.CloseHandle(hwndStop);
  end;
  FreeAndNil(objTimerThread);
  inherited Destroy;
end;

end.
