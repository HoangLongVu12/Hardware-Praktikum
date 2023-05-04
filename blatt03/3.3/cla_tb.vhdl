library ieee;
use ieee.std_logic_1164.all;

entity cla_tb is
end cla_tb;

architecture test of cla_tb is
    component cla 
        port (
            a : in STD_LOGIC_VECTOR(3 downto 0);
            b : IN STD_LOGIC_VECTOR(3 downto 0);
            cin : in STD_LOGIC;
            cout : out STD_LOGIC;
            sum : out STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    end component;

    signal a : STD_LOGIC_VECTOR(3 downto 0);
    signal b : STD_LOGIC_VECTOR(3 downto 0);
    signal cin : STD_LOGIC;
    signal cout : STD_LOGIC;
    signal sum : STD_LOGIC_VECTOR(3 downto 0);
begin
    cladder : cla port map(a => a, b => b, cin => cin, cout => cout, sum => sum);

    process begin
        a <= "1001";
        b <= "0101";
        cin <= '0';
        wait for 10 ns;

        a <= "0000";
        b <= "0001";
        cin <= '0';
        wait for 10 ns;

        a <= "0011";
        b <= "0010";
        cin <= '0';
        wait for 10 ns;

        a <= "1010";
        b <= "0110";
        cin <= '0';
        wait for 10 ns;
        wait;
    end process;

end test;