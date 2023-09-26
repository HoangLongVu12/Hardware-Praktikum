LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY robot IS
    PORT (
        pattern : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- das pattern das gefunden werden soll
        sensor, reset, clock : IN STD_LOGIC; --sensor ist der aktuell gelesene Wert
        alarm : OUT STD_LOGIC
    );
END robot;

ARCHITECTURE rtl OF robot IS
    COMPONENT DFlipFlop IS
        PORT (
            d, clk, reset : IN STD_LOGIC;
            Q : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL dffout : STD_LOGIC_VECTOR (0 TO 3);
    SIGNAL al : STD_LOGIC;
BEGIN
    -- DFFs
    dff1 : DFlipFlop PORT MAP(sensor, clock, reset, dffout(0));
    dff2 : DFlipFlop PORT MAP(dffout(0), clock, reset, dffout(1));
    dff3 : DFlipFlop PORT MAP(dffout(1), clock, reset, dffout(2));
    dff4 : DFlipFlop PORT MAP(dffout(2), clock, reset, dffout(3));

    -- falls die SIPO-Ausgabe gleich die gesuchte Pattern ist dann wird alarm 1, sonst 0
    PROCESS (dffout, pattern) IS BEGIN
        IF (dffout = pattern) THEN
            al <= '1';
        ELSE
            al <= '0';
        END IF;
    END PROCESS;

    alarm <= al;

END rtl;