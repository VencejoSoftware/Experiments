unit ooMenuEntry.Text;

interface

uses
  ooStyledText,
  ooStyle;

type
  IMenuEntryText = interface
    ['{7859D262-BBBC-4E5B-B781-AD3444718BE5}']
    function ID: Cardinal;
    function Title: IStyledText;
    function Description: IStyledText;
    function Style: IStyle;

    procedure ChangeTitle(const Title: IStyledText);
    procedure ChangeDescription(const Description: IStyledText);
    procedure ChangeStyle(const Style: IStyle);
  end;

  TMenuEntryText = class sealed(TInterfacedObject, IMenuEntryText)
  strict private
    _ID: Cardinal;
    _Title: IStyledText;
    _Description: IStyledText;
    _Style: IStyle;
  public
    function ID: Cardinal;
    function Title: IStyledText;
    function Description: IStyledText;
    function Style: IStyle;

    procedure ChangeTitle(const Title: IStyledText);
    procedure ChangeDescription(const Description: IStyledText);
    procedure ChangeStyle(const Style: IStyle);

    constructor Create(const ID: Cardinal);
    class function New(const ID: Cardinal): IMenuEntryText;
  end;

implementation

function TMenuEntryText.ID: Cardinal;
begin
  Result := _ID;
end;

function TMenuEntryText.Title: IStyledText;
begin
  Result := _Title;
end;

procedure TMenuEntryText.ChangeTitle(const Title: IStyledText);
begin
  _Title := Title;
end;

function TMenuEntryText.Description: IStyledText;
begin
  Result := _Description;
end;

procedure TMenuEntryText.ChangeDescription(const Description: IStyledText);
begin
  _Description := Description;
end;

function TMenuEntryText.Style: IStyle;
begin
  Result := _Style;
end;

procedure TMenuEntryText.ChangeStyle(const Style: IStyle);
begin
  _Style := Style;
end;

constructor TMenuEntryText.Create(const ID: Cardinal);
begin
  _ID := ID;
end;

class function TMenuEntryText.New(const ID: Cardinal): IMenuEntryText;
begin
  Result := TMenuEntryText.Create(ID);
end;

end.
