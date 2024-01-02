
-----------------------------------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: Shyama Gandhi and Bruce Cockburn
--
-- Create Date: 10/11/2021 09:50:46 PM
-- Design Name:
-- Module Name: vending - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: VENDING MACHINE - LAB 2 : ECE 410 (2021)
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--*********************************************************************************
-- The Vending Machine accepts 1$, 2$ and 3$ denominations. soft drink price : 2$, granola bar : 4$
-- The current sum of the total money inserted should be displayed on the seven segment.
-- Hand over the change to the customer, and then dispense the item (soft drink/granola bar)
----------------------------------------------------------------------------------

-- 0: ABCDEF - 0111111 - 3f
-- 1: BC - 0000110 - 06 
-- 2: ABDEG - 1011011 - 5b
-- 3: ABCDG - 1001111 -4f
-- 4: BCFG - 1100110 -66
-- 5: ACDFG - 1101101 - 6d
-- 6: ACDEFG - 1111101 - 7d

-- 7: ABC - 0000111 - 07
-- 8: ABCDEFG - 1111111 - 7f
-- 9: ABCFG - 1100111 - 67
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY vending_m IS
  PORT (
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    item_sel : IN STD_LOGIC; -- sel=0 for soft drink (2$), sel=1 for granola bar (4$)
    coins_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- "00" - 0$, "01" - 1$, "10" - 2$, "11" - 3$
    change_out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- changeout is displayed on two leds - "00" - 0$
    -- "01" - 1$, "10" - 2$ and "11" - 3$
    display_sum : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- display the current sum of inserted money on the seven segment
    select_segment : OUT STD_LOGIC; -- select the left or right segment
    soft_drink : OUT STD_LOGIC; -- turn on the LED to dispense soft drink
    granola_bar : OUT STD_LOGIC); -- turn on the LED to dispense granola bar

END vending_m;

ARCHITECTURE Behavioral OF vending_m IS

  ---------------------------------------------
  -- *** Add the clk_divider component here
  -- Remember, you want to add this component here and then use it later when you wish to have the divided clock by a factor of 62500000
  ---------------------------------------------
  COMPONENT clk_divider IS
    PORT (
      clk_in : IN STD_LOGIC;
      clk_out : OUT STD_LOGIC);
  END COMPONENT;

  SIGNAL clk_o : STD_LOGIC;
  TYPE state_type IS (sum_0, -- state names represent the total sum of inserted money by the user
    sum_1,
    sum_2,
    sum_3,
    sum_4,
    sum_5,
    sum_6,
    dispense);

  SIGNAL present_state, next_state : state_type; -- current and next state declaration.

BEGIN

  ---------------------------------------------
  -- *** port map the clk_divider here
  CLK_DIV : clk_divider PORT MAP(clk_in => clk, clk_out => clk_o);

  ---------------------------------------------

  select_segment <= '0'; -- you may use either the left or the right seven segment.

  --  the process below uses the 'clk' i.e. the undivided clock , i.e. the clock signal from the entity.
  --  you can replace it with the divided clock signal later on when you add the 'clk_divider' component.
  --  same way, you will need to change the clock signal in the 'elsif' statement inside the process below, later on!

  PROCESS (clk_o, reset)
  BEGIN
    IF (reset = '1') THEN
      ---------------------------------------------
      -- *** write one line of code to update the present state when reset=1
      ---------------------------------------------
      present_state <= sum_0;

    ELSIF (clk_o'event AND rising_edge(clk_o)) THEN
      ---------------------------------------------
      -- *** write one line of code to update the present state
      ---------------------------------------------
      present_state <= next_state;
    END IF;
  END PROCESS;

  PROCESS (present_state, coins_in, item_sel) --*** complete the sensitivity list
  BEGIN
    CASE present_state IS
      WHEN sum_0 =>
        soft_drink <= '0';
        granola_bar <= '0';
        change_out <= "00";

        ---------------------------------------------
        --*** write one line of code to display the current sum of inserted money on the seven segment display
        ---------------------------------------------
        display_sum <= "0111111"; -- sum = 0

        ---------------------------------------------
        --*** update the design lines when coins inserted are 00/01/10/11
        -- you may use any conditional assignment format
        -- based on the inserted coins, update the next state
        -- for example, if the coins inserted is "10" i.e., 2$, go to state sum_2.
        ---------------------------------------------
        CASE coins_in IS
          WHEN "00" => next_state <= sum_0;
          WHEN "01" => next_state <= sum_1;
          WHEN "10" => next_state <= sum_2;
          WHEN OTHERS => next_state <= sum_3; -- coins_in="11"
        END CASE;
      WHEN sum_1 =>
        soft_drink <= '0';
        granola_bar <= '0';
        change_out <= "00";

        ---------------------------------------------
        --*** write one line of code to display the current sum of inserted money on the seven segment display
        ---------------------------------------------
        display_sum <= "0000110";

        ---------------------------------------------
        --*** update the design lines when coins inserted are 00/01/10/11
        -- you may use any conditional assignment format
        -- based on the inserted coins, update the next state
        -- for example, if the coins inserted is "10" i.e., 2$,
        -- the total amount inserted till now is 2$ + 1$ = 3$. So, you wish to update the next_state accordingly.
        -- For example, say, if item_sel=0, and user inserted 1$, so the total amount is 2$. The next state is now, sum_2.
        -- In this case inside sum_2, you now want to return if any change and then dispense the soft drink.
        -- Make sure, from "sum_2" to "sum_6", you also take care to even check if item_sel=0 or item_sel=1 and update the state accordingly. 
        ---------------------------------------------
        CASE coins_in IS
          WHEN "00" => next_state <= sum_1;
          WHEN "01" => next_state <= sum_2;
          WHEN "10" => next_state <= sum_3;
          WHEN OTHERS => next_state <= sum_4; -- coins_in="11"
        END CASE;

      WHEN sum_2 =>
        soft_drink <= '0';
        granola_bar <= '0';
        change_out <= "00";

        ---------------------------------------------
        --*** write one line of code to display the current sum of inserted money on the seven segment display
        ---------------------------------------------
        display_sum <= "1011011";

        ---------------------------------------------
        --*** update the design lines when coins inserted are 00/01/10/11
        -- you may use any conditional assignment format
        -- based on the inserted coins, update the next state
        ---------------------------------------------
        IF (item_sel = '0') THEN
            change_out <= "00";
            next_state <= dispense;
        ELSE
            CASE coins_in IS
              WHEN "00" => next_state <= sum_2;
              WHEN "01" => next_state <= sum_3;
              WHEN "10" => next_state <= sum_4;
              WHEN OTHERS => next_state <= sum_5; -- coins_in="11"
            END CASE;
        END IF;
      WHEN sum_3 =>
        soft_drink <= '0';
        granola_bar <= '0';
        change_out <= "00";

        ---------------------------------------------
        --*** write one line of code to display the current sum of inserted money on the seven segment display
        ---------------------------------------------
        display_sum <= "1001111";

        ---------------------------------------------
        --*** update the design lines when coins inserted are 00/01/10/11
        -- you may use any conditional assignment format
        -- based on the inserted coins, update the next state
        ---------------------------------------------
        IF (item_sel = '0') THEN
            change_out <= "01";
            next_state <= dispense;
        ELSE
            CASE coins_in IS
              WHEN "00" => next_state <= sum_3;
              WHEN "01" => next_state <= sum_4;
              WHEN "10" => next_state <= sum_5;
              WHEN OTHERS => next_state <= sum_6; -- coins_in="11"
            END CASE;
        END IF;
      WHEN sum_4 =>
        soft_drink <= '0';
        granola_bar <= '0';

        ---------------------------------------------
        --*** write one line of code to display the current sum of inserted money on the seven segment display
        ---------------------------------------------
        display_sum <= "1100110";

        ---------------------------------------------
        --*** update the design lines when coins inserted are 00/01/10/11
        -- you may use any conditional assignment format
        -- based on the inserted coins, update the next state

        ---------------------------------------------
        IF (item_sel = '0') THEN
            change_out <= "10";
            next_state <= dispense;
        ELSE
            change_out <= "00";
            next_state <= dispense;
        END IF;
      WHEN sum_5 =>
        soft_drink <= '0';
        granola_bar <= '0';

        ---------------------------------------------
        --*** write one line of code to display the current sum of inserted money on the seven segment display
        ---------------------------------------------
        display_sum <= "1101101";

        ---------------------------------------------
        --*** update the design lines when coins inserted are 00/01/10/11
        -- you may use any conditional assignment format
        -- based on the inserted coins, update the next state

        ---------------------------------------------
        change_out <= "01";
        next_state <= dispense;
      WHEN sum_6 =>
        soft_drink <= '0';
        granola_bar <= '0';

        ---------------------------------------------
        --*** write one line of code to display the current sum of inserted money on the seven segment display
        ---------------------------------------------
        display_sum <= "1111101";
        ---------------------------------------------
        --*** update the design lines when coins inserted are 00/01/10/11
        -- you may use any conditional assignment format
        -- based on the inserted coins, update the next state
        ---------------------------------------------
        change_out <= "10";
        next_state <= dispense;
      WHEN dispense =>
        display_sum <= "0111111";
        change_out <= "00";
        IF (item_sel = '0') THEN
          ---------------------------------------------
          --** write two assignment statements to dispense the soft drink and granola bar
          ---------------------------------------------
          soft_drink <= '1';
          granola_bar <='0';
        ELSE
          ---------------------------------------------
          --** write two assignment statements to dispense the soft drink and granola bar
          ---------------------------------------------
          soft_drink <= '0';
          granola_bar <='1';
        END IF;
        
        next_state <= sum_0;

    END CASE;
  END PROCESS;
END Behavioral;
