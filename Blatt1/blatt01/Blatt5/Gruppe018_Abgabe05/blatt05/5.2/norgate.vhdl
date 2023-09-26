LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY norgate IS
  PORT (
    input1 : IN STD_LOGIC;
    input2 : IN STD_LOGIC;
    nor_result : OUT STD_LOGIC
  );
END norgate;

ARCHITECTURE rtl OF norgate IS
  SIGNAL nor_gate : STD_LOGIC;
BEGIN
  nor_gate <= input1 NOR input2;
  nor_result <= nor_gate;
END rtl;