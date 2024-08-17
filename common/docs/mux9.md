# MUX9: 9-Input Multiplexer

## 1. Overview and Module Description

The `mux9` module is a parameterized 9-input multiplexer implemented in Verilog. It selects one of nine input data buses based on nine select signals. The width of the input and output data buses is configurable through a parameter.

## 2. Pinout Diagram

```
         +-------------+
sel8 --->|             |
sel7 --->|             |
sel6 --->|             |
sel5 --->|             |
sel4 --->|             |
sel3 --->|    MUX9     |
sel2 --->|             |
sel1 --->|             |
sel0 --->|             |---> out
         |             |
in8  --->|             |
in7  --->|             |
in6  --->|             |
in5  --->|             |
in4  --->|             |
in3  --->|             |
in2  --->|             |
in1  --->|             |
in0  --->|             |
         +-------------+
```

## 3. Table of Ports

| Port Name | Direction | Width  | Description                    |
|-----------|-----------|--------|--------------------------------|
| sel8      | Input     | 1-bit  | Select signal for input 8      |
| sel7      | Input     | 1-bit  | Select signal for input 7      |
| sel6      | Input     | 1-bit  | Select signal for input 6      |
| sel5      | Input     | 1-bit  | Select signal for input 5      |
| sel4      | Input     | 1-bit  | Select signal for input 4      |
| sel3      | Input     | 1-bit  | Select signal for input 3      |
| sel2      | Input     | 1-bit  | Select signal for input 2      |
| sel1      | Input     | 1-bit  | Select signal for input 1      |
| sel0      | Input     | 1-bit  | Select signal for input 0      |
| in8       | Input     | DW-bit | Data input 8                   |
| in7       | Input     | DW-bit | Data input 7                   |
| in6       | Input     | DW-bit | Data input 6                   |
| in5       | Input     | DW-bit | Data input 5                   |
| in4       | Input     | DW-bit | Data input 4                   |
| in3       | Input     | DW-bit | Data input 3                   |
| in2       | Input     | DW-bit | Data input 2                   |
| in1       | Input     | DW-bit | Data input 1                   |
| in0       | Input     | DW-bit | Data input 0                   |
| out       | Output    | DW-bit | Selected data output           |

## 4. Table of Parameters

| Parameter Name | Default Value | Description                   |
|----------------|---------------|-------------------------------|
| DW             | 1             | Width of input and output data|

## 5. Important Implementation Details

- The module uses a parameterized design, allowing for flexible data width configuration.
- The multiplexer logic is implemented using a single continuous assignment statement.
- Each input is masked with its corresponding select signal, and the results are bitwise OR'ed together.
- The module uses replication operators to extend the select signals to match the data width.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/Zxcq34Z/Screenshot-2024-08-17-at-6-47-05-AM.png)

## 7. List of Major Bugs or Caveats

- The module assumes that only one select signal is active at a time. If multiple select signals are asserted simultaneously, the output will be the bitwise OR of the corresponding inputs, which may lead to unexpected results.
- There is no default case or error handling for situations where no select signal is active. In such cases, the output will be all zeros.
- The module does not include any clock or reset signals, making it a purely combinational circuit. This may lead to glitches during input transitions.