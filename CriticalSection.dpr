program CriticalSection;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  SafeCounter in 'SafeCounter.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
