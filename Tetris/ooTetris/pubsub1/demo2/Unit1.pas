unit Unit1;

interface

uses
  Classes, Graphics, Controls, Forms, StdCtrls,
  Unit2,
  PubSub.Content, PubSub.Subscriber, PubSub.Publisher, PubSub.send.Filter,
  LabelUpdate,
  Content.Validate;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _Publisher: IPublisher<TEdit>;
  public
    constructor Create(Owner: TComponent; const Publisher: IPublisher<TEdit>); reintroduce;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Edit1Change(Sender: TObject);
begin
  _Publisher.send(nil, TContent<TEdit>.New(MSG_TEXT, Edit1));
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Form2 := TForm2.Create(Application, _Publisher);
  Form2.Show;
end;

constructor TForm1.Create(Owner: TComponent; const Publisher: IPublisher<TEdit>);
begin
  inherited Create(Owner);
  _Publisher := Publisher;
  _Publisher.Attach('{04104543-8BB2-41D3-85C6-*}', TLabelUpdate.New(Label1));
end;

end.
