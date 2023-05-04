library ieee;
use ieee.std_logic_1164.all;

entity clag is
  port (
    gin : in std_logic_vector(3 downto 0);
    pin : in std_logic_vector(3 downto 0);
    cin : in std_logic;
    cout : out std_logic_vector(3 downto 0);
    pout : out std_logic;
    gout : out std_logic
  );
end clag;

architecture rtl of clag is
  signal z1, z2, z3, z4 : STD_LOGIC;
begin
  z1 <= gin(0) or (pin(0) and cin);
  z2 <= gin(1) or (pin(1) and z1);
  z3 <= gin(2) or (pin(2) and z2);
  z4 <= gin(3) or (pin(3) and z3);

  cout(0) <= z1;
  cout(1) <= z2;
  cout(2) <= z3;
  cout(3) <= z4;

  pout <= pin(3) and pin(2) and pin(1) and pin(0);
  gout <= gin(3) or (pin(3) and gin(2)) or (pin(3) and pin(2) and gin(1)) or (pin(3) and pin(2) and pin(1) and gin(0));

end rtl;
