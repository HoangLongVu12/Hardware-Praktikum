LIBRARY IEEE;
USE IEEE.Std_logic_1164.ALL;

ENTITY robot IS
    PORT (
        input_seq : IN STD_LOGIC_VECTOR := "1011"; -- Default value for input_seq is 1011 (ist die Sequenz die untersucht wird)
        Clk : IN STD_LOGIC;
        y : OUT BOOLEAN -- TRUE wenn 1011 in der Sequenz erkannt wird
    );
END robot;

ARCHITECTURE behavioral OF robot IS
BEGIN
    PROCESS (Clk, input_seq)
        VARIABLE counter : INTEGER := input_seq'length - 1;
        TYPE Zustaende IS (Z1, Z2, Z3, Z4);
        VARIABLE Zustand : Zustaende;
    BEGIN

        IF (rising_edge(Clk)) THEN -- fuer jede steigende Taktflanke wird ein Element der Eingabesequenz abgegangen
            IF (counter >= 0) THEN
                CASE Zustand IS
                    WHEN Z1 =>
                        IF input_seq(counter) = '1' THEN
                            Zustand := Z2;
                            y <= false;
                        ELSE
                            y <= false;
                        END IF;
                    WHEN Z2 =>
                        IF input_seq(counter) = '0' THEN
                            Zustand := Z3;
                            y <= false;
                        ELSE
                            y <= false; -- für 1 bleibt man im Zustand Z2
                        END IF;
                    WHEN Z3 =>
                        IF input_seq(counter) = '1' THEN
                            Zustand := Z4;
                            y <= false;
                        ELSE
                            Zustand := Z1;
                            y <= false;
                        END IF;
                    WHEN Z4 =>
                        IF input_seq(counter) = '1' THEN
                            Zustand := Z1;
                            y <= true;
                        ELSE
                            Zustand := Z3;
                            y <= false;
                        END IF;
                END CASE;
                counter := counter - 1;
            END IF;
        END IF;

    END PROCESS;
END behavioral;