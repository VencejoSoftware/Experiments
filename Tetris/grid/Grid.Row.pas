unit Grid.Row;

interface

uses
  Generics.Collections;

type
  IRow = interface
    ['{05B4E892-6CDC-4F6F-91B9-907687DB4E6F}']
    function Height: Cardinal;
  end;

  TRow = class sealed(TInterfacedObject, IRow)
  strict private
    _Height: Cardinal;
  public
    function Height: Cardinal;
    constructor Create(const Height: Cardinal);
    class function New(const Height: Cardinal): IRow;
  end;

  TRowList = class sealed(TList<IRow>);

implementation

function TRow.Height: Cardinal;
begin
  Result := _Height;
end;

constructor TRow.Create(const Height: Cardinal);
begin
  _Height := Height;
end;

class function TRow.New(const Height: Cardinal): IRow;
begin
  Result := TRow.Create(Height);
end;

end.
