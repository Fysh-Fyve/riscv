LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;
ENTITY writedatatofile IS
END writedatatofile;
ARCHITECTURE WriteDataToFile_rtl OF writedatatofile IS
	CONSTANT C_FILE_NAME : STRING := "DataOut.dat";
	CONSTANT C_DATA1_W : INTEGER := 16;
	CONSTANT C_DATA3_W : INTEGER := 4;
	CONSTANT C_CLK : TIME := 10 ns;
	SIGNAL clk : STD_LOGIC := '0';
	SIGNAL rst : STD_LOGIC := '0';
	SIGNAL eof : STD_LOGIC := '0';
	FILE fptr : text;
BEGIN
	ClockGenerator : PROCESS
	BEGIN
		clk <= '0' AFTER C_CLK, '1' AFTER 2 * C_CLK;
		WAIT FOR 2 * C_CLK;
	END PROCESS;
	rst <= '1', '0' AFTER 100 ns;
	WriteData_proc : PROCESS
		VARIABLE fstatus : file_open_status;

		VARIABLE file_line : line;
		VARIABLE var_data1 : STD_LOGIC_VECTOR(C_DATA1_W - 1 DOWNTO 0);
		VARIABLE var_data2 : INTEGER;
		VARIABLE var_data3 : STD_LOGIC_VECTOR(C_DATA3_W - 1 DOWNTO 0);
	BEGIN
		var_data1 := (0 => '1', OTHERS => '0');
		var_data2 := 0;
		var_data3 := (3 => '1', OTHERS => '0');
		eof <= '0';
		WAIT UNTIL rst = '0';
		file_open(fstatus, fptr, C_FILE_NAME, write_mode);
		WHILE (var_data2 < 4) LOOP
			WAIT UNTIL clk = '1';
			var_data1 := var_data1(C_DATA1_W - 2 DOWNTO 0) & '0';
			var_data2 := var_data2 + 1;
			var_data3 := '0' & var_data3(C_DATA3_W - 1 DOWNTO 1);
			hwrite(file_line, var_data1, left, 5);
			write(file_line, var_data2, right, 2);
			write(file_line, var_data3, left, 5);
			writeline(fptr, file_line);
		END LOOP;
		WAIT UNTIL rising_edge(clk);
		eof <= '1';
		file_close(fptr);
		WAIT;
	END PROCESS;
END WriteDataToFile_rtl;