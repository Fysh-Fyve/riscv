-- use standard IEEE signal definitions and functions
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY clk_divider IS
    PORT (
        clk_in : IN STD_LOGIC;
        clk_out : OUT STD_LOGIC);
END clk_divider;

ARCHITECTURE Behavioral OF clk_divider IS
    SIGNAL clock_out : STD_LOGIC := '0';
    SIGNAL count : INTEGER := 1;
BEGIN
    PROCESS (clk_in)
    BEGIN
        IF clk_in = '1' AND clk_in'event THEN
            count <= count + 1;
            IF (count = 62500000) THEN
                clock_out <= NOT clock_out;
                count <= 1;
            END IF;
        END IF;
        clk_out <= clock_out;
    END PROCESS;
END Behavioral;