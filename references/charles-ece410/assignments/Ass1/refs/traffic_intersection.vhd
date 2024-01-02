----------------------------------------------------------------------------------
-- Company: University of Alberta
-- Engineer: Fudong Li
-- 
-- Create Date: 05/11/2018 11:22:20 AM
-- Design Name: 
-- Module Name: traffic_intersection - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY traffic_intersection IS
    PORT (
        clk : IN STD_LOGIC;
        btn : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- btn(0) press to see traffic light status for secondary road.
        -- btn(3) press to Places controller in its initial state (highway green, secondary road red)

        sw : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- SW(0)='1'=>Vehicle present on secondary road, 
        -- SW(3)='1'=> Emergency Vehicle on HW16
        led6_r : OUT STD_LOGIC := '0'; --Traffic light status as Red
        led6_g : OUT STD_LOGIC := '0'; --Traffic light status as Green
        led6_b : OUT STD_LOGIC := '0'; --Traffic light status as Yello=>Blue on board

        led : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); --Monitor states [ led(0)-led(2) ] 
        CC : OUT STD_LOGIC; --Common cathode input to select respective 7-segment digit.

        out_7seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) -- Output  signal for selected 7 Segment display. 
    );
END traffic_intersection;

ARCHITECTURE Behavioral OF traffic_intersection IS

    CONSTANT count_for_1Hz : NATURAL := 125000000; --125000000, reduce this number to 1000 for simulation.
    SIGNAL clk_1Hz : STD_LOGIC := '0';
    SIGNAL count : NATURAL;
    SIGNAL clk_out : STD_LOGIC := '0';

    -- Use following signals to implement your FSM.
    SIGNAL D : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000"; --Next state
    SIGNAL Q : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000"; --Current state

    SIGNAL seven_segment_digit : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL reset : STD_LOGIC := btn(3); --Reset signal
BEGIN
    --1Hz clock process 
    clock_1Hz : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF (count < count_for_1Hz) THEN --count_for_1Hz=125000000
                count <= count + 1;
            ELSE
                count <= 0;
                clk_out <= NOT clk_out;
                clk_1Hz <= clk_out;
            END IF;
        END IF;
    END PROCESS;
    -- Finite State Machine Design Fulfilling Lab4 requirements.
    TrafficIntersection : PROCESS (clk, clk_1Hz)
    BEGIN

        --*Write  Flip-flop input and output equations --- (Hint: D <= function of Q and sw)
        D(2) <= ((Q(2) AND NOT Q(1) OR (Q(1) AND Q(0)) AND NOT sw(3);
        D(1) <= (Q(1) XOR Q(0)) AND NOT sw(3);
        D(0) <= ((Q(1) XOR sw(0))OR Q(2)) AND (NOT Q(1)) AND NOT sw(3);
        -----------------------------------------------
        IF btn(0) = '0' THEN
            --*Write light status equations of Highway --- (Hint: led6 <= function of Q)
            led6_r <= Q(2) OR Q(1);
            led6_g <= NOT (Q(2) OR Q(1) OR Q(0));
            leg6_b <= NOT (Q(2) OR Q(1) OR NOT Q(0));
        ELSE
            --*Write light status equations of secondary road --- (Hint: led6 <= function of Q)  
            led6_r <= NOT (Q(2) OR Q(1));
            led6_g <= (Q(2) XOR Q(1)) OR (Q(1) AND NOT Q(0))
                leg6_b <= Q(2) AND Q(1) AND Q(0);
        END IF;

        --*Write the equations of Seven Segment Display --- (Hint: seven_segment_digit <= function of Q).
        seven_segment_digit(2) <= Q(1) AND NOT Q(2);
        seven_segment_digit(1) <= Q(2) AND NOT Q(1);
        seven_segment_digit(0) <= (Q(2) OR (Q(1) AND NOT Q(2))) AND NOT Q(0);

        --*Don't forget the CC signal.
        CC <= NOT CC; -- not sure about this :(

    END PROCESS;
    D_flipflop : PROCESS (clk_1Hz) IS
    BEGIN
        IF rising_edge(clk_1Hz) THEN
            IF reset = '1' THEN
                Q <= "000";
            ELSE
                Q <= D;
            END IF;
        END IF;
        --*Write an statement below to display current state on LEDs.
        led <= Q;

    END PROCESS D_flipflop;
    Decoder_7Segment : PROCESS (clk)
    BEGIN
        --*Write the case statements below to implement the 7-segment decoder (this was done in lab 3)

        CASE seven_segment_digit IS
            WHEN "000" => out_7seg <= "0111111";
            WHEN "001" => out_7seg <= "0000110";
            WHEN "010" => out_7seg <= "1011011";
            WHEN "011" => out_7seg <= "1001111";
            WHEN "100" => out_7seg <= "1100110";
            WHEN "101" => out_7seg <= "1101101";
            WHEN OTHERS => out_7seg <= "0111111";
        END CASE;

    END PROCESS;

END Behavioral;