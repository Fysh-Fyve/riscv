---- Company: Department of Electrical and Computer Engineering, University of Alberta
---- Engineer: Shyama Gandhi and Bruce Cockburn
---- 
---- Create Date: 10/10/2021 03:41:32 PM
---- Design Name: 
---- Module Name: seq_fsm - Behavioral
---- Project Name: 
---- Target Devices: Zybo Z7-10 
---- Tool Versions: 
---- Description: SEQUENCE DETECTOR : 11011 - OVERLAPPING CASE : MEALY FSM
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created

------------------------------------------------------------------------------------
---- Additional Comments:
---- ADD THE CODE IN THE COMMENTED SECTION. THERE ARE TWO INTENTIONAL MISTAKES TOO IN THIS CODE TEMPLATE! 
---- CORRECT THE MISTAKES TO ENSURE CORRECT WORKING OF FSM.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY seq_fsm IS
  PORT (
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    seq_in : IN STD_LOGIC;
    output_detect : OUT STD_LOGIC);
END seq_fsm;

ARCHITECTURE Behavioral OF seq_fsm IS

  SIGNAL clk_o : STD_LOGIC;

  TYPE states IS (A, B, C, D, E);
  SIGNAL state_reg, state_next : states;

  ---------------------------------------------
  -- Add the clk_divider component here
  -- Remember, you want to add this component here and then use it later when you wish to have the divided clock by a factor of 62500000
  COMPONENT clk_divider IS
    PORT (
      clk_in : IN STD_LOGIC;
      clk_out : OUT STD_LOGIC);
  END COMPONENT;

  ---------------------------------------------

BEGIN
  ---------------------------------------------
  -- port map the clk_divider here
  CLK_DIV : clk_divider PORT MAP(clk_in => clk, clk_out => clk_o);

  ---------------------------------------------

  -- the process below uses the 'clk' i.e. the undivided clock , i.e. the clock signal from the entity.
  -- you can replace it with the divided clock signal later on when you add the 'clk_divider' component.
  -- same way, you will need to change the clock signal in the 'elsif' statement inside the process below, later on!
  PROCESS (clk_o, reset)
  BEGIN
    IF (reset = '1') THEN
      state_reg <= A;
    ELSIF (clk_o'event AND rising_edge(clk_o)) THEN
      state_reg <= state_next;
    END IF;
  END PROCESS;

  PROCESS (seq_in) -- complete the sensitivity list
  BEGIN
    CASE state_reg IS
      WHEN A => -- IDLE
        IF seq_in = '0' THEN
          state_next <= A;
          output_detect <= '0';
        ELSE
          state_next <= B;
          output_detect <= '0';
        END IF;

        --- Add the remaining cases for other states here!
      WHEN B => -- S1
        IF seq_in = '0' THEN
          state_next <= A;
          output_detect <= '0';
        ELSE
          state_next <= C;
          output_detect <= '0';
        END IF;

      WHEN C => -- S11
        IF seq_in = '0' THEN
          state_next <= D;
          output_detect <= '0';
        ELSE
          state_next <= C;
          output_detect <= '0';
        END IF;

      WHEN D => -- S110
        IF seq_in = '0' THEN
          state_next <= A;
          output_detect <= '0';
        ELSE
          state_next <= E;
          output_detect <= '0';
        END IF;

      WHEN E => -- S1101
        IF seq_in = '0' THEN
          state_next <= A;
          output_detect <= '0';
        ELSE
          state_next <= C;
          output_detect <= '1';
        END IF;

    END CASE;
  END PROCESS;

END Behavioral;
