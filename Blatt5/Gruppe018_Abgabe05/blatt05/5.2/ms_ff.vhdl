library ieee;
use ieee.std_logic_1164.all;

entity ms_ff is
    port (
      d, clk: in std_logic;
      Q, not_Q : out std_logic
    );
  end ms_ff;

architecture behavioral of ms_ff is
    COMPONENT D_Latch IS
    PORT (
      D, clk : IN STD_LOGIC;
      Q, not_Q : OUT STD_LOGIC
    );
    END COMPONENT;

    -- invertiert clk
    SIGNAL notclk : STD_LOGIC;
    -- n1 Mittelsignal
    SIGNAL n1 : STD_LOGIC;
    -- Füllsignale (master!Q brauchen wir nicht)
    SIGNAL nqm : STD_LOGIC;

begin
    notclk <= NOT clk;
    -- n1 = masterQ
    master : D_Latch PORT MAP(d, notclk, n1, nqm);
    slave : D_Latch PORT MAP(n1, clk, Q, not_Q);

end behavioral ;