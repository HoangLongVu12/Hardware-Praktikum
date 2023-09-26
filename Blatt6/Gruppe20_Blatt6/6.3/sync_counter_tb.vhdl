LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sync_counter_tb IS
END sync_counter_tb;

ARCHITECTURE tb OF sync_counter_tb IS
    COMPONENT sync_counter IS
        PORT (
            reset, clk, C, D : IN STD_LOGIC;
            q1, q0 : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL rst, clk, c, d, q1, q0 : STD_LOGIC;
BEGIN
    scount : sync_counter PORT MAP(rst, clk, c, d, q1, q0);
    PROCESS BEGIN
        -- initialisieren
        rst <= '0';
        clk <= '0';
        c <= '0';
        d <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        d <= '1';
        WAIT FOR 10 ns;
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        d <= '0';
        WAIT FOR 10 ns;
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        c <= '1';
        d <= '0';
        WAIT FOR 10 ns;
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        WAIT FOR 10 ns;
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        d <= '0';
        WAIT FOR 10 ns;
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        d <= '1';
        WAIT FOR 10 ns;
        rst <= '1';
        wait;
    END PROCESS;
END tb;