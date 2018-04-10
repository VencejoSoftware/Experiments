unit APropos;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAProposDlg = class(TForm)
    Panel1: TPanel;
    OKButton: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AProposDlg: TAProposDlg;

implementation

{$R *.DFM}

procedure TAProposDlg.OKButtonClick(Sender: TObject);
          begin
               close;
          end;

end.
 
