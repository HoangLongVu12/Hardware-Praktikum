library ieee;
use ieee.std_logic_1164.all;

entity mips_tb is
end mips_tb;

architecture rtl of mips_tb is

component mips
	port(
	clk: in std_logic;
    reset: in std_logic;
    pc: buffer std_logic_vector(31 downto 0);
    instr: in std_logic_vector(31 downto 0);
    readdata: in std_logic_vector(31 downto 0);
    aluout: buffer std_logic_vector(31 downto 0);
    writedata: buffer std_logic_vector(31 downto 0);
    memwrite: out std_logic
  );
end component;
	
	signal clk : std_logic;
	signal reset : std_logic;
	signal pc : std_logic_vector(31 downto 0);
	signal instr : std_logic_vector(31 downto 0);
	signal readdata : std_logic_vector(31 downto 0);
	signal aluout : std_logic_vector(31 downto 0);
	signal writedata : std_logic_vector(31 downto 0);
	signal memwrite : std_logic;
		
begin 
	
	prozessor : mips port map (clk => clk, reset => reset, pc => pc, instr => instr, readdata => readdata, aluout => aluout, writedata => writedata, memwrite => memwrite);
	
	process begin 
		
		reset <= '1';
		clk <= '0';
		wait for 10 ns;
		
		clk <= '1';
		reset <= '0';
		instr <= "00100000000000010000000000000110";	-- Speichern 6 in Reg1
		wait for 10 ns;
		
		clk <= '0';
		wait for 10 ns;
		
		clk <= '1';
		instr <= "00100000000000100000000000001000";	-- Speichern 8 in Reg2
		wait for 10 ns;
		
		clk <= '0';
		wait for 10 ns;
		
		clk <= '1';
		instr <= "00100000000000010000000000000000";	-- addi mit 0, damit man den Wert auslesen kann
		wait for 10 ns;
		
		clk <= '0';
		wait for 10 ns;
		
		clk <= '1';
		instr <= "00100000000000100000000000000000";	-- nochmal lesen mithilfe von addi 0
		wait for 10 ns;
		
		clk <= '0';
		wait for 10 ns;
		
		clk <= '1';
		instr <= "00000000001000110001100000100000";	-- Addieren 6 mit 8 und speichern Ergebnis in Reg 3
		wait for 10 ns;
		
		clk <= '0';
		wait for 10 ns;
		
		clk <= '1';
		instr <= "00100000000000110000000000000000";	-- Auslesen das Reg3
		wait for 10 ns;
		
		clk <= '0';
		wait for 10 ns;
		
		clk <= '1';
		instr <= "00001000000000000000000000000011";	-- Springe mit pc auf Adresse 12
		wait for 10 ns;

		clk <= '0';
		wait for 10 ns;
		
		clk <= '1';
		instr <= "00100000000001000000000000001000";	--Speichern 8 in Register 4
		wait for 10 ns;
		
		clk <= '0';
		wait for 10 ns;
		
		clk <= '1';
		instr <= "00010000011001000000000000001000";	-- Springen mit Pc 4+8 Adressen weiter, weil in beiden Registern 8 enthalten ist
		wait for 10 ns;

		wait;
	end process;
end rtl;