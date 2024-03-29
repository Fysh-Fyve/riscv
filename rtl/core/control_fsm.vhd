--! \file control_fsm.vhd
--! \author Charles Ancheta
--! @cond Doxygen_Suppress
library ieee;
use ieee.std_logic_1164.all;
use work.fysh_fyve.all;
--! @endcond

--! The Big Brain of the CPU.\n

entity control_fsm is
  generic (VERBOSE : boolean := false);
  port (
    clk_i     : in std_ulogic;          --! Clock Signal.
    reset_i   : in std_ulogic;
    eq_i      : in std_ulogic;          --! Equal flag (A == B).
    lt_i      : in std_ulogic;          --! Less than flag (A < B).
    ltu_i     : in std_ulogic;  --! Unsigned less than flag (A < B (unsigned)).
    load_i    : in std_ulogic;  --! Whether the next instruction is a load instruction.
    opcode_i  : in std_ulogic_vector (6 downto 0) := (others => '0');
    op_bits_i : in std_ulogic_vector (2 downto 0);
    sub_sra_i : in std_ulogic;  --! subtract or shift right arithmetic flag (0 = add, logical shift right; 1 = subtract, arithmetic shift right).

    op_bits_o : out std_ulogic_vector (2 downto 0) := (others => '0');
    rd_sel_o  : out std_ulogic_vector (1 downto 0) := (others => '0');

    sub_sra_o      : out std_ulogic := '0';
    draddr_sel_o   : out std_ulogic := '0';
    iraddr_sel_o   : out std_ulogic := '0';
    waddr_sel_o    : out std_ulogic := '0';
    alu_a_sel_o    : out std_ulogic := '0';
    alu_b_sel_o    : out std_ulogic := '0';
    mem_write_en_o : out std_ulogic := '0';
    rd_clk_o       : out std_ulogic := '0';
    pc_clk_o       : out std_ulogic := '0';
    ir_clk_o       : out std_ulogic := '0';
    pc_alu_sel_o   : out std_ulogic := '0';
    pc_next_sel_o  : out std_ulogic := '0';
    done_o         : out std_logic  := '0');  --! The CPU is done executing
end control_fsm;

architecture rtl of control_fsm is
  type state_t is (init, decode, reg_wait, drive, done);
  type write_dest_t is (mem, reg, none);

  signal pc_clk       : std_ulogic := '0';
  signal ir_clk       : std_ulogic := '0';
  signal rd_clk       : std_ulogic := '0';
  signal mem_write_en : std_ulogic := '0';

  signal branch : std_ulogic := '0';

  signal is_add : std_ulogic := '0';

  signal write_dest : write_dest_t := none;
  signal state      : state_t      := init;
  signal next_state : state_t      := drive;

  signal mux_sels : std_ulogic_vector(8 downto 0);

  procedure write (l : inout std.textio.line; s : in state_t) is
    use std.textio.all;
  begin
    case s is
      when init     => write(l, string'("init"));
      when decode   => write(l, string'("decode"));
      when reg_wait => write(l, string'("reg_wait"));
      when drive    => write(l, string'("drive"));
      when done     => write(l, string'("done"));
    end case;
  end write;

  procedure write (l : inout std.textio.line; wd : in write_dest_t) is
    use std.textio.all;
  begin
    case wd is
      when mem  => write(l, string'("mem"));
      when reg  => write(l, string'("reg"));
      when none => write(l, string'("none"));
    end case;
  end write;
begin
  with opcode_i(6 downto 2) select write_dest <=
    reg  when OPCODE_LUI
    | OPCODE_AUIPC
    | OPCODE_REG_IM
    | OPCODE_REG_REG
    | OPCODE_LOAD
    | OPCODE_JAL
    | OPCODE_JALR
    | OPCODE_FYSH,
    mem  when OPCODE_STORE,
    none when others;

  with load_i select next_state <=
    reg_wait when '1',
    drive    when others;

  with op_bits_i select is_add <=
    '1' when OP_ADD_SUB,
    '0' when others;

  with op_bits_i select branch <=
    eq_i      when BEQ,
    not eq_i  when BNE,
    lt_i      when BLT,
    not lt_i  when BGE,
    ltu_i     when BLTU,
    not ltu_i when BGEU,
    '0'       when others;

  with opcode_i(6 downto 2) select sub_sra_o <=
    sub_sra_i and not is_add when OPCODE_REG_IM,  -- There is no subi
    sub_sra_i                when OPCODE_REG_REG,
    '0'                      when others;

  with opcode_i(6 downto 2) select op_bits_o <=
    op_bits_i  when OPCODE_REG_IM | OPCODE_REG_REG,
    OP_OR      when OPCODE_LUI,
    OP_ADD_SUB when OPCODE_AUIPC,
    "000"      when others;

  -- alu_a, alu_b
  -- draddr_sel, iraddr_sel, waddr_sel
  -- pc_alu, pc_next
  -- rd_sel
  with opcode_i(6 downto 2) select mux_sels <=
    "01" & "111" & "10" & "01" when OPCODE_LUI,
    "11" & "111" & "10" & "01" when OPCODE_AUIPC,
    "01" & "111" & "10" & "01" when OPCODE_REG_IM,
    "00" & "111" & "10" & "01" when OPCODE_REG_REG,

    "01" & "011" & "10" & "11" when OPCODE_LOAD,
    "01" & "110" & "10" & "01" when OPCODE_STORE,

    "11" & "111" & "11" & "00" when OPCODE_JAL,
    "01" & "111" & "11" & "00" when OPCODE_JALR,

    "00" & "111" & "10" & "10" when OPCODE_FYSH,

    "00" & "111" & not branch & "0" & "01" when OPCODE_BRANCH,

    -- Because I'm sleeping on these
    "ZZ" & "ZZZ" & "ZZ" & "ZZ" when OPCODE_FENCE,
    "ZZ" & "ZZZ" & "ZZ" & "ZZ" when OPCODE_ATOMIC,
    (others => 'X')            when others;

  alu_a_sel_o   <= mux_sels(8);
  alu_b_sel_o   <= mux_sels(7);
  draddr_sel_o  <= mux_sels(6);
  iraddr_sel_o  <= mux_sels(5);
  waddr_sel_o   <= mux_sels(4);
  pc_alu_sel_o  <= mux_sels(3);
  pc_next_sel_o <= mux_sels(2);
  rd_sel_o      <= mux_sels(1 downto 0);

  drive_clock : process(clk_i, reset_i, opcode_i, pc_clk, ir_clk, mem_write_en)
    use std.textio.all;
    variable l : line;
  begin
    if reset_i = '1' then
      state  <= init;
      done_o <= '0';
    elsif rising_edge(clk_i) then
      if VERBOSE then
        write(l, string'("state: "));
        write(l, state);
        writeline(output, l);
      end if;
      case state is
        when init =>
          state <= decode;
        when decode =>
          mem_write_en <= '0';
          rd_clk       <= '0';
          ir_clk       <= '1';
          pc_clk       <= '0';
          state        <= next_state;
        when reg_wait =>
          state <= drive;
        when drive =>
          case write_dest is
            when mem =>
              mem_write_en <= '1';
            when reg =>
              rd_clk <= '1';
            when none =>
          end case;
          ir_clk <= '0';
          pc_clk <= '1';
          state  <= decode;
        when done =>
          done_o <= '1';
      end case;
    end if;
  end process drive_clock;

  rd_clk_o       <= rd_clk;
  pc_clk_o       <= pc_clk;
  ir_clk_o       <= ir_clk;
  mem_write_en_o <= mem_write_en;
end rtl;
