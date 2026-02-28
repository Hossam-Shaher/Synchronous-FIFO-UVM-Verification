`ifndef FIFO_ENV_CONFIG_SV
  `define FIFO_ENV_CONFIG_SV

  typedef class fifo_agent_config;

  class fifo_env_config extends uvm_object;
    `uvm_object_utils(fifo_env_config)

    fifo_agent_config m_fifo_agent_config;

    bit coverage_enable = 1;			//if this field == 1, alu_coverage_collector will be instantiated in the env 

    function new(string name="");
      super.new(name);

      m_fifo_agent_config = fifo_agent_config::type_id::create("m_fifo_agent_config");
    endfunction: new   

  endclass: fifo_env_config

`endif  //FIFO_ENV_CONFIG_SV