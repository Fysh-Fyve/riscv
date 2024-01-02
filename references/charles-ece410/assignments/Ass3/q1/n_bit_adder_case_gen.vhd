-- does not compile :( VHDL suck
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ARCHITECTURE Behavioral OF n_bit_adder IS
	SIGNAL carry_out : STD_LOGIC_VECTOR (N - 2 DOWNTO 0);
	COMPONENT full_adder IS
		PORT (
			a : IN STD_LOGIC;
			b : IN STD_LOGIC;
			c_in : IN STD_LOGIC;
			sum : OUT STD_LOGIC;
			c_out : OUT STD_LOGIC
		);
	END COMPONENT;
BEGIN
	FOR_GEN_LOOP : FOR i IN 0 TO N - 1 GENERATE
		BIT : CASE i GENERATE
			WHEN 0 =>
				ADDER : full_adder PORT MAP(
					a => a(i),
					b => b(i),
					c_in => c_in,
					c_out => carry_out(i),
					sum => sum(i));
			WHEN N - 1 =>
				ADDER : full_adder PORT MAP(
					a => a(i),
					b => b(i),
					c_in => carry_out(i - 1),
					c_out => c_out,
					sum => sum(i));
			WHEN OTHERS =>
				ADDER : full_adder PORT MAP(
					a => a(i),
					b => b(i),
					c_in => carry_out(i - 1),
					c_out => carry_out(i),
					sum => sum(i));
		END GENERATE;
	END GENERATE FOR_GEN_LOOP;
END Behavioral;