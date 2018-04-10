{$apptype windows}
{$reference 'System.Windows.Forms.dll'}
{$reference 'System.Drawing.dll'}
{$reference 'PresentationCore.dll'}
var menu := new System.Media.soundPlayer('menu-sound.wav');
var Game := new System.Media.soundPlayer('Game-Sound.wav');
var f:file of boolean;
var s,sOld:boolean;

{Procedure Repeat;
begin

end;}
begin

  Assign(f,'open');
 menu.PlayLooping;
 sOld:=False;
 while (FileExists('open')) do
 begin
 if not(FileExists('Write')) then
 begin
 Try
 begin
 Reset(f);
 read(f,S);
 Close(f);
 
 if S<>sOld then
begin
//writeln(S);
sOld:=s;
if s then Game.PlayLooping else
menu.PlayLooping;
end;
 end;
 except
 sleep(10);
 end;
 
 
 end else
 Halt();
 sleep(10);
 end;
 
 Halt();
 System.Windows.Forms.Application.Run();
  
  
end.