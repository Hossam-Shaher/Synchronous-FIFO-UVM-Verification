`ifndef FIFO_DRIVER
  `define FIFO_DRIVER

  typedef class fifo_seq_item_drv;

  class fifo_driver extends uvm_driver#(fifo_seq_item_drv);

    `uvm_component_utils(fifo_driver)

    virtual fifo_if #(`N, `M) fifo_vif;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if( ! uvm_config_db#(virtual fifo_if #(`N, `M))::get(this, "", "fifo_vif", fifo_vif) ) begin
        `uvm_error( this.get_type_name(), "fifo_vif NOT found" )
      end    
    endfunction: build_phase

    task run_phase(uvm_phase phase);
      initialize();

      forever begin
        seq_item_port.get_next_item(req);
          drive(req);            
        seq_item_port.item_done();
      end
    endtask: run_phase

    extern local task initialize();

    extern local task drive(fifo_seq_item_drv req);

  endclass: fifo_driver

  //initialize
  //----------
  task fifo_driver:: initialize();
    fifo_vif.reset_n	= 1'b1;
    fifo_vif.re			= 1'b1;
    fifo_vif.we			= 1'b1;
    fifo_vif.wd			=  '0;
  endtask

  //drive
  //-----
  task fifo_driver:: drive(fifo_seq_item_drv req);
    @(negedge fifo_vif.clk);
    
    fifo_vif.reset_n 	= req.reset_n;
    fifo_vif.re			= req.re;
    fifo_vif.we 		= req.we;
    fifo_vif.wd			= req.wd;    
    
    `uvm_info(this.get_type_name(), req.convert2string, UVM_LOW) 
  endtask: drive
    
`endif //FIFO_DRIVER