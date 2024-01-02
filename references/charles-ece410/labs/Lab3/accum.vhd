----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: Shyama Gandhi and Bruce Cockburn
--
-- Create Date: 10/29/2020 07:18:24 PM
-- Design Name:
-- Module Name: cpu - structural(datapath)
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: CPU LAB 3 - ECE 410 (2021)
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.01 - File Modified by Raju Machupalli (October 31, 2021)
-- Revision 2.01 - File Modified by Shyama Gandhi (November 2, 2021)
-- Additional Comments:
--*********************************************************************************
-- 8-bit accumulator register as shown in the datapath of lab manual
-----------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY accum IS PORT (
  clk_acc : IN STD_LOGIC;
  rst_acc : IN STD_LOGIC; -- clear signal to reset the accumulator
  wr_acc : IN STD_LOGIC; -- this signal goes high whenever you want to write into the accumulator register
  input_acc : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
  output_acc : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));

END accum;

ARCHITECTURE Behavioral OF accum IS

BEGIN
  PROCESS (clk_acc, rst_acc)

  BEGIN
    IF rst_acc = '1' THEN
      output_acc <= (OTHERS => '0');
    ELSIF (clk_acc'event) AND (clk_acc = '1') AND (wr_acc = '1') THEN
      -- **************************************************************
      -- write one line of code here when wr_acc='1'
      output_acc <= input_acc;
      -----------------------------------------------------------------
    END IF;
  END PROCESS;

END Behavioral;