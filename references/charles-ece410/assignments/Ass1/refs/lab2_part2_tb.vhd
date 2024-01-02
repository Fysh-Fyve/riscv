---------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2018 12:26:06 PM
-- Design Name: 
-- Module Name: lab2_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY lab2_part2_tb IS
    --  Port ( );
END lab2_part2_tb;

ARCHITECTURE Behavioral OF lab2_part2_tb IS

    COMPONENT lab2_part2_tb IS
        PORT (
            C : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            K : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Alarm : OUT STD_LOGIC := '0';
            Lab0_Unlock : OUT STD_LOGIC := '0';
            Lab1_Unlock : OUT STD_LOGIC := '0'
        );
    END COMPONENT;

    SIGNAL C : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL K : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL Alarm, Lab0_Unlock, Lab1_Unlock : STD_LOGIC := '0';

BEGIN

    -- Instantiate components.

    Labs_Access : lab2_part2 PORT MAP
    (
        C => C,
        K => K,
        Alarm => Alarm,
        Lab0_Unlock => Lab0_Unlock,
        Lab1_Unlock => Lab1_Unlock
    );

    Simulation : PROCESS
    BEGIN
        -- Test outputs when C0=0, C1=0 and K0=0, K1=0, K2=0
        C <= "00";
        K <= "000";
        WAIT FOR 10 ns;

        -- Test outputs when C0=1, C1=0 and K0=0, K1=0, K2=0 
        C <= "01";
        K <= "100";
        WAIT FOR 10 ns;

        -- Test outputs when C0=0, C1=1 and K0=0, K1=0, K2=0 
        C <= "01";
        K <= "000";
        WAIT FOR 10 ns;

        -- Test outputs when C0=0, C1=0 and K0=0, K1=0, K2=1 
        C <= "01";
        K <= "110";
        WAIT FOR 10 ns;

        -- Test outputs when C0=0, C1=1 and K0=0, K1=1, K2=1 
        C <= "10";
        K <= "011";
        WAIT FOR 10 ns;

        -- Test outputs when C0=0, C1=1 and K0=0, K1=1, K2=1 
        C <= "01";
        K <= "110";
        WAIT FOR 10 ns;

        -- Test outputs when C0=0, C1=1 and K0=1, K1=1, K2=0 
        C <= "00";
        K <= "001";
        WAIT FOR 10 ns;

        -- Test outputs when C0=1, C1=1 and K0=0, K1=0, K2=0 
        C <= "11";
        K <= "000";
        WAIT FOR 10 ns;

        -- Test Keypad inputs when K0=1, K1=1, K2=1 
        K <= "111";
        WAIT FOR 10 ns;

    END PROCESS;
END Behavioral;