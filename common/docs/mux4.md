# MUX4: 4-to-1 Multiplexer

## 1. Overview and Module Description

The `mux4` module is a parameterized 4-to-1 multiplexer implemented in Verilog. It selects one of four input data buses based on four select signals. The width of the input and output data buses is configurable through a parameter.

## 2. Pinout Diagram

```
         +-------------+
  sel3 --|             |
  sel2 --|             |
  sel1 --|    MUX4     |-- out
  sel0 --|             |
   in3 --|             |
   in2 --|             |
   in1 --|             |
   in0 --|             |
         +-------------+
```

## 3. Table of Ports

| Port Name | Direction | Width    | Description                    |
|-----------|-----------|----------|--------------------------------|
| sel3      | Input     | 1 bit    | Select signal for input 3      |
| sel2      | Input     | 1 bit    | Select signal for input 2      |
| sel1      | Input     | 1 bit    | Select signal for input 1      |
| sel0      | Input     | 1 bit    | Select signal for input 0      |
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
2. The output is determined by a bitwise OR of the selected input, masked by the corresponding select signal.
3. Each select signal is replicated to match the data width before masking.
4. Only one select signal should be active at a time for proper operation.
5. A simulation-only error checking mechanism is implemented using the `TARGET_SIM` define.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/wrXrNt5/Screenshot-2024-08-17-at-6-44-11-AM.png)

## 7. Major Bugs or Caveats

1. The module does not include priority encoding. If multiple select signals are active simultaneously, the output will be a bitwise OR of the corresponding inputs, which may lead to unexpected results.
2. There is no default output when all select signals are inactive. In this case, the output will be all zeros.
3. The error checking mechanism is only available in simulation mode (when `TARGET_SIM` is defined) and does not prevent incorrect operation in hardware.
4. The error checking has a 1-time unit delay, which may cause timing issues in simulation if not accounted for.
5. The error message in simulation does not provide detailed information about which select signals caused the error.