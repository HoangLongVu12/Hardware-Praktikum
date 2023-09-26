LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY parallel_mult_tb IS
END parallel_mult_tb;

ARCHITECTURE rtl OF parallel_mult_tb IS

	COMPONENT parallel_mult
		PORT (
			x, y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			z : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL x, y : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL z : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	parallel_mult_1 : parallel_mult PORT MAP(x => x, y => y, z => z);
	PROCESS BEGIN
		x <= "1010";
		y <= "1101";
		WAIT FOR 10 ns;

		y <= "0111";
		WAIT FOR 10 ns;

		x <= "1001";
		y <= "1101";
		WAIT FOR 10 ns;

		y <= "0111";
		WAIT FOR 10 ns;

		-- weitere Testergebnisse
		x <= "1111";
		y <= "0000"; -- 15 * 0
		WAIT FOR 10 ns;

		x <= "1111";
		y <= "1111"; -- 15 * 15
		WAIT FOR 10 ns;

		x <= "0001";
		y <= "1001"; -- 1 * 9
		WAIT FOR 10 ns;

		x <= "1100";
		y <= "0100"; -- 12 * 8
		WAIT FOR 10 ns;

		WAIT;
	END PROCESS;
END rtl;