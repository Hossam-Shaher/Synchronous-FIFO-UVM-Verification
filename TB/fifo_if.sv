`ifndef FIFO_IF_SV
  `define FIFO_IF_SV

interface fifo_if #(parameter N = `N, M = `M) (input logic clk);

  	//DUT inputs
  	logic 			reset_n, 	//sync
                	re, 		//read enable
                	we; 		//write enable
  	logic [M-1:0] 	wd; 		//write data

  	//DUT outputs
    logic 			empty,
    				full;
  	logic [M-1:0] 	rd; 		//read data
    
  endinterface: fifo_if 

`endif // FIFO_IF_SV