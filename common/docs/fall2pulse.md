# Fall to Pulse Converter Module (fall2pulse)

## 1. Overview and Module Description

The `fall2pulse` module is a Verilog implementation of a falling edge detector that generates a single-cycle pulse. It detects falling edges on the input signal and produces a one-cycle pulse on the output for each falling edge detected. The module supports configurable data width through a parameter.

## 2. Pinout Diagram

```
         +--------------+
clk  --->|              |
         |              |
nreset-->|   fall2pulse |---> out
         |              |
in   --->|              |
         +--------------+
```

## 3. Table of Ports

| Port Name | Direction | Width  | Description                           |
|-----------|-----------|--------|---------------------------------------|
| clk       | Input     | 1-bit  | Clock signal                          |
| nreset    | Input     | 1-bit  | Asynchronous active-low reset signal  |
| in        | Input     | DW-bit | Input signal to detect falling edges  |
| out       | Output    | DW-bit | Output pulse signal                   |

## 4. Table of Parameters

| Parameter Name | Default Value | Description                    |
|----------------|---------------|--------------------------------|
| DW             | 1             | Data width of input and output |

## 5. Important Implementation Details

1. The module uses a positive-edge triggered flip-flop to register the input signal.
2. Falling edge detection is achieved by comparing the current input with the registered previous input.
3. The output pulse is generated when the current input is low and the previous input (registered) is high.
4. The module supports multi-bit operation through the `DW` parameter, allowing for parallel edge detection on multiple signals.
5. The asynchronous reset (nreset) sets the registered input to all zeros when active (low).

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/nM1gYvc/Screenshot-2024-08-17-at-6-37-35-AM.png)

## 7. List of Major Bugs or Caveats

1. The module detects falling edges only. Rising edges will not trigger an output pulse.
2. The output pulse width is fixed to one clock cycle, regardless of how long the input signal remains low.
3. Very short input pulses (less than one clock cycle) may be missed if they don't align with the clock edge.
4. The module does not have any built-in debounce mechanism, which may be necessary when used with physical input signals.