`ifndef FIFO_MONITOR
  `define FIFO_MONITOR

  typedef class fifo_seq_item_mon;

  class fifo_monitor extends uvm_monitor;

    `uvm_component_utils(fifo_monitor)

    virtual fifo_if #(`N, `M) 				fifo_vif;
    uvm_analysis_port#(fifo_seq_item_mon) 	ap;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      ap = new("ap", this);

      if( ! uvm_config_db#(virtual fifo_if #(`N, `M))::get(this, "", "fifo_vif", fifo_vif) ) begin
        `uvm_error( this.get_type_name(), "fifo_vif NOT found" )
      end    
    endfunction: build_phase

    task run_phase(uvm_phase phase);
      forever begin
          monitor();  
      end
    endtask: run_phase

    extern local task monitor();

  endclass: fifo_monitor

  //monitor
  task fifo_monitor:: monitor();
    fifo_seq_item_mon item;
    item = fifo_seq_item_mon::type_id::create("item");
    
    @(negedge fifo_vif.clk); #(`CLK /2.0);
    
    item.reset_n 	= fifo_vif.reset_n;
    item.re 		= fifo_vif.re;
    item.we 		= fifo_vif.we;
    item.wd 		= fifo_vif.wd;

    item.empty 		= fifo_vif.empty;
    item.full 		= fifo_vif.full;
    item.rd 		= fifo_vif.rd;

    ap.write(item);

    `uvm_info(this.get_type_name(), item.convert2string, UVM_LOW) 
  endtask: monitor
    
`endif //FIFO_MONITOR