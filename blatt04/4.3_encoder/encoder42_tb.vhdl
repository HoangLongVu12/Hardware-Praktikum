library ieee;
use ieee.std_logic_1164.all;

entity encoder42_tb is
end encoder42_tb;

architecture testbench of encoder42_tb is
--missing
component encoder42 is
        PORT (
            i : in STD_LOGIC_VECTOR(3 downto 0);
            y : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    signal inp : STD_LOGIC_VECTOR(3 downto 0);
    signal outp : STD_LOGIC_VECTOR(1 downto 0);

begin
    encoder : encoder42 port map(inp, outp);

    process begin
        inp <= "0001";
        wait for 10 ns;

        inp <= "0010";
        wait for 10 ns;

        inp <= "0100";
        wait for 10 ns;

        inp <= "1000";
        wait for 10 ns;

        -- further tb

        inp <= "1111";
        wait for 10 ns;

        inp <= "0110";
        wait for 10 ns;

        inp <= "0110";
        wait for 10 ns;

        inp <= "0011";
        wait for 10 ns;

        wait;
    end process;
end testbench;