LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.MATH_REAL.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY barrel_shifter IS
    GENERIC (WID : INTEGER RANGE 2 TO 128);
    PORT (
        d_in : IN STD_LOGIC_VECTOR (WID - 1 DOWNTO 0);
        d_out : OUT STD_LOGIC_VECTOR (WID - 1 DOWNTO 0);
        rot : IN STD_LOGIC_VECTOR (
        INTEGER(ceil(log2((real(WID))))) - 1 DOWNTO 0)
    );
END barrel_shifter;

ARCHITECTURE Behavioral OF barrel_shifter IS
    -- this is what happens when software engineers touch hardware
    FUNCTION r_shift(
        d_in : IN STD_LOGIC_VECTOR(WID - 1 DOWNTO 0);
        rot : IN INTEGER)
        RETURN STD_LOGIC_VECTOR IS
        VARIABLE d_out : STD_LOGIC_VECTOR(WID - 1 DOWNTO 0);
    BEGIN
        d_out := d_in;
        -- VHDL for loop is inclusive
        FOR I IN 0 TO rot - 1 LOOP
            d_out := d_out(0) & d_out(WID - 1 DOWNTO 1);
        END LOOP;

        RETURN d_out;
    END FUNCTION r_shift;
BEGIN
    d_out <= r_shift(d_in, to_integer(unsigned(rot)));
END Behavioral;