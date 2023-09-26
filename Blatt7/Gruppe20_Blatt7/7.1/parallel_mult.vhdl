LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

--Three blocks are provided in this template(block_1, block_2 and block_3), 
--you can complete the design of this multiplier by connecting these blocks,
--or you can also design your own block based on your implementation.

ENTITY parallel_mult IS
	PORT (
		x, y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		z : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END parallel_mult;

ARCHITECTURE rtl OF parallel_mult IS

	COMPONENT block_1
		PORT (
			andgate_in_1 : IN STD_LOGIC;
			andgate_in_2 : IN STD_LOGIC;
			andgate_out : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT block_2
		PORT (
			a, b, c, cin : IN STD_LOGIC;
			cout, sum : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT block_3
		PORT (
			a, b, c : IN STD_LOGIC;
			cout, sum : OUT STD_LOGIC
		);
	END COMPONENT;

	-- speichert die sout-Werten jeder Zeile
	SIGNAL z1, z2, z3, z4 : STD_LOGIC_VECTOR(3 DOWNTO 0);

	-- speichert die Uebertraeger jeder Zeile
	SIGNAL u2, u3, u4 : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	-- block_1 -> &-Gatter
	-- block_2 -> VA
	-- block_3 -> HA

	-- row 1 nur &-Gatter
	row_0_0 : block_1 PORT MAP(x(0), y(0), z1(0));
	row_0_1 : block_1 PORT MAP(x(1), y(0), z1(1));
	row_0_2 : block_1 PORT MAP(x(2), y(0), z1(2));
	row_0_3 : block_1 PORT MAP(x(3), y(0), z1(3));

	-- 		  block_3 PORT MAP(a   , b   , c    , cout , sum  );
	--   	  block_2 PORT MAP(a   , b   , c	, cin  , cout , sum  );
	-- b, c ~= x, y
	-- a = previous z
	-- row 2 bis 4: HA bei Index 0 und VA bei dem Rest 
	row_1_0 : block_3 PORT MAP(z1(1), x(0), y(1), u2(0), z2(0));
	row_1_1 : block_2 PORT MAP(z1(2), x(1), y(1), u2(0), u2(1), z2(1));
	row_1_2 : block_2 PORT MAP(z1(3), x(2), y(1), u2(1), u2(2), z2(2));
	row_1_3 : block_2 PORT MAP('0', x(3), y(1), u2(2), u2(3), z2(3));

	row_2_0 : block_3 PORT MAP(z2(1), x(0), y(2), u3(0), z3(0));
	row_2_1 : block_2 PORT MAP(z2(2), x(1), y(2), u3(0), u3(1), z3(1));
	row_2_2 : block_2 PORT MAP(z2(3), x(2), y(2), u3(1), u3(2), z3(2));
	row_2_3 : block_2 PORT MAP(u2(3), x(3), y(2), u3(2), u3(3), z3(3));

	row_3_0 : block_3 PORT MAP(z3(1), x(0), y(3), u4(0), z4(0));
	row_3_1 : block_2 PORT MAP(z3(2), x(1), y(3), u4(0), u4(1), z4(1));
	row_3_2 : block_2 PORT MAP(z3(3), x(2), y(3), u4(1), u4(2), z4(2));
	row_3_3 : block_2 PORT MAP(u3(3), x(3), y(3), u4(2), u4(3), z4(3));

	z(0) <= z1(0);
	z(1) <= z2(0);
	z(2) <= z3(0);
	z(3) <= z4(0);
	z(4) <= z4(1);
	z(5) <= z4(2);
	z(6) <= z4(3);
	z(7) <= u4(3);
END rtl;

--first block
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY block_1 IS
	PORT (
		andgate_in_1 : IN STD_LOGIC;
		andgate_in_2 : IN STD_LOGIC;
		andgate_out : OUT STD_LOGIC
	);
END block_1;

ARCHITECTURE rtl OF block_1 IS
BEGIN
	andgate_out <= andgate_in_1 AND andgate_in_2;
END rtl;

--second block.
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY block_2 IS
	PORT (
		a, b, c, cin : IN STD_LOGIC;
		cout, sum : OUT STD_LOGIC
	);
END block_2;

ARCHITECTURE rtl OF block_2 IS
	SIGNAL d : STD_LOGIC;
BEGIN
	d <= b AND c;
	cout <= (a AND d) OR (a AND cin) OR (d AND cin);
	sum <= a XOR d XOR cin;
END rtl;

--third block.
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY block_3 IS
	PORT (
		a, b, c : IN STD_LOGIC;
		cout, sum : OUT STD_LOGIC
	);
END block_3;

ARCHITECTURE rtl OF block_3 IS
	SIGNAL d : STD_LOGIC;
BEGIN
	d <= b AND c;
	sum <= a XOR d;
	cout <= a AND d;
END rtl;