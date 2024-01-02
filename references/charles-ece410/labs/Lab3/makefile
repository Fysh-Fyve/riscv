VHD=$(shell ls | grep .vhd)

all: topmodule cpu_core_tb

topmodule: $(VHD)
	ghdl -c --std=08 -fsynopsys $^ -r $@

cpu_core_tb: $(VHD)
	ghdl -c --std=08 -fsynopsys $^ -r $@

clean:
	ghdl clean

.PHONY: clean topmodule cpu_core_tb