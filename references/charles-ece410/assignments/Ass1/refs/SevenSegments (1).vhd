----------------------------------------------------------------------------------
-- Company:     University of Alberta
-- Engineer:    Raza Bhatti
-- 
-- Create Date: 05/18/2018 09:43:23 AM
-- Design Name: 
-- Module Name: SevenSegments - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY SevenSegments IS
    PORT (
        clk : IN STD_LOGIC;
        CC : OUT STD_LOGIC; --Common cathode input to select respective 7-segment digit.
        out_7seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END SevenSegments;

ARCHITECTURE Behavioral OF SevenSegments IS

    SIGNAL count : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL clk_out : STD_LOGIC := '0';
    SIGNAL seg_select : STD_LOGIC := '0';
    SIGNAL SevenSeg_Count : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
BEGIN

    CLK_OneHz : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF (count < 125000000) THEN
                count <= count + '1';
            ELSE
                count <= (OTHERS => '0');
                clk_out <= NOT clk_out;
                SevenSeg_Count <= SevenSeg_Count + '1';
            END IF;
            seg_select <= NOT seg_selectl
                CC <= seg_select;
        END IF;
    END PROCESS;
    Decoder_4to7Segment : PROCESS (clk_out)

    BEGIN

        CASE SevenSeg_Count IS --Assuming A down to G
            WHEN "0000" => out_7seg <= "0111111";
            WHEN "0001" => out_7seg <= "0000110";
            WHEN "0010" => out_7seg <= "1011011";
            WHEN "0011" => out_7seg <= "1001111";
            WHEN "0100" => out_7seg <= "1100110";
            WHEN "0101" => out_7seg <= "1101101";
            WHEN "0110" => out_7seg <= "1111101";
            WHEN "0111" => out_7seg <= "0000111";
            WHEN "1000" => out_7seg <= "1111111";
            WHEN "1001" => out_7seg <= "1101111";
            WHEN "1010" => out_7seg <= "1110111";
            WHEN "1011" => out_7seg <= "1111100";
            WHEN "1100" => out_7seg <= "0111001";
            WHEN "1101" => out_7seg <= "1011110";
            WHEN "1110" => out_7seg <= "1111001";
            WHEN "1111" => out_7seg <= "1110001";
        END CASE;

    END PROCESS;

END Behavioral;