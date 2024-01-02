----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/25/2021 04:57:56 PM
-- Design Name: 
-- Module Name: counter_4_bit_tb - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY counter_4_bit_tb IS
	--  Port ( );
END counter_4_bit_tb;

ARCHITECTURE Behavioral OF counter_4_bit_tb IS
	SIGNAL clk : STD_LOGIC;
	SIGNAL dout : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL reset : STD_LOGIC;

	COMPONENT counter_4_bit IS
		PORT (
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			bit_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
	END COMPONENT;
BEGIN
	counter : counter_4_bit PORT MAP(clk => clk, bit_out => dout, reset => reset);
	test : PROCESS
	BEGIN
		reset <= '1';
		WAIT FOR 5 ns;
		reset <= '0';
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		clk <= '0';
		WAIT FOR 10 ns;
		clk <= '1';
		WAIT FOR 10 ns;
		WAIT;
	END PROCESS test;
END Behavioral;