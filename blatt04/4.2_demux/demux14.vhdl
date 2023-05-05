LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY demux14 IS
    PORT (
        I_n : IN std_logic_vector(2 DOWNTO 0); 
        sel : IN std_logic_vector(1 DOWNTO 0); 
        Y0 : OUT std_logic_vector(2 DOWNTO 0);
        Y1 : OUT std_logic_vector(2 DOWNTO 0);
        Y2 : OUT std_logic_vector(2 DOWNTO 0);
        Y3 : OUT std_logic_vector(2 DOWNTO 0)
        );
END demux14;

ARCHITECTURE rtl OF demux14 IS
--missing
COMPONENT and_gate IS
        PORT (
            input1 : IN std_logic;
            input2 : IN std_logic;
            input3 : IN std_logic;
            and_output : OUT std_logic);
    END COMPONENT;

    COMPONENT not_gate IS
        PORT (
            input1 : IN std_logic;
            not_output : OUT std_logic
        );
    END COMPONENT;

    SIGNAL s0, s1, ns1, ns0 : std_logic;
    SIGNAL and1, and2, and3, and4 : std_logic_vector (2 DOWNTO 0);

BEGIN
    -- generate !s1, !s0 as well as copying s1 and s0
    s0 <= sel(0);
    s1 <= sel(1);
    not0 : not_gate PORT MAP(input1 => sel(0), not_output => ns0);
    not1 : not_gate PORT MAP(input1 => sel(1), not_output => ns1);

    assignment : FOR i IN 0 TO 2 GENERATE
        -- y3 = s1 s0 i
        a3 : and_gate PORT MAP(s1, s0, I_n(i), Y3(i));
        -- y2 = s1 !s0 i
        a2 : and_gate PORT MAP(s1, ns0, I_n(i), Y2(i));
        -- y1 = !s1 s0 i
        a1 : and_gate PORT MAP(ns1, s0, I_n(i), Y1(i));
        -- y0 = !s1 !s0 i
        a0 : and_gate PORT MAP(ns1, ns0, I_n(i), Y0(i));
    END GENERATE assignment;
END rtl;
