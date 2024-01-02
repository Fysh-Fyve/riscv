LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE STD.TEXTIO.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY adder_tb IS
END adder_tb;

ARCHITECTURE Behavioral OF adder_tb IS
    SIGNAL a : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL b : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL c : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL sum : STD_LOGIC_VECTOR(5 DOWNTO 0);

    COMPONENT adder IS
        GENERIC (WID : NATURAL);
        PORT (
            a : IN STD_LOGIC_VECTOR (WID - 1 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR (WID - 1 DOWNTO 0);
            c : IN STD_LOGIC_VECTOR (WID - 1 DOWNTO 0);
            sum : OUT STD_LOGIC_VECTOR (WID + 1 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    adder_3_input : adder GENERIC MAP(WID => 4) PORT MAP(a, b, c, sum);

    testing_adder : PROCESS
    BEGIN
        FOR I IN 0 TO 15 LOOP
            a <= STD_LOGIC_VECTOR(to_unsigned(I, 4));
            b <= STD_LOGIC_VECTOR(to_unsigned(I, 4));
            c <= STD_LOGIC_VECTOR(to_unsigned(I, 4));
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