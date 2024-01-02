# Assignment 1

## Question 1

Multiple-core processors help with the designer productivity gap because it encourages modularity by having smaller, multiple cores instead of a large, single core. There modularity advantage is greater in homogeneous multiple-core systems, where the chip only includes identical cores.By increasing the computational power through multiple cores, problems with clock speed, propagation delays, and temperature do not pose as much of a problem as in single-core systems.

## Question 2

Manufacturing multiple transistors together on a single chip instead of using discrete transistor devices allows for smaller chips. This in turn reduces cost as more chips can be made with less materials. Because integrated circuits are smaller than printed circuit boards with discrete transistors, it also has better performance as charges will have shorter travel time.

## Question 3

### NOT F(A)=A'

F(A) = (AA)' = (A)' = A'

### AND F(A,B)=AB

F(A,B) = ((AB)'(AB)')' = (AB) + (AB) = AB

### OR F(A,B)=A+B

F(A,B)=((AA)'(BB)')' = AA + BB = A + B

## Question 4

F(A,B,C,D)

| ABCD | F   |
| ---- | --- |
| 0000 | 1   |
| 0001 | 0   |
| 0010 | 0   |
| 0011 | 1   |
| 0100 | 0   |
| 0101 | 1   |
| 0110 | 1   |
| 0111 | 0   |
| 1000 | 0   |
| 1001 | 1   |
| 1010 | 1   |
| 1011 | 0   |
| 1100 | 1   |
| 1101 | 0   |
| 1110 | 0   |
| 1111 | 1   |

F = A'B'C'D' + A'B'CD + A'BC'D + A'BCD' + AB'C'D + AB'CD' + ABC'D' + ABCD  
F(A,B,C,D) = SUM(0,3,5,6,9,10,12,15)

| ABC | D   | F   |
| --- | --- | --- |
| 000 | 0   | 1   |
| 000 | 1   | 0   |
| 001 | 0   | 0   |
| 001 | 1   | 1   |
| 010 | 0   | 0   |
| 010 | 1   | 1   |
| 011 | 0   | 1   |
| 011 | 1   | 0   |
| 100 | 0   | 0   |
| 100 | 1   | 1   |
| 101 | 0   | 1   |
| 101 | 1   | 0   |
| 110 | 0   | 1   |
| 110 | 1   | 0   |
| 111 | 0   | 0   |
| 111 | 1   | 1   |

MUX with SEL(A,B,C), Prune rows with F = 0, separate D

| SEL | D   | F   |
| --- | --- | --- |
| 000 | 0   | 1   |
| 001 | 1   | 1   |
| 010 | 1   | 1   |
| 011 | 0   | 1   |
| 100 | 1   | 1   |
| 101 | 0   | 1   |
| 110 | 0   | 1   |
| 111 | 1   | 1   |

0, 3, 5, 6 -> connected to D'  
1, 2, 4, 7 -> connected to D

## Question 5

| ROT | D_IN     | D_OUT    |
| --- | -------- | -------- |
| 000 | 00001111 | 00001111 |
| 001 | 00001111 | 10000111 |
| 010 | 00001111 | 11000011 |
| 011 | 00001111 | 11100000 |
| 100 | 00001111 | 01110000 |
| 101 | 00001111 | 00111000 |
| 110 | 00001111 | 00011100 |
| 111 | 00001111 | 00011110 |

## Question 6

Gray code

| Dec | Bin  | Gry  | Hex |
| --- | ---- | ---- | --- |
| 0   | 0000 | 0000 | 0   |
| 1   | 0001 | 0001 | 1   |
| 2   | 0010 | 0011 | 3   |
| 3   | 0011 | 0010 | 2   |
| 4   | 0100 | 0110 | 6   |
| 5   | 0101 | 0111 | 7   |
| 6   | 0110 | 0101 | 5   |
| 7   | 0111 | 0100 | 4   |
| 8   | 1000 | 1100 | c   |
| 9   | 1001 | 1101 | d   |
| 10  | 1010 | 1111 | f   |
| 11  | 1011 | 1110 | e   |
| 12  | 1100 | 1010 | a   |
| 13  | 1101 | 1011 | b   |
| 14  | 1110 | 1001 | 9   |
| 15  | 1111 | 1000 | 8   |

| Pres | Next |
| ---- | ---- |
| 0000 | 0001 |
| 0001 | 0011 |
| 0011 | 0010 |
| 0010 | 0110 |
| 0110 | 0111 |
| 0111 | 0101 |
| 0101 | 0100 |
| 0100 | 1100 |
| 1100 | 1101 |
| 1101 | 1111 |
| 1111 | 1110 |
| 1110 | 1010 |
| 1010 | 1011 |
| 1011 | 1001 |
| 1001 | 1000 |
| 1000 | 0000 |
