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
-- This reg_file has 8 locations each of 8-bits. Address lines are used to select from 
-- R[0]:R[7]. A write enable port helps to write to respective location of register.
-- A given instruction will perform either read or write any given time and not both
-- at the same time.
-----------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY reg_file IS PORT (
  clk_rf : IN STD_LOGIC;
  wr_rf : IN STD_LOGIC;
  addr_rf : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- addresses 8 locations in the register file
  input_rf : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  output_rf : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END reg_file;

ARCHITECTURE Behavior OF reg_file IS
  SUBTYPE reg IS STD_LOGIC_VECTOR(7 DOWNTO 0);
  TYPE regArray IS ARRAY(0 TO 7) OF reg;
  SIGNAL RF : regArray; --register file contents

BEGIN
  PROCESS (clk_rf, wr_rf)
  BEGIN
    IF (clk_rf'event AND clk_rf = '1') THEN
      IF (wr_rf = '1') THEN
        -- ********************************************************
        -- write one line code here
        RF(to_integer(unsigned(addr_rf))) <= input_rf;
        -----------------------------------------------------------
      ELSE
        -- ********************************************************
        -- write one line of code here
        output_rf <= RF(to_integer(unsigned(addr_rf)));
        -----------------------------------------------------------
      END IF;
    END IF;
  END PROCESS;
END Behavior;