library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use ieee.numeric_std.all;

entity datenspeicher is 
port (clk, we : in  STD_LOGIC;
      alout , wd : in  STD_LOGIC_VECTOR (31 downto 0);
      rd : out STD_LOGIC_VECTOR (31 downto 0));
end;
architecture behave of datenspeicher is


type ramtype is array (255 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
signal mem: ramtype;
begin
 Schreibzugriff: process (clk , we )
  begin 
   if rising_edge(clk) then   
    if we = '1' then
      mem(to_integer(unsigned(alout))) <= wd ;
    end if;
   end if ; 
   end process ; 
 lesezugriff: process (we)
  begin 
   if we = '0'then 
        rd <= mem(to_integer(unsigned(alout)));
    end if;
 end process; 
 
end behave ; 
