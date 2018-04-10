program Tetris;

uses
  GraphABC, GameEngine, Settings, PABCSystem;

type
  rec = array [1 .. 10] of integer;

var
  sel: Byte;
  W, H: integer;
  exi, cont, esc: boolean;
  f, f2: file of boolean;
  logo: picture;

procedure DelFile;
begin
  Rewrite(f2);
  Sleep(2);
  DeleteFile('open');
  Sleep(1);
  Close(f2);
  DeleteFile('write');
end;

procedure Escape(k: integer);
begin
  case k of
    VK_Enter:
      esc := true;
  end;
end;

procedure Records;
var
  recordFile: file of rec;
  list: rec;
begin

  ClearWindow;
  Assign(recordFile, 'record.txt');
  esc := false;
  OnKeyDown := Escape;
  try
    Reset(recordFile);
    read(recordFile, list);
    Close(recordFile);
    for var i := 1 to 10 do
    begin
      TextOut(20, 20 * i, '#');
      TextOut(27, 20 * i, IntToStr(i));
      TextOut(40, 20 * i, ': ');
      TextOut(60, 20 * i, IntToStr(list[i]));
    end;
    redraw;
    while not (esc) do
    begin
    end;
  except
    TextOut(20, 20, '���� � �������� �������� �� ������.');
    TextOut(20, 40, '������� ����� ������ ��� ������.');
    redraw;
    while not (esc) do
    begin
    end;
  end;
end;

procedure DrawMenu;
var
  i: integer;
begin
  Window.Clear;

  Brush.Color := ARGB(0, 0, 0, 0);

  DrawRectangle(20, 20, W - 20, 170);
  TextCentr(20, 20, W - 20, 170, '������-����');
  logo.Draw(20, 20, W - 20, 170);

  i := 220;
  if sel = 1 then
    SetPenColor(ClRed)
  else
    SetPenColor(ClBlack);
  DrawRectangle(20, i, W - 20, i + 60);
  if not(cont) then
    TextCentr(20, i, W - 20, i + 60, '������')
  else
    TextCentr(20, i, W - 20, i + 60, '����������');

  i + = 80;
  if sel = 2 then
    SetPenColor(ClRed)
  else
    SetPenColor(ClBlack);
  DrawRectangle(20, i, W - 20, i + 60);
  TextCentr(20, i, W - 20, i + 60, '���������');

  i + = 80;
  if sel = 3 then
    SetPenColor(ClRed)
  else
    SetPenColor(ClBlack);
  DrawRectangle(20, i, W - 20, i + 60);
  TextCentr(20, i, W - 20, i + 60, '�������');

  i + = 80;
  if sel = 4 then
    SetPenColor(ClRed)
  else
    SetPenColor(ClBlack);
  DrawRectangle(20, i, W - 20, i + 60);
  TextCentr(20, i, W - 20, i + 60, '�����');

  SetPenColor(ClBlack);
  DrawRectangle(20, H - 50, W - 20, H - 10);
  TextCentr(20, H - 50, W - 20, H - 10, '��� ����� �������� 2014(�)');

  redraw;
end;

procedure ButtonMenu(k: integer);
begin
  case k of
    VK_UP:
      if sel = 1 then
        sel := 4
      else
        Dec(sel);
    VK_Down:
      if sel = 4 then
        sel := 1
      else
        Inc(sel);
    VK_Enter:
      exi := true;
  end;
  if Sound then
    case k of
      VK_Enter:
        beepArrowEnter.play;
    else
      BeepArrow.play;
    end;
  DrawMenu;
end;

begin
  LoadSet;
  logo := picture.Create('logo.png');
  // ��������� � ���, ��� ���������� ����� �������� logo.png (���������� � ��� ������ *.p)
  logo.Load('logo.png'); // ��������� �������� �� ����� (���������� � ��� ������ *.p.Load)
  Assign(f, 'open');
  Assign(f2, 'Write');
  Rewrite(f2);
  Sleep(1);
  Rewrite(f);
  write(f, false);
  Close(f);
  Close(f2);
  DeleteFile('Write');
  OnClose := DelFile;
  try
    if Sound then
      Exec(GetDir + '\Music.exe');
  except
    begin
      writeln('��������� ������ ���������. �������������� ���������. ��������� ��������� ������ ����� 5 ��� ');
      Sleep(5000);
    end;
  end;
  LoadSet;
  PrimarySet;

  W := WindowWidth;  // ������ ������ ��� �
  H := WindowHeight; // ������ ������ ��� �
  repeat
    ;
    Rewrite(f2);
    Sleep(3);
    Rewrite(f);
    write(f, false);
    Close(f);
    Close(f2);
    DeleteFile('Write');
    OnKeyDown := ButtonMenu;
    sel := 1;
    exi := false;
    DrawMenu;
    while(not(exi)) do
    begin
      // ClearWindow;
      // DrawMenu;
      // Redraw;
      // sleep(10);
    end;
    OnKeyDown := nil;
    case sel of
      1:
        begin
          try
            Rewrite(f);
          except
            Sleep(10);
          end;
          write(f, true);
          Close(f);
          Sleep(10);
          Rewrite(f2);
          Sleep(4);

          Close(f2);
          DeleteFile('Write');
          Exec(GetDir + '\Music.exe');
          GameStart(cont);// ������
        end;
      2:
        OpenSettings;// ���������
      3:
        begin
          AllKeyNil;
          Sleep(5);
          Records;// �������
        end;
      4:
        begin
          DelFile;
          Halt();
          closeWindow;// �����
        end;
    end;
    if Sound then
      beepArrowEnter.play;
  until not(true);

end.
