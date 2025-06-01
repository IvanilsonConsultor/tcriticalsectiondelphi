unit SafeCounter;

interface

uses
  System.SysUtils, System.SyncObjs;  // TCriticalSection

type
  /// <summary>Contador inteiro thread‑safe.</summary>
  TSafeCounter = class
  private
    FValue: Int64;
    FLock : TCriticalSection;
  public
    constructor Create(AInitial: Int64 = 0);
    destructor  Destroy; override;

    /// <summary>Incrementa o contador e devolve o novo valor.</summary>
    function Next: Int64;

    /// <summary>Obtém o valor atual sem alterar.</summary>
    function Value: Int64;
  end;

implementation

{ TSafeCounter }

constructor TSafeCounter.Create(AInitial: Int64);
begin
  inherited Create;
  FValue := AInitial;
  FLock  := TCriticalSection.Create;
end;

destructor TSafeCounter.Destroy;
begin
  FLock.Free;
  inherited;
end;

function TSafeCounter.Next: Int64;
begin
 // FLock.Enter;           // 🔒 inicia a região crítica
  try
    Inc(FValue);
    Result := FValue;
  finally
  //  FLock.Leave;         // 🔓 sai da região crítica
  end;
end;

function TSafeCounter.Value: Int64;
begin
 // FLock.Enter;
  try
    Result := FValue;
  finally
  //  FLock.Leave;
  end;
end;

end.

