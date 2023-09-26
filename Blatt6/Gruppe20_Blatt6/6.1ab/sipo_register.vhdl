LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- ein serieler Input, 8 bit parallel Output
ENTITY sipo_register IS
    PORT (
        serial_in, clear, clock : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(0 TO 3)
    );
END sipo_register;

ARCHITECTURE rtl OF sipo_register IS
    COMPONENT DFlipFlop IS
        PORT (
            d, clk, reset : IN STD_LOGIC;
            Q : OUT STD_LOGIC
        );
    END COMPONENT;

    -- zum Speichern der letzte Ausgabe 
    SIGNAL dffout : STD_LOGIC_VECTOR (0 TO 3);

BEGIN

    -- DFF Ein- und Ausgabe
    dff1 : DFlipFlop PORT MAP(serial_in, clock, clear, dffout(0));
    dff2 : DFlipFlop PORT MAP(dffout(0), clock, clear, dffout(1));
    dff3 : DFlipFlop PORT MAP(dffout(1), clock, clear, dffout(2));
    dff4 : DFlipFlop PORT MAP(dffout(2), clock, clear, dffout(3));

    -- DFF Ausgabe zu SIPO-Reg Ausgabe
    sipo_out : FOR i IN 0 TO 3 GENERATE
        Q(i) <= dffout(i);
    END GENERATE sipo_out;

END rtl;