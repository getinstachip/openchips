# Edge to Pulse Converter (edge2pulse)

## 1. Overview

The `edge2pulse` module is a Verilog implementation of an edge-to-pulse converter. It detects edges (both rising and falling) on its input signals and generates a single-cycle pulse for each edge detected. This module can be particularly useful in digital design for creating clock enables, triggering events on signal transitions, or interfacing between different clock domains.

## 2. Pinout Diagram

```
         ┌─────────────┐
  clk ───►             │
         │             │
nreset ──►             │
         │  edge2pulse ├──► out
   in ───►             │
         │             │
         └─────────────┘
```

## 3. Port Table

| Port Name | Direction | Width    | Description                     |
|-----------|-----------|----------|---------------------------------|
| clk       | Input     | 1-bit    | Clock signal                    |
| nreset    | Input     | 1-bit    | Asynchronous active-low reset   |
| in        | Input     | DW-bit   | Edge input signal               |
| out       | Output    | DW-bit   | One-cycle pulse output signal   |

## 4. Parameter Table

| Parameter | Default Value | Description                  |
|-----------|---------------|------------------------------|
| DW        | 1             | Width of data inputs/outputs |

## 5. Implementation Details

- The module uses a registered version of the input (`in_reg`) to detect edges.
- Edge detection is performed by XORing the current input with its registered version.
- The output pulse is generated for both rising and falling edges.
- The module is synchronous with the rising edge of the clock and has an asynchronous active-low reset.
- The data width is parameterizable, allowing for multi-bit edge detection and pulse generation.

## 6. GTKWave Simulation Results

![Simulation Waveform](https://i.ibb.co/3my0k1m/Screenshot-2024-08-17-at-6-34-58-AM.png)

## 7. Caveats

1. **Multiple Edges**: If multiple edges occur within a single clock cycle on a given bit, only one pulse will be generated for that bit in the following cycle.
2. **Initial State**: Upon reset, the first rising edge on an input bit will not generate a pulse, as both `in` and `in_reg` will transition from 0 to 1 simultaneously.
3. **Timing**: The output pulse appears one clock cycle after the input edge, which may need to be accounted for in downstream logic.
4. **Clock Domain Crossing**: If used for clock domain crossing, additional synchronization may be required to prevent metastability issues.