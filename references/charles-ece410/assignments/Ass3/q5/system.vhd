LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY system IS
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
END system;

ARCHITECTURE Behavioral OF system IS
	COMPONENT data_path IS
		PORT (
			clk_in : IN STD_LOGIC;
			d_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			load : IN STD_LOGIC;
			reset_in : IN STD_LOGIC;
			display_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

			count : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			err : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT controller IS
		PORT (
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			clear_results : IN STD_LOGIC;
			load : IN STD_LOGIC;
			sel_display : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			ack : OUT STD_LOGIC;
			err : OUT STD_LOGIC;

			err_in : IN STD_LOGIC;
			load_in : OUT STD_LOGIC;
			reset_in : OUT STD_LOGIC;
			sel_display_in : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL err_in : STD_LOGIC;
	SIGNAL sel_display_in : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL reset_in : STD_LOGIC;
	SIGNAL load_in : STD_LOGIC;
BEGIN
	ctrl : controller PORT MAP(
		clk => clk,
		reset => reset,
		clear_results => clear_results,
		load => load,
		sel_display => sel_display,
		ack => ack,
		err => err,
		err_in => err_in,
		load_in => load_in,
		reset_in => reset_in,
		sel_display_in => sel_display_in
	);

	dp : data_path PORT MAP(
		clk_in => clk,
		d_in => d,
		load => load_in,
		reset_in => reset_in,
		display_sel => sel_display_in,
		count => count,
		err => err_in
	);
END Behavioral;