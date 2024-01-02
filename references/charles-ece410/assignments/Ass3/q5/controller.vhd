LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY controller IS
	PORT (
		-- external inputs
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		clear_results : IN STD_LOGIC;
		load : IN STD_LOGIC;
		sel_display : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

		-- external outputs
		ack : OUT STD_LOGIC;
		err : OUT STD_LOGIC;

		-- internal inputs (from datapath)
		err_in : IN STD_LOGIC;

		-- internal outputs (to datapath)
		load_in : OUT STD_LOGIC;
		reset_in : OUT STD_LOGIC;
		sel_display_in : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE Behavioral OF controller IS
BEGIN

END Behavioral;