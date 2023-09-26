LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sync_counter IS
    PORT (
        reset, clk, C, D : IN STD_LOGIC;
        q1, q0 : OUT STD_LOGIC
    );
END sync_counter;

ARCHITECTURE bh OF sync_counter IS
    COMPONENT jk_flipflop IS
        PORT (
            j, k, clk, reset : IN STD_LOGIC;
            Q : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL j1, k1, j0, k0, q0i, q1i : STD_LOGIC;
BEGIN
    -- wie komme ich darauf? hier ist die Equivalenz von sync.txt. Auch siehe PDF.
    PROCESS BEGIN
        WAIT UNTIL rising_edge(clk);
        IF (reset = '1') THEN
            q1 <= '0';
            q0 <= '0';
        ELSIF rising_edge(clk) THEN
            q1 <= q1i;
            q0 <= q0i;
            IF (C = '0') THEN
                j1 <= q1i;
                k1 <= NOT q1i;
                j0 <= q0i;
                k0 <= NOT q0i;
            ELSIF (C = '1') THEN
                j1 <= q1i OR (q0i AND (NOT D));
                k1 <= (NOT q1i) OR ((NOT q0i) AND D);
                j0 <= (NOT q1i) OR (NOT q0i) OR (NOT d);
                k0 <= (NOT q1i) OR (NOT q0i);
            END IF;
        END IF;
        WAIT;
    END PROCESS;

    jkff1 : jk_flipflop PORT MAP(j1, k1, clk, reset, q1i);
    jkff0 : jk_flipflop PORT MAP(j0, k0, clk, reset, q0i);
END bh;