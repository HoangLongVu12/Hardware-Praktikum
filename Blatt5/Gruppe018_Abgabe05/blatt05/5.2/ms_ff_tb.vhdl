library ieee;
use ieee.std_logic_1164.all;

entity ms_ff_tb is
end ms_ff_tb;

architecture testbench of ms_ff_tb is
    COMPONENT ms_ff IS
        PORT (
            d, clk : IN STD_LOGIC;
            Q, not_Q : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL d, clk, q, nq : STD_LOGIC;

begin
    msdff : ms_ff PORT MAP(d, clk, q, nq);

    -- (fast) genau wie Abb. 4
    PROCESS BEGIN
        clk <= '0';
        d <= '0';
        WAIT FOR 10 ns; -- 10ns + Fall 00
        -- Q ist undefiniert für den ersten 10ns, da wir noch kein Qprev haben.
        clk <= '1';
        WAIT FOR 10 ns; -- 20ns
        clk <= '0';
        WAIT FOR 2.5 ns; -- 22.5ns
        d <= '1';
        WAIT FOR 2.5 ns; -- 25ns + Fall 01
        d <= '0';
        WAIT FOR 2.5 ns; -- 27.5ns
        d <= '1';
        WAIT FOR 2.5 ns; -- 30ns
        clk <= '1';
        WAIT FOR 2.5 ns; -- 32.5ns + Fall 11
        d <= '0';
        WAIT FOR 2.5 ns; -- 35ns + Fall 10
        WAIT FOR 5 ns; -- 40ns 
        clk <= '0';
        WAIT FOR 10 ns; -- 50ns
        clk <= '1';
        WAIT FOR 10 ns; -- 60ns
        clk <= '0';
        -- endet hier bei 60ns, es wird zu kompliziert für die genaue Signal wie im Abb.
        WAIT;
    END PROCESS;
   
end testbench;