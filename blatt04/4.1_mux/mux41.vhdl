LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
--the 4:1 multiplexer to be designed consists of four 3-bit inputs, i.e., i0, i1, i2 and i3.
--sel is a 2-bit select signal.
--y is the output.
ENTITY mux41 IS
    PORT (
        i0 : IN std_logic_vector(2 DOWNTO 0); 
        i1 : IN std_logic_vector(2 DOWNTO 0);
        i2 : IN std_logic_vector(2 DOWNTO 0);
        i3 : IN std_logic_vector(2 DOWNTO 0);
        sel : IN std_logic_vector(1 DOWNTO 0); 
        y : OUT std_logic_vector(2 DOWNTO 0)
        );
END mux41;

ARCHITECTURE rtl OF mux41 IS
--you can add more components you need
--you can also increase the number of inputs, e.g., the "and" gate below is extended to a 3-input gate.

    COMPONENT and_gate IS
        PORT (input1 : IN std_logic;
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
            input1 : IN STD_LOGIC;
            not_output : OUT STD_LOGIC
        );
    END COMPONENT;

--you can define more signals here if you need, e.g.,:
    SIGNAL not_sel, s : std_logic_vector(1 DOWNTO 0); 
	SIGNAL and1, and2, and3, and4 : STD_LOGIC_VECTOR (2 DOWNTO 0);

BEGIN

    s(0) <= sel(0);
    s(1) <= sel(1);
    not0 : not_gate PORT MAP(input1 => sel(0), not_output => not_sel(0));
    not1 : not_gate PORT MAP(input1 => sel(1), not_output => not_sel(1));

--bitwise operation for each logic gate because the input signals are multilple-bit signals.
--please complete the implementation based on the schema you designed.
     gate_assignment : FOR i in 0 TO 2 GENERATE
        -- !s1 !s0 i0
        and_output1 : and_gate PORT MAP(input1 => not_sel(1), input2 => not_sel(0), input3 => i0(i), and_output => and1(i));
        -- !s1 s0 i1
        and_output2 : and_gate PORT MAP(input1 => not_sel(1), input2 => s(0), input3 => i1(i), and_output => and2(i));
        -- s1 !s0 i2
        and_output3 : and_gate PORT MAP(input1 => s(1), input2 => not_sel(0), input3 => i2(i), and_output => and3(i));
        -- s1 s0 i3
        and_output4 : and_gate PORT MAP(input1 => s(1), input2 => s(0), input3 => i3(i), and_output => and4(i));

        -- y = and1 | and2 | and3 | and4
        orout : or_gate PORT MAP(input1 => and1(i), input2 => and2(i), input3 => and3(i), input4 => and4(i), or_result => y(i));

    END GENERATE gate_assignment;
   

END rtl;
