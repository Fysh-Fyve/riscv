----------------------------------------------------------------------------------
-- Company: University of Alberta
-- Engineer: Charles Ancheta
-- 
-- Create Date: 09/25/2021 06:41:22 PM
-- Design Name: 
-- Module Name: barrel_shifter_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Test bench for 8-bit barrel shifter
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
USE STD.TEXTIO.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY barrel_shifter_tb IS
    --  Port ( );
END barrel_shifter_tb;

ARCHITECTURE Behavioral OF barrel_shifter_tb IS
    SIGNAL d_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL d_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL rot : STD_LOGIC_VECTOR(2 DOWNTO 0);

    COMPONENT barrel_shifter IS
        PORT (
            d_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            d_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            rot : IN STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT;
BEGIN
    shifter : barrel_shifter PORT MAP(d_in => d_in, d_out => d_out, rot => rot);
    d_in <= "00001111";
    rot <= "000",
        "001" AFTER 5 ns,
        "010" AFTER 10 ns,
        "011" AFTER 15 ns,
        "100" AFTER 20 ns,
        "101" AFTER 25 ns,
        "110" AFTER 30 ns,
        "111" AFTER 35 ns,
        "000" AFTER 40 ns;

    print_out : PROCESS (d_out)
        VARIABLE my_line : line;
    BEGIN
        write(my_line, rot, left, 5);
        write(my_line, d_in, left, 10);
        write(my_line, d_out, left, 10);
        writeline(output, my_line);
    END PROCESS;

END Behavioral;