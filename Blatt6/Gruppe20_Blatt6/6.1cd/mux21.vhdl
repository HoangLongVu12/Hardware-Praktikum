LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux21 IS
    PORT (
        i1 : IN STD_LOGIC;
        i2 : IN STD_LOGIC;
        sel : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
END mux21;

ARCHITECTURE rtl OF mux21 IS

    SIGNAL not_sel : STD_LOGIC;
    SIGNAL wire1 : STD_LOGIC;
    SIGNAL wire2 : STD_LOGIC;
    SIGNAL result : STD_LOGIC;

BEGIN
    not_sel <= NOT sel;
    wire1 <= i1 AND not_sel;
    wire2 <= i2 AND sel;

    result <= wire1 OR wire2;

    y <= result;
END rtl;