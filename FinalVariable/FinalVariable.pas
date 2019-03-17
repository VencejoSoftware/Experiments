unit FinalVariable;

interface

uses
  SysUtils;

type
  EFinalInitialized = class(Exception);

  Final<T> = record
  private
    IsInitialized: Boolean;
    Content: T;
  public
    class operator Implicit(const Value: T): Final<T>;
    class operator Implicit(const Value: Final<T>): T;
  end;

implementation

class operator Final<T>.Implicit(const Value: T): Final<T>;
begin
  if Result.IsInitialized then
    raise EFinalInitialized.Create('Final value can not change');
  Result.IsInitialized := True;
  Result.Content := Value;
end;

class operator Final<T>.Implicit(const Value: Final<T>): T;
begin
  if not Value.IsInitialized then
    Result := default (T)
  else
    Result := Value.Content;
end;

end.
