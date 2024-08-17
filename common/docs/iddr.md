# IDDR (Input Double Data Rate) Module

## 1. Overview and Module Description

The IDDR (Input Double Data Rate) module is a Verilog implementation designed to sample input data on both the rising and falling edges of a clock signal. This module is particularly useful in applications where data needs to be captured at twice the clock frequency, effectively doubling the data rate without increasing the clock speed.

The module samples the input data on both clock edges and provides two separate output streams, one for data sampled on the rising edge and another for data sampled on the falling edge. It also includes a clock enable signal for controlled data sampling.

## 2. Pinout Diagram

```
         +-------------+
         |             |
    clk  |             |
   ----->|             |
         |             |
    ce   |             |
   ----->|             |    q1
         |    IDDR     |----->
   din   |             |
   ----->|             |    q2
         |             |----->
         |             |
         |             |
         +-------------+
```

## 3. Table of Ports

| Port Name | Direction | Width    | Description                                    |
|-----------|-----------|----------|------------------------------------------------|
| clk       | Input     | 1-bit    | Clock signal                                   |
| ce        | Input     | 1-bit    | Clock enable signal                            |
| din       | Input     | DW-bit   | Data input sampled on both edges of clock      |
| q1        | Output    | DW-bit   | IDDR rising edge sampled data                  |
| q2        | Output    | DW-bit   | IDDR falling edge sampled data                 |

## 4. Table of Parameters

| Parameter Name | Default Value | Description                     |
|----------------|---------------|---------------------------------|
| DW             | 1             | Width of data inputs and outputs|

## 5. Important Implementation Details

1. The module uses two always blocks to sample the input data:
   - One block samples on the positive edge of the clock (rising edge)
   - Another block samples on the negative edge of the clock (falling edge)

2. The clock enable (ce) signal is used to control when data is sampled on the rising edge. When ce is high, data is sampled; when low, sampling is disabled.

3. Two intermediate registers (q1_sl and q2_sh) are used to store the sampled data.

4. A third always block is used to pipeline the sampled data, aligning the rising and falling edge samples and assigning them to the output ports q1 and q2.

5. The module is parameterized, allowing for variable data width (DW) to be specified during instantiation.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/Q99Nn7L/Screenshot-2024-08-17-at-6-40-21-AM.png)

## 7. List of Major Bugs or Caveats

1. The clock enable (ce) signal only affects the rising edge sampling. Falling edge sampling occurs on every negative clock edge, regardless of the ce signal state. This asymmetry might lead to unexpected behavior in some applications.

2. There is no reset signal in the module. This means that the initial state of the outputs is undefined and may require several clock cycles to stabilize after power-up or configuration.

3. The module does not include any input synchronization or metastability mitigation techniques. When used in a design where the input data (din) comes from a different clock domain, additional synchronization may be necessary to prevent metastability issues.

4. The parameterized nature of the module allows for a data width of 0 (if DW is set to 0), which would result in a non-functional module. It's advisable to add a check or assertion to ensure DW is always greater than 0.