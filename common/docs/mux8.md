# 8-to-1 Multiplexer (mux8)

## 1. Overview

The `mux8` module is a parameterized 8-to-1 multiplexer implemented in Verilog. It selects one of eight input data buses based on eight select signals and outputs the selected data. The width of the input and output data buses is configurable through a parameter.

## 2. Pinout Diagram

```
         +-------------+
sel7 --->|             |
sel6 --->|             |
sel5 --->|             |
sel4 --->|             |
sel3 --->|    mux8     |---> out
sel2 --->|             |
sel1 --->|             |
sel0 --->|             |
         |             |
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

## 3. Port Description

| Port | Direction | Width  | Description                    |
|------|-----------|--------|--------------------------------|
| sel7 | Input     | 1-bit  | Select signal for input 7      |
| sel6 | Input     | 1-bit  | Select signal for input 6      |
| sel5 | Input     | 1-bit  | Select signal for input 5      |
| sel4 | Input     | 1-bit  | Select signal for input 4      |
| sel3 | Input     | 1-bit  | Select signal for input 3      |
| sel2 | Input     | 1-bit  | Select signal for input 2      |
| sel1 | Input     | 1-bit  | Select signal for input 1      |
| sel0 | Input     | 1-bit  | Select signal for input 0      |
| in7  | Input     | DW-bit | Input data bus 7               |
| in6  | Input     | DW-bit | Input data bus 6               |
| in5  | Input     | DW-bit | Input data bus 5               |
| in4  | Input     | DW-bit | Input data bus 4               |
| in3  | Input     | DW-bit | Input data bus 3               |
| in2  | Input     | DW-bit | Input data bus 2               |
| in1  | Input     | DW-bit | Input data bus 1               |
| in0  | Input     | DW-bit | Input data bus 0               |
| out  | Output    | DW-bit | Selected data output bus       |

## 4. Parameters

| Parameter | Default Value | Description              |
|-----------|---------------|--------------------------|
| DW        | 1             | Width of the data buses  |

## 5. Implementation Details

The `mux8` module uses a combinational logic implementation to select the output. It employs bitwise AND operations between each select signal (extended to match the data width) and its corresponding input data bus. The results are then combined using bitwise OR operations to produce the final output.

The implementation allows for parallel selection of all bits in the data bus, making it suitable for wide data paths.

## 6. GTKWave Simulation Results

![Simulation Waveform](https://i.ibb.co/MZfLzLv/Screenshot-2024-08-17-at-6-46-31-AM.png)

## 7. Bugs and Caveats

1. **Multiple Active Selects**: The module does not explicitly handle the case where multiple select signals are active simultaneously. In such scenarios, the output will be the bitwise OR of all selected inputs, which may lead to unexpected results.

2. **No Default Output**: There is no default output when all select signals are low. In this case, the output will be all zeros.

3. **Timing Considerations**: For large values of DW, the wide OR operation might introduce significant propagation delay, potentially affecting timing in high-speed designs.

4. **Power Consumption**: The continuous bitwise operations on wide data paths may lead to higher power consumption compared to alternative multiplexer implementations.

5. **Scalability**: While the module is parameterized for data width, adding more inputs would require manual modification of the module, as the number of inputs is fixed at 8.