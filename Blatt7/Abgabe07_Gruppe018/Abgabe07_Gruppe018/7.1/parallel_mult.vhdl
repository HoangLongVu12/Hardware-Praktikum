library ieee;
use ieee.std_logic_1164.all;

--Three blocks are provided in this template(block_1, block_2 and block_3), 
--you can complete the design of this multiplier by connecting these blocks,
--or you can also design your own block based on your implementation.

entity parallel_mult is
  port (
    x,y : in std_logic_vector(3 downto 0);
	z : out std_logic_vector(7 downto 0)
  );
end parallel_mult;

architecture rtl of parallel_mult is
	-- speichert die sout-Werten jeder Zeile
	signal z1, z2, z3, z4 : std_logic_vector(3 downto 0);

	-- speichert die Uebertraeger jeder Zeile
	signal u2, u3, u4 : std_logic_vector(3 downto 0);
	
	component block_1
	port (
    andgate_in_1: in std_logic;
    andgate_in_2: in std_logic;
    andgate_out: out std_logic
	);
	end component;
	
    component block_2
	port (
    a,b,c,cin : in std_logic;
    cout,sum : out std_logic
	);
	end component;
    
	component block_3 
	port (
    a,b,c: in std_logic;
    cout,sum: out std_logic
	);
	end component;
	 
begin
	-- block_1 -> &-Gatter
	-- block_2 -> VA
	-- block_3 -> HA

	-- row 1 nur &-Gatter
	row_0_0 : block_1 port map(x(0), y(0), z1(0));
	row_0_1 : block_1 port map(x(1), y(0), z1(1));
	row_0_2 : block_1 port map(x(2), y(0), z1(2));
	row_0_3 : block_1 port map(x(3), y(0), z1(3));

	-- block_3 port map(a   , b   , c    , cout , sum  );
	-- block_2 port map(a   , b   , c	, cin  , cout , sum  );
	-- b, c ~= x, y
	-- a = previous z
	-- row 2 bis 4: HA bei Index 0 und VA bei dem Rest 
	row_1_0 : block_3 port map(z1(1), x(0), y(1), u2(0), z2(0));
	row_1_1 : block_2 port map(z1(2), x(1), y(1), u2(0), u2(1), z2(1));
	row_1_2 : block_2 port map(z1(3), x(2), y(1), u2(1), u2(2), z2(2));
	row_1_3 : block_2 port map('0', x(3), y(1), u2(2), u2(3), z2(3));

	row_2_0 : block_3 port map(z2(1), x(0), y(2), u3(0), z3(0));
	row_2_1 : block_2 port map(z2(2), x(1), y(2), u3(0), u3(1), z3(1));
	row_2_2 : block_2 port map(z2(3), x(2), y(2), u3(1), u3(2), z3(2));
	row_2_3 : block_2 port map(u2(3), x(3), y(2), u3(2), u3(3), z3(3));

	row_3_0 : block_3 port map(z3(1), x(0), y(3), u4(0), z4(0));
	row_3_1 : block_2 port map(z3(2), x(1), y(3), u4(0), u4(1), z4(1));
	row_3_2 : block_2 port map(z3(3), x(2), y(3), u4(1), u4(2), z4(2));
	row_3_3 : block_2 port map(u3(3), x(3), y(3), u4(2), u4(3), z4(3));

	z(0) <= z1(0);
	z(1) <= z2(0);
	z(2) <= z3(0);
	z(3) <= z4(0);
	z(4) <= z4(1);
	z(5) <= z4(2);
	z(6) <= z4(3);
	z(7) <= u4(3);
end rtl;

--first block
library ieee;
use ieee.std_logic_1164.all;

entity block_1 is
  port (
    andgate_in_1: in std_logic;
    andgate_in_2: in std_logic;
    andgate_out: out std_logic
  );
end block_1;

architecture rtl of block_1 is
begin
	andgate_out <= andgate_in_1 and andgate_in_2;
end rtl;

--second block.
library ieee;
use ieee.std_logic_1164.all;

entity block_2 is
  port (
    a,b,c,cin : in std_logic;
    cout,sum : out std_logic
  );
end block_2;

architecture rtl of block_2 is
  signal d : std_logic;
begin
	d <= b and c;
	cout <= (a and d) or (a and cin) or (d and cin);
	sum <= a xor d xor cin;
end rtl;

--third block.
library ieee;
use ieee.std_logic_1164.all;

entity block_3 is
  port (
    a,b,c: in std_logic;
    cout,sum: out std_logic
  );
end block_3;

architecture rtl of block_3 is
	signal d : std_logic;
begin
	d <= b and c;
	sum <= a xor d;
	cout <= a and d;
end rtl;
