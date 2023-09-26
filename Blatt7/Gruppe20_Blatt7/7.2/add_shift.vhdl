LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY add_shift IS
	PORT (
		p_in_1, p_in_2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		parallel_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END add_shift;
ARCHITECTURE behavioral OF add_shift IS

	TYPE Zustand IS (start, check, add, shift, check_finish);

	SIGNAL aktuellerZ, naechsterZ : Zustand;

	--PIPO Schieberegister 
	COMPONENT PIPO IS
		PORT (
			initial_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
			parallel_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			Clock, Clear : IN STD_LOGIC;
			parallel_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	--SIPO_L Schieberegister  (verschiebt nach links)
	COMPONENT SIPO_L IS
		PORT (
			initial_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
			serial_in, Clock, Clear : IN STD_LOGIC;
			parallel_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	--SIPO_R Schieberegister (verschiebt nach rechts)
	COMPONENT SISO_R IS
		PORT (
			initial_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
			serial_in, Clock, Clear : IN STD_LOGIC;
			serial_out : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT addierer IS
		PORT (
			a, b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			control : IN STD_LOGIC;
			summe : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL initial_PIPO, initial_SIPO, initial_SISO : STD_LOGIC_VECTOR(7 DOWNTO 0);

	SIGNAL wire_PIPO_adder, wire_adder_PIPO, wire_SIPO_L_adder : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL control_add, control_save, control_shift, control_clear : STD_LOGIC;
	SIGNAL SISO_R_in, SISO_R_out : STD_LOGIC;
	SIGNAL SIPO_L_in : STD_LOGIC;

	SIGNAL clock : STD_LOGIC;

BEGIN

	multiplikand_register : SIPO_L PORT MAP(initial_SIPO, SIPO_L_in, control_shift, control_clear, wire_SIPO_L_adder);
	multiplikator_register : SISO_R PORT MAP(initial_SISO, SISO_R_in, control_shift, control_clear, SISO_R_out);
	produkt_register : PIPO PORT MAP(initial_PIPO, wire_adder_PIPO, control_save, control_clear, wire_PIPO_adder);

	addierwerk : addierer PORT MAP(wire_PIPO_adder, wire_SIPO_L_adder, control_add, wire_adder_PIPO);

	-- Implemierung des Automaten für den Add-Shift Adder (fehlt)
	PROCESS (clock)
		VARIABLE count : INTEGER := 0;
		aktuellerZ := start;
	BEGIN
		IF (rising_edge(clock)) THEN
			CASE aktuellerZ IS
				WHEN start =>
					IF (p_in_1(count) = 1)
					END IF;
			END CASE;
		END IF;
	END PROCESS;

END behavioral;

-- Implementierung eines addierers auf Basis eines ripple-carry-adders, jedoch angepasst an die Aufgabe
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY addierer IS
	PORT (
		a, b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		control : IN STD_LOGIC;
		summe : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END addierer;

ARCHITECTURE behavioral OF addierer IS

	--Der rca von Blatt 3
	COMPONENT rca IS
		PORT (
			a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			cout : OUT STD_LOGIC;
			sum : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL s_out : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

	ripple : rca PORT MAP(a => a, b => b, sum => s_out);

	PROCESS (control) BEGIN
		IF (control'event AND control = '1') THEN
			summe <= s_out;
		END IF;
	END PROCESS;
END behavioral;

-- Implementierung eines PIPO Schieberegisters
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY PIPO IS
	PORT (
		initial_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
		parallel_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Clock, Clear : IN STD_LOGIC;
		parallel_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END PIPO;

ARCHITECTURE behavioral OF PIPO IS
BEGIN
	PROCESS (Clock) BEGIN
		IF (Clock'event AND Clock = '1') THEN
			IF (Clear = '1') THEN
				parallel_out <= initial_in;
			ELSE
				parallel_out <= parallel_in;
			END IF;
		END IF;
	END PROCESS;
END behavioral;

-- Implementierung eines SIPO Schieberegisters, welches nach links verschiebt
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY SIPO_L IS
	PORT (
		initial_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
		serial_in, Clock, Clear : IN STD_LOGIC;
		parallel_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END SIPO_L;

ARCHITECTURE behavioral OF SIPO_L IS

	SIGNAL s_out : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
	PROCESS (Clock) BEGIN
		IF (Clock'event AND Clock = '1') THEN
			IF (Clear = '1') THEN
				s_out <= initial_in;
			ELSE
				FOR i IN 7 DOWNTO 1 LOOP
					s_out(i) <= s_out(i - 1);
				END LOOP;
				s_out(0) <= serial_in;
			END IF;

		END IF;
		parallel_out <= s_out;
	END PROCESS;

END behavioral;
-- Implementierung eines SIPO Schieberegisters, welches nach rechts verschiebt
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY SISO_R IS
	PORT (
		initial_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
		serial_in, Clock, Clear : IN STD_LOGIC;
		serial_out : OUT STD_LOGIC
	);
END SISO_R;

ARCHITECTURE behavioral OF SISO_R IS

	SIGNAL s_out : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
	PROCESS (Clock) BEGIN
		IF (Clock'event AND Clock = '1') THEN
			IF (Clear = '1') THEN
				s_out <= initial_in;
			ELSE
				FOR i IN 0 TO 6 LOOP
					s_out(i) <= s_out(i + 1);
				END LOOP;
				s_out(7) <= serial_in;
			END IF;
		END IF;
	END PROCESS;

	serial_out <= s_out(0);

END behavioral;