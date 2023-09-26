library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.signext;

entity signext_tb is 
end signext_tb ;

architecture structure of signext_tb is 
component signext 
port(
    a: in std_logic_vector(15 downto 0);
    aext: out std_logic_vector(31 downto 0)
  );
end component ; 
signal a :std_logic_vector(15 downto 0);
signal aext : std_logic_vector(31 downto 0);
begin 
Testobject : signext 
 port map (a => a, aext => aext);
 
  a <="0110011100011101" after 0 ns , "1110011100011101" after 10 ns ,"0110011100011101" after 20 ns ,"0000000000000000" after 30 ns;
  
  end structure ;