--  Hello world program.
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE STD.TEXTIO.ALL; --  Imports the standard textio package.

--  Defines a design entity, without any ports.
ENTITY hello_world IS
END hello_world;

ARCHITECTURE behaviour OF hello_world IS
BEGIN
	nice : PROCESS
		VARIABLE l : line;
	BEGIN
		write (l, STRING'("Hello world!"));
		writeline (output, l);

		FOR I IN 0 TO 32 LOOP
			write (l, STD_LOGIC_VECTOR(to_unsigned(I, 5)));
			writeline (output, l);
		END LOOP;
		WAIT;
	END PROCESS;
END behaviour;