LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sipo_register_tb IS
END sipo_register_tb;

ARCHITECTURE rtl OF sipo_register_tb IS

    COMPONENT sipo_register IS
        PORT (
            serial_in, clear, clock : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR(0 TO 3)
        );
    END COMPONENT;

    -- Ein- und Ausgabe
    SIGNAL sdi, clear, clock : STD_LOGIC;
    SIGNAL q : STD_LOGIC_VECTOR(0 TO 3);

BEGIN
    sipotb : sipo_register PORT MAP(sdi, clear, clock, q);

    PROCESS BEGIN
        -- SIPO initialisieren indem man es zurueck setzt
        clock <= '0';
        clear <= '0';
        sdi <= '0';
        WAIT FOR 10 ns; -- 10ns
        --Zuruecksetzen.
        clear <= '1';
        clock <= '1';

        WAIT FOR 10 ns; -- 20ns
        clock <= '0';
        clear <= '0';
        WAIT FOR 10 ns; -- 30ns

        --Uebergebe die Bitsequenz 1000 
        --erstes Bit 1
        sdi <= '1';
        clock <= '1';
        WAIT FOR 10 ns; -- 40ns
        clock <= '0';
        WAIT FOR 10 ns; -- 50ns

        -- 2. bis 4. Bit 0
        sdi <= '0';
        clock <= '1';
        WAIT FOR 10 ns; -- 60ns
        clock <= '0';
        WAIT FOR 10 ns; -- 70ns

        sdi <= '0';
        clock <= '1';
        WAIT FOR 10 ns; -- 80ns
        clock <= '0';
        WAIT FOR 10 ns; -- 90ns

        sdi <= '0';
        clock <= '1';
        WAIT FOR 10 ns; -- 100ns
        clock <= '0';
        WAIT FOR 10 ns; -- 110ns

        --Pause, nichts aendert sich
        WAIT FOR 30 ns; -- 140ns
        --Zuruecksetzen.
        clear <= '1';
        clock <= '1';
        sdi <= '0';
        WAIT FOR 10 ns; -- 150ns
        clock <= '0';
        clear <= '0';
        WAIT FOR 10 ns; -- 160ns

        --Uebergebe die Bitsequenz 1101
        --erstes Bit 1
        sdi <= '1';
        clock <= '0';
        WAIT FOR 10 ns; -- 170ns
        clock <= '1';
        WAIT FOR 10 ns; -- 180ns

        -- 2. Bit 1
        sdi <= '1';
        clock <= '0';
        WAIT FOR 10 ns; -- 190ns
        clock <= '1';
        WAIT FOR 10 ns; -- 200ns

        -- 3. Bit 0
        sdi <= '0';
        clock <= '0';
        WAIT FOR 10 ns; -- 210ns
        clock <= '1';
        WAIT FOR 10 ns; -- 220ns

        -- 4. Bit 1
        sdi <= '1';
        clock <= '0';
        WAIT FOR 10 ns; -- 230ns
        clock <= '1';
        WAIT FOR 10 ns; -- 240ns

        WAIT;
    END PROCESS;

END rtl;