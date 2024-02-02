--! \file phy_map.vhd
--! \author Charles Ancheta
--! @cond Doxygen_Suppress
library ieee;
use ieee.std_logic_1164.all;
use work.rom.rom_arr;
--! @endcond


--! Creates physical maps to memory\n
--! TODO: Implement!\n
--! 0x00000000 - 0x0001FFFF (ROM)\n
--! 0x00020000 - 0x0003FFFF (RAM)\n
--! 0xDEADBEEC - 0xDEADBEEF (GPIO)\n
entity phy_map is
  port (
    clk_i      : in std_ulogic;         --! Clock signal
    write_en_i : in std_ulogic;         --! Write enable

    addr_i : in    std_ulogic_vector (31 downto 0);   --! Read & Write Address
    d_i    : in    std_ulogic_vector (31 downto 0);   --! Data Output
    d_o    : out   std_ulogic_vector (31 downto 0);   --! Data Output
    gpio   : inout std_ulogic_vector (31 downto 0));  --! GPIO Pins

end phy_map;

architecture rtl of phy_map is
  --! Bit used for muxing/demuxing the two memory blocks.
  --! Maybe we should split them up more?
  constant MEM_SPLIT : integer := 17;

  signal mem_sel       : std_ulogic;
  signal ram_write_en  : std_ulogic;
  signal gpio_write_en : std_ulogic;
  signal rom_write_en  : std_ulogic;

  signal gpio_out, mem_out, ram_out, rom_out : std_ulogic_vector (31 downto 0);

  signal gpio_addr_start : std_ulogic;
begin
  ram_write_en <= (not mem_sel) and write_en_i;
  rom_write_en <= '0';                  -- Disable writing

  gpio_addr_start <= '1' when (addr_i = x"DEADBEEC") else '0';
  gpio_write_en   <= mem_sel and write_en_i and gpio_addr_start;

  gpio_clk : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if gpio_write_en = '1' then
        gpio <= d_i;
      end if;
    end if;
    gpio_out <= gpio;
  end process gpio_clk;

  with mem_sel select d_o <=
    gpio_out        when '1',
    mem_out         when '0',
    (others => 'X') when others;

  with addr_i(31 downto 20) select mem_sel <=
    '1' when x"DEA",
    '0' when x"000",
    'X' when others;

  with addr_i(MEM_SPLIT) select mem_out <=
    ram_out         when '1',
    rom_out         when '0',
    (others => 'X') when others;

  rom_inst : entity work.mem(rtl)
    generic map (DATA => rom_arr)
    port map (
      clk_i        => clk_i,
      read_addr_i  => addr_i(MEM_SPLIT-1 downto 2),
      write_addr_i => addr_i(MEM_SPLIT-1 downto 2),
      write_en_i   => rom_write_en,
      d_i          => d_i,
      d_o          => rom_out);

  ram_inst : entity work.mem(rtl) port map (
    clk_i        => clk_i,
    read_addr_i  => addr_i(MEM_SPLIT-1 downto 2),
    write_addr_i => addr_i(MEM_SPLIT-1 downto 2),
    write_en_i   => ram_write_en,
    d_i          => d_i,
    d_o          => ram_out);
end rtl;