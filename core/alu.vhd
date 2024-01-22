--! \file alu.vhd
--! \author Charles Ancheta
--! @cond Doxygen_Suppress
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--! @endcond

-- VHDL code for an Arithmetic Logic Unit (ALU).
-- This ALU supports basic arithmetic and logical operations.
-- It takes two 32-bit operands, a function code, and a control signal for subtraction or arithmetic right shift.

entity alu is
  port (
    operand_a, operand_b : in  std_ulogic_vector (31 downto 0);  -- 32-bit input operands
    func_code            : in  std_ulogic_vector (2 downto 0);   -- 3-bit function code determining the operation
    sub_or_sra           : in  std_ulogic;                       -- Control signal for subtraction/arithmetic right shift
    result               : out std_ulogic_vector (31 downto 0);  -- 32-bit output result of the ALU
    equal_flag,          -- Output flag for equality comparison
    less_than_flag,      -- Output flag for signed less than comparison
    less_than_unsigned_flag : out std_ulogic);                   -- Output flag for unsigned less than comparison
end alu;

architecture Behavioral of alu is
  signal addition_result          : signed (31 downto 0);            -- Signal for storing addition/subtraction result
  signal left_shifted_result      : std_ulogic_vector (31 downto 0); -- Signal for storing left shift result
  signal right_shifted_result     : std_ulogic_vector (31 downto 0); -- Signal for storing right shift result
  signal unsigned_shift_operand_a : std_ulogic_vector (31 downto 0); -- Operand A for unsigned right shift
  signal signed_shift_operand_a   : std_ulogic_vector (31 downto 0); -- Operand A for signed right shift

  -- Function to compare two 32-bit unsigned numbers and return '1' if first is less than second
  function less_than_unsigned(
    a : std_ulogic_vector (31 downto 0);
    b : std_ulogic_vector (31 downto 0)) return std_ulogic is
    variable lt : std_ulogic;
  begin
    lt := '1' when to_integer(unsigned(a(30 downto 0))) < to_integer(unsigned(b(30 downto 0))) else '0';
    return (not a(31) and b(31)) or (lt and (a(31) xnor b(31)));
  end function less_than_unsigned;

begin
  -- Multiplexer for selecting the operation based on function code
  with func_code select result <=
    operand_a and operand_b                when "111",
    operand_a or operand_b                 when "110",
    right_shifted_result                   when "101",
    operand_a xor operand_b                when "100",
    x"0000000" & "000" & less_than_unsigned_flag when "011",
    x"0000000" & "000" & less_than_flag    when "010",
    left_shifted_result                    when "001",
    std_ulogic_vector(addition_result)     when "000",
    (others => 'X')                        when others;

  -- Compute addition or subtraction based on sub_or_sra signal
  addition_result  <= (signed(operand_a) - signed(operand_b)) when sub_or_sra else (signed(operand_a) + signed(operand_b));
  
  -- Shift operations
  left_shifted_result  <= std_ulogic_vector(shift_left(unsigned(operand_a), to_integer(unsigned(operand_b(4 downto 0)))));
  right_shifted_result <= signed_shift_operand_a when sub_or_sra else unsigned_shift_operand_a;
  unsigned_shift_operand_a <= std_ulogic_vector(shift_right(unsigned(operand_a), to_integer(unsigned(operand_b(4 downto 0)))));
  signed_shift_operand_a   <= std_ulogic_vector(shift_right(signed(operand_a), to_integer(unsigned(operand_b(4 downto 0)))));

  -- Flags for comparison results
  equal_flag  <= and (operand_a xnor operand_b);
  less_than_flag  <= '1' when to_integer(signed(operand_a)) < to_integer(signed(operand_b)) else '0';
  less_than_unsigned_flag <= less_than_unsigned(operand_a, operand_b);
end Behavioral;
