# Power Isolation Module (pwr_isolo)

## 1. Overview and Module Description

The `pwr_isolo` module is a parameterized Verilog module designed to implement power isolation functionality. It takes an active-low isolation signal and a data input, producing an output that is either the input data or isolated (all zeros) based on the isolation signal. This module is useful in power management scenarios where certain parts of a design need to be isolated to reduce power consumption.

## 2. Pinout Diagram

```
      +-------------+
  iso |             |
----->|             |
      |   pwr_isolo |
  in  |             |    out
----->|             |----->
      |             |
      +-------------+
```

## 3. Table of Ports

| Port Name | Direction | Width  | Description                           |
|-----------|-----------|--------|---------------------------------------|
| iso       | Input     | 1-bit  | Active-low isolation signal           |
| in        | Input     | DW-bit | Input data                            |
| out       | Output    | DW-bit | Output data (isolated when iso is high)|

## 4. Table of Parameters

| Parameter Name | Default Value | Description                    |
|----------------|---------------|--------------------------------|
| DW             | 1             | Width of input and output data |

## 5. Important Implementation Details

- The module uses a generate block to create a parameterized width output.
- The isolation is implemented using a bitwise AND operation between the inverted `iso` signal (replicated to match the data width) and the input data.
- When `iso` is low (0), the output matches the input.
- When `iso` is high (1), the output is forced to all zeros, effectively isolating the output from the input.

## 6. GTKwave Simulation Result

[This section is intentionally left blank as per the request]

## 7. List of Major Bugs or Caveats

- No known bugs or caveats exist for this module.
- It's important to note that this module does not include any sequential logic or clock inputs, making it a purely combinational circuit.
- Care should be taken when using this module in larger designs to ensure that the isolation signal timing is properly managed to prevent glitches or unexpected behavior during power state transitions.