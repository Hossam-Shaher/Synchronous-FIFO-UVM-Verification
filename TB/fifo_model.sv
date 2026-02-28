`ifndef FIFO_MODEL_SV
  `define FIFO_MODEL_SV

  typedef class fifo_seq_item_mon;
    
  class fifo_model extends uvm_component;
    
    `uvm_component_utils(fifo_model)
     
    uvm_analysis_imp#(fifo_seq_item_mon, fifo_model) analysis_imp;	//for receiving information from the agent
    
    uvm_analysis_port#(fifo_seq_item_mon) analysis_port;	//for sending the expected transactions to the scorebored
    
    fifo_t 	fifo_m;				//"fifo_m" models "fifo" in DUT
  
    ptr_t 	w_ptr_m, r_ptr_m;	//"*_ptr_m" models "*_ptr" in DUT 
            
    extern function new (string name = "", uvm_component parent);
    
    extern function void build_phase (uvm_phase phase);

    extern function void write (fifo_seq_item_mon item);
      
  endclass: fifo_model
      
  /**************************************************************************/    
  /***************************** IMPLEMENTATION *****************************/    
  /**************************************************************************/ 

  //new
  //---
      
  function fifo_model:: new(string name = "", uvm_component parent);
    super.new(name, parent);  
  endfunction
      
  //build_phase
  //-----------
      
  function void fifo_model:: build_phase(uvm_phase phase);
    super.build_phase(phase);

    analysis_imp  = new("analysis_imp",  this);
    analysis_port = new("analysis_port", this);

  endfunction: build_phase

  //write
  //-----
      
  function void fifo_model:: write(fifo_seq_item_mon item);
    
    if(!item.reset_n) begin
      item.empty = 1;
      item.full 	= 0;
      w_ptr_m = 0; 
      r_ptr_m	= 0; 
    end
    else begin
      //write data
      if(item.we && !item.full) begin
        fifo_m[w_ptr_m] = item.wd;
        w_ptr_m++;
      end
      //read data
      if(item.re && !item.empty) begin
        item.rd = fifo_m[r_ptr_m];
        r_ptr_m++;
      end
      //empty flag
      item.empty = (r_ptr_m === w_ptr_m);
      //full flag
      item.full  = (r_ptr_m[`N-1:0] === w_ptr_m[`N-1:0]) && (r_ptr_m[`N] !== w_ptr_m[`N]);
    end
    
    analysis_port.write(item);
    
  endfunction: write

`endif //FIFO_MODEL_SV