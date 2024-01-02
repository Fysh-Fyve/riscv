LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE STD.TEXTIO.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY barrel_shifter_tb IS
END barrel_shifter_tb;

ARCHITECTURE Behavioral OF barrel_shifter_tb IS
    SIGNAL d_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL d_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rot : STD_LOGIC_VECTOR(4 DOWNTO 0);

    COMPONENT barrel_shifter IS
        GENERIC (WID : INTEGER RANGE 2 TO 128);
        PORT (
            d_in : IN STD_LOGIC_VECTOR (WID - 1 DOWNTO 0);
            d_out : OUT STD_LOGIC_VECTOR (WID - 1 DOWNTO 0);
            rot : IN STD_LOGIC_VECTOR (
            INTEGER(ceil(log2((real(WID))))) - 1 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    shifter : barrel_shifter GENERIC MAP(WID => 32)
    PORT MAP(d_in => d_in, d_out => d_out, rot => rot);

    shifter_testing : PROCESS
    BEGIN
        d_in <= "00000000000000001111111111111111";

        FOR I IN 0 TO 31 LOOP
            rot <= STD_LOGIC_VECTOR(to_unsigned(I, rot'length));
            WAIT FOR 5 ns;
        END LOOP;

        WAIT;
    END PROCESS;

    print_out : PROCESS (d_out)
        VARIABLE my_line : line;
    BEGIN
        write(my_line, rot, left, 10);
        write(my_line, d_in, left, 40);
        write(my_line, d_out, left, 40);
        writeline(output, my_line);
    END PROCESS;
END Behavioral;