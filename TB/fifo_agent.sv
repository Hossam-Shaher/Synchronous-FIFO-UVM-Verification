`ifndef FIFO_AGENT_SV
  `define FIFO_AGENT_SV

  typedef class fifo_agent_config;
  typedef class fifo_monitor;
  typedef class fifo_driver; 
  typedef class fifo_sequencer;
  typedef class fifo_seq_item_mon;

  class fifo_agent extends uvm_agent;
    `uvm_component_utils(fifo_agent)

    fifo_agent_config 						m_fifo_agent_config;
    fifo_driver 							m_fifo_driver;
    fifo_sequencer							m_fifo_sequencer;
    fifo_monitor							m_fifo_monitor;
    uvm_analysis_port#(fifo_seq_item_mon)	ap;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction: new 

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      m_fifo_agent_config = fifo_agent_config::type_id::create("m_fifo_agent_config", this);
      if( ! uvm_config_db#(fifo_agent_config)::get(this, "", "m_fifo_agent_config", m_fifo_agent_config) ) begin
        `uvm_error(this.get_type_name(), "m_fifo_agent_config NOT found");
      end    
      if ( m_fifo_agent_config.fifo_vif == null ) begin
        `uvm_error(this.get_type_name(), "m_fifo_agent_config.fifo_vif == null")
      end
      if ( get_is_active() == UVM_ACTIVE) begin
        m_fifo_driver = fifo_driver::type_id::create("m_fifo_driver", this);
        m_fifo_sequencer = fifo_sequencer::type_id::create("m_fifo_sequencer", this); 

        uvm_config_db#(virtual fifo_if #(`N, `M))::set(this, "m_fifo_driver", "fifo_vif", m_fifo_agent_config.fifo_vif);
        m_fifo_sequencer.set_arbitration(m_fifo_agent_config.arb_mode);
      end

      m_fifo_monitor = fifo_monitor::type_id::create("m_fifo_monitor", this);
      uvm_config_db#(virtual fifo_if #(`N, `M))::set(this, "m_fifo_monitor", "fifo_vif", m_fifo_agent_config.fifo_vif);
/*
      m_fifo_monitor.checks_enable = m_fifo_agent_config.checks_enable ;
      m_fifo_monitor.stuck_threshold = m_fifo_agent_config.stuck_threshold ;
*/
      ap = new("ap", this);

    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
      if ( get_is_active() == UVM_ACTIVE) begin
          m_fifo_driver.seq_item_port.connect(m_fifo_sequencer.seq_item_export);
      end
      m_fifo_monitor.ap.connect(ap);
    endfunction: connect_phase

    function uvm_active_passive_enum get_is_active();
      return uvm_active_passive_enum'(m_fifo_agent_config.is_active);
    endfunction: get_is_active

  endclass: fifo_agent

`endif  //FIFO_AGENT_SV