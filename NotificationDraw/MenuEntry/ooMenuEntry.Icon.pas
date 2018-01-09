unit ooMenuEntry.Icon;

interface

uses
  ooGlyph,
  ooStyledText,
  ooStyle,
  ooMenuEntry.Text;

type
  IMenuEntryIcon = interface(IMenuEntryText)
    ['{04D5604A-9B28-4EB7-A79A-5A3D5B83B8B5}']
    function Glyph: IGlyph;
  end;

  TMenuEntryIcon = class sealed(TInterfacedObject, IMenuEntryIcon, IMenuEntryText)
  strict private
    _TextItem: IMenuEntryText;
    _Glyph: IGlyph;
  public
    function ID: Cardinal;
    function Title: IStyledText;
    function Description: IStyledText;
    function Glyph: IGlyph;
    function Style: IStyle;

    procedure ChangeTitle(const Title: IStyledText);
    procedure ChangeDescription(const Description: IStyledText);
    procedure ChangeStyle(const Style: IStyle);

    constructor Create(const TextItem: IMenuEntryText; const Glyph: IGlyph);
    class function New(const TextItem: IMenuEntryText; const Glyph: IGlyph): IMenuEntryIcon;
  end;

implementation

function TMenuEntryIcon.ID: Cardinal;
begin
  Result := _TextItem.ID;
end;

function TMenuEntryIcon.Title: IStyledText;
begin
  Result := _TextItem.Title;
end;

procedure TMenuEntryIcon.ChangeTitle(const Title: IStyledText);
begin
  _TextItem.ChangeTitle(Title);
end;

function TMenuEntryIcon.Description: IStyledText;
begin
  Result := _TextItem.Description;
end;

procedure TMenuEntryIcon.ChangeDescription(const Description: IStyledText);
begin
  _TextItem.ChangeDescription(Description);
end;

function TMenuEntryIcon.Style: IStyle;
begin
  Result := _TextItem.Style;
end;

procedure TMenuEntryIcon.ChangeStyle(const Style: IStyle);
begin
  _TextItem.ChangeStyle(Style);
end;

function TMenuEntryIcon.Glyph: IGlyph;
begin
  Result := _Glyph;
end;

constructor TMenuEntryIcon.Create(const TextItem: IMenuEntryText; const Glyph: IGlyph);
begin
  _TextItem := TextItem;
  _Glyph := Glyph;
end;

class function TMenuEntryIcon.New(const TextItem: IMenuEntryText; const Glyph: IGlyph): IMenuEntryIcon;
begin
  Result := TMenuEntryIcon.Create(TextItem, Glyph);
end;

end.
