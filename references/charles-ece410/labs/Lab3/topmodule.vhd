----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: Shyama Gandhi and Bruce Cockburn
--
-- Create Date: 10/29/2020 07:18:24 PM
-- Design Name: CONTROLLER FOR THE CPU
-- Module Name: cpu
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
-- This is the top module file for the cpu, clk_divider and the seven segment
-----------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY topmodule IS
  PORT (
    clk : IN STD_LOGIC;
    rst_button : IN STD_LOGIC;
    entered_input : IN STD_LOGIC;
    input_sw : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    OPcode_LED : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    PC_on_7_seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    select_segment : OUT STD_LOGIC;
    done_signal : OUT STD_LOGIC);
END topmodule;

ARCHITECTURE Behavioral OF topmodule IS

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

  COMPONENT sev_segment PORT (
    --output of PC from cpu
    DispVal : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
    anode : OUT STD_LOGIC;
    --controls which digit to display
    segOut : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
  END COMPONENT;

  COMPONENT clk_divider PORT (clk_in : IN STD_LOGIC;
    clk_out : OUT STD_LOGIC);
  END COMPONENT;
  SIGNAL clk_1Hz : STD_LOGIC;
  SIGNAL in_modified : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL output_from_cpu : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL PC : STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN

  in_modified <= "00000" & input_sw;

  clk_div : clk_divider PORT MAP(
    clk_in => clk,
    clk_out => clk_1Hz);
  cpu_core : cpu_ctrl_dp PORT MAP(
    clk_cpu => clk_1Hz,
    rst_cpu => rst_button,
    entered_ip => entered_input,
    input_cpu => in_modified, -- port map this signal
    output_cpu => output_from_cpu, -- port map this signal
    PC_output => PC,
    OPCODE_ouput => OPcode_LED, -- port map this signal
    done_cpu => done_signal); -- port map this signal

  seven_seg : COMPONENT sev_segment PORT MAP(
    DispVal => PC,
    anode => select_segment,
    segOut => PC_on_7_seg);

END Behavioral;