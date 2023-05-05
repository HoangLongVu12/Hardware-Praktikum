library ieee;
use ieee.std_logic_1164.all;

entity mux81_tb is
end mux81_tb;

architecture testbench of mux81_tb is
  component mux81
    port (i0_81 : in std_logic_vector(2 downto 0);
      i1_81 : in std_logic_vector(2 downto 0);
      i2_81 : in std_logic_vector(2 downto 0);
      i3_81 : in std_logic_vector(2 downto 0);
      i4_81 : in std_logic_vector(2 downto 0);
      i5_81 : in std_logic_vector(2 downto 0);
      i6_81 : in std_logic_vector(2 downto 0);
      i7_81 : in std_logic_vector(2 downto 0);
      sel_81 : in std_logic_vector(2 downto 0);
      y_81 : OUT std_logic_vector(2 downto 0));
  end component;

--missing (Signale)
-- ins and outs for tb
  signal i0, i1, i2, i3, i4, i5, i6, i7 : std_logic_vector(2 downto 0);
  signal sel : std_logic_vector(2 downto 0);
  signal yields : std_logic_vector(2 downto 0);
begin
    multiplex: mux81 port map(i0, i1, i2, i3, i4, i5, i6, i7, sel, yields);

    process begin
    -- Die vorgegebenen Werte werden an die Eingaenge des 8:1 Mux angelegt
    i0 <= "000";
    i1 <= "001";
    i2 <= "010";
    i3 <= "011";
    i4 <= "100";
    i5 <= "101";
    i6 <= "110";
    i7 <= "111";

    -- Die Eingaenge werden der Reihe nach durchgeschaltet    
    sel <= "000";
    wait for 10 ns;

    sel <= "001";
    wait for 10 ns;

    sel <= "010";
    wait for 10 ns;

    sel <= "011";
    wait for 10 ns;

    sel <= "100";
    wait for 10 ns;

    sel <= "101";
    wait for 10 ns;

    sel <= "110";
    wait for 10 ns;

    sel <= "111";
    wait for 10 ns;
	
	wait;
    end process;
end testbench;
