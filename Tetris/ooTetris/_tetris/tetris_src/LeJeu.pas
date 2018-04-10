unit LeJeu;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TLeJeuDlg = class(TForm)
    OKBtn: TButton;
    Bevel1: TBevel;
    Memo1: TMemo;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LeJeuDlg: TLeJeuDlg;

implementation

{$R *.DFM}

procedure TLeJeuDlg.OKBtnClick(Sender: TObject);
          begin
               Close;
          end;

end.
