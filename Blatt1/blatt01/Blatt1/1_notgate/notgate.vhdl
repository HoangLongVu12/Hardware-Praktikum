-- from the ieee libary we use std_logic_1164
-- defines a standard for logic values used in electronic design
-- for more info check the std_logic_1164.vhdl file in ghdl/libraries/ieee
-- ieee libary also defines operators and keywords

-- wir verwenden std_logic_1164 aus der IEEE libary
-- diese Datei definiert die Standards fuer logische Werte im elektronischen Design
-- Details finden sich in der Datei std_logic_1164.vhdl in ghdl/libraries/ieee
-- Die IEEE libary definiert auch operatoren und Schluesselwoerter
library ieee;
use ieee.std_logic_1164.all;

-- entities defined in a file (notgate.vhdl) are can be seen as black boxes
-- entities have ports that defines all inputs and outputs 
-- std_logic can have 9 different values, it is part of std_logic_1164 package
-- you can think of it as a single bit

-- die in einer Datei definierten entities koennen als black box angesehen werden. 
-- entities haben ports die Eingaben und Ausgaben definieren
-- std_logic can 9 unterschiedliche Werte annehmen (mehr dazu auf Blatt 2)
-- kann als einzelnes bit verstanden werden
entity notgate is
  -- the notgate as one in port named "input" and one out port named "not_result"
  -- das notgate hat einen Eingangsport "input" und einen Ausgangsport "not_result"
  port (
    input : in std_logic;
    not_result : out std_logic
  );
end notgate;

-- architecture describes functionality of particular entity
-- like the implementation of a function
-- actually describes the "internal wiring" of block
-- interconnection signals, constants, or other components

-- die Architekture beschreibt die Funktionalitaet einer entity
-- aehnlich wie die Implementierung einer Funktion
-- beschreibt die "innere Verdrahtung" eines blocks
-- verbindet Signale, Konstanten oder andere Komponenten
architecture rtl of notgate is
  -- internal signal, not yet connected to the outside
  -- internes Signal, bisher nicht nach aussen verbunden
  signal not_gate : std_logic;
begin
  -- setting the internal signal, based on the desired logical functionality (here: negation of the input value)
  -- internes Signal wird entsprechend der benoetigten Funktionalitaet gesetzt (hier: Negierung des Eingabewertes)
  not_gate <= not(input);
  -- internal signal gets connected to the outside
  -- internes Signal wird nach aussen verbunden
  not_result <= not_gate;
end rtl;
