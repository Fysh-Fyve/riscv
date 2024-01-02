LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY SevenSegments IS
    PORT (
        sw : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        CC : OUT STD_LOGIC;
        out_7seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0) --0:A,6:G
    );
END SevenSegments;

ARCHITECTURE Behavioral OF SevenSegments IS

BEGIN
    -- Assuming G down to A
    out_7seg(0) <= ((NOT sw(2)) NAND (NOT sw(0))) NAND (sw(3) NAND (NOT sw(0))) NAND (sw(3) NAND sw(2) NAND sw(0)) NAND (sw(3) NAND (NOT sw(2)) NAND (NOT sw(1))) NAND ((NOT sw(3)) NAND sw(1)) NAND (sw(2) NAND sw(1));
    out_7seg(1) <= ((NOT sw(2)) NAND (NOT sw(0))) NAND ((NOT sw(3)) NAND (NOT sw(2))) NAND ((NOT sw(3)) NAND (NOT sw(1)) NAND (NOT sw(0))) NAND ((NOT sw(3)) NAND sw(1) NAND sw(0)) NAND (sw(3) NAND (NOT sw(1)) NAND sw(0));
    out_7seg(2) <= (sw(3) NAND (NOT sw(2))) NAND ((NOT sw(1)) NAND sw(0)) NAND ((NOT sw(3)) NAND (NOT sw(1))) NAND ((NOT sw(3)) NAND sw(0));
    out_7seg(3) <= ((NOT sw(3)) NAND (NOT sw(2)) NAND (NOT sw(0))) NAND (sw(3) NAND (NOT sw(1))) NAND (sw(2) NAND (NOT sw(1)) NAND sw(0)) NAND ((NOT sw(2)) NAND sw(1) NAND sw(0)) NAND (sw(2) NAND sw(1) NAND (NOT sw(0)));
    out_7seg(4) <= ((NOT sw(2)) NAND (NOT sw(0))) NAND (sw(3) NAND sw(2)) NAND (sw(1) NAND (NOT sw(0))) NAND (sw(3) NAND sw(1));
    out_7seg(5) <= ((NOT sw(1)) NAND (NOT sw(0))) NAND (sw(3) NAND (NOT sw(2))) NAND (sw(3) NAND sw(1)) NAND (sw(2) NAND (NOT sw(0))) NAND ((NOT sw(3)) NAND sw(2) NAND (NOT sw(1)));
    out_7seg(6) <= (sw(3) NAND (NOT sw(2))) NAND (sw(1) NAND (NOT sw(0))) NAND ((NOT sw(2)) NAND sw(1)) NAND (sw(3) NAND sw(0)) NAND ((NOT sw(3)) NAND sw(2) NAND (NOT sw(1)));

END Behavioral;