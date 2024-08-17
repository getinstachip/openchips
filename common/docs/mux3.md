# 3-Input Multiplexer (mux3) Module Documentation

## 1. Overview and Module Description

The `mux3` module is a parameterized 3-input multiplexer implemented in Verilog. It selects one of three input data streams based on three select signals and outputs the chosen data. The width of the input and output data is configurable through a parameter.

## 2. Pinout Diagram

```
         +-------------+
sel2 --->|             |
sel1 --->|             |
sel0 --->|    mux3     |---> out
 in2 --->|             |
 in1 --->|             |
 in0 --->|             |
         +-------------+
```

## 3. Table of Ports

| Port Name | Direction | Width    | Description                    |
|-----------|-----------|----------|--------------------------------|
| sel2      | Input     | 1 bit    | Select signal for input 2      |
| sel1      | Input     | 1 bit    | Select signal for input 1      |
| sel0      | Input     | 1 bit    | Select signal for input 0      |
| in2       | Input     | DW bits  | Input data 2                   |
| in1       | Input     | DW bits  | Input data 1                   |
| in0       | Input     | DW bits  | Input data 0                   |
| out       | Output    | DW bits  | Selected data output           |

## 4. Table of Parameters

| Parameter Name | Default Value | Description                     |
|----------------|---------------|---------------------------------|
| DW             | 1             | Width of input and output data  |

## 5. Important Implementation Details

1. The module uses a parameterized design, allowing for flexible data width configuration.
2. The selection logic is implemented using bitwise AND and OR operations.
3. The select signals (sel2, sel1, sel0) are replicated to match the data width for bitwise operations.
4. The output is a combination of the selected input based on the active select signal.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/F5kZ6Rk/Screenshot-2024-08-17-at-6-43-28-AM.png)

## 7. Major Bugs or Caveats

1. The module does not include priority logic for the select signals. If multiple select signals are active simultaneously, the output will be a bitwise OR of the corresponding inputs.
2. There is no default output when all select signals are inactive (logic 0). In this case, the output will be all zeros.
3. The module does not include any error checking or handling for invalid select signal combinations.