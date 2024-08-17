# Reset Synchronizer (rsync) Module

## 1. Overview and Module Description

The `rsync` module is a parameterized reset synchronizer designed to synchronize an asynchronous reset signal with a clock domain. It helps prevent metastability issues when the reset signal crosses clock domains. The module uses a configurable number of flip-flop stages to achieve synchronization.

## 2. Pinout Diagram

```
        ┌─────────┐
clk ────┤         │
        │  rsync  ├──── nrst_out
nrst_in ┤         │
        └─────────┘
```

## 3. Table of Ports

| Port Name | Direction | Description |
|-----------|-----------|-------------|
| clk       | Input     | Clock signal |
| nrst_in   | Input     | Asynchronous active-low reset input |
| nrst_out  | Output    | Synchronized active-low reset output |

## 4. Table of Parameters

| Parameter Name | Default Value | Description |
|----------------|---------------|-------------|
| PS             | 2             | Number of synchronization stages |

## 5. Important Implementation Details

1. The module uses a generate block to create a parameterized number of flip-flop stages.
2. A shift register (`sync_pipe`) is used to implement the synchronization stages.
3. The reset signal is active-low, meaning it is asserted when low (0) and de-asserted when high (1).
4. On the assertion of the asynchronous reset (`nrst_in`), all flip-flops in the synchronization chain are immediately cleared.
5. When the reset is de-asserted, a logic '1' propagates through the synchronization chain.
6. The output (`nrst_out`) is taken from the last flip-flop in the chain, ensuring a synchronized reset release.

## 6. GTKwave Simulation Results

![Simulation Waveform](https://i.ibb.co/jwqR15T/Screenshot-2024-08-17-at-6-53-27-AM.png)

## 7. Major Bugs or Caveats

1. The module assumes that the input clock (`clk`) is stable and continuous. It may not function correctly if the clock is gated or unstable.
2. While the default value of 2 stages (PS = 2) is common, some applications might require more stages for increased reliability in high-frequency designs or when crossing between significantly different clock domains.
3. The module synchronizes the de-assertion (release) of the reset, but the assertion of the reset remains asynchronous. This is generally acceptable but should be noted in the design considerations.
4. Care should be taken when synthesizing this module to ensure that the synchronization chain is not optimized away by synthesis tools.