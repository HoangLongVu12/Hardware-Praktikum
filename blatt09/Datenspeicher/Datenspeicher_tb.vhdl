library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use ieee.numeric_std.all;

entity Datenspeicher_tb is
end entity;

architecture test of Datenspeicher_tb is 
 component Datenspeicher
  port (clk, we : in  STD_LOGIC;
      alout , wd : in  STD_LOGIC_VECTOR (31 downto 0);
      rd : out STD_LOGIC_VECTOR (31 downto 0));
 end component ;
 
 signal clk , we :  STD_LOGIC;
 signal alout , rd , wd : STD_LOGIC_VECTOR(31 downto 0);
 
begin 
 speicher : Datenspeicher port map ( clk ,we , alout , wd , rd ); 
 process 
 begin
 clk <= '0';
 
 wait for 10 ns;
 clk <= '1';
 we <= '1';
 alout <= x"00000006";
 wd <= x"00000008";
 -- Speichern 8 in Addresse 6
 wait for 10 ns ;
 we <= '0';
 -- Auslesen 
 wait for 10 ns ;
 
 wait ;
end process;

end test;
