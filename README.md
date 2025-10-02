# PISO
# Verilog PISO Shift Register

This repository contains the Verilog code for a **Parallel-In, Serial-Out (PISO) shift register** and a corresponding testbench to verify its functionality.

## Table of Contents
- [Project Description](#project-description)
- [File Structure](#file-structure)
- [Module: PISO](#module-piso)
- [Testbench: PISO_tb](#testbench-piso_tb)
- [How to Simulate](#how-to-simulate)
- [Simulation Waveforms](#simulation-waveforms)

## Project Description
A Parallel-In, Serial-Out (PISO) shift register is a digital circuit that allows parallel data to be loaded into the register and then shifted out serially, one bit at a time.  
It is widely used in communication systems, data conversion, and interfaces where parallel data needs to be transmitted over a serial link.

The core behavior is as follows:
- On `i_load = 1`, the parallel data is loaded into the register.  
- On each clock cycle, the most significant bit (MSB) is shifted out on `o_serial_out`.  
- The register shifts left by one bit per clock cycle, inserting `0` into the least significant bit (LSB).  
- The circuit can be cleared using the asynchronous reset `i_rst`.

## File Structure
The repository contains the following files:
- **PISO.v**: The synthesizable Verilog module for the n-bit PISO shift register.  
- **PISO_tb.v**: The testbench used to simulate and verify the PISO.v module.  

## Module: PISO
This file defines the PISO module.

### Parameters
- `n`: The number of bits in the shift register (default = 4).  

### Ports
- `i_clk` (Input): Clock signal. The register shifts on the positive edge.  
- `i_rst` (Input): Active-high asynchronous reset. Clears the register and output.  
- `i_load` (Input): Load signal. When high, loads `i_parallel_in` into the register.  
- `i_parallel_in [n-1:0]` (Input): Parallel input data.  
- `o_serial_out` (Output): Serial output bit (MSB first).  

### Functionality
- When `i_rst` is asserted, both the register and output are reset to `0`.  
- When `i_load` is high, the parallel input data is loaded into the shift register.  
- On each rising edge of the clock (when not loading/resetting), the MSB is output on `o_serial_out`, and the register shifts left by one bit.  

## Testbench: PISO_tb
This file (`PISO_tb.v`) instantiates the PISO module as the Device Under Test (DUT) and applies test sequences.

### Test Sequence
1. **Reset Phase**: Asserts reset to clear the register.  
2. **Load Phase**: Loads parallel input `1010` into the register.  
3. **Shift Phase**: Serially shifts out the bits one at a time (`1, 0, 1, 0`) over consecutive clock cycles.  
4. **Simulation End**: Runs for a fixed duration, then finishes.  

The testbench also generates a 100 MHz clock (`10 ns period`).  

## How to Simulate
To run the simulation, you will need a Verilog simulator such as ModelSim, Vivado, or Icarus Verilog.

Steps:
1. Compile both `PISO.v` and `PISO_tb.v`.  
2. Set `PISO_tb` as the top-level module.  
3. Run the simulation.  
4. Observe signals in the waveform viewer (`i_clk`, `i_rst`, `i_load`, `i_parallel_in`, and `o_serial_out`).  

Expected output: The bits of the parallel input (`1010`) should appear sequentially at `o_serial_out` after loading.  

## Simulation Waveforms
Below is an example waveform captured during simulation:

![waveform](PISO_waveform.png<img width="1919" height="1079" alt="PISO_waveform" src="https://github.com/user-attachments/assets/e8293229-c740-461d-82c2-54517f162c82" />
)

- `i_clk`: Clock signal (10 ns period).  
- `i_rst`: Asynchronous reset signal.  
- `i_load`: Load control signal.  
- `i_parallel_in`: Parallel input data (`1010`).  
- `o_serial_out`: Serial output showing MSB-first shifting.  
