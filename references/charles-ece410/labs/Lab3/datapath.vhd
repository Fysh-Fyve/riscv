----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: Shyama Gandhi and Bruce Cockburn
--
-- Create Date: 10/29/2020 07:18:24 PM
-- Design Name: DATAPATH FOR THE CPU
-- Module Name: cpu - structural(datapath)
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: CPU_PART 1 OF LAB 3 - ECE 410 (2021)
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.01 - File Modified by Raju Machupalli (October 31, 2021)
-- Revision 2.01 - File Modified by Shyama Gandhi (November 2, 2021)
-- Additional Comments:
--*********************************************************************************
-- datapath module that maps all the components used... 
-----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY datapath IS PORT (
  clk_dp : IN STD_LOGIC;
  rst_dp : IN STD_LOGIC;
  muxsel_dp : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- mux select for selecting between the four different inputs
  imm_dp : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- getting the immediate value as an operand
  input_dp : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- getting user input value
  accwr_dp : IN STD_LOGIC; -- write signal asserted to write into the accumulator
  rfaddr_dp : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- select signal for choosing between the eight register locations
  rfwr_dp : IN STD_LOGIC; -- write control signal asserted to write to register file
  alusel_dp : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- select signal for the eight ALU operations
  outen_dp : IN STD_LOGIC; -- outer buffer enable signal for the output buffer 

  bits_sel_dp : IN STD_LOGIC; -- select signal to load the bits either in upper or lower nibble of the input
  bits_shift_dp : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- signal for shifting operation of the number by these many bits

  zero_dp : OUT STD_LOGIC; -- output zero flag signal
  positive_dp : OUT STD_LOGIC; -- output positive flag signal
  output_dp : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END datapath;

ARCHITECTURE struct OF datapath IS

  COMPONENT mux4 PORT (
    sel_mux : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    in3_mux, in2_mux, in1_mux, in0_mux : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    out_mux : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
  END COMPONENT;

  COMPONENT accum PORT (
    clk_acc : IN STD_LOGIC;
    rst_acc : IN STD_LOGIC;
    wr_acc : IN STD_LOGIC;
    input_acc : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    output_acc : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
  END COMPONENT;

  COMPONENT reg_file PORT (
    clk_rf : IN STD_LOGIC;
    wr_rf : IN STD_LOGIC;
    addr_rf : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    input_rf : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    output_rf : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
  END COMPONENT;

  COMPONENT alu PORT (
    clk_alu : IN STD_LOGIC;
    sel_alu : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    inA_alu : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    inB_alu : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    bits_shift : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    OUT_alu : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
  END COMPONENT;
  COMPONENT tristatebuffer PORT (
    E : IN STD_LOGIC;
    D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    Y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
  END COMPONENT;

  -----------------------------------------------------------------------------------
  SIGNAL C_aluout, C_accout, C_rfout, C_muxout, usr_input : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL C_outen : STD_LOGIC;
  -----------------------------------------------------------------------------------

BEGIN

  U0 : mux4 PORT MAP (sel_mux => muxsel_dp,
    in3_mux => imm_dp,
    in2_mux => usr_input,
    -- ****************************************
    -- map the remaining signals here for this component
    in1_mux => C_aluout,
    in0_mux => C_rfout,
    -------------------------------------------
    out_mux => C_muxout);

  U1 : accum PORT MAP(
    clk_acc => clk_dp,
    rst_acc => rst_dp,
    wr_acc => accwr_dp,
    input_acc => C_muxout,
    output_acc => C_accout);

  U2 : reg_file PORT MAP(
    clk_rf => clk_dp,
    -- ****************************************
    -- map the remaining signals here for this component
    wr_rf => rfwr_dp,
    addr_rf => rfaddr_dp,
    -------------------------------------------
    input_rf => C_accout,
    output_rf => C_rfout);

  U3 : alu PORT MAP(
    clk_alu => clk_dp,
    sel_alu => alusel_dp,
    inA_alu => C_accout,
    inB_alu => C_rfout,
    bits_shift => bits_shift_dp,
    OUT_alu => C_aluout);

  C_outen <= outen_dp OR rst_dp;

  U5 : tristatebuffer PORT MAP(
    E => C_outen,
    D => C_accout,
    Y => output_dp);

  -- ***********************************************************
  -- Write lines of code here for "usr_input" based on the "bits_sel_dp" signal
  PROCESS (bits_sel_dp)
  BEGIN
    IF bits_sel_dp = '1' THEN
        usr_input(7 downto 4) <= input_dp(3 downto 0);
        usr_input(3 downto 0) <= C_accout(3 downto 0);
    ELSE
      -- write two lines of logic code here
        usr_input(3 downto 0) <= input_dp(3 downto 0);
        usr_input(7 downto 4) <= C_accout(7 downto 4);
    END IF;
  END PROCESS;

  --------------------------------------------------------------

  -- ***********************************************************
  -- Write two lines for zero flag and positive flag here (hint: these flags are being detected at the output of 4:1 mux)
  --------------------------------------------------------------
  zero_dp <= '1' when (C_accout = "00000000") else '0'; -- output zero flag signal
  positive_dp <= NOT C_accout(7); -- check MSB

END struct;
