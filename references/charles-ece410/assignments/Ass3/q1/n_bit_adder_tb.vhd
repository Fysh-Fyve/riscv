LIBRARY IEEE;
USE STD.TEXTIO.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY n_bit_adder_tb IS
END n_bit_adder_tb;

ARCHITECTURE Behavioral OF n_bit_adder_tb IS
	COMPONENT n_bit_adder IS
		GENERIC (N : NATURAL);
		PORT (
			a : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
			b : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
			c_in : IN STD_LOGIC;
			sum : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
			c_out : OUT STD_LOGIC
		);
	END COMPONENT;

	SIGNAL a : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL b : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL sum : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL c_in : STD_LOGIC;
	SIGNAL c_out : STD_LOGIC;
BEGIN
	adder_4_bit : n_bit_adder
	GENERIC MAP(N => 4)
	PORT MAP(a => a, b => b, c_in => c_in, sum => sum, c_out => c_out);
	testing : PROCESS
	BEGIN
		a <= "0001";
		b <= "0001";
		c_in <= '0';
		WAIT FOR 5 ns;
		a <= "0001";
		b <= "0001";
		c_in <= '1';
		WAIT FOR 5 ns;
		a <= "1001";
		b <= "1001";
		c_in <= '1';
		WAIT FOR 5 ns;
		a <= "0001";
		b <= "0001";
		c_in <= '1';
		WAIT FOR 5 ns;
		WAIT;
	END PROCESS;

	print : PROCESS (sum, c_out)
		VARIABLE my_line : LINE;
	BEGIN
		write(my_line, a, left, 5);
		write(my_line, b, left, 5);
		write(my_line, c_in, left, 2);
		write(my_line, c_out, left, 2);
		write(my_line, sum, left, 5);
		writeline(output, my_line);
	END PROCESS;
END Behavioral;