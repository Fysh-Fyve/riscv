----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: Shyama Gandhi and Bruce Cockburn
--
-- Create Date: 10/29/2020 07:18:24 PM
-- Design Name:
-- Module Name: cpu _core test bench
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

ENTITY cpu_core_tb IS
END cpu_core_tb;

ARCHITECTURE behavior OF cpu_core_tb IS

  -- Component Declaration for the Unit Under Test (UUT)

  COMPONENT cpu_ctrl_dp PORT (
    clk_cpu : IN STD_LOGIC;
    rst_cpu : IN STD_LOGIC;
    entered_ip : IN STD_LOGIC;
    input_cpu : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    output_cpu : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    PC_output : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    OPCODE_ouput : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    done_cpu : OUT STD_LOGIC);
  END COMPONENT;

  SIGNAL clk_tb : STD_LOGIC := '0';
  SIGNAL rst_tb : STD_LOGIC := '0';
  SIGNAL in_tb : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL opcode_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL pc_tb : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL output_tb : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL enter : STD_LOGIC;
  SIGNAL done : STD_LOGIC;

  -- Clock period definitions
  CONSTANT clk_period : TIME := 8 ns;

BEGIN
  -- Instantiate the Unit Under Test (UUT)
  uut : cpu_ctrl_dp PORT MAP(
    clk_cpu => clk_tb,
    rst_cpu => rst_tb,
    entered_ip => enter,
    input_cpu => in_tb,
    output_cpu => output_tb,
    PC_output => pc_tb,
    OPCODE_ouput => opcode_tb,
    done_cpu => done);
  -- Clock process definitions
  clk_process : PROCESS
  BEGIN
    clk_tb <= '0';
    WAIT FOR clk_period/2;
    clk_tb <= '1';
    WAIT FOR clk_period/2;
  END PROCESS;
  -- Stimulus process
  stim_proc : PROCESS
  BEGIN

    --*********************************
    -- provide the required input stimulus here for the design under test
    rst_tb <= '1';
    -- in_tb <= "00001010";
    enter <= '1';
    wait until rising_edge(clk_tb);
    rst_tb <= '0';
    in_tb <= "00000001";
    wait until rising_edge(clk_tb);
    in_tb <= "00000000"; 
    wait until done = '1';
    -----------------------------------
  END PROCESS;

END behavior;
