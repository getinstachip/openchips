# DSYNC Module Documentation

## 1. Overview and Module Description

The `dsync` module is a configurable synchronizer designed to safely transfer data across clock domains. It implements a parameterized synchronization pipeline to mitigate metastability issues when crossing clock domains. The module also includes an optional delay feature for testing purposes.

## 2. Pinout Diagram

```
         +-------------+
clk  --->|             |
         |             |
nreset-->|    dsync    |---> dout
         |             |
din   -->|             |
         +-------------+
```

## 3. Table of Ports

| Port Name | Direction | Description |
|-----------|-----------|-------------|
| clk       | Input     | Clock signal |
| nreset    | Input     | Active-low reset signal |
| din       | Input     | Input data to be synchronized |
| dout      | Output    | Synchronized output data |

## 4. Table of Parameters

| Parameter Name | Default Value | Description |
|----------------|---------------|-------------|
| PS             | 2             | Number of synchronization stages |
| DELAY          | 0             | Random delay enable (0 or 1) |

## 5. Important Implementation Details

- The module uses a generate block to create a configurable synchronization pipeline.
- The synchronization pipeline is implemented using a shift register (`sync_pipe`) with a parameterized number of stages (PS).
- The module supports an active-low asynchronous reset (nreset).
- An optional delay can be introduced by setting the DELAY parameter to 1, which adds an extra cycle of latency to the output.
- The output (dout) is selected based on the DELAY parameter:
  - If DELAY is 0, dout is connected to the second-to-last stage of the pipeline.
  - If DELAY is 1, dout is connected to the last stage of the pipeline, introducing an extra cycle of latency.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/Q8tJ6N7/Screenshot-2024-08-17-at-6-33-42-AM.png)

## 7. Major Bugs or Caveats

- The module assumes that the input clock (clk) is stable and continuous. It may not function correctly with gated clocks or clock domains with significant jitter.
- The effectiveness of metastability mitigation depends on the number of synchronization stages (PS). Two stages are typically sufficient, but critical applications may require more stages or additional analysis.
- The DELAY parameter is primarily intended for testing and simulation purposes. It should be set to 0 for normal operation in most cases.
- Care should be taken when using this module in designs with strict timing requirements, as the synchronization process introduces latency.
- The module does not include any specific provisions for handling multi-bit buses. If synchronizing multi-bit data is required, multiple instances of this module should be used, or a different approach should be considered.