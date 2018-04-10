unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Panel2: TPanel;
    Label3: TLabel;
    Bevel1: TBevel;
    Panel1: TPanel;
    Image1: TImage;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

procedure TForm2.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
