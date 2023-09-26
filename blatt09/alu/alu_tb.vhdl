library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu;

entity alu_tb is 
end alu_tb;

architecture structure of alu_tb is 
component alu 
port(
    a: in std_logic_vector(31 downto 0);
    b: in std_logic_vector(31 downto 0);
    alucontrol: in std_logic_vector(2 downto 0);
    result: buffer std_logic_vector(31 downto 0);
    zero: out std_logic
  );
end component ;
signal a , b , result : std_logic_vector(31 downto 0);
signal alucontrol : std_logic_vector(2 downto 0);
signal zero: std_logic;
begin 
Testobject : alu 
port map (a => a , 
          b => b, 
		  alucontrol => alucontrol , 
		  result => result , 
		  zero => zero
         );
		 
 alucontrol <= "000" after 0 ns, "001" after 10 ns, "010" after 20 ns, "011" after 30 ns,"100" after 40 ns ,"101" after 50 ns, "110" after 60 ns, "111" after 70 ns, "000" after 80 ns;
 a <= "00000000000001000000000000001000";
 b <= "00000000000000000110000100011000";
 
 end structure ;
