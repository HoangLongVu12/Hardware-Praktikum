library ieee;
use ieee.std_logic_1164.all;

entity datapath_tb is
end datapath_tb;

architecture rtl of datapath_tb is

component datapath 
	port(
	 clk: in std_logic;
    reset: in std_logic;
    memtoreg: std_logic;
    pcsrc: std_logic;
    alusrc: in std_logic;
    regdst: in std_logic;
    regwrite: in std_logic;
    jump: in std_logic;
    alucontrol: in std_logic_vector(2 downto 0);
    readdata: in std_logic_vector(31 downto 0);
    instr: in std_logic_vector(31 downto 0);
    zero: out std_logic;
    pc: buffer std_logic_vector(31 downto 0);
    aluout: buffer std_logic_vector(31 downto 0);
    writedata: buffer std_logic_vector(31 downto 0)
  );
end component;
	
	signal clk : std_logic;
	signal reset : std_logic;
    signal memtoreg : std_logic;
    signal pcsrc : std_logic;
    signal alusrc : std_logic;
    signal regdst: std_logic;
    signal regwrite : std_logic;
    signal jump : std_logic;
    signal alucontrol :  std_logic_vector(2 downto 0);
    signal readdata : std_logic_vector(31 downto 0);
    signal instr : std_logic_vector(31 downto 0);
    signal zero: std_logic;
    signal pc : std_logic_vector(31 downto 0);
    signal aluout : std_logic_vector(31 downto 0);
    signal writedata : std_logic_vector(31 downto 0);
	
begin

data : datapath port map (clk, reset, memtoreg, pcsrc, alusrc, regdst, regwrite, jump, alucontrol, readdata, instr, zero, pc, aluout, writedata);

process begin 
    
--A
    clk <= '0';
    reset <= '1';
    memtoreg <= '1';-- Nehmen Readdata aus DataMemmory auf
    pcsrc <= '0';
    alusrc <= '1';		
    regdst <= '0';-- Schreiben in das von 20:16 Bits spezifizierte Register 
    regwrite <= '1';-- Bereit zu schreiben
    jump <= '1';
    alucontrol <= "111";
    readdata <= x"00000006";-- Speicher 6
	instr(20 downto 16) <= "00001";-- in den Reg1
    wait for 10 ns ;
    reset <= '0'; 
    clk <= '1';
    -- damit wird der Zahl 6 in den Reg1 gespeichert 
    wait for 5 ns ;
    clk <= '0';
	readdata <= x"00000008";-- Speicher 8
	instr(20 downto 16) <= "00010";-- in den Reg2
    wait for 5 ns ; 
    clk  <= '1';  
    -- damit wird der Zahl 8 in den Reg2 gespeichert 
    wait for 10 ns ; 
    --Auslesen  
    instr(25 downto 21) <= "00001";-- a1(25:21="00001")
	instr(20 downto 16) <= "00010";-- a2(20:16="00010")
	instr(15 downto 0) <= x"0000";-- 0ffset=x"0000" 	
	alucontrol <= "001";-- (a or Offset)=a
    -- Ergebnisse werden an aluout und writedata ausgegeben	
    clk <= '0';
    wait for 10 ns;
--B
    alusrc <= '0';--Waehlen rd2
	alucontrol <= "010";-- Ausfuehren Addition;
	memtoreg <= '0';
	regdst <= '1';
	instr(15 downto 11) <= "00011";-- Speichern Summe in den Reg3
    wait for 5 ns;	
	clk <= '1';
	--damit wird die Summe 6+8 in den Reg3 gespeichert
    wait for 5 ns;
    --Auslesen der Summe
	instr(20 downto 16) <= "00011";
	--Ergebniss wird an writedata ausgegeben
	clk <= '0';
	wait for 10 ns;
--C
    alusrc <= '1';--Waehlen Offset
	instr(25 downto 21) <= "00011";
	instr(15 downto 0) <= x"0007";--Addieren 7 dazu
	instr(20 downto 16) <= "00100";--Speicher in den Reg4
	regdst <= '0';
	wait for 5 ns;
	clk <= '1';
	--damit wird die Summe 14+6 in den Reg4 gespeichert
	wait for 5 ns;
	instr(20 downto 16) <= "00011";
	wait for 10 ns;
	--Auslesen der Summe
	instr(20 downto 16) <= "00100";
	--Ergebniss wird an writedata ausgegeben
	clk <= '0';
	wait for 10 ns;
--D	
	clk <= '1';
	jump <= '1';
	instr(25 downto 0) <= "00000000000000000000110010";	-- springe mit dem PC wert auf 50
	wait for 10 ns;
	clk <= '0';
	wait for 10 ns;
	clk <= '1';
	jump <= '0';
	wait for 10 ns;
	clk <= '0';
--E	
	clk <= '1';
	pcsrc <= '1';
	wait for 10 ns;
	clk <= '0';
	wait for 10 ns;
	clk <= '1';
	pcsrc <= '0';
	wait for 10 ns;
	clk <= '0';
wait;
end process ;
end rtl ;