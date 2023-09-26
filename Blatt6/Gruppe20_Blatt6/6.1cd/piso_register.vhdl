LIBRARY IEEE;
USE IEEE.Std_logic_1164.ALL;

ENTITY piso_register IS
    PORT (
        pinput : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        clk : IN STD_LOGIC;
        clear : IN STD_LOGIC;
        write : IN STD_LOGIC; -- write auf 1: es kann geschrieben werden. 
        sout : OUT STD_LOGIC
    );
END piso_register;

ARCHITECTURE behavioral OF piso_register IS
    COMPONENT DFlipFlop IS
        PORT (
            D : IN STD_LOGIC;
            Clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            Q : OUT STD_LOGIC
        );
    END COMPONENT;

    -- ob paralle geschrieben oder seriel geschoben wird ist hier als 21mux implementiert 
    COMPONENT mux21 IS
        PORT (
            i1 : IN STD_LOGIC;
            i2 : IN STD_LOGIC;
            sel : IN STD_LOGIC;
            y : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Ausgabe MUX sowie AND-Gatter
    SIGNAL and1, mux1, mux2, mux3 : STD_LOGIC;

    -- Ausgabe DFFs
    SIGNAL q1, q2, q3, q4 : STD_LOGIC;

BEGIN
    and1 <= pinput(3) AND write;

    -- dff1 Ausgabe q1 wird dann für mux1 als Eingabe genutzt
    -- das gleiche für den Rest
    ff1 : DFlipFlop PORT MAP(and1, clk, clear, q1);
    m1 : mux21 PORT MAP(q1, pinput(2), write, mux1);

    ff2 : DFlipFlop PORT MAP(mux1, clk, clear, q2);
    m2 : mux21 PORT MAP(q2, pinput(1), write, mux2);

    ff3 : DFlipFlop PORT MAP(mux2, clk, clear, q3);
    m3 : mux21 PORT MAP(q3, pinput(0), write, mux3);

    ff4 : DFlipFlop PORT MAP(mux3, clk, clear, q4);

    -- sout ist das Ergebnis des letzten DFF
    sout <= q4;

END behavioral;