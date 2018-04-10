unit Unit2;

interface

uses
  Classes, Graphics, Controls, Forms, StdCtrls,
  PubSub.Content, PubSub.Subscriber, PubSub.Publisher, PubSub.send.Filter,
  LabelUpdate,
  Content.Validate;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
  private
    _Publisher: IPublisher<TEdit>;
  public
    constructor Create(Owner: TComponent; const Publisher: IPublisher<TEdit>); reintroduce;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Edit1Change(Sender: TObject);
begin
  _Publisher.send(nil, TContent<TEdit>.New(MSG_TEXT, Edit1));
end;

procedure TForm2.Edit2Change(Sender: TObject);
begin
  _Publisher.send(nil, TContent<TEdit>.New(MSG_INT, Edit2));
end;

procedure TForm2.Edit3Change(Sender: TObject);
begin
// _Publisher.send(nil, TContent<TEdit>.New(MSG_DATE, Edit3));
end;

procedure TForm2.Edit3Exit(Sender: TObject);
begin
  _Publisher.send(nil, TContent<TEdit>.New(MSG_DATE, Edit3));
end;

constructor TForm2.Create(Owner: TComponent; const Publisher: IPublisher<TEdit>);
begin
  inherited Create(Owner);
  _Publisher := Publisher;
  _Publisher.Attach('{04104543-8BB2-41D3-85C6-*}', TLabelUpdate.New(Label1));
end;

end.
