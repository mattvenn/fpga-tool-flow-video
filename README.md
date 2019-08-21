# truth table for AND, OR and XOR

    I3 I2 I1 I0 | O& O| O^
    ----------------------
    x  x  0  0  | 0  0  0
    x  x  0  1  | 0  1  1
    x  x  1  0  | 0  1  1
    x  x  1  1  | 1  1  0

# LUT configs for AND, OR and XOR

    a & b: 1000 = 8
    a | b: 1110 = 14
    a ^ b: 0110 = 6
