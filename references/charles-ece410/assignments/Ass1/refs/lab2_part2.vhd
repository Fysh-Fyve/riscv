LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY lab2_part2 IS
    PORT (
        C : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        K : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Alarm : OUT STD_LOGIC := '0';
        Lab0_Unlock : OUT STD_LOGIC := '0';
        Lab1_Unlock : OUT STD_LOGIC := '0'
    );
END lab2_part2;

ARCHITECTURE Behavioral OF lab2_part2 IS

BEGIN

    Lab0_Unlock <= ((NOT C(0)) AND C(1)) AND (K(0) AND (NOT K(2)));
    Lab1_Unlock <= ((NOT C(1)) AND C(0)) AND (K(2) AND (NOT K(0)));
    Alarm <= (C(0) OR C(1)) AND (C(0) OR (NOT K(0)) OR K(2)) AND (C(1) OR K(0) OR (NOT K(2)));

END Behavioral;