unit LabelUpdate;

interface

uses
  SysUtils, StdCtrls, Graphics,
  PubSub.Content, PubSub.Subscriber;

type
  TLabelUpdate = class sealed(TInterfacedObject, ISubscriber<TEdit>)
  strict private
    _Label: TLabel;
  public
    function ID: TSubscriberID;
    procedure ContentHandler(const Content: IContent<TEdit>; const From: ISubscriber<TEdit>);
    constructor Create(const LabelControl: TLabel);
    class function New(const LabelControl: TLabel): ISubscriber<TEdit>;
  end;

implementation

function TLabelUpdate.ID: TSubscriberID;
begin
  CreateGuid(result);
end;

procedure TLabelUpdate.ContentHandler(const Content: IContent<TEdit>; const From: ISubscriber<TEdit>);
begin
  _Label.Caption := Content.Value.Text;
  _Label.Top := Content.Value.Top;
  _Label.Left := Content.Value.Left + Content.Value.Width + 10;
end;

constructor TLabelUpdate.Create(const LabelControl: TLabel);
begin
  _Label := LabelControl;
end;

class function TLabelUpdate.New(const LabelControl: TLabel): ISubscriber<TEdit>;
begin
  result := TLabelUpdate.Create(LabelControl);
end;

end.
