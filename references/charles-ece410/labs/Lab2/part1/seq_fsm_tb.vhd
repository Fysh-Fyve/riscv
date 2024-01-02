----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: Shyama Gandhi and Bruce Cockburn
-- 
-- Create Date: 10/10/2021 04:05:35 PM
-- Design Name: 
-- Module Name: seq_fsm_tb - Behavioral
-- Project Name: 
-- Target Devices: Zybo Z7-10 
-- Tool Versions: 
-- Description: SEQUENCE DETECTOR : 11011 - OVERLAPPING CASE : MEALY FSM
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

ENTITY seq_fsm_tb IS
END seq_fsm_tb;

ARCHITECTURE Behavioral OF seq_fsm_tb IS

  COMPONENT seq_fsm IS
    PORT (
      clk : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      seq_in : IN STD_LOGIC;
      output_detect : OUT STD_LOGIC);
  END COMPONENT;

  SIGNAL clk_design : STD_LOGIC;
  SIGNAL rst : STD_LOGIC;
  SIGNAL sequence_in : STD_LOGIC;
  SIGNAL fsm_detector_out : STD_LOGIC;
  CONSTANT clk_period : TIME := 40 ns;

BEGIN
  --*** add the design lines to port map the entity here
  FSM_SEQ : seq_fsm PORT MAP(
    seq_in => sequence_in,
    reset => rst,
    output_detect => fsm_detector_out,
    clk => clk_design);
  --*** end design lines                               
  clk_process : PROCESS
  BEGIN
    clk_design <= '0';
    WAIT FOR clk_period/2;
    clk_design <= '1';
    WAIT FOR clk_period/2;
  END PROCESS;

  stim_proc : PROCESS
  BEGIN

    -- test sequence : "0110110"
    sequence_in <= '0';
    rst <= '1';
    WAIT FOR clk_period;
    rst <= '0';
    sequence_in <= '0';
    WAIT FOR clk_period;
    sequence_in <= '1';
    WAIT FOR clk_period;
    sequence_in <= '1';
    WAIT FOR clk_period;
    sequence_in <= '0';
    WAIT FOR clk_period;
    sequence_in <= '1';
    WAIT FOR clk_period;
    sequence_in <= '1';
    WAIT FOR clk_period;
    sequence_in <= '0';
    WAIT FOR clk_period;

    -- test overlap : "11"
    sequence_in <= '1';
    WAIT FOR clk_period;
    sequence_in <= '1';
    WAIT FOR clk_period;

    sequence_in <= '0';
    WAIT FOR clk_period;
  END PROCESS;
END Behavioral;
