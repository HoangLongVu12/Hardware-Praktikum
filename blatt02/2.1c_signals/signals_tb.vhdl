library ieee;
use ieee.std_logic_1164.all;

entity signals_tb is
end signals_tb;

architecture test of signals_tb is
  signal a, b, c : std_logic;
begin
  process begin
    -- dies sind nur Beispiel für Tupel die nicht verwendet werden muessen
    -- insgesamt sollen 8 verschiedene Tupel ausgewaehlt werden
    -- Beispiel für ein Tupel mit 2 unterschiedlichen Signalwerten
    a <= 'X';
    b <= 'W';
    wait for 10 ns; -- Ansonsten werden die Zuordnungen für a, b und c gleichzeitig ausgeführt
    c <= a and b;		
    wait for 10 ns; -- Gibt ein Zeitfenster für die Beobachtung der Ausgabe von a und b im GTK Wave
    c <= a or b;		
    wait for 10 ns; -- Gibt ein Zeitfenster für die Beobachtung der Ausgabe von a oder b im GTK Wave
    -- Das Tupel (0,1) das auf jeden Fall ausgewertet werden soll
    a <= '0';
    b <= '1';
    wait for 10 ns;
    c <= a and b;		--c ist 0
    wait for 10 ns;
    c <= a or b;		--c ist 1
    wait for 10 ns;
    -- Ab hier folgen die eigenen Paare
    
    -- Beispiele für Tupel die nicht verwendet werden sollten 
    -- (0,1) und (1,0) sind das gleiche Tupel, es sollte also nur eins davon verwendet werden
    a <= '1';
    b <= '0';
    -- (0,0) hat die gleichen Signalwerte, sollte also nicht verwendet werden
    a <= '0';
    b <= '0';
    -- (1,1) hat die gleichen Signalwerte, sollte also nicht verwendet werden
    a <= '1';
    b <= '1';
	
	--Doing the homework start here
	
	--first tuple(X,1)
	a <= 'X';
	b <= '1';
	wait for 10 ns;
	c <= a and b;      --c is X
	wait for 10 ns;
	c <= a or b;       --c is 1
	wait for 10 ns;
	
	--second tuple(X,0)
	a <= 'X';          
	b <= '0';
	wait for 10 ns;
	c <= a and b;      --c is 0
	wait for 10 ns;
	c <= a or b;       --c is X
	wait for 10 ns;
	
	--third tuple(W,0)
	a <= 'W';
	b <= '1';
	wait for 10 ns;
	c <= a and b;      --c is 0
	wait for 10 ns;
	c <= a or b;       --c is X
	wait for 10 ns;
	
	--fourth(W,1)
	a <= 'W';
	b <= '0';
	wait for 10 ns;
	c <= a and b;      --c is X
	wait for 10 ns;
	c <= a or b;       --c is 1
	wait for 10 ns;
	
	--fifth tuple(L,0)
	a <= 'L';
	b <= '1';
	wait for 10 ns;
	c <= a and b;      --c is 0
	wait for 10 ns;
	c <= a or b;       --c is 0
	wait for 10 ns;
	
	--sixth tuple(L,1)
	a <= 'L';
	b <= '0';
	wait for 10 ns;
	c <= a and b;      --c is 0
	wait for 10 ns;
	c <= a or b;       --c is 1
	wait for 10 ns;
	
	--seventh tuple(L,H)
	a <= 'L';
	b <= 'H';
	wait for 10 ns;
	c <= a and b;      --c is 0
	wait for 10 ns;
	c <= a or b;       --c is 1
	wait for 10 ns;
	
	--eighth tuple(H,Z)
	a <= 'H';
	b <= 'Z';
	wait for 10 ns;
	c <= a and b;      --c ist X
	wait for 10 ns;
	c <= a or b;       --c ist 1
	wait for 10 ns;
	-- finished
	
    assert false report "End of test";
    wait;
  end process;
end test;
