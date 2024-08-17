# Stretcher Module Documentation

## 1. Overview and Module Description

The `stretcher` module is a digital circuit designed to extend the duration of an input pulse. It takes a single-cycle input pulse and stretches it to a specified number of clock cycles. This module is particularly useful in scenarios where a longer pulse duration is required for downstream logic or when synchronizing signals across different clock domains.

## 2. Pinout Diagram

```
         ┌─────────────┐
    clk ─┤             │
         │             │
     in ─┤   stretcher ├─ out
         │             │
 nreset ─┤             │
         └─────────────┘
```

## 3. Table of Ports

| Port Name | Direction | Description |
|-----------|-----------|-------------|
| clk       | Input     | Clock signal |
| in        | Input     | Input pulse to be stretched |
| nreset    | Input     | Asynchronous active-low reset |
| out       | Output    | Stretched output pulse |

## 4. Table of Parameters

| Parameter Name | Default Value | Description |
|----------------|---------------|-------------|
| CYCLES         | 5             | Number of clock cycles to stretch the input pulse |

## 5. Important Implementation Details

1. **Shift Register**: The module uses a shift register (`valid`) with a width equal to the `CYCLES` parameter. This register is used to maintain the stretched pulse state.

2. **Pulse Stretching**: When an input pulse is detected, the shift register is filled with 1's. In subsequent clock cycles, these 1's are shifted out, creating a stretched pulse.

3. **Output**: The output (`out`) is derived from the most significant bit of the shift register, ensuring the pulse is stretched for the specified number of cycles.

4. **Reset Behavior**: On an active-low reset, the entire shift register is cleared to 0.

5. **Parameterization**: The module is parameterized, allowing for easy adjustment of the pulse stretch duration by modifying the `CYCLES` parameter.

## 6. GTKwave Simulation Result

![Simulation Waveform](https://i.ibb.co/xCtnCyW/Screenshot-2024-08-17-at-6-56-09-AM.png)

## 7. List of Major Bugs or Caveats

1. **Minimum Pulse Width**: The input pulse (`in`) must be at least one clock cycle wide to be detected and stretched properly.

2. **Consecutive Pulses**: If a new input pulse arrives before the previous stretched pulse has completed, it will restart the stretching process, potentially leading to a longer overall pulse than expected.

3. **Maximum Stretch Limit**: The maximum stretch duration is limited by the width of the shift register, which is determined by the `CYCLES` parameter. Very large values of `CYCLES` may lead to excessive resource usage.

4. **Reset Timing**: Care should be taken to ensure that the asynchronous reset signal (`nreset`) meets the setup and hold time requirements relative to the rising edge of the clock to avoid metastability issues.