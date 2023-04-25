-- creates a nandgate by combining two previously created components: an andgate and a notgate
-- erzeugt ein nandgate aus zwei vorher erstellten Komponenten: einem andgate und einem notgate

library ieee;
use ieee.std_logic_1164.all;

entity nandgate is
  port (
    nand_in1 : in std_logic;
    nand_in2 : in std_logic;
    nand_result : out std_logic
  );
end nandgate;

architecture rtl of nandgate is
  -- component declaration, so that it can be instantiated later
  -- components are ofen defined in other files
  -- must have same name and port list as the entity
  
  -- Komponenten Dekleration, damit diese spaeter instanziert werden können
  -- die Komponenten werden meist in andere Dateien definiert
  -- die Komponenten muessen den gleichen Namen und die gleich port list haben wie die vorher definierten Komponenten
  component andgate is
    port (
    input1 : in std_logic;
    input2 : in std_logic;
    and_result : out std_logic
  );
  end component andgate;

  component notgate is
    port (
    input : in std_logic;
    not_result : out std_logic
  );
  end component notgate;

  signal and_gate_out : std_logic;
begin
  -- two components are initialised, an andgate named "logical_and" and a notgate named "negate"
  -- the port map connects the in/outputs of the components with the signals of the architecture 
  -- for "logical_and", the two inputs are connected to the inputs of the nandgate
  -- the output is connected to the internal signal "and_gate_out"
  
  -- instanziert zwei Komponenten, ein andgate mit namen "logical_and" und ein notgate mit namen "negate"
  -- die port map "verbindet" die Ein/Ausgaenge der Komponenten den Signale die zur Architektur gehören 
  -- fuer "logical_and" sind die beiden inputs mit den inputs des nandgates verbunden
  -- der output ist mit dem internen signal "and_gate_out" verbunden
  logical_and : andgate port map(input1 => nand_in1, input2 => nand_in2, and_result => and_gate_out);
  negate : notgate port map(input => and_gate_out, not_result => nand_result);
end rtl;
