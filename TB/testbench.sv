`include "fifo_pkg.sv"

module tb; 
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import fifo_pkg::*;
  
  //Clock generator
  logic clk = 0;
  always #`CLK clk = ~clk;

  //Interface
  fifo_if #(.N(`N), .M(`M)) fifo_if_inst( .clk( clk ) );
  
  //DUT
  FIFO #(.N(`N)) dut (
    .clk		( clk ),		
    .reset_n	( fifo_if_inst.reset_n 	),			
    .re			( fifo_if_inst.re 		),	
    .we			( fifo_if_inst.we 		),	
    .wd			( fifo_if_inst.wd 		),	
    .empty		( fifo_if_inst.empty	),		
    .full		( fifo_if_inst.full 	),		
    .rd			( fifo_if_inst.rd 		)
  );
  
  //Initial reset generator
  initial begin
    fifo_if_inst.re = 1'b1;
    fifo_if_inst.we = 1'b1;
    fifo_if_inst.wd = '0;

    fifo_if_inst.reset_n = 1;
    #3  fifo_if_inst.reset_n = 0;
    #30 fifo_if_inst.reset_n = 1;    
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    uvm_config_db#(virtual fifo_if #(`N, `M)):: set(null, "uvm_test_top", "fifo_vif", fifo_if_inst);
    
    run_test("fifo_test_base"); 
    //Default test is "fifo_test_base" 
    //Use +UVM_TESTNAME=<class name> to choose another test
  end
  
endmodule: tb