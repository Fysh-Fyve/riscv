----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: Shyama Gandhi and Bruce Cockburn
-- 
-- Create Date: 08/10/2020 11:28:43 AM
-- Design Name: 
-- Module Name: s1_16_1_mux - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY S1_mux IS
  PORT (
    cin : IN STD_LOGIC;
    select_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    y_s1 : OUT STD_LOGIC);
END S1_mux;

ARCHITECTURE Behavioral OF S1_mux IS

BEGIN
  PROCESS (cin, select_in)
  BEGIN
    -- write the input line functions generated for 16:1 to derive the S(1) output.
    -- The input lines can be '0' / '1' / Cin / (not) Cin.
    -- It is possible to use if...else or case statements here. 
    CASE select_in IS
      WHEN "0000" => y_s1 <= '0';
      WHEN "0001" => y_s1 <= cin;
      WHEN "0010" => y_s1 <= '1';
      WHEN "0011" => y_s1 <= NOT cin;
      WHEN "0100" => y_s1 <= cin;
      WHEN "0101" => y_s1 <= '1';
      WHEN "0110" => y_s1 <= NOT cin;
      WHEN "0111" => y_s1 <= '0';
      WHEN "1000" => y_s1 <= '1';
      WHEN "1001" => y_s1 <= NOT cin;
      WHEN "1010" => y_s1 <= '0';
      WHEN "1011" => y_s1 <= cin;
      WHEN "1100" => y_s1 <= NOT cin;
      WHEN "1101" => y_s1 <= '0';
      WHEN "1110" => y_s1 <= cin;
      WHEN OTHERS => y_s1 <= '1'; -- select_in="1111"
        -- Write the VHDL codes for all the input cases.
    END CASE;
  END PROCESS;

END Behavioral;
