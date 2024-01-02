ENTITY counter IS
    PORT (
        clk : IN STD_LOGIC; -- 125 MHz onboard clock on Zybo Z7
        dir : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        led : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END counter;

ARCHITECTURE Behavioral OF counter IS

    COMPONENT clock_divider IS
        PORT (
            clk : IN STD_LOGIC;
            clk_out : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL clk_out : STD_LOGIC;
    SIGNAL count : STD_LOGIC_VECTOR (3 DOWNTO 0);
BEGIN
    -- Component Instantiation
    divider : clock_divider PORT MAP
    (
        clk => clk,
        clk_out => clk_out
    );

    p1 : PROCESS (clk_out)
    BEGIN
        IF clk_out = '1' AND clk_out'event THEN
            IF reset = '1' THEN
                count <= "0000";
            ELSIF dir = '1' THEN
                count <= count + 1;
            ELSE
                count <= count - 1;
            END IF;
            led <= count;
        END IF;
    END PROCESS;

END Behavioral;