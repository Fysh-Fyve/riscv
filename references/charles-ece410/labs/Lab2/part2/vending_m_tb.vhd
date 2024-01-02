
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY vending_m_tb IS
END vending_m_tb;

ARCHITECTURE Behavioral OF vending_m_tb IS

  COMPONENT vending_m IS
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
  END COMPONENT;

  SIGNAL clk_design : STD_LOGIC;
  SIGNAL rst : STD_LOGIC;
  SIGNAL item_select : STD_LOGIC;
  SIGNAL coins : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL change : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL display : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL segment : STD_LOGIC;
  SIGNAL soft_drink_dispense : STD_LOGIC;
  SIGNAL granola_bar_dispense : STD_LOGIC;
  SIGNAL dispensed : STD_LOGIC_VECTOR(1 DOWNTO 0);

  CONSTANT clk_period : TIME := 40 ns;

BEGIN
  --*** add the design lines to port map the entity here
  VENDING_ENT : vending_m PORT MAP(
    clk => clk_design,
    reset => rst,
    item_sel => item_select,
    coins_in => coins,
    change_out => change,
    display_sum => display,
    select_segment => segment,
    soft_drink => soft_drink_dispense,
    granola_bar => granola_bar_dispense);
  --*** end design lines     
  --   dispensed <= "10";    

  clk_process : PROCESS
  BEGIN
    clk_design <= '0';
    WAIT FOR clk_period/2;
    clk_design <= '1';
    WAIT FOR clk_period/2;
  END PROCESS;

  stim_proc : PROCESS
  BEGIN

    rst <= '1';
    item_select <= '0';
    coins <= "00";
    dispensed <= "00";
    WAIT FOR clk_period;
    -- ****Test cases****
    -- Write the series of test cases here to verify the correct working of your design.
    -- Provide the input stimulus to the signals : item_select, coins
    
    -- buying a soft drink - no change
    rst <= '0';
    item_select <= '0';
    coins <= "10";
    WAIT FOR clk_period;
    coins <= "00";
    WAIT FOR clk_period;
    WAIT FOR clk_period;

    -- buying a soft drink - $1 change
    item_select <= '0';
    coins <= "11";
    WAIT FOR clk_period;
    coins <= "00";
    WAIT FOR clk_period;
    coins <= "00";
    WAIT FOR clk_period;
    
    -- buying a soft drink - $2 change
    item_select <= '0';
    coins <= "01";
    WAIT FOR clk_period;
    coins <= "11";
    WAIT FOR clk_period;
    coins <= "00";
    WAIT FOR clk_period;
    WAIT FOR clk_period;

        
    -- buying a granola bar - no change
    item_select <= '1';
    WAIT FOR clk_period;
    coins <= "11";
    WAIT FOR clk_period;
    coins <= "01";
    WAIT FOR clk_period;
    coins <= "00";
    WAIT FOR clk_period;
    
    -- buying a granola bar - $1 change
    item_select <= '1';
    WAIT FOR clk_period;
    coins <= "11";
    WAIT FOR clk_period;
    coins <= "10";
    WAIT FOR clk_period;
    coins <= "00";
    WAIT FOR clk_period;
    
    -- buying a granola bar - $2 change
    item_select <= '1';
    WAIT FOR clk_period;
    coins <= "11";
    WAIT FOR clk_period;
    coins <= "11";
    WAIT FOR clk_period;
    coins <= "00";
    WAIT FOR clk_period;

    
  END PROCESS;
END Behavioral;
