unit uHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmHelp = class(TForm)
    Memo1: TMemo;
  private
    { Private declarations }
  public

  end;

var
  frmHelp: TfrmHelp;

procedure ShowHelp;

implementation

{$R *.dfm}

{ TfrmHelp }


procedure ShowHelp;
begin
  frmHelp := TfrmHelp.Create(Application);

  with frmHelp do
  begin
    Left := Application.MainForm.BoundsRect.Right;
    Top := Application.MainForm.BoundsRect.Top;
    Height := Application.MainForm.Height;
    Width := 220;
    show;
  end;

end;

end.
