LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY adder IS
    GENERIC (WID : NATURAL);
    PORT (
        a : IN STD_LOGIC_VECTOR (WID - 1 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR (WID - 1 DOWNTO 0);
        c : IN STD_LOGIC_VECTOR (WID - 1 DOWNTO 0);
        sum : OUT STD_LOGIC_VECTOR (WID + 1 DOWNTO 0)
    );
END adder;

ARCHITECTURE Behavioral OF adder IS
BEGIN
    add : PROCESS (a, b, c)
        VARIABLE c_in : STD_LOGIC_VECTOR(1 DOWNTO 0);
        VARIABLE c_out : STD_LOGIC_VECTOR(1 DOWNTO 0);
        VARIABLE temp_carry : STD_LOGIC;
    BEGIN
        c_out := "00"; -- c_in is assumed to be 00
        FOR i IN 0 TO WID - 1 LOOP
            c_in := c_out; -- use carry from last bit operation
            sum(i) <= a(i) XOR b(i) XOR c(i) XOR c_in(0);

            temp_carry := (c_in(0) AND (a(i) XOR b(i)))
                OR (c(i) AND (c_in(0) XOR a(i)))
                OR (b(i) AND ((a(i) AND NOT c(i)) OR (NOT c_in(0) AND c(i))));

            c_out(0) := temp_carry XOR c_in(1); -- half-add
            c_out(1) := (temp_carry AND c_in(1))
            -- 4 bits equal one MSB carry
            OR (a(i) AND b(i) AND c(i) AND c_in(0));
        END LOOP;

        -- append any carry bits to the MSB of the sum
        sum(WID + 1 DOWNTO WID) <= c_out;
    END PROCESS;
END Behavioral;