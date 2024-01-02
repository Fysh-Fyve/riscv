LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY system_tb IS
END system_tb;

ARCHITECTURE Behavioral OF system_tb IS
	COMPONENT system IS
		PORT (
			-- external inputs
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			clear_results : IN STD_LOGIC;
			load : IN STD_LOGIC;
			sel_display : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			d : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

			-- external outputs
			ack : OUT STD_LOGIC;
			err : OUT STD_LOGIC;
			count : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	-- external inputs
	SIGNAL clk : STD_LOGIC;
	SIGNAL reset : STD_LOGIC;
	SIGNAL clear_results : STD_LOGIC;
	SIGNAL load : STD_LOGIC;
	SIGNAL sel_display : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL d : STD_LOGIC_VECTOR(7 DOWNTO 0);

	-- external outputs
	SIGNAL ack : STD_LOGIC;
	SIGNAL err : STD_LOGIC;
	SIGNAL count : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
	s : system PORT MAP(
		clk => clk, reset => reset, clear_results => clear_results, load => load, sel_display => sel_display, d => d, ack => ack,
		err => err, count => count
	);

END Behavioral;