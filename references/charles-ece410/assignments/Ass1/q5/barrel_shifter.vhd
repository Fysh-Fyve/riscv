LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY barrel_shifter IS
  PORT (
    d_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    d_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    rot : IN STD_LOGIC_VECTOR (2 DOWNTO 0));
END barrel_shifter;

ARCHITECTURE Behavioral OF barrel_shifter IS
BEGIN
  WITH rot SELECT
    d_out <= d_in WHEN "000",
    d_in(0) & d_in(7 DOWNTO 1) WHEN "001",
    d_in(1 DOWNTO 0) & d_in(7 DOWNTO 2) WHEN "010",
    d_in(2 DOWNTO 0) & d_in(7 DOWNTO 3) WHEN "011",
    d_in(3 DOWNTO 0) & d_in(7 DOWNTO 4) WHEN "100",
    d_in(4 DOWNTO 0) & d_in(7 DOWNTO 5) WHEN "101",
    d_in(5 DOWNTO 0) & d_in(7 DOWNTO 6) WHEN "110",
    d_in(6 DOWNTO 0) & d_in(7) WHEN OTHERS; -- rot = "111"
END Behavioral;