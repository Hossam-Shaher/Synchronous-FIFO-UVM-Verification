`ifndef FIFO_TEST_BASE_SV
  `define FIFO_TEST_BASE_SV

  typedef class fifo_env;
  typedef class fifo_env_config;

  class fifo_test_base extends uvm_test;

    `uvm_component_utils(fifo_test_base)

    fifo_env 		m_fifo_env;
    fifo_env_config	m_fifo_env_config;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      m_fifo_env			= fifo_env::type_id::create("m_fifo_env", this); 
      m_fifo_env_config 	= fifo_env_config::type_id::create("m_fifo_env_config", this);  

      if( ! uvm_config_db#(virtual fifo_if #(`N, `M))::get(this, "", "fifo_vif", m_fifo_env_config.m_fifo_agent_config.fifo_vif) ) begin
        `uvm_error(this.get_type_name(), "fifo_vif NOT found")
      end

      uvm_config_db#(fifo_env_config)::set(this, "m_fifo_env", "m_fifo_env_config", m_fifo_env_config);

    endfunction: build_phase 

  endclass: fifo_test_base

`endif //FIFO_TEST_BASE_SV