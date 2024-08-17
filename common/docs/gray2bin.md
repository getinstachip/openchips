# Gray to Binary Converter (gray2bin)

## 1. Overview and Module Description

The `gray2bin` module is a parameterized Verilog implementation of a Gray code to binary converter. It takes a Gray-encoded input and produces the corresponding binary-encoded output. The module supports variable data widths, making it flexible for different applications.

## 2. Pinout Diagram

```
         +-----------+
    in -->|           |
         |  gray2bin  |--> out
         |           |
         +-----------+
```

## 3. Table of Ports

| Port Name | Direction | Width  | Description                 |
|-----------|-----------|--------|-----------------------------|
| in        | Input     | DW     | Gray-encoded input          |
| out       | Output    | DW     | Binary-encoded output       |

## 4. Table of Parameters

| Parameter Name | Default Value | Description                  |
|----------------|---------------|------------------------------|
| DW             | 32            | Width of data inputs/outputs |

## 5. Important Implementation Details

- The module uses a combinational logic approach to convert Gray code to binary.
- The conversion is performed using a nested loop structure:
  - The outer loop iterates through each bit of the binary output.
  - The inner loop calculates each binary bit by XORing all Gray code bits from the current position to the most significant bit.
- The most significant bit of the binary output is always equal to the most significant bit of the Gray input.
- The module is fully parameterized, allowing for easy adjustment of the data width.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/PsLSzdM/Screenshot-2024-08-17-at-6-38-46-AM.png)

## 7. List of Major Bugs or Caveats

- The module assumes that the input Gray code is valid. Invalid inputs may produce unexpected results.
- For very large data widths, the nested loop structure may impact timing performance and synthesis results. Consider alternative implementations for extremely wide data paths.
- The module does not include any input validation or error checking mechanisms.