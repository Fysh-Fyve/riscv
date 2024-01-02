LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE STD.TEXTIO.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY adder_numeric_tb IS
END adder_numeric_tb;

ARCHITECTURE Behavioral OF adder_numeric_tb IS
    SIGNAL a : UNSIGNED(3 DOWNTO 0);
    SIGNAL b : UNSIGNED(3 DOWNTO 0);
    SIGNAL c : UNSIGNED(3 DOWNTO 0);
    SIGNAL sum : UNSIGNED(5 DOWNTO 0);

    COMPONENT adder_numeric IS
        GENERIC (WID : NATURAL);
        PORT (
            a : IN UNSIGNED (WID - 1 DOWNTO 0);
            b : IN UNSIGNED (WID - 1 DOWNTO 0);
            c : IN UNSIGNED (WID - 1 DOWNTO 0);
            sum : OUT UNSIGNED (WID + 1 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    adder_3_input : adder_numeric GENERIC MAP(WID => 4) PORT MAP(a, b, c, sum);
    testing_adder : PROCESS
    BEGIN
        FOR I IN 0 TO 15 LOOP
            a <= to_unsigned(I, 4);
            b <= to_unsigned(I, 4);
            c <= to_unsigned(I, 4);
            WAIT FOR 5 ns;
        END LOOP;
        WAIT;
    END PROCESS;

    header : PROCESS
        VARIABLE my_line : line;
    BEGIN
        write(my_line, STRING'("A    B    C    S  sum"));
        writeline(output, my_line);
        WAIT;
    END PROCESS;

    print_out : PROCESS (sum)
        VARIABLE my_line : line;
        VARIABLE sum_int : INTEGER;
    BEGIN
        sum_int := to_integer(unsigned(sum));
        write(my_line, a, left, 5);
        write(my_line, b, left, 5);
        write(my_line, c, left, 5);
        write(my_line, INTEGER'image(sum_int), right, 2);
        write(my_line, sum, right, 7);
        writeline(output, my_line);
    END PROCESS;

END Behavioral;