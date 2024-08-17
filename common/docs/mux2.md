# MUX2: 2-to-1 Multiplexer

## 1. Overview

The `mux2` module is a parameterized 2-to-1 multiplexer. It selects between two input buses based on select signals and outputs the chosen data. The width of the input and output buses is configurable through a parameter.

## 2. Pinout Diagram

```
         +-------------+
sel1 --->|             |
sel0 --->|             |
         |    mux2     |---> out
in1  --->|             |
in0  --->|             |
         +-------------+
```

## 3. Port Table

| Port | Direction | Width  | Description                    |
|------|-----------|--------|--------------------------------|
| sel1 | Input     | 1-bit  | Select signal for input 1      |
| sel0 | Input     | 1-bit  | Select signal for input 0      |
| in1  | Input     | DW-bit | Input data bus 1               |
| in0  | Input     | DW-bit | Input data bus 0               |
| out  | Output    | DW-bit | Selected data output bus       |

## 4. Parameter Table

| Parameter | Default | Description              |
|-----------|---------|--------------------------|
| DW        | 1       | Width of the data buses  |

## 5. Implementation Details

- The module uses a parameterized width (DW) for input and output buses.
- Selection logic:
  - When sel0 is high, in0 is selected.
  - When sel1 is high, in1 is selected.
- The selection is implemented using bitwise AND operations with replicated select signals, followed by a bitwise OR.
- The design assumes that only one select signal (sel0 or sel1) is active at a time.

## 6. GTKWave Simulation Results

![Simulation Waveform](https://i.ibb.co/26jMCLg/Screenshot-2024-08-17-at-6-42-43-AM.png)

## 7. Known Issues and Caveats

- The module does not include priority logic. If both sel0 and sel1 are asserted simultaneously, the output will be the bitwise OR of in0 and in1.
- There is no default output state when neither sel0 nor sel1 is asserted. In this case, the output will be all zeros.
- The module does not include any error checking or handling for invalid select signal combinations.