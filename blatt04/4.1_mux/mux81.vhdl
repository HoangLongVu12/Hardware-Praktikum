LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux81 IS
    PORT (
        i0_81 : IN std_logic_vector(2 DOWNTO 0); 
        i1_81 : IN std_logic_vector(2 DOWNTO 0);
        i2_81 : IN std_logic_vector(2 DOWNTO 0);
        i3_81 : IN std_logic_vector(2 DOWNTO 0);
        i4_81 : IN std_logic_vector(2 DOWNTO 0);
        i5_81 : IN std_logic_vector(2 DOWNTO 0);
        i6_81 : IN std_logic_vector(2 DOWNTO 0);
        i7_81 : IN std_logic_vector(2 DOWNTO 0);
        sel_81 : IN std_logic_vector(2 DOWNTO 0); 
        y_81 : OUT std_logic_vector(2 DOWNTO 0));
END mux81;

ARCHITECTURE rtl OF mux81 IS

    COMPONENT mux41 IS
        PORT (
            i0 : IN std_logic_vector(2 DOWNTO 0); 
            i1 : IN std_logic_vector(2 DOWNTO 0);
            i2 : IN std_logic_vector(2 DOWNTO 0);
            i3 : IN std_logic_vector(2 DOWNTO 0);
            sel : IN std_logic_vector(1 DOWNTO 0); 
            y : OUT std_logic_vector(2 DOWNTO 0)
        );
    END COMPONENT;
    
    -- weitere Komponenten 
    COMPONENT and_gate IS
        PORT (
            input1 : IN std_logic;
            input2 : IN std_logic;
            input3 : IN std_logic;
            and_output : OUT std_logic);
    END COMPONENT;

    COMPONENT or_gate IS
        PORT (
            input1 : IN std_logic;
            input2 : IN std_logic;
            input3 : IN std_logic;
            input4 : IN std_logic;
            or_result : OUT std_logic
        );
    END COMPONENT;

    COMPONENT not_gate IS
        PORT (
            input1 : IN std_logic;
            not_output : OUT std_logic
        );
    END COMPONENT;
    
    -- Signale
	SIGNAL mux1, mux2 : std_logic_vector(2 DOWNTO 0); -- output of mux4s
    SIGNAL notsel : std_logic_vector(2 DOWNTO 0); -- negated value of selectors
    SIGNAL and1out, and2out : std_logic_vector(2 DOWNTO 0); -- values of the first and gates
begin

    --missing;
    -- hier werden die einzelnen Komponenten verschaltet
	-- generates !s0, !s1, !s2 (though only !s2 is needed)
    not_assignment : FOR i IN 0 TO 2 GENERATE
        notting : not_gate PORT MAP(input1 => sel_81(i), not_output => notsel(i));
    END GENERATE not_assignment;

    -- for each bit map mux8 inputs with corresponding mux4 inputs
    --mux_assignment : FOR i IN 0 TO 2 GENERATE
    muxone : mux41 PORT MAP(i0 => i0_81, i1 => i1_81, i2 => i2_81, i3 => i3_81, sel => sel_81(1 DOWNTO 0), y => mux1);
    muxtwo : mux41 PORT MAP(i0 => i4_81, i1 => i5_81, i2 => i6_81, i3 => i7_81, sel => sel_81(1 DOWNTO 0), y => mux2);
    --END GENERATE mux_assignment;

    -- firstand = mux1 & !s2
    -- secondand = mux2 & s2
    and_assignment : FOR i IN 0 TO 2 GENERATE
        firstand : and_gate PORT MAP(input1 => mux1(i), input2 => notsel(2), input3 => '1', and_output => and1out(i));
        secondand : and_gate PORT MAP(input1 => mux2(i), input2 => sel_81(2), input3 => '1', and_output => and2out(i));
    END GENERATE and_assignment;

    -- "calculate" the final or gate result
    or_assignment : FOR i IN 0 TO 2 GENERATE
        oring : or_gate PORT MAP(input1 => and1out(i), input2 => and2out(i), input3 => '0', input4 => '0', or_result => y_81(i));
    END GENERATE or_assignment;

end rtl;
