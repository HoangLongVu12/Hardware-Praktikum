library ieee;
use ieee.std_logic_1164.all;

entity SR_Latch_tb is
end SR_Latch_tb;

architecture testbench of SR_Latch_tb is
    COMPONENT SR_Latch IS
        PORT (
            S, R : IN STD_LOGIC;
            Q, not_Q : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL s, r, q, nq : STD_LOGIC;
    SIGNAL test : STD_LOGIC;

begin
    srlatch : SR_Latch PORT MAP(s, r, q, nq);
    process begin
        S <= '1';
        R <= '1';
        wait for 10 ns;
        S <= '0';
        R <= '0';
        wait for 10 ns;
        S <= '1';
        R <= '0';
        wait for 10 ns;
        S <= '0';
        R <= '1';
        wait for 10 ns;
        wait;
    end process;
end testbench;
