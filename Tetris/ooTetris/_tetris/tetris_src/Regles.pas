unit regles;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TReglesDlg = class(TForm)
    OKBtn: TButton;
    Bevel1: TBevel;
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReglesDlg: TReglesDlg;

implementation

{$R *.DFM}

end.
