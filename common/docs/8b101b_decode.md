# 8b10b Decoder Module Documentation

## 1. Overview and Module Description

The `8b10b_decode` module is a Verilog implementation of an 8b/10b decoder. This decoder converts 10-bit code groups into 8-bit data bytes, primarily used in high-speed serial communications. It performs the following key functions:

- Decodes 10-bit input code groups into 8-bit output data
- Detects and flags K-characters (special characters in 8b/10b encoding)
- Checks for code errors and disparity errors
- Maintains running disparity

## 2. Pinout Diagram

```
                        +-----------------+
                 clk -->|                 |
              nreset -->|                 |
                        |                 |---> K_out
                        |    8b10b_decode |
                        |                 |---> code_group[7:0]
                        |                 |
                        |                 |---> code_error
                        |                 |
  rx_code_group[9:0] -->|                 |---> disp_error
                        |                 |
                        +-----------------+
```

## 3. Table of Ports

| Port Name        | Direction | Width | Description                           |
|------------------|-----------|-------|---------------------------------------|
| clk              | Input     | 1     | Input clock                           |
| nreset           | Input     | 1     | Synchronous active-low reset          |
| rx_code_group    | Input     | 10    | 10-bit input code group               |
| K_out            | Output    | 1     | K-character group indicator           |
| code_group       | Output    | 8     | Decoded 8-bit output                  |
| code_error       | Output    | 1     | Code error indicator                  |
| disp_error       | Output    | 1     | Disparity error indicator             |

## 4. Table of Parameters

This module does not have any parameters.

## 5. Important Implementation Details

1. **Decoding Process**: 
   - The module separates the 10-bit input into 6-bit and 4-bit groups for decoding.
   - It uses combinational logic to decode these groups into 5-bit and 3-bit segments respectively.

2. **Disparity Tracking**: 
   - The module tracks running disparity to ensure DC balance in the bit stream.
   - It calculates disparity for both 6-bit and 4-bit groups separately.

3. **Error Detection**:
   - Code errors are detected when invalid 5b/6b or 3b/4b mappings are encountered.
   - Disparity errors are flagged when the running disparity violates 8b/10b coding rules.

4. **K-character Detection**:
   - The module identifies special K-characters based on specific decoded 8-bit patterns.

5. **Synchronous Operation**:
   - All outputs are registered and updated on the rising edge of the clock.
   - The module includes a synchronous reset for initialization.

6. **Lookup Tables**:
   - The decoding process uses case statements as lookup tables for 5b/6b and 3b/4b conversions.

## 6. GTKWave Simulation Result

[This section is intentionally left blank as per the request]

## 7. Known Bugs or Caveats

1. The module does not handle all possible invalid 10-bit input combinations. Some invalid inputs may produce undefined behavior.

2. The disparity error detection might not catch all possible disparity violations in complex sequences of code groups.

3. The module assumes a specific initial disparity state (positive) on reset, which may not be suitable for all applications.

4. There is no explicit handling of comma detection or alignment, which might be necessary in some 8b/10b applications.

5. The module does not provide any specific error handling or recovery mechanisms beyond flagging errors.