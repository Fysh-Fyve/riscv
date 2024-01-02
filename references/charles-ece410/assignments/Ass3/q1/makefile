if_gen: full_adder.vhd n_bit_adder.vhd n_bit_adder_if_gen.vhd n_bit_adder_tb.vhd
	ghdl -c --std=08 $^ -r n_bit_adder_tb

case_gen: full_adder.vhd n_bit_adder.vhd n_bit_adder_case_gen.vhd n_bit_adder_tb.vhd
	ghdl -c --std=08 $^ -r n_bit_adder_tb