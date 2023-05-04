library ieee;
use ieee.std_logic_1164.all;

entity facla is
  port (
    a : in std_logic;
    b : in std_logic;
    cin : in std_logic;
    g : out std_logic;
    p : out std_logic;
    sum : out std_logic
  );
end facla;

architecture rtl of facla is
  signal mittel : STD_LOGIC;
begin
  g <= a and b;
  p <= a or b;
  mittel <= a xor b;
  sum <= mittel xor cin;
end rtl;
