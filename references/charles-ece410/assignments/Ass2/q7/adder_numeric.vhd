LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY adder_numeric IS
    GENERIC (WID : NATURAL);
    PORT (
        a : IN UNSIGNED (WID - 1 DOWNTO 0);
        b : IN UNSIGNED (WID - 1 DOWNTO 0);
        c : IN UNSIGNED (WID - 1 DOWNTO 0);
        sum : OUT UNSIGNED (WID + 1 DOWNTO 0)
    );
END adder_numeric;

ARCHITECTURE Behavioral OF adder_numeric IS
BEGIN
    -- extend a, b, and c to match sum's length
    sum <= ("00" & a) + ("00" & b) + ("00" & c);
END Behavioral;