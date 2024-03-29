--! \file imm_sx.vhd
--! \author Charles Ancheta
--! @cond Doxygen_Suppress
library ieee;
use ieee.std_logic_1164.all;
use work.fysh_fyve.all;
--! @endcond

--! Immediate Value Sign-extender.\n

--! Takes an immediate value from an instruction and outputs its sign-extended
--! value.
entity imm_sx is
  port (
    instruction_i : in  std_ulogic_vector (31 downto 0) := (others => '0');  --! The 32-bit instruction.
    imm_val_o     : out std_ulogic_vector (31 downto 0) := (others => '0'));  --! The immediate value, sign-extended.
end imm_sx;

architecture rtl of imm_sx is
  --! Take 20 bits from the instruction and output as the high 20 bits.
  --! The lower 12 bits are zeroed.\n
  --! ins[31:12] (20 bits) & (12:0 => 0)
  signal u_type : std_ulogic_vector (31 downto 0);
  --! Take 12 bits from the instruction and sign extend as the low 12 bits.\n
  --! sext ins[31:20] (12 bits)
  signal i_type : std_ulogic_vector (31 downto 0);
  --! Take 12 bits from the instruction (mixed) and sign extend as the low 12
  --! bits (for store instructions).\n
  --! sext ins[31:25] (7 bits) & ins[11:7] (5 bits)
  signal s_type : std_ulogic_vector (31 downto 0);
  --! Take 12 bits from the instruction (mixed) and sign extend as the low 12
  --! bits shifted left by 1, the LSb is zeroed (for branch instructions).\n
  --! sext ins[31] & ins[7] & ins[30:25] (6 bits) & ins[11:8] (4 bits) & 0
  signal b_type : std_ulogic_vector (31 downto 0);
  --! Take 20 bits from the instruction (mixed) and sign extend as the low 20
  --! bits shifted left by 1, the LSb is zeroed (unique to JAL).\n
  --! sext ins[31] & ins[19:12] (8 bits) & ins[20] & ins[30:21] (10 bits) & 0
  signal j_type : std_ulogic_vector (31 downto 0);
begin
  with instruction_i(6 downto 2) select imm_val_o <=
    u_type          when OPCODE_AUIPC | OPCODE_LUI,
    i_type          when OPCODE_LOAD | OPCODE_REG_IM | OPCODE_JALR,
    s_type          when OPCODE_STORE,
    b_type          when OPCODE_BRANCH,
    j_type          when OPCODE_JAL,
    (others => 'X') when others;

  -- long immediate
  u_type <= instruction_i(31 downto 12) & (11 downto 0 => '0');

  -- immediate
  i_type <=
    (31 downto 12 => instruction_i(31))  -- Sign extend
    & instruction_i(31 downto 20);       -- 11:0

  -- store
  s_type <=
    (31 downto 12 => instruction_i(31))  -- Sign extend
    & instruction_i(31 downto 25)        -- 11:5
    & instruction_i(11 downto 7);        -- 4:0

  -- jump
  j_type <=
    (31 downto 21 => instruction_i(31))  -- Sign extend
    & instruction_i(31)                  -- 20
    & instruction_i(19 downto 12)        -- 19:12
    & instruction_i(20)                  -- 11
    & instruction_i(30 downto 21)        -- 10:1
    & '0';                               -- 9:0

  -- branch
  b_type <=
    (31 downto 13 => instruction_i(31))  -- Sign extend
    & instruction_i(31)                  -- 12
    & instruction_i(7)                   -- 11
    & instruction_i(30 downto 25)        -- 10:5
    & instruction_i(11 downto 8)         -- 4:1
    & '0';
end rtl;
