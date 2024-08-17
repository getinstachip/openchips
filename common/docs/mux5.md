# 5-Input Multiplexer (mux5)

## 1. Overview and Module Description

The `mux5` module is a parameterized 5-input multiplexer. It selects one of five input data buses based on five select signals. The width of the input and output data buses is configurable through a parameter.

## 2. Pinout Diagram

```
         ┌─────────┐
   sel4 ─┤         │
   sel3 ─┤         │
   sel2 ─┤         │
   sel1 ─┤   mux5  ├─ out
   sel0 ─┤         │
    in4 ─┤         │
    in3 ─┤         │
    in2 ─┤         │
    in1 ─┤         │
    in0 ─┤         │
         └─────────┘
```

## 3. Table of Ports

| Port Name | Direction | Width    | Description                    |
|-----------|-----------|----------|--------------------------------|
| sel4      | Input     | 1 bit    | Select signal for input 4      |
| sel3      | Input     | 1 bit    | Select signal for input 3      |
| sel2      | Input     | 1 bit    | Select signal for input 2      |
| sel1      | Input     | 1 bit    | Select signal for input 1      |
| sel0      | Input     | 1 bit    | Select signal for input 0      |
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

- The module uses a single continuous assignment to implement the multiplexer functionality.
- Each input is masked with its corresponding select signal, which is replicated to match the bus width.
- The masked inputs are then combined using bitwise OR operations.
- Only one select signal should be active (high) at a time for proper operation.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/LpXnjGL/Screenshot-2024-08-17-at-6-44-46-AM.png)

## 7. List of Major Bugs or Caveats

- The module does not include input validation to ensure that only one select signal is active at a time. Activating multiple select signals simultaneously may lead to undefined behavior.
- There is no default case when all select signals are low, which could result in an undefined output in this scenario.