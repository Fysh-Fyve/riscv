--! \file alu_control.vhd
--! \author Charles Ancheta
--! @cond Doxygen_Suppress
library ieee;
use ieee.std_logic_1164.all;
--! @endcond

-- VHDL code for the ALU Control module.
-- This module coordinates the operation of the ALU, Immediate Sign-extend,
-- and Program Counter components based on the instruction and control signals.
-- It processes the incoming instruction and generates appropriate control signals
-- and clocking for these components.

entity alu_control is
  port (
    clk_input          : in std_ulogic;                -- Main clock input
    instruction_input  : in std_ulogic_vector (31 downto 0); -- 32-bit input instruction
    rs1_value, rs2_value: in std_ulogic_vector (31 downto 0); -- 32-bit input values from registers

    -- Clock outputs to other components
    rd_clock_output    : out std_ulogic;               -- Clock output for Register File write
    memory_clock_output: out std_ulogic;               -- Clock output for Memory access
    instruction_reg_clock_output: out std_ulogic;      -- Clock output for Instruction Register

    -- Output ports for various control signals and data paths
    alu_output, pc_output, pc_alu_output : out std_ulogic_vector (31 downto 0);
    reset_output, address_select_output  : out std_ulogic;
    rd_select_output                     : out std_ulogic_vector (1 downto 0);
    sign_extend_size_output              : out std_ulogic_vector (2 downto 0));
end alu_control;

architecture Behavioral of alu_control is
  -- Declaration of internal components used in the ALU Control module.

  component control_fsm is 
    port (
      clk_input       : in std_ulogic;
      eq_input, lt_input, ltu_input : in std_ulogic; -- Equality, less than, less than unsigned flags from ALU
      opcode_input    : in std_ulogic_vector (6 downto 0);
      funct3_input    : in std_ulogic_vector (2 downto 0);
      sub_sra_input   : in std_ulogic;

      -- Clock and control signal outputs
      memory_clock_output, rd_clock_output : out std_ulogic;
      pc_clock_output, instruction_reg_clock_output : out std_ulogic;

      -- Output control signals for different data paths and operations
      address_select_output            : out std_ulogic;
      pc_alu_select_output, pc_next_select_output : out std_ulogic;
      alu_a_select_output, alu_b_select_output   : out std_ulogic;

      sub_sra_output       : out std_ulogic;
      func_output, sign_extend_size_output : out std_ulogic_vector (2 downto 0);
      rd_select_output     : out std_ulogic_vector (1 downto 0);
      reset_output         : out std_logic);
  end component;

  component alu is 
    port (
      operand_a, operand_b : in std_ulogic_vector (31 downto 0);
      func_input           : in std_ulogic_vector (2 downto 0);
      sub_sra_input        : in std_ulogic;

      -- Outputs of the ALU operation
      alu_result_output    : out std_ulogic_vector (31 downto 0);
      eq_output, lt_output, ltu_output : out std_ulogic);
  end component;

  component imm_sx is 
    port (
      instruction_input  : in  std_ulogic_vector (31 downto 0);
      imm_extended_output: out std_ulogic_vector (31 downto 0));
  end component;

  component program_counter is 
    port (
      pc_clock_input, reset_input, pc_next_select_input, pc_alu_select_input : in std_ulogic;

      -- Inputs for program counter value and ALU output for branch/jump calculations
      imm_extended_input, alu_input : in  std_ulogic_vector (31 downto 0);
      pc_output, pc_alu_output      : out std_ulogic_vector (31 downto 0));
  end component;

  -- Internal signals for clocking and control logic.
  signal pc_clock_signal : std_ulogic := '0';

  -- Select signals for controlling data path and operations
  signal pc_next_select_signal : std_ulogic := '0';
  signal pc_alu_select_signal  : std_ulogic := '0';
  signal sub_sra_signal        : std_ulogic := '0';
  signal func_signal           : std_ulogic_vector (2 downto 0) := (others => '0');

  -- Signals for ALU operands and results
  signal imm_extended_signal : std_ulogic_vector (31 downto 0) := (others => '0');
  signal alu_operand_a       : std_ulogic_vector (31 downto 0) := (others => '0');
  signal alu_operand_b       : std_ulogic_vector (31 downto 0) := (others => '0');
  signal eq_flag, lt_flag, ltu_flag : std_ulogic := '0';

  -- Select signals for ALU operands
  signal alu_a_select, alu_b_select : std_ulogic := '0';

begin
  -- Instantiation of components and mapping of inputs/outputs
  imm_sx_instance : component imm_sx port map (
    instruction_input  => instruction_input,
    imm_extended_output => imm_extended_signal);

  program_counter_instance : component program_counter port map (
    pc_clock_input     => pc_clock_signal,
    reset_input        => reset_output,
    pc_next_select_input => pc_next_select_signal,
    pc_alu_select_input  => pc_alu_select_signal,
    imm_extended_input   => imm_extended_signal,
    alu_input            => alu_output,
    pc_output            => pc_output,
    pc_alu_output        => pc_alu_output);

  alu_instance : component alu port map (
    operand_a    => alu_operand_a,
    operand_b    => alu_operand_b,
    func_input   => func_signal,
    sub_sra_input => sub_sra_signal,
    alu_result_output => alu_output,
    eq_output   => eq_flag,
    lt_output   => lt_flag,
    ltu_output  => ltu_flag);

  control_fsm_instance : component control_fsm port map(
    clk_input    => clk_input,
    eq_input     => eq_flag,
    lt_input     => lt_flag,
    ltu_input    => ltu_flag,
    opcode_input => instruction_input(6 downto 0),
    funct3_input => instruction_input(14 downto 12
