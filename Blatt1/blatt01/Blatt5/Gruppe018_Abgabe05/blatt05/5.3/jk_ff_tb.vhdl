library ieee;
use ieee.std_logic_1164.all;

entity jk_ff_tb is
end jk_ff_tb;

architecture testbench of jk_ff_tb is

component JK_FlipFlop is
    port (
      J,K, clk , reset : in std_logic;
      Q : out std_logic
    );
end component;

signal j, k, c, r, q : std_logic;

begin

jkff : JK_FlipFlop port map (j, k, c, r, q);

process begin

    r <= '1';
    c <= '0';
    j <= '0';
    k <= '0';
    wait for 10 ns;
    j <= '1';
    k <= '0';
    wait for 10 ns;
    j <= '0';
    k <= '1';
    wait for 10 ns;
    j <= '1';
    k <= '1';
    wait for 10 ns;

    c <= '1';
    j <= '0';
    k <= '0';
    wait for 10 ns;
    j <= '1';
    k <= '0';
    wait for 10 ns;
    j <= '0';
    k <= '1';
    wait for 10 ns;
    j <= '1';
    k <= '1';
    wait for 10 ns;

    r <= '0';
    c <= '0';
    j <= '0';
    k <= '0';
    wait for 10 ns;
    j <= '1';
    k <= '0';
    wait for 10 ns;
    j <= '0';
    k <= '1';
    wait for 10 ns;
    j <= '1';
    k <= '1';
    wait for 10 ns;

    c <= '1';
    j <= '0';
    k <= '0';
    wait for 10 ns;
    j <= '1';
    k <= '0';
    wait for 10 ns;
    j <= '0';
    k <= '1';
    wait for 10 ns;
    j <= '1';
    k <= '1';
    wait for 10 ns;

	wait;
end process;

end testbench;
