unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  IText = interface
    ['{9F80F9A3-44C0-47AB-8421-FB967ED1113D}']
    function Read: String;
  end;

  TText = class(TInterfacedObject, IText)
  private
    strValue: String;
  public
    function Read: String;
    constructor Create(const aString: String);
    class function New(const aString: String): IText;
  end;

  TUpperText = class(TInterfacedObject, IText)
  private
    Text: IText;
  public
    function Read: String;
    constructor Create(const aText: IText);
    class function New(const aText: IText): IText;
  end;

  TTrimText = class(TInterfacedObject, IText)
  private
    Text: IText;
  public
    function Read: String;
    constructor Create(const aText: IText);
    class function New(const aText: IText): IText;
  end;

  TStepCharText = class(TInterfacedObject, IText)
  private
    Text: IText;
    Position: Integer;
    function EndOfStep: Boolean;
  public
    function Read: String;
    function StepCount: Integer;

    procedure NextStep;
    procedure Step(const aPosition: Integer);

    constructor Create(const aText: IText);
    class function New(const aText: IText): IText;
  end;

{ TText }

function TText.Read: String;
begin
  Result := strValue;
end;

class function TText.New(const aString: String): IText;
begin
  Result := TText.Create(aString);
end;

constructor TText.Create(const aString: String);
begin
  strValue := aString;
end;

{ TUpperString }

function TUpperText.Read: String;
begin
  Result := UpperCase(Text.Read);
end;

constructor TUpperText.Create(const aText: IText);
begin
  Text := aText;
end;

class function TUpperText.New(const aText: IText): IText;
begin
  Result := TUpperText.Create(aText);
end;

{ TTrimText }
function TTrimText.Read: String;
begin
  Result := Trim(Text.Read);
end;

constructor TTrimText.Create(const aText: IText);
begin
  Text := aText;
end;

class function TTrimText.New(const aText: IText): IText;
begin
  Result := TTrimText.Create(aText);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  pp: TStepCharText;
begin
  // ShowMessage(TTrimText.New(TUpperText.New(TText.New('   Texto de prueba con Espacios   '))).Read);
  pp := TStepCharText.Create(TText.New('uno dos tres'));
  while not pp.EndOfStep do
  begin
    ShowMessage(pp.Read);
    pp.NextStep;
  end;
end;

{ TStepCharText }

function TStepCharText.EndOfStep: Boolean;
begin
  Result := Position >= StepCount;
end;

constructor TStepCharText.Create(const aText: IText);
begin
  Text := aText;
  Position := 1;
end;

class function TStepCharText.New(const aText: IText): IText;
begin
  Result := TStepCharText.Create(aText);
end;

function TStepCharText.Read: String;
begin
  Result := Text.Read[Position];
end;

procedure TStepCharText.Step(const aPosition: Integer);
begin
  Position := aPosition;
end;

function TStepCharText.StepCount: Integer;
begin
  Result := Length(Text.Read);
end;

procedure TStepCharText.NextStep;
begin
  if not EndOfStep then
    Inc(Position);
end;

end.
