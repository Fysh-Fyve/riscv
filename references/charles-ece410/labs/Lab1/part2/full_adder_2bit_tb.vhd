----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2021 11:20:10 AM
-- Design Name: 
-- Module Name: full_adder_2bit_tb - Behavioral
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

ENTITY full_adder_2bit_tb IS
  --  Port ( );
END full_adder_2bit_tb;

ARCHITECTURE Behavioral OF full_adder_2bit_tb IS

  COMPONENT full_adder_2bit IS
    PORT (
      A : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      B : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      C_in : IN STD_LOGIC;
      Sum : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
      C_out : OUT STD_LOGIC;
      compare_result : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
  END COMPONENT;

  SIGNAL A, B : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL C_in, C_out : STD_LOGIC;
  SIGNAL Sum : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL compare_result : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
  Full_adder : full_adder_2bit PORT MAP(
    A => A,
    B => B,
    C_in => C_in,
    Sum => Sum,
    C_out => C_out,
    compare_result => compare_result);

  PROCESS
    CONSTANT time_period : TIME := 20ns;

  BEGIN

    -- this is a self checking testbench written for few input combinations of the 2-bit half adder.
    -- Error in Sum and Cout will be reported using this self checking test bench
    -- On generation of the wrong outputs, error is reported in the tcl console window

    -- You must include reasonable number of test cases to verify the working of your design.

    ----------------
    A <= "00";
    B <= "00";
    C_in <= '0';
    WAIT FOR time_period;
    ASSERT ((Sum = "00") AND (C_out = '0') AND (compare_result = "001"))
    REPORT "Error for input A_in=00 and B_in=00 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    B <= "01";
    WAIT FOR time_period;
    ASSERT ((Sum = "01") AND (C_out = '0') AND (compare_result = "010")) 
    REPORT "Error for input A_in=00 and B_in=01 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    B <= "10";
    WAIT FOR time_period;
    ASSERT ((Sum = "10") AND (C_out = '0') AND (compare_result = "010")) 
    REPORT "Error for input A_in=00 and B_in=10 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    B <= "11";
    WAIT FOR time_period;
    ASSERT ((Sum = "11") AND (C_out = '0') AND (compare_result = "010")) 
    REPORT "Error for input A_in=00 and B_in=11 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    A <= "01";
    B <= "00";
    WAIT FOR time_period;
    ASSERT ((Sum = "01") AND (C_out = '0') AND (compare_result = "100"))
    REPORT "Error for input A_in=01 and B_in=00 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    B <= "01";
    WAIT FOR time_period;
    ASSERT ((Sum = "10") AND (C_out = '0') AND (compare_result = "001")) 
    REPORT "Error for input A_in=01 and B_in=01 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    B <= "10";
    WAIT FOR time_period;
    ASSERT ((Sum = "11") AND (C_out = '0') AND (compare_result = "010")) 
    REPORT "Error for input A_in=01 and B_in=10 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    B <= "11";
    WAIT FOR time_period;
    ASSERT ((Sum = "00") AND (C_out = '1') AND (compare_result = "010")) 
    REPORT "Error for input A_in=01 and B_in=11 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    A <= "10";
    B <= "00";
    WAIT FOR time_period;
    ASSERT ((Sum = "10") AND (C_out = '0') AND (compare_result = "100"))
    REPORT "Error for input A_in=10 and B_in=00 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    B <= "01";
    WAIT FOR time_period;
    ASSERT ((Sum = "11") AND (C_out = '0') AND (compare_result = "100")) 
    REPORT "Error for input A_in=10 and B_in=01 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    B <= "10";
    WAIT FOR time_period;
    ASSERT ((Sum = "00") AND (C_out = '1') AND (compare_result = "001")) 
    REPORT "Error for input A_in=10 and B_in=10 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    B <= "11";
    WAIT FOR time_period;
    ASSERT ((Sum = "01") AND (C_out = '1') AND (compare_result = "010")) 
    REPORT "Error for input A_in=10 and B_in=11 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    A <= "11";
    B <= "00";
    WAIT FOR time_period;
    ASSERT ((Sum = "11") AND (C_out = '0') AND (compare_result = "100"))
    REPORT "Error for input A_in=11 and B_in=00 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    B <= "01";
    WAIT FOR time_period;
    ASSERT ((Sum = "00") AND (C_out = '1') AND (compare_result = "100")) 
    REPORT "Error for input A_in=11 and B_in=01 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    B <= "10";
    WAIT FOR time_period;
    ASSERT ((Sum = "01") AND (C_out = '1') AND (compare_result = "100")) 
    REPORT "Error for input A_in=11 and B_in=10 and C_in=0" SEVERITY error;
    ----------------
    ----------------
    B <= "11";
    WAIT FOR time_period;
    ASSERT ((Sum = "10") AND (C_out = '1') AND (compare_result = "001")) 
    REPORT "Error for input A_in=11 and B_in=11 and C_in=0" SEVERITY error;
    ----------------

    ----------------
    A <= "00";
    B <= "00";
    C_in <= '1';
    WAIT FOR time_period;
    ASSERT ((Sum = "01") AND (C_out = '0') AND (compare_result = "001"))
    REPORT "Error for input A_in=00 and B_in=00 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    B <= "01";
    WAIT FOR time_period;
    ASSERT ((Sum = "10") AND (C_out = '0') AND (compare_result = "010")) 
    REPORT "Error for input A_in=00 and B_in=01 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    B <= "10";
    WAIT FOR time_period;
    ASSERT ((Sum = "11") AND (C_out = '0') AND (compare_result = "010")) 
    REPORT "Error for input A_in=00 and B_in=10 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    B <= "11";
    WAIT FOR time_period;
    ASSERT ((Sum = "00") AND (C_out = '1') AND (compare_result = "010")) 
    REPORT "Error for input A_in=00 and B_in=11 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    A <= "01";
    B <= "00";
    WAIT FOR time_period;
    ASSERT ((Sum = "10") AND (C_out = '0') AND (compare_result = "100"))
    REPORT "Error for input A_in=01 and B_in=00 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    B <= "01";
    WAIT FOR time_period;
    ASSERT ((Sum = "11") AND (C_out = '0') AND (compare_result = "001")) 
    REPORT "Error for input A_in=01 and B_in=01 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    B <= "10";
    WAIT FOR time_period;
    ASSERT ((Sum = "00") AND (C_out = '1') AND (compare_result = "010")) 
    REPORT "Error for input A_in=01 and B_in=10 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    B <= "11";
    WAIT FOR time_period;
    ASSERT ((Sum = "01") AND (C_out = '1') AND (compare_result = "010")) 
    REPORT "Error for input A_in=01 and B_in=11 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    A <= "10";
    B <= "00";
    WAIT FOR time_period;
    ASSERT ((Sum = "11") AND (C_out = '0') AND (compare_result = "100"))
    REPORT "Error for input A_in=10 and B_in=00 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    B <= "01";
    WAIT FOR time_period;
    ASSERT ((Sum = "00") AND (C_out = '1') AND (compare_result = "100")) 
    REPORT "Error for input A_in=10 and B_in=01 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    B <= "10";
    WAIT FOR time_period;
    ASSERT ((Sum = "01") AND (C_out = '1') AND (compare_result = "001")) 
    REPORT "Error for input A_in=10 and B_in=10 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    B <= "11";
    WAIT FOR time_period;
    ASSERT ((Sum = "10") AND (C_out = '1') AND (compare_result = "010")) 
    REPORT "Error for input A_in=10 and B_in=11 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    A <= "11";
    B <= "00";
    WAIT FOR time_period;
    ASSERT ((Sum = "00") AND (C_out = '1') AND (compare_result = "100"))
    REPORT "Error for input A_in=11 and B_in=00 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    B <= "01";
    WAIT FOR time_period;
    ASSERT ((Sum = "01") AND (C_out = '1') AND (compare_result = "100")) 
    REPORT "Error for input A_in=11 and B_in=01 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    B <= "10";
    WAIT FOR time_period;
    ASSERT ((Sum = "10") AND (C_out = '1') AND (compare_result = "100")) 
    REPORT "Error for input A_in=11 and B_in=10 and C_in=1" SEVERITY error;
    ----------------
    ----------------
    B <= "11";
    WAIT FOR time_period;
    ASSERT ((Sum = "11") AND (C_out = '1') AND (compare_result = "001")) 
    REPORT "Error for input A_in=11 and B_in=11 and C_in=1" SEVERITY error;
    ----------------

  END PROCESS;

END Behavioral;
