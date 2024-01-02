----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2021 12:49:40 PM
-- Design Name: 
-- Module Name: clk_divider - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY clk_divider IS
  PORT (
    clk_in : IN STD_LOGIC;
    clk_out : OUT STD_LOGIC);
END clk_divider;

ARCHITECTURE Behavioral OF clk_divider IS
  SIGNAL clock_out : STD_LOGIC := '0';
  SIGNAL count : INTEGER := 1;
BEGIN
  PROCESS (clk_in)
  BEGIN
    IF clk_in = '1' AND clk_in'event THEN
      count <= count + 1;
      IF (count = 62500000) THEN
        clock_out <= NOT clock_out;
        count <= 1;
      END IF;
    END IF;
    clk_out <= clock_out;
  END PROCESS;
END Behavioral;