//Alex Aleyan

`ifndef _CLOCK_PERIOD
  `define _CLOCK_PERIOD 5
`endif
`ifndef _HALT
  `define _HALT 2500
`endif

`ifndef _FSM_COUNTER_SPAN
  `define _FSM_COUNTER_SPAN 25000000
`endif
`ifndef _FSM_WAIT_TO_INIT
  `define _FSM_WAIT_TO_INIT 50
`endif
`ifndef _FSM_WAIT_SEND_AGAIN
  `define _FSM_WAIT_SEND_AGAIN 50000000
`endif

//`ifndef _SIMULATION
//  `define _SIMULATION 1
//`endif

`ifndef _COMPILE_TYPE
  localparam _COMPILE_TYPE = 0;
`else
  localparam _COMPILE_TYPE = 1;
`endif


module tse_controller_tb(

);

//*****************************************************************************************
// Type Imports:
//*****************************************************************************************
typedef AlteraAvalon_Pkg::AvalonST_Bus AvalonST_Bus;


//*****************************************************************************************
// Constants & Parameters Declarations:
//*****************************************************************************************

localparam BRIDGE_DATA_WIDTH = 32;


// TSE Controller Parameters:
localparam SPEED_SENSOR_WIDTH = 16;
localparam ADC_WIDTH          = 16;

localparam TSE_TX_ST_DATA_WIDTH = 32;
localparam TSE_CONTROL_MM_DATA_WIDTH = 32;

localparam FSM_COUNTER_SPAN = `_FSM_COUNTER_SPAN;
localparam FSM_WAIT_TO_INIT = `_FSM_WAIT_TO_INIT;
localparam FSM_WAIT_SEND_AGAIN = `_FSM_WAIT_SEND_AGAIN;



//*****************************************************************************************
// Data Type Declarations:
//*****************************************************************************************



//*****************************************************************************************
// Variable & Signal Declarations:
//*****************************************************************************************


//reg clock, start,ready,reset_n_xR,waitrequest; // always unsigned!
logic clock       = 0, 
      start       = 0, 
	  reset_n_xR  = 1, 
	  waitrequest = 0; // always unsigned!

logic [SPEED_SENSOR_WIDTH-1:0] speed_sensor_driver = 'hdead;
logic [ADC_WIDTH-1:0]          adc_driver = 'hbeef;

AvalonST_Bus avalon_st_bus;


typedef struct packed
{
    logic Ready;
}   To_AvalonST_SourceStruct_TEST;
    
To_AvalonST_SourceStruct_TEST to_avalonst_source;
//AvalonMM_Bus avalon_MM_bus;

logic [511:0] write_data_512 [5]; 
logic [3:0]   nibble;



//*****************************************************************************************
// Modules/Entities Instantiations:
//*****************************************************************************************

//IAvalonST #(
//    .DATA_WIDTH(32)
//  )
//  avalon_st_bus ( /*no ports*/ );


//IAvalonMM #(
//    .ADDRESS_WIDTH(8),
//    .DATA_WIDTH(32)
//  )
//  avalon_mm_bus( /* no ports */ );


//https://verificationacademy.com/forums/systemverilog/vhdl-record-systemverilog-struct
tse_controller #(
    .SPEED_SENSOR_WIDTH         (SPEED_SENSOR_WIDTH),
    .ADC_WIDTH                  (ADC_WIDTH),
	.TSE_TX_ST_DATA_WIDTH       (TSE_TX_ST_DATA_WIDTH),
	.TSE_CONTROL_MM_DATA_WIDTH  (TSE_CONTROL_MM_DATA_WIDTH),
    
    .FSM_COUNTER_SPAN(FSM_COUNTER_SPAN),       // parameter FSM_COUNTER_SPAN = 250000000,
    .FSM_WAIT_TO_INIT(FSM_WAIT_TO_INIT),       // parameter FSM_WAIT_TO_INIT = 5,
    .FSM_WAIT_SEND_AGAIN(FSM_WAIT_SEND_AGAIN)  // parameter FSM_WAIT_SEND_AGAIN = 5,

) dut_1 (
    .CLOCK(clock),
    .RESET_N(reset_n_xR),
    .SEND_PACKET(start),

    .MTU( 16'h06),          
    .SPEED_SENSOR(speed_sensor_driver),
    .ADC(adc_driver),         

	  
    // Avalon-ST Master:
    .AVALON_ST_SOURCE_IN_1(avalon_st_bus.to_source),
	.AVALON_ST_SOURCE_OUT_1(avalon_st_bus.from_source),
          
    //Avalon-MM Master:
    .AVALON_MM_MASTER_IN_1 (),
	.AVALON_MM_MASTER_OUT_1()
);




//*****************************************************************************************
// Stimulus Generation:
//*****************************************************************************************
   
   
   
//always begin //  #(`_CLOCK_PERIOD/2) clock = ~clock; end
initial begin : clock_gen
    clock = 'b0;
    forever #(`_CLOCK_PERIOD/2) clock = ~clock;
end


initial begin: stimulus_gen
    #1   reset_n_xR = 'b1;
    #150 reset_n_xR = 'b0;
    #20  reset_n_xR = 'b1;
    
    #50;
    for(int j=0;j<5;j=j+1) begin
      for(int i=0;i<16;i=i+1) begin 
        write_data_512[j][i*BRIDGE_DATA_WIDTH+:BRIDGE_DATA_WIDTH] = 'hadd00000 + i + (j*16);
        $display("Time: %0t; \t init write_data_512[%0d][%0d %0d]\t\t\t\t\t\t 0x%0x", $time, 
                                                                                      j, 
    																		          i*BRIDGE_DATA_WIDTH+32-1, 
    																		          i*BRIDGE_DATA_WIDTH, 
    																		          write_data_512[j][i*BRIDGE_DATA_WIDTH+:BRIDGE_DATA_WIDTH]);
      end
    end
	

	#1500;
    repeat(1) @(posedge clock);
    start=1;
    repeat(1) @(posedge clock);
    start=0;
	
	
	#(`_HALT) $stop; // $finish can be used instead of $stop to close modelsim completely when logging data to a file.
end



//*****************************************************************************************
// Tasks & Function Definitions:
//*****************************************************************************************

endmodule

