# Power Isolation High (pwr_isohi) Module

## 1. Overview and Module Description

The `pwr_isohi` module is a parameterized Verilog module designed to implement power isolation functionality. It provides a high-side isolation mechanism where the output is forced high when the isolation signal is active (low). When isolation is inactive, the input signal passes through to the output.

## 2. Pinout Diagram

```
     +-------------+
     |             |
iso --|             |
     |   pwr_isohi  |-- out
in  --|             |
     |             |
     +-------------+
```

## 3. Table of Ports

| Port Name | Direction | Width  | Description                    |
|-----------|-----------|--------|--------------------------------|
| iso       | Input     | 1      | Active low isolation signal    |
| in        | Input     | DW     | Input signal                   |
| out       | Output    | DW     | Output signal (iso \| in)      |

## 4. Table of Parameters

| Parameter | Default Value | Description              |
|-----------|---------------|--------------------------|
| DW        | 1             | Width of data inputs/outputs |

## 5. Important Implementation Details

- The module uses a generate block to create a parameterized width output.
- The output is computed using a bitwise OR operation between the isolation signal (replicated to match the data width) and the input signal.
- When `iso` is low (active), all bits of the output are forced high, regardless of the input.
- When `iso` is high (inactive), the output matches the input.

## 6. GTKwave Simulation Result

[This section is intentionally left blank as per the request]

## 7. List of Major Bugs or Caveats

- The module assumes active-low isolation signal. Care should be taken to ensure correct polarity when integrating this module into a larger design.
- The parameter `DW` should be set to a positive integer value. Setting it to 0 or negative values may lead to unexpected behavior.
- As with any parameterized module, synthesis tools may have limitations on the maximum value of `DW` that can be practically implemented.