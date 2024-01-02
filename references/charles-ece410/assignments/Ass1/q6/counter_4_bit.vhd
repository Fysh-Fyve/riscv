LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY counter_4_bit IS
  PORT (
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    bit_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END counter_4_bit;

ARCHITECTURE GrayCodeBehavioral OF counter_4_bit IS
  SIGNAL count : STD_LOGIC_VECTOR (3 DOWNTO 0);
BEGIN
  count_gray : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      -- reset counter back to 0
      count <= "0000";
    ELSIF (rising_edge(clk)) THEN
      CASE count IS
        WHEN "0000" => count <= "0001";
        WHEN "0001" => count <= "0011";
        WHEN "0011" => count <= "0010";
        WHEN "0010" => count <= "0110";
        WHEN "0110" => count <= "0111";
        WHEN "0111" => count <= "0101";
        WHEN "0101" => count <= "0100";
        WHEN "0100" => count <= "1100";
        WHEN "1100" => count <= "1101";
        WHEN "1101" => count <= "1111";
        WHEN "1111" => count <= "1110";
        WHEN "1110" => count <= "1010";
        WHEN "1010" => count <= "1011";
        WHEN "1011" => count <= "1001";
        WHEN "1001" => count <= "1000";
        WHEN OTHERS => count <= "0000"; -- count = "1000"
      END CASE;
    END IF;
    bit_out <= count;
  END PROCESS;
END GrayCodeBehavioral;