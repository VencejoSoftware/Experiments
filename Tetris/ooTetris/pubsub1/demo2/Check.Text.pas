unit Check.Text;

interface

uses
  SysUtils, StdCtrls, Graphics,
  PubSub.Content, PubSub.Subscriber,
  RegExpr;

type
  TCheckText = class sealed(TInterfacedObject, ISubscriber<TEdit>)
  strict private
    _Mask: String;
  public
    function ID: TSubscriberID;
    procedure ContentHandler(const Content: IContent<TEdit>; const From: ISubscriber<TEdit>);
    constructor Create(const Mask: String);
    class function New(const Mask: String): ISubscriber<TEdit>;
  end;

implementation

function TCheckText.ID: TSubscriberID;
begin
  CreateGuid(result);
end;

procedure TCheckText.ContentHandler(const Content: IContent<TEdit>; const From: ISubscriber<TEdit>);
begin
  if ExecRegExpr(_Mask, Content.Value.Text) then
  begin
    Content.Value.Color := clWindow;
  end
  else
  begin
    Content.Value.Text := Copy(Content.Value.Text, 1, Pred(Length(Content.Value.Text)));
    Content.Value.SelStart := Length(Content.Value.Text);
    Content.Value.Color := clSkyBlue;
  end;
end;

constructor TCheckText.Create(const Mask: String);
begin
  _Mask := Mask;
end;

class function TCheckText.New(const Mask: String): ISubscriber<TEdit>;
begin
  result := TCheckText.Create(Mask);
end;

end.
