LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY full_adder_2bit IS
  PORT (
    A : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    c_in : IN STD_LOGIC;
    sum : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    c_out : OUT STD_LOGIC);
END full_adder_2bit;

ARCHITECTURE Behavioral OF full_adder_2bit IS

  COMPONENT full_adder_1bit IS
    PORT (
      a : IN STD_LOGIC;
      b : IN STD_LOGIC;
      c_in : IN STD_LOGIC;
      sum : OUT STD_LOGIC;
      c_out : OUT STD_LOGIC);
  END COMPONENT;
  SIGNAL c_in_1 : STD_LOGIC;
  SIGNAL c_out_0 : STD_LOGIC;
BEGIN
  bit1 : full_adder_1bit PORT MAP(a => A(1), b => B(1), c_in => c_in_1, sum => sum(1), c_out => c_out);
  bit0 : full_adder_1bit PORT MAP(a => A(0), b => B(0), c_in => c_in, sum => sum(0), c_out => c_out_0);
  c_in_1 <= c_out_0;
END Behavioral;