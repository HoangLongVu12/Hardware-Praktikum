LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY and_gate IS
  PORT (
    input1 : IN STD_LOGIC;
    input2 : IN STD_LOGIC;
    input3 : IN STD_LOGIC;
    and_output : OUT STD_LOGIC
  );
END and_gate;

ARCHITECTURE rtl OF and_gate IS
  SIGNAL andgate : STD_LOGIC;
BEGIN
  andgate <= input1 AND input2 AND input3;
  and_output <= andgate;
END rtl;