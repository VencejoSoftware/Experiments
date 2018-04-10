unit Rect.Transform;

interface

uses
  Types;

procedure ReduceRect(var aRect: TRect; const aX, aY: Integer);

implementation

procedure ReduceRect(var aRect: TRect; const aX, aY: Integer);
begin
  aRect.Left := aRect.Left + aX;
  aRect.Right := aRect.Right - aX * 2 - 1;
  aRect.Top := aRect.Top + aY;
  aRect.Bottom := aRect.Bottom - aY * 2 - 1;
end;

end.
