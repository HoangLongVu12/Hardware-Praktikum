library ieee;
use ieee.std_logic_1164.all;

entity encoder42 is 
	port (
		i : in  std_logic_vector(3 downto 0);
		y : out std_logic_vector(1 downto 0)
		);
end encoder42;

architecture rtl of encoder42 is
--missing
-- signals to temporarily save the value for complex terms
	signal noti2, ni2andi1 : std_logic;
begin
	y(1) <= i(2) or i(3);
	noti2 <= not i(2);
	ni2andi1 <= noti2 and i(1);
	y(0) <= i(3) or ni2andi1;
end rtl;