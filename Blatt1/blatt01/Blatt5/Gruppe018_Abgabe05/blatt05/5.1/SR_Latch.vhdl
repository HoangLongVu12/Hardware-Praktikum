library ieee;
use ieee.std_logic_1164.all;

entity SR_Latch is
    port (
      S,R : in std_logic;
      Q,not_Q : out std_logic
    );
  end SR_Latch;

architecture Behavioral of SR_Latch is
    COMPONENT norgate IS
    PORT (
      input1 : IN STD_LOGIC;
      input2 : IN STD_LOGIC;
      nor_result : OUT STD_LOGIC
    );
    END COMPONENT;
	-- wir brauchen 2 andere Signale, die diesen Ausgabewert als Eingabewert des anderen Gatters speichern, da Q und not_Q nicht unmittelbar gelesen werden können
    SIGNAL q1, q2 : STD_LOGIC;
    -- q1 ~ Q, q2 ~ not_Q

begin
    -- erste nor Gatter mit S als Input
   snor : norgate PORT MAP(S, q1, q2);
   -- zweite nor Gatter mit R als Input
   rnor : norgate PORT MAP(R, q2, q1);
   -- dann speichern wir temporal die Variablen im Output
   Q <= q1;
   not_Q <= q2;

end Behavioral;
