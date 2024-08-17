# 6-Input Multiplexer (mux6)

## 1. Overview and Module Description

The `mux6` module is a parameterized 6-input multiplexer implemented in Verilog. It selects one of six input data buses based on six select signals. The width of the input and output data buses is configurable through a parameter.

## 2. Pinout Diagram

```
         +----------+
sel5 --->|          |
sel4 --->|          |
sel3 --->|          |
sel2 --->|   mux6   |---> out
sel1 --->|          |
sel0 --->|          |
         |          |
  in5 --->|          |
  in4 --->|          |
  in3 --->|          |
  in2 --->|          |
  in1 --->|          |
  in0 --->|          |
         +----------+
```

## 3. Table of Ports

| Port Name | Direction | Width    | Description                    |
|-----------|-----------|----------|--------------------------------|
| sel5      | Input     | 1 bit    | Select signal for input 5      |
| sel4      | Input     | 1 bit    | Select signal for input 4      |
| sel3      | Input     | 1 bit    | Select signal for input 3      |
| sel2      | Input     | 1 bit    | Select signal for input 2      |
| sel1      | Input     | 1 bit    | Select signal for input 1      |
| sel0      | Input     | 1 bit    | Select signal for input 0      |
| in5       | Input     | DW bits  | Input data bus 5               |
| in4       | Input     | DW bits  | Input data bus 4               |
| in3       | Input     | DW bits  | Input data bus 3               |
| in2       | Input     | DW bits  | Input data bus 2               |
| in1       | Input     | DW bits  | Input data bus 1               |
| in0       | Input     | DW bits  | Input data bus 0               |
| out       | Output    | DW bits  | Selected data output           |

## 4. Table of Parameters

| Parameter Name | Default Value | Description                     |
|----------------|---------------|---------------------------------|
| DW             | 1             | Width of input and output buses |

## 5. Important Implementation Details

- The module uses a parameterized design, allowing for flexible data bus widths.
- The multiplexer logic is implemented using a single continuous assignment statement.
- The selection is performed using bitwise AND operations with replicated select signals, followed by bitwise OR operations to combine the results.
- The module supports up to 6 inputs, each with its own select signal.
- Only one select signal should be active (high) at a time for proper operation.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/0KVz231/Screenshot-2024-08-17-at-6-45-21-AM.png)

## 7. List of Major Bugs or Caveats

- The module does not include input validation or priority encoding. If multiple select signals are active simultaneously, the output will be the bitwise OR of all selected inputs, which may lead to unexpected results.
- There is no default or "else" case when no select signal is active. In this situation, the output will be all zeros.
- The module does not include any sequential logic or clock inputs, making it a purely combinational circuit. This may lead to potential glitches during input transitions.