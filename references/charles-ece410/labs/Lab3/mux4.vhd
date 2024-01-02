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
-- Revision 1.01 - File Modified by Shyama Gandhi (Nov 2, 2021)
-- Additional Comments:
--*********************************************************************************
--THIS IS A 4x1 MUX that selects between the four inputs as shown in the lab manual.
-----------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux4 IS PORT (
  sel_mux : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
  in3_mux, in2_mux, in1_mux, in0_mux : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  out_mux : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END mux4;

ARCHITECTURE Behavioral OF mux4 IS
BEGIN
  PROCESS (sel_mux, in3_mux, in2_mux, in1_mux, in0_mux)
  BEGIN
    IF (sel_mux = "11") THEN
      out_mux <= in3_mux;
    ELSIF (sel_mux = "10") THEN
      out_mux <= in2_mux;
    ELSIF (sel_mux = "01") THEN
      out_mux <= in1_mux;
    ELSIF (sel_mux = "00") THEN
      out_mux <= in0_mux;
    ELSE
      out_mux <= (OTHERS => 'X');
    END IF;

  END PROCESS;
END Behavioral;