library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.regfile;

entity regfile_tb is
end regfile_tb;

architecture structure of regfile_tb is 
component regfile
	port (
    clk: in std_logic;
    we3: in std_logic;
    a1: in std_logic_vector(4 downto 0);
    a2: in std_logic_vector(4 downto 0);
    a3: in std_logic_vector(4 downto 0);
    wd3: in std_logic_vector(31 downto 0);
    rd1: buffer std_logic_vector(31 downto 0);
    rd2: buffer std_logic_vector(31 downto 0)
  );
end component;
Signal clk, we3:	    std_logic;
signal a1, a2, a3:		std_logic_vector(4 downto 0);				  
signal rd1, rd2, wd3:	std_logic_vector(31 downto 0);
begin
Testobject: regfile
	port map(
		clk => clk,
        we3 => we3,
        a1 => a1,
        a2 => a2,
        a3 => a3,
        wd3 => wd3,
        rd1 => rd1,
        rd2 => rd2
	);
-- Schreiben 50 in Reg1 und 55 in Reg2
clk <= '0' after 0 ns,'1' after 10 ns, '0' after 20 ns,'1' after 30 ns, '0' after 40 ns;

we3 <= '1' after 0 ns;

wd3 <= "00000000000000000000000001010000" after 0 ns,
       "00000000000000000000000001010101" after 20 ns;

a3 <= "00001" after 0 ns, "00010" after 20 ns;

a1 <= "00000" after 0 ns, "00001" after 40 ns, "10000" after 50 ns; 

a2 <= "00000" after 0 ns, "00010" after 40 ns, "01000" after 50 ns;

end structure;