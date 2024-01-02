-- use standard IEEE signal definitions and functions
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY bcd_counter IS
    PORT (
        clk : IN STD_LOGIC;
        dir : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        led_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END bcd_counter;

ARCHITECTURE Behavioral OF bcd_counter IS

    COMPONENT clk_divider IS
        PORT (
            clk_in : IN STD_LOGIC;
            clk_out : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL temp : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
    SIGNAL clk_out_component : STD_LOGIC;

BEGIN
    -- Component Instantiation
    label_clk_divider : clk_divider PORT MAP(
        clk_in => clk,
        clk_out => clk_out_component
    );

    process_0 : PROCESS (clk_out_component, reset)
    BEGIN
        IF reset = '1' THEN
            temp <= "0000";
        ELSIF (rising_edge(clk_out_component)) THEN
            IF (dir = '1') THEN
                IF (temp = "1001") THEN
                    temp <= "0000";
                ELSE
                    temp <= temp + 1;
                END IF;
            ELSE
                IF (temp = "0000") THEN
                    temp <= "1001";
                ELSE
                    temp <= temp - 1;
                END IF;
            END IF;
            led_out <= temp;
        END IF;
    END PROCESS;
END Behavioral;