# MUX7: 7-Input Multiplexer

## 1. Overview and Module Description

The `mux7` module is a parameterized 7-input multiplexer implemented in Verilog. It selects one of seven input data buses based on seven select signals. The width of the input and output data buses is configurable through a parameter.

## 2. Pinout Diagram

```
         +-------------+
sel6 --->|             |
sel5 --->|             |
sel4 --->|             |
sel3 --->|             |
sel2 --->|    MUX7     |---> out
sel1 --->|             |
sel0 --->|             |
         |             |
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

| Port Name | Direction | Width    | Description                    |
|-----------|-----------|----------|--------------------------------|
| sel6      | Input     | 1 bit    | Select signal for input 6      |
| sel5      | Input     | 1 bit    | Select signal for input 5      |
| sel4      | Input     | 1 bit    | Select signal for input 4      |
| sel3      | Input     | 1 bit    | Select signal for input 3      |
| sel2      | Input     | 1 bit    | Select signal for input 2      |
| sel1      | Input     | 1 bit    | Select signal for input 1      |
| sel0      | Input     | 1 bit    | Select signal for input 0      |
| in6       | Input     | DW bits  | Input data bus 6               |
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

1. The module uses a parameterized design, allowing for flexible data bus widths.
2. The multiplexer is implemented using a single continuous assignment statement.
3. Each input is masked with its corresponding select signal before being combined.
4. The module uses bitwise AND (&) and OR (|) operations for selection and combination.
5. The select signals are replicated to match the data width using the replication operator.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/2yWjPFX/Screenshot-2024-08-17-at-6-45-51-AM.png)

## 7. Major Bugs or Caveats

1. The module assumes that only one select signal is active at a time. Activating multiple select signals simultaneously may lead to undefined behavior.
2. There is no default output when all select signals are low. In such cases, the output will be all zeros.
3. The module does not include any error checking for invalid select signal combinations.
4. High fan-in may cause timing issues in physical implementation for large data widths.