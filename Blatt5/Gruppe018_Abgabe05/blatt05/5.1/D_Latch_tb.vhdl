library ieee;
use ieee.std_logic_1164.all;

entity D_Latch_tb is
end D_Latch_tb;

architecture testbench of D_Latch_tb is
    COMPONENT D_latch IS
        PORT (
            clk, D : IN STD_LOGIC;
            Q, not_Q : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL clk, d, q, nq : STD_LOGIC;

begin
    dlatch : D_latch PORT MAP(clk, d, q, nq);

    process begin
        clk <= '1';
        d <= '0';
        wait for 10 ns;
        clk <= '0';
        d <= '0';
        wait for 10 ns;
        clk <= '1';
        d <= '0';
        wait for 10 ns;
        clk <= '0';
        d <= '1';
        wait for 10 ns;
        clk <= '1';
        d <= '1';
        wait for 10 ns;
		clk <= '0';
        d <= '0';
        wait for 10 ns;
        wait;
    end process;
end testbench;