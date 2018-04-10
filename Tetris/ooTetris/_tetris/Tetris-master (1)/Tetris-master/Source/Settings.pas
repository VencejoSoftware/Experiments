Unit Settings;
interface
Uses GraphABC;
var Sound,RCL:boolean;
     BeepArrow := new System.Media.soundPlayer('beep_arrow.wav');
     beepArrowEnter := new System.Media.soundPlayer('beep_arrow_enter.wav');
Procedure TextCentr(x,y,x2,y2:integer; s:string);
Procedure PrimarySet;
Procedure OpenSettings;
Procedure AllKeyNil;
Procedure LoadSet;
implementation
var exi,smooth:boolean;
    sel:byte;
 procedure SaveSettings;
 var f:file of boolean;
 begin
 Assign(f,'set.dat');
 Rewrite(f);
 Write(f,Smooth,Sound,RCL);
 close(f);
 end;
Procedure TextCentr(x,y,x2,y2:integer; s:string);
begin
Try
TextOut(x+Round(((x2-x)/2)-(TextWidth(s)/2) + 0.0001),y+Round(((y2-y)/2)-(TextHeight(s)/2) + 0.0001),s); except end;
end;
Procedure AllKeyNil;
begin
OnKeyDown:=nil;
OnKeyUp:=nil;
OnKeyPress:=nil;
end;
Procedure LoadSet;
var f:File of boolean;
begin
Assign(f,'set.dat');
try
Reset(f);
Except
begin
Rewrite(f);
Write(f,True,True,False);
close(f);
Reset(f);
end;
end;
Read(f,Smooth,Sound,RCL);
close(f);
end;
Procedure PrimarySet;
begin
SetWindowCaption('Tetris');
SetWINDOWSIZE(400,600);
CenterWindow;
Window.IsFixedSize:=true;
SetSmoothing(smooth);
LockDrawing;
end;
Procedure DrawMenu;
var i,w:integer;
begin
  W := WindowWidth;   // Ширина Экрана или Х
ClearWindow;
TextCentr(0,0,400,100,'Настройки');

i:=220;
if sel=1 then 
SetPenColor(ClRed) else 
SetPenColor(ClBlack);
DrawRectangle(20,i,W-20,i+60);
TextCentr(20,i,W-20,i+60,'Сглаживание');
if smooth then
begin
Brush.Color:=(ClRed);
Circle(w-40,i+30,15);
Brush.Color := ARGB(0, 0, 0, 0);
end;

i+=80;
if sel=2 then 
SetPenColor(ClRed) else 
SetPenColor(ClBlack);
DrawRectangle(20,i,W-20,i+60);
TextCentr(20,i,W-20,i+60,'Звуки');

i+=80;
if sel=3 then 
SetPenColor(ClRed) else 
SetPenColor(ClBlack);
DrawRectangle(20,i,W-20,i+60);
TextCentr(20,i,W-20,i+60,'Случайные цвета');

if RCL then
begin
Brush.Color:=(ClRed);
Circle(w-40,i+30,15);
Brush.Color := ARGB(0, 0, 0, 0);
end;

redraw;
end;
Procedure SettingsKey(k:integer);
begin
case k of
VK_UP:if sel=1 then
        sel:=3 else
       Dec(sel);
Vk_Down:if sel=3 then
        sel:=1 else
       Inc(sel);;
VK_Escape:exi:=true;
VK_Enter:case sel of
          1:begin
          Smooth:=not(Smooth);
          PrimarySet;
          end;
          2:Sound:=not(Sound);
          3:RCL:=Not(RCL);
         end;
   
end;
if Sound then
Case k of 
VK_Enter:beepArrowEnter.play;
else
BeepArrow.Play;
end;
DrawMenu;
end;
Procedure OpenSettings;
var f,f2:File of boolean;
begin
Window.Clear;
sleep(5);
exi:=false;
sel:=1;
AllKeyNil;
OnKeyDown:=SettingsKey;
DrawMenu;
While not(Exi) do
begin
end;
While not(DeleteFile('open')) do
      begin
      end;
SaveSettings;
assign(f2,'Write');
Rewrite(f2);
close(f2);
sleep(10);
assign(f,'open');
Rewrite(f);
Write(f,false);
close(f);
DeleteFile('Write');
if sound then
Exec(GetDir+'\Music.exe');
end;
end.