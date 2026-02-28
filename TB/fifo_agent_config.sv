`ifndef FIFO_AGENT_CONFIG_SV
  `define FIFO_AGENT_CONFIG_SV

  class fifo_agent_config extends uvm_object;
    `uvm_object_utils(fifo_agent_config)

    virtual fifo_if#(`N, `M) 	fifo_vif;
    uvm_active_passive_enum 	is_active = UVM_ACTIVE;
    uvm_sequencer_arb_mode 		arb_mode = UVM_SEQ_ARB_FIFO;

    function new(string name="");
      super.new(name);
    endfunction: new   

  endclass: fifo_agent_config

`endif  //FIFO_AGENT_CONFIG_SV