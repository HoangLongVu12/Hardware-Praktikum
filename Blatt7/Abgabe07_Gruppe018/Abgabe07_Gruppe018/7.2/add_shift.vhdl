library ieee;
use ieee.std_logic_1164.all;

entity add_shift is
    port (
	  p_in_1, p_in_2: in std_logic_vector(3 downto 0);
      parallel_out : out std_logic_vector(7 downto 0)
    );
  end add_shift;
  
  
architecture behavioral of add_shift is

	type Zustand is (start, check, add, shift, check_finish);
	
	signal aktuellerZ, naechsterZ: Zustand;


	--PIPO Schieberegister 
	component PIPO is
		port (
			initial_in: std_logic_vector(7 downto 0);
		  parallel_in : in std_logic_vector(7 downto 0);
		  Clock, Clear: in std_logic;
		  parallel_out : out std_logic_vector(7 downto 0)
		);
	end component;
	
	
	--SIPO_L Schieberegister  (verschiebt nach links)
	component SIPO_L is
		port (
			initial_in: std_logic_vector(7 downto 0); 
		  serial_in, Clock, Clear: in std_logic;
		  parallel_out : out std_logic_vector(7 downto 0)
		);
	end component;
	
	--SIPO_R Schieberegister (verschiebt nach rechts)
	component SISO_R is
		port (
			initial_in: std_logic_vector(7 downto 0);
		  serial_in, Clock, Clear: in std_logic;
		  serial_out : out std_logic
		);
	end component;
	
	component addierer is
		port (
			a, b : in std_logic_vector(7 downto 0);
			control: in std_logic;
			summe : out std_logic_vector(7 downto 0)
		);
	end component;
	
	
	
	signal initial_PIPO, initial_SIPO, initial_SISO: std_logic_vector(7 downto 0);
	
	signal wire_PIPO_adder, wire_adder_PIPO, wire_SIPO_L_adder:std_logic_vector(7 downto 0);
	signal control_add, control_save, control_shift, control_clear : std_logic;
	signal SISO_R_in, SISO_R_out: std_logic;
	signal SIPO_L_in: std_logic;

	signal clock: std_logic;
	
begin

	multiplikand_register:SIPO_L port map (initial_SIPO, SIPO_L_in, control_shift, control_clear, wire_SIPO_L_adder);
	multiplikator_register:SISO_R port map (initial_SISO, SISO_R_in, control_shift, control_clear, SISO_R_out);
	produkt_register:PIPO port map (initial_PIPO, wire_adder_PIPO, control_save, control_clear, wire_PIPO_adder);
	
	addierwerk:addierer port map(wire_PIPO_adder, wire_SIPO_L_adder, control_add, wire_adder_PIPO);
	
    -- Implemierung des Automaten für den Add-Shift Adder (fehlt)
    process (clock)
		variable count : INTEGER := 0;
		aktuellerZ := start;
	begin
		if (rising_edge(clock)) then
			case aktuellerZ is
				when start =>
					if (p_in_1(count) = 1)
					end if;
			end case;
		end if;
	end process;


end behavioral ;


-- Implementierung eines addierers auf Basis eines ripple-carry-adders, jedoch angepasst an die Aufgabe
library ieee;
use ieee.std_logic_1164.all;
entity addierer is
	port (
		a, b : in std_logic_vector(7 downto 0);
		control: in std_logic;
		summe : out std_logic_vector(7 downto 0)
    );
end addierer;

architecture behavioral of addierer is
	
	--Der rca von Blatt 3
	component rca is
		port (
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		cout : out std_logic;
		sum : out std_logic_vector(7 downto 0)
	  );
	  end component;
	
	signal s_out: std_logic_vector(7 downto 0);
	
begin

	ripple:rca port map (a=>a, b=>b, sum=>s_out);

	process (control) begin
		if(control'event and control = '1') then
			summe<=s_out;
		end if;
	end process;
	
	
end behavioral;



-- Implementierung eines PIPO Schieberegisters
library ieee;
use ieee.std_logic_1164.all;
entity PIPO is
	port (
		initial_in: std_logic_vector(7 downto 0);
      parallel_in : in std_logic_vector(7 downto 0);
	  Clock, Clear: in std_logic;
      parallel_out : out std_logic_vector(7 downto 0)
    );
end PIPO;

architecture behavioral of PIPO is
begin
	process (Clock) begin
		if(Clock'event and Clock = '1') then
		if(Clear = '1') then
				parallel_out <= initial_in;
			else
				parallel_out <= parallel_in;
			end if;
		end if;
	end process;
end behavioral;




-- Implementierung eines SIPO Schieberegisters, welches nach links verschiebt
library ieee;
use ieee.std_logic_1164.all;
entity SIPO_L is
	port (
		initial_in: std_logic_vector(7 downto 0); 
      serial_in, Clock, Clear: in std_logic;
      parallel_out : out std_logic_vector(7 downto 0)
    );
end SIPO_L;

architecture behavioral of SIPO_L is
	
	signal s_out: std_logic_vector(7 downto 0);
	
begin
	process (Clock) begin
		if(Clock'event and Clock = '1') then
			if(Clear = '1') then
				s_out <= initial_in;
			else
				for i in 7 downto 1 loop
					s_out(i) <= s_out(i-1);
				end loop;
				s_out(0) <= serial_in;
			end if;
			
		end if;
		
	end process;
	parallel_out<=s_out;
	
	
end behavioral;


-- Implementierung eines SIPO Schieberegisters, welches nach rechts verschiebt
library ieee;
use ieee.std_logic_1164.all;
entity SISO_R is
	port (
		initial_in: std_logic_vector(7 downto 0);
      serial_in, Clock, Clear: in std_logic;
      serial_out : out std_logic
    );
end SISO_R;

architecture behavioral of SISO_R is
	
	signal s_out: std_logic_vector(7 downto 0);
	
begin
	process (Clock) begin
		if(Clock'event and Clock = '1') then
			if(Clear = '1') then
				s_out <= initial_in;
			else
				for i in 0 to 6 loop
					s_out(i) <= s_out(i+1);
				end loop;
				s_out(7) <= serial_in;
			end if;
		end if;
	end process;
	
	serial_out<=s_out(0);
	
end behavioral;
