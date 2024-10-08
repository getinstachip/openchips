# rise2pulse Module Documentation

## 1. Overview and Module Description

The `rise2pulse` module is designed to convert a rising edge on an input signal into a single-cycle pulse output. It can handle multi-bit inputs and outputs, with the width configurable through a parameter. This module is useful in digital designs where edge detection and pulse generation are required.

## 2. Pinout Diagram

```
         +--------------+
clk  --->|              |
         |              |
nreset-->|   rise2pulse |---> out
         |              |
in   --->|              |
         +--------------+
```

## 3. Table of Ports

| Port Name | Direction | Width  | Description                    |
|-----------|-----------|--------|--------------------------------|
| clk       | Input     | 1-bit  | Clock signal                   |
| nreset    | Input     | 1-bit  | Asynchronous active-low reset  |
| in        | Input     | DW-bit | Edge input signal              |
| out       | Output    | DW-bit | One-cycle pulse output signal  |

## 4. Table of Parameters

| Parameter Name | Default Value | Description        |
|----------------|---------------|--------------------|
| DW             | 1             | Data width in bits |

## 5. Important Implementation Details

1. The module uses a parameterized data width (DW) to support multi-bit operations.
2. It employs a registered version of the input (`in_reg`) to detect changes.
3. The output pulse is generated by ANDing the current input with the inverse of the registered input: `out = in & ~in_reg`
4. This implementation detects rising edges (0 to 1 transitions) on each bit of the input independently.
5. The output pulse width is exactly one clock cycle for each detected rising edge.
6. The module is sensitive to the positive edge of the clock and the negative edge of the reset signal.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/6s0JDNf/Screenshot-2024-08-17-at-6-52-42-AM.png)

## 7. List of Major Bugs or Caveats

1. The module will not detect falling edges (1 to 0 transitions).
2. If the input signal changes faster than the clock rate, some edges may be missed.
3. The first rising edge after reset may not be detected if it occurs on the same clock cycle as the reset release.
4. Care should be taken when using this module with asynchronous input signals, as it may lead to metastability issues.