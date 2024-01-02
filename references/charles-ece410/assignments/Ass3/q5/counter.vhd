LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY up_counter IS
	GENERIC (WID : NATURAL);
	PORT (
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		inc : IN STD_LOGIC;
		counter : OUT STD_LOGIC_VECTOR(WID - 1 DOWNTO 0);
		err : OUT STD_LOGIC
	);
END up_counter;

ARCHITECTURE counter_behavior OF up_counter IS
	SIGNAL counter_up : STD_LOGIC_VECTOR(WID - 1 DOWNTO 0);
	SIGNAL counter_err : STD_LOGIC;
	CONSTANT max_num : STD_LOGIC_VECTOR(WID - 1 DOWNTO 0) := (OTHERS => '1');
BEGIN
	INCREMENT : PROCESS (clk)
	BEGIN
		IF (clk'event AND rising_edge(clk)) THEN
			IF (reset = '0') THEN
				counter_up <= (OTHERS => '0');
				counter_err <= '0';
			ELSIF (counter_err = '0' AND inc = '1') THEN
				IF (counter_up = max_num) THEN
					counter_err <= '1';
				ELSE
					counter_up <= STD_LOGIC_VECTOR(unsigned(counter_up) + 1);
				END IF;
			END IF;
		END IF;
	END PROCESS;

	counter <= counter_up;
	err <= counter_err;

END counter_behavior;