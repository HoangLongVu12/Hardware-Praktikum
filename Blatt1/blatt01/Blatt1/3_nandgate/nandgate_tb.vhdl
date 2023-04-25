library ieee;
use ieee.std_logic_1164.all;

-- create testbench for and_gate
-- can be left empty, since test bench (this file) has no inputs or outputs
entity nandgate_tb is
end nandgate_tb;

architecture test of nandgate_tb is
  -- component declaration, so that it can be instantiated later
  -- must have same name and port list as the entity
  component nandgate
      port (
        nand_in1 : in std_logic;
        nand_in2 : in std_logic;
        nand_result : out std_logic
      );
  end component;
-- define the signals that will be used in test
  signal a, b, c : std_logic;
-- begin test code
begin
  -- creates an instance of andgate
  nand_g: nandgate port map(nand_in1 => a, nand_in2 => b, nand_result => c);
  -- testing all combinations of standard binary input values (that is, a and b have all combinations of 1 and 0)
  -- teste alle Eingabekombinationen der Standard Binaerwerte 1 und 0
  process begin
    a <= '0';
    b <= '0';
    wait for 10 ns;
    a <= '0';
    b <= '1';
    wait for 10 ns;
    a <= '1';
    b <= '0';
    wait for 10 ns;
    a <= '1';
    b <= '1';
    wait for 10 ns;
    -- testing what happens for non-standard signal values as input
    -- was passiert wenn nicht-standard Signalwerte angelegt werden
    a <= 'X';
    b <= 'W';
    wait for 10 ns;
    assert false report "End of test";
    wait;
  end process;
end test;
