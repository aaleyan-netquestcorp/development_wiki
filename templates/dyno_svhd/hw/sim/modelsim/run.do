# can take on these values: 1,10,100 ns,us,ms,s
set time_scale 1ns

# can take on these values: 1,10,100 ns,us,ms,s
set time_precision 1ns

# Set to 20 ns (50 MHz clock)
set clock_period 20

# Set to 20 ns (50 MHz clock)
set halt_at 2500

# See tse_controller.sv -> "`ifdef" and "disable"
set simulation 1
set compile_type 0

vlib work
#vmap work ./work

# VLOG - Verilog Compile command; Compiles the Verilog files:
vlog -work work ./../../src/pkgs/inet_stack_pkg.sv
vlog -work work ./../../src/pkgs/interface_pkg.sv
vcom -2008 -work work ./../../src/pkgs/interface_design_pkg.vhd
vcom -2008 -work work ./../../src/tse/tse_controller.vhd

vlog -timescale ${time_scale}/${time_precision} \
     -work work \
     +define+_CLOCK_PERIOD=$clock_period \
     +define+_HALT=$halt_at \
     +define+_SIMULATION=$simulation \
     +define+_COMPILE_TYPE=$compile_type \
     ./../tse_controller_tb.sv

# VSIM - VHDL Simulate command; 
# -novopt turns off optimization that might remove signals
# Launches the simulation of the compiled test bench script:
vsim -novopt -L work tse_controller_tb
do wave.do
run $halt_at ns
				
  
