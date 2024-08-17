# Serial to Parallel Converter (ser2par)

## 1. Overview and Module Description

The `ser2par` module is a configurable serial-to-parallel converter implemented in Verilog. It takes a serial input and converts it to a parallel output. The module supports both LSB-first and MSB-first conversion modes and is parameterized to allow for different input and output widths.

## 2. Pinout Diagram

```
         +-------------+
clk  --->|             |
din  --->|             |
         |   ser2par   |---> dout
lsbfirst--->|             |
shift  --->|             |
         +-------------+
```

## 3. Table of Ports

| Port Name | Direction | Width  | Description                    |
|-----------|-----------|--------|--------------------------------|
| clk       | Input     | 1-bit  | Sampling clock                 |
| din       | Input     | SW-bit | Serial data input              |
| dout      | Output    | PW-bit | Parallel data output           |
| lsbfirst  | Input     | 1-bit  | LSB first order control        |
| shift     | Input     | 1-bit  | Shift control signal           |

## 4. Table of Parameters

| Parameter | Default Value | Description                                    |
|-----------|---------------|------------------------------------------------|
| PW        | 64            | Parallel packet width                          |
| SW        | 1             | Serial packet width                            |
| CW        | $clog2(PW/SW) | Serialization factor (for counter)             |

## 5. Important Implementation Details

1. The module uses a parameterized design, allowing for flexible configuration of input and output widths.
2. The conversion process is controlled by the `shift` and `lsbfirst` signals:
   - When `shift` is high, data is shifted into the `dout` register.
   - The `lsbfirst` signal determines the direction of the shift:
     - When high, data is shifted from LSB to MSB.
     - When low, data is shifted from MSB to LSB.
3. The module operates on the positive edge of the `clk` signal.
4. The `CW` parameter is calculated using the `$clog2` function to determine the required width of the internal counter based on the serialization factor.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/L8sNQJX/Screenshot-2024-08-17-at-6-54-18-AM.png)

## 7. List of Major Bugs or Caveats

1. The `count` register is declared but not used in the current implementation. This may lead to unnecessary resource usage in synthesis.
2. The `shiftdata` wire is declared but not used, which may cause warnings during compilation.
3. There is no reset signal, which may lead to undefined behavior on startup or after power cycling.
4. The module does not provide any indication when a full parallel word has been assembled, which may complicate integration with other modules.
5. The current implementation assumes that the `shift` signal is properly timed and does not provide protection against shifting more times than necessary to fill the parallel output.