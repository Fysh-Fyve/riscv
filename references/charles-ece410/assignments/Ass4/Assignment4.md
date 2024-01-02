# 1. Debouncing circuit

Assuming the stable time is 100 ms, this makes sure that the input is stable before outputting its result

```
# gets called every 5 ms
interrupt:
  # value_1 is undefined in the first interrupt call but
  # it would have a real value for the next (button_input)
  value_2 = value_1
  value_1 = button_input
  if value_1 == value_2:
    increment(stable_time_counter)
    # only change the output if the
    # input hasn't changed for 100 ms
    if stable_time_counter >= 100 ms:
      debounced_output = value_2
  else:
    # input is not stable yet
    reset(stable_time_counter)
```

# 2. Using two-edge clocking pros/cons

Advantages:

Greater throughput since data

Disadvantages:

# 3. Rectangular mesh clock distribution pros/cons

Advantages:

Disadvantages:

# 4. Tree-structured comparator

# 5. Booth multiplication & Fast (Radix-4) multiplication

+M (+87) = 01010111
-M (-87) = 10101001
Q (-78) = 10110010
Expected result = -6786 = 1110010101111110

a) Booth multiplication

| Step | P        | Q        | F   | Operation                   |
| ---- | -------- | -------- | --- | --------------------------- |
| 0    | UUUUUUUU | UUUUUUUU | U   | Uninitialized               |
| 1    | 00000000 | 10110010 | 0   | Initialize (P = 0, Q = -78) |
| 2    | 00000000 | 10110010 | 0   | No-op                       |
| 3    | 00000000 | 01011001 | 0   | Shift right                 |
| 4    | 10101001 | 01011001 | 0   | -M (-87)                    |
| 5    | 11010100 | 10101100 | 1   | Shift right                 |
| 6    | 00101011 | 10101100 | 1   | +M (+87)                    |
| 7    | 00010101 | 11010110 | 0   | Shift right                 |
| 8    | 00010101 | 11010110 | 0   | No-op                       |
| 9    | 00001010 | 11101011 | 0   | Shift right                 |
| 10   | 10110011 | 11101011 | 0   | -M (-87)                    |
| 11   | 11011001 | 11110101 | 1   | Shift right                 |
| 12   | 11011001 | 11110101 | 1   | No-op                       |
| 13   | 11101100 | 11111010 | 1   | Shift right                 |
| 14   | 01000011 | 11111010 | 1   | +M (+87)                    |
| 15   | 00100001 | 11111101 | 0   | Shift right                 |
| 16   | 11001010 | 11111101 | 0   | -M (-87)                    |
| 17   | 11100101 | 01111110 | 1   | Shift right                 |

b) Fast (Radix-4) Multiplication

```
+M  = 01010111
+2M = 10101110
-M  = 10101001
-2M = 01010010
```

| Step | P         | Q         | F   | Operation                   |
| ---- | --------- | --------- | --- | --------------------------- |
| 0    | UUUUUUUUU | UUUUUUUUU | U   | Uninitialized               |
| 1    | 000000000 | 110110010 | 0   | Initialize (P = 0, Q = -78) |
| 2    | 101010010 | 110110010 | 0   | -2M                         |
| 3    | 111010100 | 101101100 | 1   | Shift 2 bits                |
| 4    | 000101011 | 101101100 | 1   | +M                          |
| 5    | 000001010 | 111011011 | 0   | Shift 2 bits                |
| 6    | 110110011 | 111011011 | 0   | -M                          |
| 7    | 111101100 | 111110110 | 1   | Shift 2 bits                |
| 8    | 110010101 | 111110110 | 1   | -M                          |
| 9    | 111100101 | 011111101 | 1   | Shift 2 bits                |

=> 11100101 | 01111110 = -6786
