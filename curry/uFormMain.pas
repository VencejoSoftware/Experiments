unit uFormMain;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms,
  Generics.Defaults,
  Dialogs;

type
  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
  end;

type
  TPartialFunction<T> = reference to function(const A: T): T;

  IAddCurrying<T> = interface
    ['{85512575-4808-4D1B-8232-07D68E5DA8EB}']
    function AddCurrying(const ValueA: T): TPartialFunction<T>;
  end;

  TAddCurrying<T> = class(TInterfacedObject, IAddCurrying<T>)
  protected
    function Add(const ValueA, ValueB: T): T; virtual; abstract;
  public
    function AddCurrying(const ValueA: T): TPartialFunction<T>;
  end;

  TAddCurryingInteger = class(TAddCurrying<Integer>, IAddCurrying<Integer>)
  protected
    function Add(const ValueA, ValueB: Integer): Integer; override;
  end;

  TGreeting = class(TAddCurrying<String>, IAddCurrying<String>)
  protected
    function Add(const ValueA, ValueB: String): String; override;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

function TAddCurrying<T>.AddCurrying(const ValueA: T): TPartialFunction<T>;
begin
  Result := function(const ValueB: T): T
  begin
    Result := Add(ValueA, ValueB);
  end;
end;

function TAddCurryingInteger.Add(const ValueA, ValueB: Integer): Integer;
begin
  Result := ValueA + ValueB;
end;

function TGreeting.Add(const ValueA, ValueB: String): String;
begin
  Result := ValueA + ', ' + ValueB;
end;

type
  TAddCurry = reference to function(const A: Integer): Integer;

function Add(const ValueA, ValueB: Integer): Integer;
begin
  Result := ValueA + ValueB;
end;

function AddCurrying(const ValueA: Integer): TAddCurry;
begin
  Result := function(const ValueB: Integer): Integer
  begin
    Result := Add(ValueA, ValueB);
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  AddCurrying2, AddCurrying3: TAddCurry;
  CurryingInt: IAddCurrying<Integer>;
  CurryFuncInt: TPartialFunction<Integer>;
  Greeting: IAddCurrying<String>;
  PartialFuncStr: TPartialFunction<String>;
begin
  // AddCurrying2 := AddCurrying(2);
  // AddCurrying3 := AddCurrying(3);
  // ShowMessage(IntToStr(AddCurrying2(5)));
  // ShowMessage(IntToStr(AddCurrying3(6)));
  // ShowMessage(IntToStr(AddCurrying(1)(2)));

  CurryingInt := TAddCurryingInteger.Create;
  CurryFuncInt := CurryingInt.AddCurrying(1);
  ShowMessage(IntToStr(CurryFuncInt(2)));

  Greeting := TGreeting.Create;
  PartialFuncStr := Greeting.AddCurrying('Hello');
  ShowMessage(PartialFuncStr('Heidi'));
  ShowMessage(PartialFuncStr('Eddie'));
  ShowMessage(Greeting.AddCurrying('Hi there')('Howard'));
end;

end.
