LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY aludecoder_tb IS
END;

ARCHITECTURE behavior OF aludecoder_tb IS
    COMPONENT aludecoder
        PORT (
            funct : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            aluop : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            alucontrol : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL funct : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL op : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL ctrl : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
    adc : aludecoder PORT MAP(funct, op, ctrl);
    PROCESS BEGIN
        op <= "00";
        funct <= "000000";
        WAIT FOR 10 ns;
        op <= "01";
        WAIT FOR 10 ns;
        op <= "11";
        WAIT FOR 10 ns;
        funct <= "101010";
        WAIT FOR 10 ns;
        funct <= "100100";
        WAIT FOR 10 ns;
        WAIT;
    END PROCESS;
END;