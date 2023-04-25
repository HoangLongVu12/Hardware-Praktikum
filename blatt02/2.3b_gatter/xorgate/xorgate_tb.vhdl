library ieee;
use ieee.std_logic_1164.all;
entity xorgate_tb is
end xorgate_tb;

architecture test of xorgate_tb is
  component xorgate
      port (
        input1 : in std_logic;
        input2 : in std_logic;
        xor_result :out std_logic
      );
  end component;
  signal a, b, c : std_logic;
begin
  xor_g: xorgate port map(input1 => a, input2 => b, xor_result => c);
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
    a <= 'X';
    b <= 'W';
    wait for 10 ns;
    assert false report "End of test";
    wait;
  end process;
end test;