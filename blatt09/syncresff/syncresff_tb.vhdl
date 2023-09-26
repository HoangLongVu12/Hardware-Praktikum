library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.syncresff;

entity syncresff_tb is
end syncresff_tb;

architecture structure of syncresff_tb is 
component syncresff
    generic (w: integer :=4);
	port (
    clk: in std_logic;
    reset: in std_logic;
    d: in std_logic_vector(w-1 downto 0);
    q: buffer std_logic_vector(w-1 downto 0)
  );
end component;
Signal clk, reset:	    std_logic;
signal d, q:		std_logic_vector(3 downto 0);				  
begin
Testobject: syncresff
	port map(
	clk => clk,
    reset => reset,
    d => d,
    q => q
	);

clk <= '0' after 0 ns,'1' after 10 ns, '0' after 20 ns,'1' after 30 ns, '0' after 40 ns,'1' after 50 ns, '0' after 60 ns;
d <= "0101" after 10 ns, "1011" after 20 ns, "0111" after 40 ns;
reset <= '1' after 0 ns, '0' after 40 ns;


end structure;