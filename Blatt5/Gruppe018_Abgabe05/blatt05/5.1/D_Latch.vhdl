library ieee;
use ieee.std_logic_1164.all;

entity D_Latch is
    port(
        D, clk : in std_logic;
        Q, not_Q : out std_logic
    );
end D_Latch;

architecture Behavioral of D_Latch is
    COMPONENT SR_latch IS
        PORT (
            S, R : IN STD_LOGIC;
            Q, not_Q : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT andgate IS
        PORT (
            input1, input2 : IN STD_LOGIC;
            and_result : OUT STD_LOGIC
        );
    END COMPONENT;
    -- Negierter Wert von d speichern
    SIGNAL notd : STD_LOGIC;
    -- Zugewiesene Werte in R und S speichern
    SIGNAL r, s : STD_LOGIC;

begin
    notd <= NOT D;
    -- and-Gatter für den Eingang R
    andr : andgate PORT MAP(clk, notd, r);
    -- and-Gatter für den Eingang S
    ands : andgate PORT MAP(clk, D, s);
    -- SR-Latch
    sr : SR_latch PORT MAP(s, r, Q, not_Q);
end Behavioral;
