----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: Shyama Gandhi and Bruce Cockburn
--
-- Create Date: 10/29/2020 07:18:24 PM
-- Updated Date: 01/11/2021
-- Design Name: CONTROLLER FOR THE CPU
-- Module Name: cpu - behavioral(controller)
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: CPU_LAB 3 - ECE 410 (2021)
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.01 - File Modified by Raju Machupalli (October 31, 2021)
-- Revision 2.01 - File Modified by Shyama Gandhi (November 2, 2021)
-- Additional Comments:
--*********************************************************************************
-- The controller implements the states for each instructions and asserts appropriate control signals for the datapath during every state.
-- For detailed information on the opcodes and instructions to be executed, refer the lab manual.
-----------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; -- needed for CONV_INTEGER()

ENTITY controller IS PORT (
  clk_ctrl : IN STD_LOGIC;
  rst_ctrl : IN STD_LOGIC;
  enter : IN STD_LOGIC;
  muxsel_ctrl : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
  imm_ctrl : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
  accwr_ctrl : OUT STD_LOGIC;
  rfaddr_ctrl : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
  rfwr_ctrl : OUT STD_LOGIC;
  alusel_ctrl : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
  outen_ctrl : OUT STD_LOGIC;
  zero_ctrl : IN STD_LOGIC;
  positive_ctrl : IN STD_LOGIC;
  PC_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
  OP_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  ---------------------------------------------------
  bit_sel_ctrl : OUT STD_LOGIC;
  bits_shift_ctrl : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
  ---------------------------------------------------
  done : OUT STD_LOGIC);
END controller;

ARCHITECTURE Behavior OF controller IS

  TYPE state_type IS (Fetch, Decode, LDA_execute, STA_execute, LDI_execute, ADD_execute, SUB_execute, SHFL_execute, SHFR_execute,
    input_A, output_A, Halt_cpu, JZ_execute, flag_state, ADD_SUB_SL_SR_next);

  SIGNAL state : state_type;
  SIGNAL IR : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL PC : INTEGER RANGE 0 TO 31;
  -- Instructions and their opcodes (pre-decided)
  CONSTANT LDA : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
  CONSTANT STA : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";
  CONSTANT LDI : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011";

  CONSTANT ADD : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0100";
  CONSTANT SUB : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0101";

  CONSTANT SHFL : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0110";
  CONSTANT SHFR : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0111";

  CONSTANT INA : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1000";
  CONSTANT OUTA : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1001";
  CONSTANT HALT : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1010";

  CONSTANT JZ : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1100";

  TYPE PM_BLOCK IS ARRAY(0 TO 31) OF STD_LOGIC_VECTOR(7 DOWNTO 0); -- program memory that will store the instructions sequentially from part 1 and part 2 test program

  -- Functions for creating instructions in the program memory
  FUNCTION part_1 RETURN PM_BLOCK IS
    VARIABLE PM : PM_BLOCK;
  BEGIN
    PM(0) := INA & "0000"; --   IN A (0)
    PM(1) := INA & "0001"; --   IN A (1)
    PM(2) := JZ & "0000"; --    JZ 05
    PM(3) := "00000101"; --     05
    PM(4) := SHFL & "0001"; --  SHFL A (1)
    PM(5) := OUTA & "0000"; --  OUT A
    PM(6) := LDI & "0000"; --   LDI A, 10
    PM(7) := "00001010"; --     10
    PM(8) := SHFR & "0001"; --  SHFR A
    PM(9) := OUTA & "0000"; --  OUT A
    PM(10) := HALT & "0000"; -- HALT
    RETURN PM;
  END FUNCTION part_1;

  FUNCTION part_2 RETURN PM_BLOCK IS
    VARIABLE PM : PM_BLOCK;
  BEGIN
    PM(0) := INA & "0000"; --   IN A (0)
    PM(1) := INA & "0001"; --   IN A (1)
    PM(2) := STA & "0000"; --   STA R[0], A
    PM(3) := LDI & "0000"; --   LDI A, 15
    PM(4) := "00001111"; --     15
    PM(5) := ADD & "0000"; --   ADD A, R[0]
    PM(6) := OUTA & "0000"; --  OUT A
    PM(10) := HALT & "0000"; -- HALT
    RETURN PM;
  END FUNCTION part_2;

BEGIN

  --opcode is kept up-to-date
  OP_out <= IR(7 DOWNTO 4);

  PROCESS (clk_ctrl) -- complete the sensitivity list ********************************************

    -- "PM" is the program memory that holds the instructions to be executed by the CPU 
    VARIABLE PM : PM_BLOCK;

    -- To decode the 4 MSBs from the PC content
    VARIABLE OPCODE : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Zero flag and positive flag
    VARIABLE zero_flag, positive_flag : STD_LOGIC;

  BEGIN
    IF (rst_ctrl = '1') THEN -- RESET initializes all the control signals to 0.
      PC <= 0;
      muxsel_ctrl <= "00";
      imm_ctrl <= (OTHERS => '0');
      accwr_ctrl <= '0';
      rfaddr_ctrl <= "000";
      rfwr_ctrl <= '0';
      alusel_ctrl <= "000";
      outen_ctrl <= '0';
      done <= '0';
      bit_sel_ctrl <= '0';
      bits_shift_ctrl <= "00";
      state <= Fetch;

      -- *************** assembly code for PART1/PART2 goes here
      -- for example this is how the instructions will be stored in the program memory
      --                PM(0) := "XXXXXXXX";    
      PM := part_1;
      -- PM := part_2;
      -- **************

    ELSIF (clk_ctrl'event AND clk_ctrl = '1') THEN
      CASE state IS
        WHEN Fetch => -- fetch instruction
          IF (enter = '1') THEN
            PC_out <= conv_std_logic_vector(PC, 5);
            -- ****************************************
            -- write one line of code to get the 8-bit instruction into IR                      
            IR <= PM(PC);
            -------------------------------------------

            PC <= PC + 1;
            muxsel_ctrl <= "00";
            imm_ctrl <= (OTHERS => '0');
            accwr_ctrl <= '0';
            rfaddr_ctrl <= "000";
            rfwr_ctrl <= '0';
            alusel_ctrl <= "000";
            outen_ctrl <= '0';
            done <= '0';
            zero_flag := zero_ctrl;
            positive_flag := positive_ctrl;
            state <= Decode;
          ELSIF (enter = '0') THEN
            state <= Fetch;
          END IF;

        WHEN Decode => -- decode instruction

          OPCODE := IR(7 DOWNTO 4);

          CASE OPCODE IS
            WHEN LDA => state <= LDA_execute;
            WHEN STA => state <= STA_execute;
            WHEN LDI => state <= LDI_execute;
            WHEN ADD => state <= ADD_execute;
            WHEN SUB => state <= SUB_execute;
            WHEN SHFL => state <= SHFL_execute;
            WHEN SHFR => state <= SHFR_execute;
            WHEN INA => state <= input_A;
            WHEN OUTA => state <= output_A;
            WHEN HALT => state <= Halt_cpu;
            WHEN JZ => state <= JZ_execute;
            WHEN OTHERS => state <= Halt_cpu;

          END CASE;

          muxsel_ctrl <= "00";
          imm_ctrl <= PM(PC); --since the PC is incremented here, I am just doing the pre-fetching. Will relax the requirement for PM to be very fast for LDI to work properly.
          accwr_ctrl <= '0';
          rfaddr_ctrl <= IR(2 DOWNTO 0); --Decode pre-emptively sets up the register file, just to reduce the delay for waiting one more cycle
          rfwr_ctrl <= '0';
          alusel_ctrl <= "000";
          outen_ctrl <= '0';
          done <= '0';
          bit_sel_ctrl <= IR(0);
          bits_shift_ctrl <= IR(1 DOWNTO 0);
        
        
        WHEN flag_state => -- set zero and positive flags and then goto next instruction
          muxsel_ctrl <= "00";
          imm_ctrl <= (OTHERS => '0');
          accwr_ctrl <= '0';
          rfaddr_ctrl <= "000";
          rfwr_ctrl <= '0';
          alusel_ctrl <= "000";
          outen_ctrl <= '0';
          done <= '0';
          state <= Fetch;
          zero_flag := zero_ctrl;
          positive_flag := positive_ctrl;

        WHEN ADD_SUB_SL_SR_next => -- next state TO add, sub,shfl, shfr
          muxsel_ctrl <= "01";
          imm_ctrl <= (OTHERS => '0');
          accwr_ctrl <= '1';
          rfaddr_ctrl <= "000";
          rfwr_ctrl <= '0';
          alusel_ctrl <= "000";
          outen_ctrl <= '0';
          state <= flag_state;

        WHEN LDA_execute => -- LDA 
          -- *********************************
          -- write the entire state for LDA_execute
          muxsel_ctrl <= "00";
          imm_ctrl <= (OTHERS => '0');
          accwr_ctrl <= '1'; -- write to accumulator
          rfaddr_ctrl <= IR(2 DOWNTO 0);
          rfwr_ctrl <= '0'; -- read from register file
          alusel_ctrl <= "000";
          outen_ctrl <= '0';
          done <= '0';
          state <= flag_state;
          ------------------------------------

        WHEN STA_execute => -- STA 
          muxsel_ctrl <= "00";
          imm_ctrl <= (OTHERS => '0');
          accwr_ctrl <= '0';
          rfaddr_ctrl <= IR(2 DOWNTO 0);
          rfwr_ctrl <= '1';
          alusel_ctrl <= "000";
          outen_ctrl <= '0';
          done <= '0';
          
          state <= Fetch;

        WHEN LDI_execute => -- LDI 
          -- *********************************
          -- write the entire state for LDI_execute
          muxsel_ctrl <= "11";
          imm_ctrl <= PM(PC);
          PC <= PC +1;
          accwr_ctrl <= '1'; -- write to accumulator
          rfaddr_ctrl <= "000";
          rfwr_ctrl <= '0';
          alusel_ctrl <= "000";
          outen_ctrl <= '0';
          done <= '0';
          state <= flag_state;
          ------------------------------------

        WHEN JZ_execute => -- JZ
          -- *********************************
          -- write the entire state for JZ_execute 
          muxsel_ctrl <= "00";
          imm_ctrl <= PM(PC);
          IF zero_flag = '1' THEN
            PC <= conv_integer(unsigned(imm_ctrl(4 downto 0)));
          ELSE
            PC <= PC + 1;
          END IF;
          accwr_ctrl <= '0';
          rfaddr_ctrl <= "000";
          rfwr_ctrl <= '0';
          alusel_ctrl <= "000";
          outen_ctrl <= '0';
          done <= '0';
          state <= Fetch;
          ------------------------------------
        WHEN ADD_execute => -- ADD 
          -- *********************************
          -- write the entire state for ADD_execute 
          muxsel_ctrl <= "00";
          imm_ctrl <= (OTHERS => '0');
          accwr_ctrl <= '1';
          rfaddr_ctrl <= IR(2 DOWNTO 0);
          rfwr_ctrl <= '0';
          alusel_ctrl <= "100";
          outen_ctrl <= '0';
          done <= '0';
          state <= ADD_SUB_SL_SR_next;
          ------------------------------------

        WHEN SUB_execute => -- SUB 
          -- *********************************
          -- write the entire state for SUB_execute 
          muxsel_ctrl <= "00";
          imm_ctrl <= (OTHERS => '0');
          accwr_ctrl <= '0';
          rfaddr_ctrl <= IR(2 DOWNTO 0);
          rfwr_ctrl <= '0';
          alusel_ctrl <= "101";
          outen_ctrl <= '0';
          done <= '0';
          state <= ADD_SUB_SL_SR_next;
          ------------------------------------
        WHEN SHFL_execute => -- SHFL
          -- *********************************
          -- write the entire state for SHFL_execute 
          muxsel_ctrl <= "00";
          imm_ctrl <= (OTHERS => '0');
          accwr_ctrl <= '0';
          rfaddr_ctrl <= IR(2 downto 0);
          rfwr_ctrl <= '0';
          alusel_ctrl <= "010";
          bits_shift_ctrl <= IR(1 downto 0);
          outen_ctrl <= '0';
          done <= '0';
          state <= ADD_SUB_SL_SR_next;
          ------------------------------------
        WHEN SHFR_execute => -- SHFR 
          -- *********************************
          -- write the entire state for SHFR_execute 
          muxsel_ctrl <= "00";
          imm_ctrl <= (OTHERS => '0');
          accwr_ctrl <= '0';
          rfaddr_ctrl <= IR(2 downto 0);
          rfwr_ctrl <= '0';
          alusel_ctrl <= "011";
          bits_shift_ctrl <= IR(1 downto 0);
          outen_ctrl <= '0';
          done <= '0';
          state <= ADD_SUB_SL_SR_next;
          ------------------------------------
        WHEN input_A => -- INA
          muxsel_ctrl <= "10";
          imm_ctrl <= (OTHERS => '0');
          accwr_ctrl <= '1';
          rfaddr_ctrl <= "000";
          rfwr_ctrl <= '0';
          alusel_ctrl <= "000";
          outen_ctrl <= '0';
          done <= '0';
          bit_sel_ctrl <= IR(0);
          state <= flag_state;

        WHEN output_A => -- OUTA
          -- *********************************
          -- write the entire state for output_A
          muxsel_ctrl <= "00";
          imm_ctrl <= (OTHERS => '0');
          accwr_ctrl <= '0';
          rfaddr_ctrl <= "000";
          rfwr_ctrl <= '0';
          alusel_ctrl <= "000";
          outen_ctrl <= '1';
          done <= '0';
          state <= Fetch;
          ------------------------------------

        WHEN Halt_cpu => -- HALT
          muxsel_ctrl <= "00";
          imm_ctrl <= (OTHERS => '0');
          accwr_ctrl <= '0';
          rfaddr_ctrl <= "000";
          rfwr_ctrl <= '0';
          alusel_ctrl <= "000";
          outen_ctrl <= '1';
          done <= '1';
          state <= Halt_cpu;

        WHEN OTHERS =>
          muxsel_ctrl <= "00";
          imm_ctrl <= (OTHERS => '0');
          accwr_ctrl <= '0';
          rfaddr_ctrl <= "000";
          rfwr_ctrl <= '0';
          alusel_ctrl <= "000";
          outen_ctrl <= '1';
          done <= '1';
          state <= Halt_cpu;
      END CASE;
    END IF;

  END PROCESS;
END Behavior;
