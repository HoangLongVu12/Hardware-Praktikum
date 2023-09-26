LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY maindecoder_tb IS
END;

ARCHITECTURE behavior OF maindecoder_tb IS
    COMPONENT maindec
        PORT (
            op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            memtoreg : OUT STD_LOGIC;
            memwrite : OUT STD_LOGIC;
            branch : OUT STD_LOGIC;
            alusrc : OUT STD_LOGIC;
            regdst : OUT STD_LOGIC;
            regwrite : OUT STD_LOGIC;
            jump : OUT STD_LOGIC;
            aluop : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL op : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL aluop : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL mem2reg, memwrite, branch, alusrc, regdst, regwrite, jump : STD_LOGIC;
BEGIN
    adc : maindec PORT MAP(op, mem2reg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);
    PROCESS BEGIN
        op <= "000000";
        WAIT FOR 10 ns;
        op <= "000010";
        WAIT FOR 10 ns;
        op <= "101011";
        WAIT FOR 10 ns;
        op <= "111111"; -- ungueltig
        WAIT FOR 10 ns;
        op <= "000100";
        WAIT FOR 10 ns;
        WAIT;
    END PROCESS;
END;