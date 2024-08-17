# Par2Ser: Parallel to Serial Converter

## 1. Overview and Module Description

The `par2ser` module is a configurable parallel-to-serial converter implemented in Verilog. It takes a parallel input and converts it to a serial output, with various options for data ordering, fill bits, and flow control. This module is particularly useful in digital communication systems where data needs to be serialized for transmission.

## 2. Pinout Diagram

```
              +-------------+
     clk  --->|             |
  nreset  --->|             |
     din  --->|             |---> dout
    load  --->|             |---> access_out
   shift  --->|   par2ser   |---> wait_out
 datasize --->|             |
 lsbfirst --->|             |
     fill --->|             |
  wait_in --->|             |
              +-------------+
```

## 3. Table of Ports

| Port Name   | Direction | Width    | Description                           |
|-------------|-----------|----------|---------------------------------------|
| clk         | Input     | 1        | Sampling clock                        |
| nreset      | Input     | 1        | Asynchronous active low reset         |
| din         | Input     | PW       | Parallel data input                   |
| dout        | Output    | SW       | Serial data output                    |
| access_out  | Output    | 1        | Output data valid signal              |
| load        | Input     | 1        | Load parallel data (priority)         |
| shift       | Input     | 1        | Shift data                            |
| datasize    | Input     | 8        | Size of data to shift                 |
| lsbfirst    | Input     | 1        | LSB first order when high             |
| fill        | Input     | 1        | Fill bit for shifting                 |
| wait_in     | Input     | 1        | Wait input                            |
| wait_out    | Output    | 1        | Wait output (wait_in OR serial wait)  |

## 4. Table of Parameters

| Parameter | Description                | Default Value |
|-----------|----------------------------|---------------|
| PW        | Parallel packet width      | 64            |
| SW        | Serial packet width        | 1             |
| CW        | Serialization factor       | $clog2(PW/SW) |

## 5. Important Implementation Details

1. **Shift Register**: The core of the module is a shift register (`shiftreg`) that holds the parallel data and shifts it out serially.

2. **Transfer Counter**: A counter (`count`) keeps track of how many serial transfers are left to complete the parallel-to-serial conversion.

3. **Start Condition**: A transfer starts when `load` is high, `wait_in` is low, and the module is not busy.

4. **Busy Signal**: The module is considered busy when the transfer counter is non-zero.

5. **Data Validity**: The `access_out` signal is high while the shifter is busy, indicating valid output data.

6. **Wait Mechanism**: The `wait_out` signal is high when either `wait_in` is high or the module is busy.

7. **Shift Direction**: The module supports both LSB-first and MSB-first shifting, controlled by the `lsbfirst` input.

8. **Fill Bit**: When shifting, empty positions in the shift register are filled with the value of the `fill` input.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/B3tsRdk/Screenshot-2024-08-17-at-6-51-04-AM.png)

## 7. Major Bugs or Caveats

1. The `datasize` input is 8 bits wide, but only `CW` bits are used when loading the counter. This could lead to unexpected behavior if `datasize` is set larger than 2^CW - 1.

2. There's no explicit handling of the case where `shift` is asserted while the module is not busy. The behavior in this scenario is undefined and could lead to unexpected results.

3. The module assumes that the `load` signal will not be asserted while a transfer is in progress. There's no protection against this, which could disrupt ongoing transfers.

4. The `wait_in` signal can prevent a transfer from starting, but it doesn't pause an ongoing transfer. This might not be the expected behavior in all use cases.

5. There's no overflow protection on the counter. If more shift operations occur than the initial `datasize`, the behavior is undefined.