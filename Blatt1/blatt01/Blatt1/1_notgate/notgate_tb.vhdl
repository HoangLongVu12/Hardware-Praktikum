library ieee;
use ieee.std_logic_1164.all;

-- create testbench for not_gate
-- can be left empty, since test bench (this file) has no inputs or outputs

-- erzeugt eine Testbech fuer das not_gate
-- kann hier leer gelassen werde, da die Testbench (in dieser Datei) keine Eingaben oder Ausgaben hat
entity notgate_tb is
end notgate_tb;

architecture test of notgate_tb is
  -- component declaration, so that it can be instantiated later
  -- must have same name and port list as the entity "notgate" in notgate.vhdl
  
  -- Komponenteten Dekleration, damit diese spaeter instantiiert werden kann
  -- Muss den gleichen Namen und die gleiche Port Liste haben wie die Entity "notgate" in notgate.vhdl
  component notgate
      port (
        input : in std_logic;
        not_result : out std_logic
      );
  end component;
-- define the signals that will be used in test
-- definiert die Signale die im Test verwendet werden
  signal a, c : std_logic;

-- begin test code
-- hier beginnt der eigentliche Testcode
begin
  -- creates an instance of notgate
  -- erzeugte eine Instanz von notgate
  not_g: notgate port map(input => a, not_result => c);

  -- tests the behaviour of notgate based on the different input values for "a"
  -- Testet das Verhalten von notgate basierend auf den unterschiedlichen Eingabewerten an "a"
  process begin
    a <= '0';
    wait for 10 ns;
    a <= '1';
    wait for 10 ns;
    a <= 'X';
    wait for 10 ns;
    assert false report "End of test";
    wait;
  end process;
end test;
