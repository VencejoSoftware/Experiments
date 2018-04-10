unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  PubSub.Content, PubSub.Subscriber, PubSub.Publisher, PubSub.send.Filter,
  Subscriber1, Subscriber2,
  Subscriber2.Filter;

const
  MSG1: TContentID = '{B05F679D-0603-4B97-A947-B189587F25B5}';
  MSG2: TContentID = '{C6EF7042-2646-46C1-ADAB-37F1EA6C4D2C}';

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    _Publisher: IPublisher<String>;
  public
    constructor Create(Owner: TComponent; const Publisher: IPublisher<String>); reintroduce;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  _Publisher.send(nil, TContent<String>.New(MSG1, 'Something!'));
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  _Publisher.SendWithFilter(nil, TContent<String>.New(MSG1, 'Filtered!'), TSendFilter2.New);
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  NewForm: TForm2;
begin
  NewForm := TForm2.Create(Application, _Publisher);
  _Publisher.Attach(MSG2, TSubscriber1.New(Edit2));
  NewForm.Show;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  _Publisher.send(nil, TContent<String>.New(MSG2, 'Value 2!'));
end;

constructor TForm2.Create(Owner: TComponent; const Publisher: IPublisher<String>);
begin
  inherited Create(Owner);
  _Publisher := Publisher;
  _Publisher.Attach(MSG1, TSubscriber1.New(Edit1));
  _Publisher.Attach(MSG1, TSubscriber2.New);
end;

end.
