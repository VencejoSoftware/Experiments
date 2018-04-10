unit GameEngine;

interface

uses
  GraphABC, Timers, Settings;

procedure GameStart(var conts: boolean);

implementation

const
  allFigure = 7;

type
  mas = array [0 .. 28, 1 .. 20] of byte;

  block = record
    types: byte;
    Rotate: byte;
    cor: array [1 .. 4, 1 .. 2] of byte;
  end;

  rec = array [1 .. 10] of integer;

var
  exi, Cont, FirstStart, GameOver: boolean;
  W, H, msec, sec, score, ins, n: integer;
  m: mas;
  bl: block;
  NextBlock: byte;
GameOverMusic := new System.Media.soundPlayer('GameOver.wav');
move := new System.Media.soundPlayer('move_brick.wav');
DeBl := new System.Media.soundPlayer('delete.wav');

procedure RecordWrite;
var
  temp1, temp2: integer;
  recordFile: file of rec;
  list: rec;
begin
  Assign(recordFile, 'record.txt');
  try
    Reset(recordFile);
    read(recordFile, list);
    for var i := 1 to 10 do
      if (list[i]< score) then
      begin
        temp1 := list[i];
        list[i]:= score;
        for var j := i + 1 to 10 do
        begin
          temp2 := list[j];
          list[j]:= temp1;
          temp1 := temp2;
        end;
        break;
      end;
    Rewrite(recordFile);
    write(recordFile, list);
  except
    Rewrite(recordFile);
    list[1]:= score;
    for var i := 2 to 10 do
      list[i]:= 0;
    write(recordFile, list);
  end;
  Close(recordFile);
end;

procedure Elements;
var
  i, i2: integer;
begin
  Brush.Color := ARGB(0, 0, 0, 0);
  DrawRectangle(20, 5, W - 20, 70);
  DrawRectangle(20, 80, W - 20, H - 16);// Игровое поле 20,80  380,584
  TextOut(21, 6, 'Время:' + IntToStr(sec));
  TextOut(21, 25, 'Очки:' + IntToStr(score));
  TextOut(200, 6, 'Следующий блок:');
  // Начало отричовки блока
  case NextBlock of
    1:
      begin
        Brush.Color := ClBlack;
        FillRectangle(200, 25, 200 + 18, 25 + 18);
        FillRectangle(219, 25, 219 + 18, 25 + 18);
        FillRectangle(200, 44, 200 + 18, 44 + 18);
        FillRectangle(219, 44, 219 + 18, 44 + 18);
      end;
    2:
      begin
        Brush.Color := ClRed;
        for i := 0 to 3 do
          FillRectangle(200 +(i * 18)+ 1, 25, 200 +(i * 18)+ 18, 25 + 18);
      end;
    3:
      begin
        Brush.Color := ClYellow;
        FillRectangle(200, 25, 200 + 18, 25 + 18);
        FillRectangle(200, 44, 200 + 18, 44 + 18);
        FillRectangle(219, 44, 219 + 18, 44 + 18);
        FillRectangle(238, 44, 238 + 18, 44 + 18);
      end;
    4:
      begin
        Brush.Color := ClGreen;
        FillRectangle(200, 25, 200 + 18, 25 + 18);
        FillRectangle(219, 25, 219 + 18, 25 + 18);
        FillRectangle(219, 44, 219 + 18, 44 + 18);
        FillRectangle(238, 44, 238 + 18, 44 + 18);
      end;
    5:
      begin
        Brush.Color := ClBlue;
        FillRectangle(219, 25, 219 + 18, 25 + 18);
        FillRectangle(238, 25, 238 + 18, 25 + 18);
        FillRectangle(219, 44, 219 + 18, 44 + 18);
        FillRectangle(200, 44, 200 + 18, 44 + 18);
      end;
    6:
      begin
        Brush.Color := ClPink;
        FillRectangle(219, 25, 219 + 18, 25 + 18);
        FillRectangle(219, 44, 219 + 18, 44 + 18);
        FillRectangle(200, 44, 200 + 18, 44 + 18);
        FillRectangle(238, 44, 238 + 18, 44 + 18);
      end;
    7:
      begin
        Brush.Color := ClOrange;
        FillRectangle(200, 44, 200 + 18, 44 + 18);
        FillRectangle(219, 44, 219 + 18, 44 + 18);
        FillRectangle(238, 44, 238 + 18, 44 + 18);
        FillRectangle(238, 25, 238 + 18, 25 + 18);
      end;

  end;
  // Конец отрисовки блока
  i := 80;
  i2 := 20;
  SetPenColor(ARGB(128, 0, 0, 0));
  SetPenStyle(psDash);
  while i < 584 do
  begin
    line(20, i, W - 21, i);
    if i2 < 380 then
      line(i2, 80, i2, H - 17);
    i + = 18;
    i2 + = 18;
  end;
  SetPenStyle(psSolid);
  SetPenColor(ClBlack);
end;

procedure DelOld;
var
  i: integer;
begin
  for i := 1 to 4 do
    m[bl.cor[i, 1], bl.cor[i, 2]]:= 0;
end;

procedure DrawNew;
var
  i: integer;
begin
  for i := 1 to 4 do
    m[bl.cor[i, 1], bl.cor[i, 2]]:= bl.types;
end;

procedure Clear;
var
  i, i2, l, l2, temp: integer;
  b: boolean;
  function Po(i: integer): boolean;
  var
    b: boolean;
  begin
    b := false;
    for var z := 1 to 4 do
      if (bl.cor[z, 1]= i) then
        b := true;
    Result := b;
  end;

begin
  repeat
    ;
    b := false;
    for i := 28 downto 1 do
      if not(Po(i)) then
      begin
        // B:=False;
        temp := 0;

        for i2 := 1 to 20 do
          if m[i, i2]= 0 then
            temp + = 1;
        // B:=true;

        if temp = 0 then
        begin
          DelOld;
          for l := i downto 2 do
            for l2 := 1 to 20 do
              // for poi:=1 to 4 do
              // if (bl.cor[poi,1]<>l) then
              m[l, l2]:= m[l - 1, l2];
          score + = 20;
          DeBl.play;
          DrawNew;
        end;
        if temp = 0 then
        begin
          b := true;
          break;
        end;
      end;
  until not b;
end;

procedure DrawBlock;
var
  i: integer;

  function Free: boolean;
  var
    i: integer;
  begin
    Result := true;
    for i := 1 to 4 do
      if bl.cor[i, 1]= 28 then
        Result := false
      else
         if m[bl.cor[i, 1]+ 1, bl.cor[i, 2]]<> 0 then
        Result := false;
  end;

begin
  if Cont then
  begin // Если есть созданный блок, то перемещаем его
    DelOld;
    if Free then
      for i := 1 to 4 do
        Inc(bl.cor[i, 1])
    else
    begin
      Cont := false;
      score + = 4;
    end;

  end else
  begin // Если нет текущего блока, то создаем его
    Cont := true;
    bl.Rotate := 1;
    case NextBlock of
      1:
        begin
          bl.types := 1;
          bl.cor[1, 1]:= 1;
          bl.cor[1, 2]:= 10;
          bl.cor[2, 1]:= 1;
          bl.cor[2, 2]:= 11;
          bl.cor[3, 1]:= 2;
          bl.cor[3, 2]:= 10;
          bl.cor[4, 1]:= 2;
          bl.cor[4, 2]:= 11;
        end;
      2:
        begin
          bl.types := 2;
          bl.cor[1, 1]:= 1;
          bl.cor[1, 2]:= 9;
          bl.cor[2, 1]:= 1;
          bl.cor[2, 2]:= 10;
          bl.cor[3, 1]:= 1;
          bl.cor[3, 2]:= 11;
          bl.cor[4, 1]:= 1;
          bl.cor[4, 2]:= 12;
        end;
      3:
        begin
          bl.types := 3;
          bl.cor[1, 1]:= 1;
          bl.cor[1, 2]:= 9;
          bl.cor[2, 1]:= 2;
          bl.cor[2, 2]:= 9;
          bl.cor[3, 1]:= 2;
          bl.cor[3, 2]:= 10;
          bl.cor[4, 1]:= 2;
          bl.cor[4, 2]:= 11;
        end;
      4:
        begin
          bl.types := 4;
          bl.cor[1, 1]:= 1;
          bl.cor[1, 2]:= 10;
          bl.cor[2, 1]:= 1;
          bl.cor[2, 2]:= 11;
          bl.cor[3, 1]:= 2;
          bl.cor[3, 2]:= 11;
          bl.cor[4, 1]:= 2;
          bl.cor[4, 2]:= 12;
        end;
      5:
        begin
          bl.types := 5;
          bl.cor[1, 1]:= 1;
          bl.cor[1, 2]:= 11;
          bl.cor[2, 1]:= 1;
          bl.cor[2, 2]:= 12;
          bl.cor[3, 1]:= 2;
          bl.cor[3, 2]:= 10;
          bl.cor[4, 1]:= 2;
          bl.cor[4, 2]:= 11;
        end;
      6:
        begin
          bl.types := 6;
          bl.cor[1, 1]:= 1;
          bl.cor[1, 2]:= 11;
          bl.cor[2, 1]:= 2;
          bl.cor[2, 2]:= 10;
          bl.cor[3, 1]:= 2;
          bl.cor[3, 2]:= 11;
          bl.cor[4, 1]:= 2;
          bl.cor[4, 2]:= 12;
        end;
      7:
        begin
          bl.types := 7;
          bl.cor[1, 1]:= 1;
          bl.cor[1, 2]:= 11;
          bl.cor[2, 1]:= 2;
          bl.cor[2, 2]:= 9;
          bl.cor[3, 1]:= 2;
          bl.cor[3, 2]:= 10;
          bl.cor[4, 1]:= 2;
          bl.cor[4, 2]:= 11;
        end;

    end;
    if Free then
    begin
      NextBlock := Random(1, allFigure);
      Clear;
    end
    else
      GameOver := true;
  end;
  // Отрисовываем блок
  DrawNew;
end;

procedure CurrentBlock;
var
  i, i2, x, y: integer;
begin
  x := 20;
  y := 80;

  // Brush.Style:=bsHatch;
  // Brush.Hatch:=bhPercent50;

  for i := 1 to 28 do
    for i2 := 1 to 20 do
    begin
      if m[i, i2]<> 0 then
      begin
        if RCL then
          Brush.Color := CLRandom
        else
          case m[i, i2] of
            1:
              Brush.Color := ClBlack;
            2:
              Brush.Color := ClRed;
            3:
              Brush.Color := ClYellow;
            4:
              Brush.Color := ClGreen;
            5:
              Brush.Color := ClBlue;
            6:
              Brush.Color := ClPink;
            7:
              Brush.Color := ClOrange;
          end;
        FillRectangle(x + 1, y + 1, x + 18, y + 18);
      end;
      if x = 362 then
      begin
        x := 20;
        y + = 18;
      end
      else
        x + = 18;
    end;
  // SetBrushStyle(bsSolid);
  Brush.Color := ARGB(0, 0, 0, 0);

end;

procedure TimeDraw;
begin
  clearWindow;
  if msec = 9 then
  begin
    Inc(sec);
    msec := 0;
    if sec mod 30 = 0 then
      if n > 1 then
        n - = 1;
  end
  else
    Inc(msec);

  Elements;                                // Элементы интерфейса
  if not(FirstStart) and ((msec mod n = 0))// or (msec=0))
  then
    DrawBlock// Падающий блок
  else
     if sec > 0 then
    FirstStart := false;
  // CleAR;
  CurrentBlock;// текущие блоки
  redraw;
end;

procedure RotateType2;
var
  i: integer;
  b: boolean;
begin
  case bl.Rotate of
    1:
      begin
        b := true;
        if bl.cor[1, 1]<= 25 then
        begin
          for i := 1 to 3 do
            if m[bl.cor[i, 1]+ i, bl.cor[i, 2]]<> 0 then
              b := false;
        end
        else
          b := false;

        if b then
          for i := 2 to 4 do
          begin
            bl.cor[i, 1]:= bl.cor[i - 1, 1]+ 1;
            bl.cor[i, 2]:= bl.cor[1, 2];
          end;
        bl.Rotate := 2;
      end;

    2:
      begin
        b := true;
        if bl.cor[1, 2]<= 17 then
        begin
          for i := 1 to 3 do
            if m[bl.cor[i, 1], bl.cor[i, 2]+ i]<> 0 then
              b := false
        end
        else
          b := false;

        if b then
          for i := 2 to 4 do
          begin
            bl.cor[i, 2]:= bl.cor[i - 1, 2]+ 1;
            bl.cor[i, 1]:= bl.cor[1, 1];
          end;
        bl.Rotate := 1;
      end;
  end;
end;

procedure RotateType3;
var
  i: integer;
  b: boolean;
begin
  case bl.Rotate of
    1:
      begin
        b := true;
        if bl.cor[1, 1]<= 25 then
        begin
          if m[bl.cor[2, 1], bl.cor[2, 2]]= 0 then
            if m[bl.cor[3, 1], bl.cor[3, 2]]= 0 then
              if m[bl.cor[3, 1]- 1, bl.cor[3, 2]]= 0 then
                if m[bl.cor[3, 1]- 1, bl.cor[3, 2]]= 0 then
                  b := true;
        end
        else
          b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[2, 1];
          bl.cor[1, 2]:= bl.cor[2, 2];
          bl.cor[2, 1]:= bl.cor[3, 1];
          bl.cor[2, 2]:= bl.cor[3, 2];
          bl.cor[3, 1]- = 1;
          bl.cor[4, 1]:= bl.cor[3, 1]- 1;
          bl.cor[4, 2]:= bl.cor[3, 2];
          bl.Rotate := 2;
        end;
      end;

    2:
      begin
        b := true;
        if bl.cor[1, 1]>= 1 then
          if bl.cor[1, 1]<= 26 then
            if bl.cor[1, 1]<= 25 then
            begin
              for i := - 1 to 1 do
                if m[bl.cor[3, 1]+ i, bl.cor[3, 2]- 1]<> 0 then
                  b := false;
            end
            else
              b := false;
        if ((bl.cor[3, 1]< 28) and (bl.cor[3, 2]< 20)) then
        begin
          if m[bl.cor[3, 1]+ 1, bl.cor[3, 2]+ 1]<> 0 then
            b := false;
        end
        else
          b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[3, 1]+ 1;
          bl.cor[1, 2]:= bl.cor[3, 2]- 1;
          bl.cor[2, 1]:= bl.cor[3, 1]+ 1;
          bl.cor[2, 2]:= bl.cor[3, 2];
          bl.cor[3, 2]+ = 1;
          bl.cor[3, 1]+ = 1;
          bl.cor[4, 1]:= bl.cor[3, 1]+ 1;
          bl.cor[4, 2]:= bl.cor[3, 2];
          bl.Rotate := 3;
        end;
      end;

    3:
      begin
        b := true;
        if bl.cor[1, 1]<= 25 then
        begin
          for i := - 1 to 1 do
            if m[bl.cor[2, 1]+ i, bl.cor[2, 2]]<> 0 then
              b := false;
        end
        else
          b := false;
        if m[bl.cor[2, 1]- 1, bl.cor[2, 2]+ 1]<> 0 then
          b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[2, 1]+ 1;
          bl.cor[1, 2]:= bl.cor[2, 2];
          bl.cor[3, 1]- = 1;
          bl.cor[3, 2]- = 1;
          bl.cor[4, 1]- = 2;
          bl.Rotate := 4;
        end;
      end;

    4:
      begin
        b := true;
        if bl.cor[1, 2]>= 1 then
          if bl.cor[1, 1]<= 25 then
          begin
            for i := - 1 to 1 do
              if m[bl.cor[2, 1]+ i, bl.cor[2, 2]]<> 0 then
                b := false;
          end
          else
            b := false;
        if bl.cor[3, 2]> 1 then
        begin
          if m[bl.cor[3, 1], bl.cor[3, 2]- 1]<> 0 then
            b := false;
        end
        else
          b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[3, 1];
          bl.cor[1, 2]:= bl.cor[3, 2]- 1;
          bl.cor[2, 2]- = 1;
          bl.cor[3, 1]:= bl.cor[4, 1]+ 1;
          bl.cor[3, 2]:= bl.cor[4, 2]- 1;
          bl.cor[4, 1]+ = 1;
          bl.Rotate := 1;
        end;
      end;

  end;
end;

procedure RotateType4;
var
  b: boolean;
begin
  case bl.Rotate of
    1:
      begin
        b := true;
        if bl.cor[1, 1]> 1 then
          if bl.cor[2, 2]<= 19 then
          begin
            if m[bl.cor[2, 1], bl.cor[2, 2]+ 1]= 0 then
              if m[bl.cor[2, 1]- 1, bl.cor[2, 2]+ 1]= 0 then
                b := true;
          end
          else
            b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[3, 1];
          bl.cor[1, 2]:= bl.cor[3, 2];
          bl.cor[3, 1]:= bl.cor[2, 1];
          bl.cor[3, 2]:= bl.cor[2, 2]+ 1;
          bl.cor[4, 1]:= bl.cor[3, 1]- 1;
          bl.cor[4, 2]:= bl.cor[3, 2];
          bl.Rotate := 2;
        end;
      end;
    2:
      begin
        b := true;
        if bl.cor[1, 1]> 1 then
          if bl.cor[2, 2]<= 19 then
          begin
            if m[bl.cor[2, 1], bl.cor[2, 2]- 1]= 0 then
              if m[bl.cor[2, 1]- 1, bl.cor[2, 2]- 1]= 0 then
                if m[bl.cor[3, 1]+ 1, bl.cor[3, 2]]= 0 then
                  b := true;
          end
          else
            b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[2, 1];
          bl.cor[1, 2]:= bl.cor[2, 2]- 1;
          bl.cor[3, 1]:= bl.cor[2, 1]+ 1;
          bl.cor[3, 2]:= bl.cor[2, 2];
          bl.cor[4, 1]:= bl.cor[3, 1];
          bl.cor[4, 2]:= bl.cor[3, 2]+ 1;
          bl.Rotate := 1;
        end;
      end;

  end;
end;

procedure RotateType5;
var
  b: boolean;
begin
  case bl.Rotate of
    1:
      begin
        b := true;
        if bl.cor[1, 1]> 1 then
          if bl.cor[2, 2]> 1 then
            if bl.cor[2, 2]> 20 then
              if bl.cor[3, 1]< 28 then
              begin
                if m[bl.cor[2, 1], bl.cor[2, 2]- 1]= 0 then
                  if m[bl.cor[2, 1], bl.cor[2, 2]+ 1]= 0 then
                    if m[bl.cor[3, 1]+ 1, bl.cor[3, 2]]= 0 then
                      b := true;
              end
              else
                b := false;

        if b then
        begin
          bl.cor[1, 1]- = 1;
          bl.cor[2, 2]:= bl.cor[2, 2]- 1;
          bl.cor[3, 1]:= bl.cor[2, 1];
          bl.cor[3, 2]:= bl.cor[2, 2]+ 1;
          bl.cor[4, 1]:= bl.cor[3, 1]+ 1;
          bl.cor[4, 2]:= bl.cor[3, 2];
          bl.Rotate := 2;
        end;
      end;
    2:
      begin
        if bl.cor[1, 1]< 28 then
          if bl.cor[1, 2]> 5 then
            if bl.cor[1, 2]< 20 then
              if bl.cor[2, 2]<= 19 then
              begin
                if m[bl.cor[1, 1]+ 2, bl.cor[1, 2]+ 1]= 0 then
                  if m[bl.cor[1, 1]+ 2, bl.cor[1, 2]- 1]= 0 then
                    if m[bl.cor[1, 1]+ 2, bl.cor[1, 2]- 2]= 0 then
                      b := true;
              end
              else
                b := false;

        if b then
        begin
          bl.cor[1, 1]+ = 1;
          bl.cor[2, 1]:= bl.cor[1, 1];
          bl.cor[2, 2]:= bl.cor[1, 2]+ 1;
          bl.cor[3, 1]:= bl.cor[1, 1]+ 1;
          bl.cor[3, 2]:= bl.cor[1, 2];
          bl.cor[4, 1]:= bl.cor[3, 1];
          bl.cor[4, 2]:= bl.cor[3, 2]- 1;
          bl.Rotate := 1;
        end;
      end;

  end;
end;

procedure RotateType6;
var
  b: boolean;
begin
  case bl.Rotate of
    1:
      begin
        b := true;
        if bl.cor[3, 1]> 1 then
          if bl.cor[4, 1]< 28 then
            if bl.cor[4, 2]> 1 then
            begin
              if m[bl.cor[2, 1], bl.cor[2, 2]]= 0 then
                if m[bl.cor[3, 1]- 1, bl.cor[3, 2]]= 0 then
                  if m[bl.cor[4, 1]+ 1, bl.cor[4, 2]- 1]= 0 then
                    b := true;
            end
            else
              b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[2, 1];
          bl.cor[1, 2]:= bl.cor[2, 2];
          bl.cor[2, 1]:= bl.cor[3, 1]- 1;
          bl.cor[2, 2]:= bl.cor[3, 2];
          bl.cor[4, 1]:= bl.cor[4, 1]+ 1;
          bl.cor[4, 2]:= bl.cor[4, 2]- 1;
          bl.Rotate := 2;
        end;
      end;

    2:
      begin
        b := true;

        if bl.cor[3, 2]< 20 then
        begin
          if m[bl.cor[3, 1]+ 1, bl.cor[3, 2]+ 1]= 0 then
            b := true;
        end
        else
          b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[4, 1];
          bl.cor[1, 2]:= bl.cor[4, 2];
          bl.cor[2, 1]:= bl.cor[3, 1];
          bl.cor[2, 2]:= bl.cor[3, 2]- 1;
          bl.cor[4, 1]:= bl.cor[3, 1];
          bl.cor[4, 2]:= bl.cor[3, 2]+ 1;
          bl.Rotate := 3;
        end;
      end;

    3:
      begin
        b := true;
        if bl.cor[3, 1]> 1 then
        begin

          if m[bl.cor[3, 1]- 1, bl.cor[3, 2]]= 0 then
            b := true;
        end
        else
          b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[4, 1];
          bl.cor[1, 2]:= bl.cor[4, 2];
          bl.cor[2, 1]- = 1;
          bl.cor[2, 2]+ = 1;
          bl.cor[4, 1]+ = 1;
          bl.cor[4, 2]- = 1;
          bl.Rotate := 4;
        end;
      end;

    4:
      begin
        b := true;
        if bl.cor[3, 2]> 1 then
        begin

          if m[bl.cor[3, 1], bl.cor[3, 2]- 1]= 0 then
            b := true;
        end
        else
          b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[2, 1];
          bl.cor[1, 2]:= bl.cor[2, 2];
          bl.cor[2, 1]+ = 1;
          bl.cor[2, 2]- = 1;
          bl.cor[4, 1]- = 1;
          bl.cor[4, 2]+ = 1;
          bl.Rotate := 1;
        end;
      end;

  end;
end;

procedure RotateType7;
var
  b: boolean;
begin
  case bl.Rotate of
    1:
      begin
        b := true;
        if bl.cor[2, 1]> 1 then
          if bl.cor[3, 1]> 1 then
            if bl.cor[3, 1]< 28 then
            begin
              if m[bl.cor[2, 1]- 1, bl.cor[2, 2]]= 0 then
                if m[bl.cor[3, 1]- 1, bl.cor[3, 2]]= 0 then
                  if m[bl.cor[3, 1]+ 1, bl.cor[3, 2]]= 0 then
                    b := true;
            end
            else
              b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[2, 1]- 1;
          bl.cor[1, 2]:= bl.cor[2, 2];
          bl.cor[2, 1]:= bl.cor[3, 1]- 1;
          bl.cor[2, 2]:= bl.cor[3, 2];
          bl.cor[4, 1]:= bl.cor[3, 1]+ 1;
          bl.cor[4, 2]:= bl.cor[3, 2];
          bl.Rotate := 2;
        end;
      end;

    2:
      begin
        b := true;
        if bl.cor[3, 1]< 28 then
          if bl.cor[3, 2]> 1 then
            if bl.cor[3, 1]> 1 then
              if bl.cor[3, 2]< 20 then
              begin
                if m[bl.cor[3, 1]+ 1, bl.cor[3, 2]- 1]= 0 then
                  if m[bl.cor[3, 1]- 1, bl.cor[3, 2]- 1]= 0 then
                    if m[bl.cor[3, 1]+ 1, bl.cor[3, 2]+ 1]= 0 then
                      b := true;
              end
              else
                b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[3, 1]+ 1;
          bl.cor[1, 2]:= bl.cor[3, 2]- 1;
          bl.cor[2, 1]:= bl.cor[3, 1];
          bl.cor[2, 2]:= bl.cor[3, 2]- 1;
          bl.cor[4, 1]:= bl.cor[3, 1];
          bl.cor[4, 2]:= bl.cor[3, 2]+ 1;
          bl.Rotate := 3;
        end;
      end;

    3:
      begin
        b := true;
        if bl.cor[3, 1]< 28 then
          if bl.cor[3, 2]> 1 then
            if bl.cor[3, 2]< 20 then
            begin
              if m[bl.cor[3, 1]+ 1, bl.cor[3, 2]+ 1]= 0 then
                if m[bl.cor[3, 1]+ 1, bl.cor[3, 2]]= 0 then
                  if m[bl.cor[3, 1]- 1, bl.cor[3, 2]]= 0 then
                    b := true;
            end
            else
              b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[3, 1]+ 1;
          bl.cor[1, 2]:= bl.cor[3, 2]+ 1;
          bl.cor[2, 1]:= bl.cor[3, 1]+ 1;
          bl.cor[2, 2]:= bl.cor[3, 2];
          bl.cor[4, 1]:= bl.cor[3, 1]- 1;
          bl.cor[4, 2]:= bl.cor[3, 2];
          bl.Rotate := 4;
        end;
      end;

    4:
      begin
        if bl.cor[3, 1]< 28 then
          if bl.cor[3, 1]> 1 then
            if bl.cor[3, 2]> 1 then
              if bl.cor[3, 2]< 20 then
              begin
                if m[bl.cor[3, 1]- 1, bl.cor[3, 2]+ 1]= 0 then
                  if m[bl.cor[3, 1]+ 1, bl.cor[3, 2]- 1]= 0 then
                    if m[bl.cor[3, 1], bl.cor[3, 2]+ 1]= 0 then
                      b := true;
              end
              else
                b := false;

        if b then
        begin
          bl.cor[1, 1]:= bl.cor[3, 1]- 1;
          bl.cor[1, 2]:= bl.cor[3, 2]+ 1;
          bl.cor[2, 1]:= bl.cor[3, 1];
          bl.cor[2, 2]:= bl.cor[3, 2]- 1;
          bl.cor[4, 1]:= bl.cor[3, 1];
          bl.cor[4, 2]:= bl.cor[3, 2]+ 1;
          bl.Rotate := 1;
        end;
      end;

  end;
end;

procedure Rotate;
begin
  DelOld;
  case bl.types of
    2:
      RotateType2;
    3:
      RotateType3;
    4:
      RotateType4;
    5:
      RotateType5;
    6:
      RotateType6;
    7:
      RotateType7;
  end;

  DrawNew;

end;

procedure OffSet(b: boolean);// 0 - влево; 1 - Вправо
var
  i: integer;
begin
  DelOld;
  if not(b) then
  begin
    b := true;
    for i := 1 to 4 do
      if bl.cor[i, 2]= 1 then
        b := false;
    if b then
      for i := 1 to 4 do
        if m[bl.cor[i, 1], bl.cor[i, 2]- 1]<> 0 then
          b := false;

    if b then
    begin
      DelOld;
      for i := 1 to 4 do
        Dec(bl.cor[i, 2]);
    end;
  end else
  begin
    b := true;
    for i := 1 to 4 do
      if bl.cor[i, 2]= 20 then
        b := false;

    if b then
      for i := 1 to 4 do
        if m[bl.cor[i, 1], bl.cor[i, 2]+ 1]<> 0 then
          b := false;

    if b then
    begin

      for i := 1 to 4 do
        Inc(bl.cor[i, 2]);

    end;
  end;
  DrawNew;
end;

procedure ButtonGame(k: integer);
begin
  case k of
    VK_UP:
      if Cont then
        Rotate;
    VK_Down:
      if Cont then
        while (Cont) do
          DrawBlock;
    VK_Left:
      if Cont then
        OffSet(false);
    VK_Right:
      if Cont then
        OffSet(true);
    ;
    VK_ESCAPE:
      exi := true;
    // VK_Enter:
  end;
  if (Sound) then
    move.play;
  if (GameOver) and (k = VK_Enter) then
    msec := 1;
end;

procedure ClearMas;
begin
  for var i := 0 to 28 do
    for var i2 := 1 to 20 do
      m[i, i2]:= 0;
  sec := 0;
  msec := 0;
  score := 0;

end;

procedure GameOverAnim;
begin
  clearWindow;
  TextCentr(0, Round(ins - 10), W, Round(ins + 10), 'Игра закончена. Вы набрали ' + IntToStr(score)+
     ' очков за ' + IntToStr(sec) + 'сек.');
  redraw;
  ins - = 2;
  if ins < 40 then
    msec := 1;

end;

procedure GameStart(var conts: boolean);
var
t := new Timer(100, TimeDraw);
var
t2 := new Timer(100, GameOverAnim);
var
  f: file of boolean;
begin
  Randomize;
  if not conts then
  begin
    NextBlock := Random(1, allFigure);
    n := 6;
  end;
  conts := false;

  clearWindow;
  W := WindowWidth;  // Ширина Экрана или Х
  H := WindowHeight; // Высота экрана или У
  exi := false;
  FirstStart := true;
  GameOver := false;
  ins := Round(H / 2);
  t.start;
  OnKeyDown := ButtonGame;

  while(not(GameOver) and not(exi)) do
  begin
  end;
  t.Stop;
  if GameOver then
  begin
    clearWindow;
    while not(DeleteFile('open')) do
    begin
    end;

    GameOverMusic.play;
    RecordWrite;
    msec := 0;
    t2.start;
    while (msec <> 1) do
    begin
    end;
    t2.Stop;
    ClearMas;
    Assign(f, 'open');
    Rewrite(f);
    write(f, false);
    Close(f);
    if Sound then
      Exec(GetDir + '\Music.exe');
  end
  else
    conts := true;
end;

end.
