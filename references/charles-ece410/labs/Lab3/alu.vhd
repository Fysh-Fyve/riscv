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
-- Total eights operations can be performed using 3 select lines of this ALU.
-- The select line codes have been given to you in the lab manual.
-- In future, this alu is scalable to say, 16 operations using 4 select lines.
-----------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- The following package is needed so that the STD_LOGIC_VECTOR signals
-- A and B can be used in unsigned arithmetic operations.
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY alu IS PORT (
  clk_alu : IN STD_LOGIC;
  sel_alu : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  inA_alu : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  inB_alu : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  bits_shift : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- decides how much to shift during shift left and shift right operation (decide from last 2 bits in the SHFL/SHFR operation)
  OUT_alu : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000");
END alu;

ARCHITECTURE Behavior OF alu IS
  CONSTANT zero : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
BEGIN
  PROCESS (clk_alu) -- complete the sensitivity list here! *********************************
  BEGIN
    IF clk_alu'event AND clk_alu = '1' THEN
      CASE sel_alu IS
        WHEN "000" =>
          OUT_alu <= inA_alu;
        WHEN "001" =>
          OUT_alu <= inA_alu AND inB_alu;
        WHEN "010" =>
          -- shift left based on "bits_shift"
          -- ***************************************
          CASE bits_shift is
            WHEN "00" => OUT_alu <= inA_alu; 
	        WHEN "01" => OUT_alu <= inA_alu(6 DOWNTO 0) & "0";
            WHEN "10" => OUT_alu <= inA_alu(5 DOWNTO 0) & "00";
            WHEN "11" => OUT_alu <= inA_alu(4 DOWNTO 0) & "000";
	        WHEN OTHERS => OUT_alu <= (OTHERS => 'X');
	      END CASE;
        WHEN "011" =>
          -- shift right based on "bits_shift"
          -- ***************************************
          CASE bits_shift is
            WHEN "00" => OUT_alu <= inA_alu; 
       	    WHEN "01" => OUT_alu <= "0" & inA_alu(7 DOWNTO 1);
            WHEN "10" => OUT_alu <= "00" & inA_alu(7 DOWNTO 2);
            WHEN "11" => OUT_alu <= "000" & inA_alu(7 DOWNTO 3);
	        WHEN OTHERS => OUT_alu <= (OTHERS => 'X');
	      END CASE;
	    WHEN "100" =>
          OUT_alu <= inA_alu + inB_alu;
        WHEN "101" =>
          OUT_alu <= inA_alu - inB_alu;
        WHEN "110" =>
          OUT_alu <= inA_alu + 1;
        WHEN OTHERS =>
          OUT_alu <= inA_alu - 1;
      END CASE;
    END IF;
  END PROCESS;
END Behavior;
