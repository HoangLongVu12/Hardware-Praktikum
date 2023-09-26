LIBRARY IEEE;
USE IEEE.Std_logic_1164.ALL;

ENTITY piso_register_tb IS
END piso_register_tb;

ARCHITECTURE test OF piso_register_tb IS
    COMPONENT piso_register IS
        PORT (
            pinput : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Clk : IN STD_LOGIC;
            clear : IN STD_LOGIC;
            write : IN STD_LOGIC; -- wird gesetzt wenn geschrieben werden kann
            sout : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL pinput : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Clk : STD_LOGIC;
    SIGNAL clear : STD_LOGIC;
    SIGNAL write : STD_LOGIC;
    SIGNAL sout : STD_LOGIC;

BEGIN

    ps : piso_register PORT MAP(pinput, Clk, clear, write, sout);

    PROCESS BEGIN
        pinput <= "1100";
        -- SIPO initialisieren indem man es zurueck setzt
        Clk <= '0';
        clear <= '0';
        write <= '0';
        WAIT FOR 10 ns; -- 10ns
        Clk <= '1';
        clear <= '1';
        write <= '0';
        WAIT FOR 10 ns; -- 20ns
        Clk <= '0';
        clear <= '0';
        write <= '0';
        WAIT FOR 10 ns; -- 30ns

        --Uebergebe die Bitsequenz 1100 
        pinput <= "1100";
        Clk <= '0';
        clear <= '0';
        write <= '1';
        WAIT FOR 10 ns; -- 40ns
        Clk <= '1';
        clear <= '0';
        -- es wurde geschrieben, am sout liegt 1 an
        WAIT FOR 10 ns; -- 50ns
        -- bits durchschieben

        Clk <= '0';
        clear <= '0';
        write <= '0';
        WAIT FOR 10 ns; -- 60ns
        Clk <= '1';
        WAIT FOR 10 ns; -- 70ns 
        Clk <= '0';
        WAIT FOR 10 ns; -- 80ns

        --Uebergebe die Bitsequenz 0010 
        pinput <= "0010";
        Clk <= '0';
        clear <= '0';
        write <= '1';
        WAIT FOR 10 ns; -- 90ns
        Clk <= '1';
        clear <= '0';
        WAIT FOR 10 ns; -- 100ns

        WAIT;
    END PROCESS;
END test;