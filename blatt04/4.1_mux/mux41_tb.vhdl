library ieee;
use ieee.std_logic_1164.all;

entity mux41_tb is
end mux41_tb;

architecture testbench of mux41_tb is
  component mux41
    port (
      i0 : in std_logic_vector(2 downto 0);
      i1 : in std_logic_vector(2 downto 0);
      i2 : in std_logic_vector(2 downto 0);
      i3 : in std_logic_vector(2 downto 0);
      sel : in std_logic_vector(1 downto 0);
      y : out std_logic_vector(2 downto 0)
    );
  end component;

--missing (signals)
-- ins and outs for testbench
  signal in0 : std_logic_vector(2 downto 0);
  signal in1 : std_logic_vector(2 downto 0);
  signal in2 : std_logic_vector(2 downto 0);
  signal in3 : std_logic_vector(2 downto 0);
  signal selector : std_logic_vector(1 downto 0);
  signal yields : std_logic_vector(2 downto 0);

begin
    multiplex: mux41 port map(i0 => in0, i1 => in1, i2 => in2, i3 => in3, sel => selector, y => yields);

    process begin
    --setting the input values
    in0 <= "000";
    in1 <= "001";
    in2 <= "010";
    in3 <= "011";
    --switching which input is propagated
    selector <= "00";
    wait for 10 ns;
    selector <= "01";
    wait for 10 ns;
    selector <= "10";
    wait for 10 ns;
    selector <= "11";
    wait for 10 ns;
    selector <= "10";
    wait for 10 ns;
    selector <= "11";
    wait for 10 ns;

		
        wait;
    end process;
end testbench;
