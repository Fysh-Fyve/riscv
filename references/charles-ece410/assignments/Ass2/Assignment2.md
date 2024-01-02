# Assignment 2

## Question 1: "Component" object vs "Component instance"

> In VHDL, briefly describe what a "component" object is and what a "component
> instance" is. In your descriptions, be sure to explain the main purpose and
> advantage of each concept in a VHDL specification. What are the similarities
> and differences between the two concepts?

A component instance is a copy of an entity, and is a representation of a
part in the model. This is connected with other parts and signals through wires.
Its main purpose is abstracting the implementation of a sub-device away and
focusing on the higher-level details of the whole architecture.

A component describes the interface for an entity that will be instantiated
as a component instance. This is free of any specific architecture
(implementation) and the architecture is determined later at compile-time. Its
main purpose is to define the interface of a sub-block ahead of time and
worrying about the implementation of that sub-block later.

The two are similar in a way that they describe a part of a device. You can
think of a component as the blueprint for a part while a component instance is
the part itself.

## Question 2: quark_t Scalar Type Definition

> Give a VHDL statement that defines a new scalar type, quark_t, for the six
> kinds of subatomic particles called quarks, namely: up, down, charm,
> strange, top and bottom (in that order). As well as the attributes for
> scalar types that were introduced on slide 4-16, VHDL provides additional
> attributes for discrete scalar types. Consult reputable documentation and
> state the result of the following attribute expressions:  
> (a) quark_t'pos(strange),  
> (b) quark_t'val(1),  
> (c) quark_t'succ(charm),  
> (d) quark_t'pred(bottom),  
> (e) quark_t'leftof(top), and  
> (f) quark_t'rightof(down).

```vhdl
TYPE quark_t IS (up, down, charm, strange, top, bottom);
```

(a) `quark_t'pos(strange) = 3`  
(b) `quark_t'val(1) = down`  
(c) `quark_t'succ(charm) = strange`  
(d) `quark_t'pred(bottom) = top`  
(e) `quark_t'leftof(top) = strange`  
(f) `quark_t'rightof(down) = charm`

## Question 3: Meaning of STD_ULOGIC values

> In your own words, briefly describe the meaning of the std_ulogic values 'U',
> 'X', 'W', 'Z' and '-'. Then justify how each of these values is resolved with
> the full list of nine values from std_ulogic in the IEEE resolution_table.

'U' -> Uninitialized value.  
'X' -> Forced unknown. Usually happens when the value is set to 0 and 1
simultaneously.  
'W' -> Weak unknown. Usually happens when the value is set to H and L
simultaneously.  
'Z' -> Cut off. This is a floating value.  
'-' -> Impossible state.

### Resolution table

```vhdl
constant resolution_table : stdlogic_table := (
--------------------------------------------------------------
--'U'  'X'  '0'  '1'  'Z'  'W'  'L'  'H'  '-'
--------------------------------------------------------------
( 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U' ), -- 'U'
( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' ), -- 'X'
( 'U', 'X', '0', 'X', '0', '0', '0', '0', 'X' ), -- '0'
( 'U', 'X', 'X', '1', '1', '1', '1', '1', 'X' ), -- '1'
( 'U', 'X', '0', '1', 'Z', 'W', 'L', 'H', 'X' ), -- 'Z'
( 'U', 'X', '0', '1', 'W', 'W', 'W', 'W', 'X' ), -- 'W'
( 'U', 'X', '0', '1', 'L', 'W', 'L', 'W', 'X' ), -- 'L'
( 'U', 'X', '0', '1', 'H', 'W', 'W', 'H', 'X' ), -- 'H'
( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' )  -- '-'
);
```

'U' -> Since the value is uninitialized and is completely random and unknown,
the value should not be trusted and kept uninitialized until it's forced to a
real, known value.  
'X' -> Same as U, but U would take precedence. Even though this value is forced,
it is still completely unknown.  
'Z' -> Since this is cut off, once it makes contact it will just be resolved to
any other connected value.  
'W' -> Since it is unknown, it will resolve any weak signal into a weak unknown.
However, since it is weak, it will be resolved to any strong signal.  
'-' -> This is an impossible value, or at least something that is not used, so
it can be resolved to any random value (forced unknown).

## Question 4: Generic N-bit barrel shifter

> In Question 5 of Assignment #1 you were asked to design an 8-bit barrel
> shifter that received an 8-bit input operand D_IN and then right-rotates that
> operand by a given bit distance of ROT to produce the 8-bit output D_OUT. You
> are now to generalize that design using a VDHL generic so that it handles
> input operands ranging in width from 2 bits up to 128 bits. Your solution is
> to contain  
> (a) the entity for your design,  
> (b) the architecture for that entity, and  
> (c) an example of how the entity could be instantiated to accommodate a D_IN
> of width 32.

(a) `barrel_shifter` entity

```vhdl
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
```

(b) `barrel_shifter` architecture

```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.MATH_REAL.ALL;
USE IEEE.NUMERIC_STD.ALL;

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
```

(c) `barrel_shifter` 32-bit example

```vhdl
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
```

## Question 5: Timing Specifiers

> Briefly explain why synthesis software for VHDL ignores any timing specifiers
> in signal assignment statements. If those specifiers are ignored when the
> hardware design is being specified, why would one use timing specifiers at
> all in a VHDL specification, either before or after the design has been
> synthesized to a hardware implementation?

Synthesis software for VHDL ignores any timing specifiers in signal assignment
statements because it has no way to guarantee that that delay will occur in the
target hardware. However, timing specifiers are still useful when creating the
simulation model.

## Question 6: Resizeable 3-input-operand binary adder

> Design a behavioural-level model of a resizeable three-input-operand binary
> adder whose width is specified using a generic called WID. All three input
> arguments (a, b and c) are to be of type std_logic_vector(WID-1 downto 0). The
> carry-in bit at the least significant position is to be assumed to have
> value 0. The output of the adder, called sum, is to be of type
> std_logic_vector(WID+1 downto 0). The inputs and outputs can all be assumed to
> be unsigned integers, where the most significant bit position is a magnitude
> bit and not a sign bit. Your architecture must use a VHDL loop construct that
> iterates over the bits of the input operands, going from the least significant
> bit position (index 0) up to the most significant bit position (WID-1) of the
> three input operands.

To implement this purely using combinational logic, we need to keep track of two
carry bits.  
The carry bits for the next operation are then evaluated using a half-adder.

### Truth table:

| C0 ABC (C1=0) | Sum | Cout | C0 ABC (C1=1) | Sum | Cout |
| ------------- | --- | ---- | ------------- | --- | ---- |
| 0000          | 0   | 00   | 0000          | 0   | 01   |
| 0001          | 1   | 00   | 0001          | 1   | 01   |
| 0010          | 1   | 00   | 0010          | 1   | 01   |
| 0011          | 0   | 01   | 0011          | 0   | 10   |
| 0100          | 1   | 00   | 0100          | 1   | 01   |
| 0101          | 0   | 01   | 0101          | 0   | 10   |
| 0110          | 0   | 01   | 0110          | 0   | 10   |
| 0111          | 1   | 01   | 0111          | 1   | 10   |
| 1000          | 1   | 00   | 1000          | 1   | 01   |
| 1001          | 0   | 01   | 1001          | 0   | 10   |
| 1010          | 0   | 01   | 1010          | 0   | 10   |
| 1011          | 1   | 01   | 1011          | 1   | 10   |
| 1100          | 0   | 01   | 1100          | 0   | 10   |
| 1101          | 1   | 01   | 1101          | 1   | 10   |
| 1110          | 1   | 01   | 1110          | 1   | 10   |
| 1111          | 0   | 10   | 1111          | 0   | 11   |

### Hardware Description

```vhdl
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
```

## Question 7: Adder using IEEE.NUMERIC_STD

> Repeat question 6, but this time assume that the three input operands as well
> as the output sum are of type unsigned as defined in the IEEE package
> NUMERIC_STD. Hint: This package is used in the up/down counter example on
> slide 4-60.

```vhdl
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
```
