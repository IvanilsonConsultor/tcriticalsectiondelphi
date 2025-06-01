program TesteSafeCounter;

{$APPTYPE CONSOLE}

uses
  System.SysUtils, System.Classes, SafeCounter;

const
  THREADS      = 10;
  INCREMENTS   = 100_000;

type
  TWorker = class(TThread)
  private
    FCounter: TSafeCounter;
  protected
    procedure Execute; override;
  public
    constructor Create(ACounter: TSafeCounter);
  end;

constructor TWorker.Create(ACounter: TSafeCounter);
begin
  FCounter := ACounter;
  inherited Create(False); // cria e já inicia
end;

procedure TWorker.Execute;
var
  I: Integer;
begin
  for I := 1 to INCREMENTS do
    FCounter.Next; // incrementa em região crítica
end;

var
  Counter: TSafeCounter;
  Workers: array[1..THREADS] of TWorker;
  I      : Integer;
begin
  Counter := TSafeCounter.Create;
  try
    // lança N threads que incrementam simultaneamente
    for I := 1 to THREADS do
      Workers[I] := TWorker.Create(Counter);

    // aguarda todas terminarem
    for I := 1 to THREADS do
      Workers[I].WaitFor;

    Writeln(Format('Valor esperado: %d', [THREADS * INCREMENTS]));
    Writeln(Format('Valor real    : %d', [Counter.Value]));
  finally
    Counter.Free;
  end;

  Readln;
end.

