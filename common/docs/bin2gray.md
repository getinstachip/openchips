# Binary to Gray Code Converter (bin2gray)

## 1. Overview and Module Description

The `bin2gray` module is a parameterized Verilog implementation of a binary to Gray code converter. It takes a binary-encoded input and produces the corresponding Gray-encoded output. The module supports variable data widths, making it flexible for different applications.

Gray code is a sequence of binary numerals where two successive values differ in only one bit. This module performs the conversion from standard binary to Gray code, which can be useful in various digital systems, particularly in reducing errors in data transmission.

## 2. Pinout Diagram

```
         ┌─────────────┐
    in ──┤             │
         │   bin2gray  ├── out
         │             │
         └─────────────┘
```

## 3. Table of Ports

| Port Name | Direction | Width  | Description                 |
|-----------|-----------|--------|-----------------------------|
| in        | Input     | DW     | Binary-encoded input        |
| out       | Output    | DW     | Gray-encoded output         |

## 4. Table of Parameters

| Parameter Name | Default Value | Description                  |
|----------------|---------------|------------------------------|
| DW             | 32            | Width of data inputs/outputs |

## 5. Important Implementation Details

1. The module uses a combinational logic approach to perform the binary to Gray code conversion.
2. The most significant bit (MSB) of the Gray code output is the same as the MSB of the binary input.
3. For all other bits, each bit of the Gray code is calculated as the XOR of the corresponding binary bit and the next more significant binary bit.
4. The conversion is performed using a for loop in an always block, allowing for easy scaling to different data widths.
5. The module is fully parameterized, with the data width (DW) configurable at instantiation.

## 6. GTKWave Simulation Results

![Simulation Waveform](https://i.ibb.co/nLFP2NV/Screenshot-2024-08-17-at-5-20-59-AM.png)

## 7. Known Bugs or Caveats

1. The module assumes that the input is a valid binary number. No input validation is performed.
2. Care should be taken when instantiating this module with large data widths, as it may impact timing and resource utilization in hardware implementations.
3. The module does not include any clock or reset signals, making it purely combinational. For sequential designs, additional logic may be needed.