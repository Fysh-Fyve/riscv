----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: Shyama Gandhi and Bruce Cockburn
-- 
-- Create Date: 08/10/2020 10:04:58 AM
-- Design Name: 
-- Module Name: fa_2bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 2-BIT FULL ADDER CREATED USING THREE 16:1 MULTIPLEXERS each for carry out, S(1) and S(0).
--  The components for S0, S1 and C0 are to be included in this top module using the port map statements.

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

-- use for comparison
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY full_adder_2bit IS
  PORT (
    A : IN STD_LOGIC_VECTOR(1 DOWNTO 0); --input vector A
    B : IN STD_LOGIC_VECTOR(1 DOWNTO 0); --input vector B
    C_in : IN STD_LOGIC; --CARRY INPUT : 0/1
    Sum : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);--sum output
    C_out : OUT STD_LOGIC; --carry output
    compare_result : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)); -- compare the input vector A and B : mapped to RGB led in xdc file
END full_adder_2bit;

ARCHITECTURE Behavioral OF full_adder_2bit IS

  COMPONENT Co_mux IS
    PORT (
      cin : IN STD_LOGIC;
      select_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      y_cout : OUT STD_LOGIC);
  END COMPONENT;

  COMPONENT S1_mux IS
    PORT (
      cin : IN STD_LOGIC;
      select_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      y_s1 : OUT STD_LOGIC);
  END COMPONENT;

  COMPONENT S0_mux IS
    PORT (
      cin : IN STD_LOGIC;
      select_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      y_s0 : OUT STD_LOGIC);
  END COMPONENT;

BEGIN

  -- PART 3....
  -- The "LD6" - RGB led on board is used as an indication if A>B or A<B or A=B. 
  -- Write 3 lines of conditional signal assignment code (say using "WHEN/ELSE")
  -- to turn the LED red when A>B, green when A<B and blue when A=B.

  compare_result <= "100" WHEN A > B ELSE           -- red
    "010" WHEN A < B ELSE -- green
    "001"; -- A = B, blue

  -- port map the component for generating carry output                     
  carry_map : Co_mux PORT MAP(
    cin => C_in,
    select_in(3 DOWNTO 2) => A,
    select_in(1 DOWNTO 0) => B,
    y_cout => C_out);

  -- port map the component for generating the S(1)

  s1_map : S1_mux PORT MAP(
    cin => C_in,
    select_in(3 DOWNTO 2) => A,
    select_in(1 DOWNTO 0) => B,
    y_s1 => Sum(1));
  -- port map the component for generating the S(0)                                    
  s0_map : S0_mux PORT MAP(
    cin => C_in,
    select_in(3 DOWNTO 2) => A,
    select_in(1 DOWNTO 0) => B,
    y_s0 => Sum(0));
END Behavioral;
