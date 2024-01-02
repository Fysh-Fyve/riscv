LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY data_path IS
	PORT (
		clk_in : IN STD_LOGIC;
		d_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		load : IN STD_LOGIC;
		reset_in : IN STD_LOGIC;
		display_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

		count : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		err : OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE data_path_struc OF data_path IS
	COMPONENT up_counter IS
		GENERIC (WID : NATURAL);
		PORT (
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			inc : IN STD_LOGIC;
			counter : OUT STD_LOGIC_VECTOR(WID - 1 DOWNTO 0);
			err : OUT STD_LOGIC
		);
	END COMPONENT;

	-- inc(0) increment the total vectors counter
	-- inc(1) increment the odd parity counter
	-- inc(2) increment the three adjacent 1s counter
	SIGNAL inc : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL counter_err : STD_LOGIC_VECTOR(2 DOWNTO 0);

	SIGNAL total_count : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL odd_parity_count : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL adjacent_count : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
	tot_counter : up_counter
	GENERIC MAP(WID => 16)
	PORT MAP(clk => clk_in, reset => reset_in, inc => inc(0), counter => total_count, err => counter_err(0));

	odd_counter : up_counter
	GENERIC MAP(WID => 16)
	PORT MAP(clk => clk_in, reset => reset_in, inc => inc(1), counter => odd_parity_count, err => counter_err(1));

	adj_counter : up_counter
	GENERIC MAP(WID => 16)
	PORT MAP(clk => clk_in, reset => reset_in, inc => inc(2), counter => adjacent_count, err => counter_err(2));

	err <= OR(counter_err); -- use reductive OR function

	count <= odd_parity_count WHEN display_sel = "01" ELSE
		adjacent_count WHEN display_sel = "10" ELSE
		total_count;

	inc(0) <= load;
	inc(1) <= load AND XOR (d_in);
	inc(2) <= load AND
	( AND (d_in(7 DOWNTO 5)) OR AND (d_in(6 DOWNTO 4)) OR
	AND (d_in(5 DOWNTO 3)) OR AND (d_in(4 DOWNTO 2)) OR
	AND (d_in(3 DOWNTO 1)) OR AND (d_in(2 DOWNTO 0)));
END data_path_struc;