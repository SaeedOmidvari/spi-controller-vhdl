# SPI Controller (VHDL)

Configurable SPI Master controller written in VHDL.

## Features
- SPI Master
- Mode 0 (CPOL=0, CPHA=0)
- 8 / 16 / 24 / 32-bit transfers
- Byte-wise RX with Data_Out_Valid
- Force_CS for streaming transfers
- Synthesizable (FPGA-ready)

## Files
- `rtl/SPI_Controller.vhd`
- `tb/SPI_Controller_tb.vhd`

## Simulation
Verified using Vivado Simulator.

## Author
Saeed Omidvari
