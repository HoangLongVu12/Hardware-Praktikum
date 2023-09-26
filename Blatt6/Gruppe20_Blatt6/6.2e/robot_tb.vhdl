LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY robot_tb IS
END robot_tb;

ARCHITECTURE rtl OF robot_tb IS

    COMPONENT robot IS
        PORT (
            pattern : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            sensor, reset, clock : IN STD_LOGIC;
            alarm : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL alarm : STD_LOGIC;
    SIGNAL reset : STD_LOGIC;
    SIGNAL sensor : STD_LOGIC;
    SIGNAL clock : STD_LOGIC;
    SIGNAL pattern : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    rbt : robot PORT MAP(sensor => sensor, reset => reset, clock => clock, alarm => alarm, pattern => pattern);
    PROCESS BEGIN
        ------Initialisierung--
        pattern(0) <= '1';
        pattern(1) <= '0';
        pattern(2) <= '1';
        pattern(3) <= '1';

        sensor <= '0';
        reset <= '1';
        clock <= '1';
        WAIT FOR 10 ns;
        -----------------------
        reset <= '0';
        clock <= '0';
        WAIT FOR 10 ns;
        -----------------------

        -- Wir lesen die Bitfolge "101101111" bitweise in sensor ein 
        -- Nachdem "1011" erkannt wurde wird das Pattern auf "1101" gesetzt

        -----------------------
        sensor <= '1';
        clock <= '1';
        WAIT FOR 10 ns;
        clock <= '0';
        WAIT FOR 10 ns;
        -----------------------
        sensor <= '0';
        clock <= '1';
        WAIT FOR 10 ns;
        clock <= '0';
        WAIT FOR 10 ns;
        -----------------------
        sensor <= '1';
        clock <= '1';
        WAIT FOR 10 ns;
        clock <= '0';
        WAIT FOR 10 ns;
        -----------------------
        sensor <= '1';
        clock <= '1';
        WAIT FOR 10 ns;
        clock <= '0';
        WAIT FOR 10 ns;
        -- hier sollte alarm = 1 sein (1011 wurde erkannt)
        -----------------------
        -- das zu suchende Pattern wird auf 1101 gesetzt 
        pattern(0) <= '1';
        pattern(1) <= '1';
        pattern(2) <= '0';
        pattern(3) <= '1';

        -----------------------
        sensor <= '0';
        clock <= '1';
        WAIT FOR 10 ns;
        clock <= '0';
        WAIT FOR 10 ns;
        -----------------------
        sensor <= '1';
        clock <= '1';
        WAIT FOR 10 ns;
        clock <= '0';
        WAIT FOR 10 ns;
        -- hier sollte alarm = 1 sein (1101 wurde erkannt, die 11 zu beginn wurden schon vor dem neu setzen des patterns gelesen)
        -----------------------
        sensor <= '1';
        clock <= '1';
        WAIT FOR 10 ns;
        clock <= '0';
        WAIT FOR 10 ns;
        -----------------------
        sensor <= '0';
        clock <= '1';
        WAIT FOR 10 ns;
        clock <= '0';
        WAIT FOR 10 ns;
        -----------------------
        sensor <= '1';
        clock <= '1';
        WAIT FOR 10 ns;
        clock <= '0';
        WAIT FOR 10 ns;
        -- hier sollte alarm = 1 sein (1101 wurde erkannt)

        WAIT;
    END PROCESS;

END rtl;