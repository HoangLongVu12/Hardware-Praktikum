library ieee;
use ieee.std_logic_1164.all;

entity demux14_tb is
end demux14_tb;

architecture testbench of demux14_tb is
--missing
COMPONENT demux14 IS
        PORT (
            I_n : IN std_logic_vector(2 DOWNTO 0);
            sel : IN std_logic_vector(1 DOWNTO 0);
            Y0 : OUT std_logic_vector(2 DOWNTO 0);
            Y1 : OUT std_logic_vector(2 DOWNTO 0);
            Y2 : OUT std_logic_vector(2 DOWNTO 0);
            Y3 : OUT std_logic_vector(2 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL inp, y0, y1, y2, y3 : std_logic_vector(2 DOWNTO 0);
    SIGNAL selector : std_logic_vector(1 DOWNTO 0);

BEGIN
    demultiplex : demux14 PORT MAP(inp, selector, y0, y1, y2, y3);

    PROCESS BEGIN
        --setting the input values
        inp <= "101";
        --switching which input is propagated
        selector <= "00";
        WAIT FOR 10 ns;
        selector <= "01";
        WAIT FOR 10 ns;
        selector <= "10";
        WAIT FOR 10 ns;
        selector <= "11";
        WAIT FOR 10 ns;

        -- testing for different inp
        inp <= "010";
        --switching which input is propagated
        selector <= "00";
        WAIT FOR 10 ns;
        selector <= "01";
        WAIT FOR 10 ns;
        selector <= "10";
        WAIT FOR 10 ns;
        selector <= "11";
        WAIT FOR 10 ns;

        inp <= "111";
        --switching which input is propagated
        selector <= "00";
        WAIT FOR 10 ns;
        selector <= "01";
        WAIT FOR 10 ns;
        selector <= "10";
        WAIT FOR 10 ns;
        selector <= "11";
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;
end testbench;