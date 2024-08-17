# ODDR (Output Double Data Rate) Module

## 1. Overview and Module Description

The ODDR module is a parameterizable Verilog implementation of an Output Double Data Rate (DDR) circuit. It takes two input data streams and combines them into a single output stream, effectively doubling the data rate. The module uses both the rising and falling edges of the input clock to transmit data, making it suitable for high-speed data transmission applications.

## 2. Pinout Diagram

```
         ┌─────────┐
    clk ─┤         │
         │         │
   din1 ─┤  ODDR   ├─ out
         │         │
   din2 ─┤         │
         └─────────┘
```

## 3. Table of Ports

| Port Name | Direction | Width    | Description                    |
|-----------|-----------|----------|--------------------------------|
| clk       | Input     | 1        | Clock input                    |
| din1      | Input     | DW       | Data input 1                   |
| din2      | Input     | DW       | Data input 2                   |
| out       | Output    | DW       | DDR output                     |

## 4. Table of Parameters

| Parameter Name | Default Value | Description                     |
|----------------|---------------|---------------------------------|
| DW             | 1             | Width of data inputs and output |

## 5. Important Implementation Details

1. The module uses three internal registers:
   - `q1_sl`: Stores `din1` on the rising edge of the clock
   - `q2_sl`: Stores `din2` on the rising edge of the clock
   - `q2_sh`: Stores `q2_sl` on the falling edge of the clock

2. Data sampling:
   - `din1` and `din2` are sampled on the rising edge of the clock
   - `q2_sl` is sampled on the falling edge of the clock

3. Output multiplexing:
   - When `clk` is high, `out` is assigned the value of `q1_sl`
   - When `clk` is low, `out` is assigned the value of `q2_sh`

4. The module is parameterizable, allowing for different data widths by changing the `DW` parameter

5. The implementation ensures that the output changes on both the rising and falling edges of the clock, effectively doubling the data rate compared to the input data streams

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/2g0V4mh/Screenshot-2024-08-17-at-6-50-09-AM.png)

## 7. List of Major Bugs or Caveats

1. The module does not include any reset logic, which may lead to undefined initial states in some applications

2. Care should be taken when using this module in designs with tight timing constraints, as the output multiplexing based on the clock signal may introduce glitches or timing violations in certain scenarios

3. The module assumes that the input data (`din1` and `din2`) are stable and valid for the entire clock cycle. Violating this assumption may lead to incorrect output data

4. When instantiating this module, ensure that the receiving logic can handle data changes on both clock edges to fully utilize the doubled data rate