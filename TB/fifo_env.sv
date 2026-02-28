`ifndef FIFO_ENV_SV
  `define FIFO_ENV_SV

  typedef class fifo_env_config;
  typedef class fifo_agent;
  typedef class fifo_coverage_collector;
  typedef class fifo_model;  
  typedef class fifo_scoreboard;

  class fifo_env extends uvm_env;

    `uvm_component_utils(fifo_env)

    fifo_env_config 			m_fifo_env_config;
    fifo_agent 					m_fifo_agent;
    fifo_coverage_collector 	m_fifo_coverage_collector;
    fifo_model 					m_fifo_model;
    fifo_scoreboard				m_fifo_scoreboard;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction: new

    extern function void build_phase(uvm_phase phase);

    extern function void connect_phase(uvm_phase phase);

  endclass: fifo_env
      
  /**************************************************************************/    
  /***************************** IMPLEMENTATION *****************************/    
  /**************************************************************************/    
      

  //build_phase
  //-----------

  function void fifo_env:: build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_fifo_env_config = fifo_env_config::type_id::create("m_fifo_env_config", this);
    if( ! uvm_config_db#(fifo_env_config)::get(this, "", "m_fifo_env_config", m_fifo_env_config) ) begin
      `uvm_error(this.get_type_name(), "m_fifo_env_config NOT found")
    end    
    // manipulate properties of m_fifo_env_config HERE

    m_fifo_agent = fifo_agent::type_id::create("m_fifo_agent", this);
    
    if( m_fifo_env_config.coverage_enable == 1 )
        m_fifo_coverage_collector = fifo_coverage_collector::type_id::create("m_fifo_coverage_collector", this);

    uvm_config_db#(fifo_agent_config)::set(this, "m_fifo_agent", "m_fifo_agent_config", m_fifo_env_config.m_fifo_agent_config);

    m_fifo_model = fifo_model::type_id::create("m_fifo_model", this);
/*
    if ( m_fifo_env_config.fifo_vif == null ) begin
      `uvm_error(this.get_type_name(), "m_fifo_env_config.fifo_vif == null")
    end
    uvm_config_db#(virtual fifo_if #(`N, `M)):: set(this, "m_fifo_model" , "fifo_vif", m_fifo_env_config.fifo_vif);
*/    
    m_fifo_scoreboard = fifo_scoreboard::type_id::create("m_fifo_scoreboard", this);
  endfunction: build_phase 

  //connect_phase
  //-------------

  function void fifo_env:: connect_phase(uvm_phase phase);
    
    if( m_fifo_env_config.coverage_enable == 1 )
        m_fifo_agent.ap.connect(m_fifo_coverage_collector.analysis_export);

    m_fifo_agent.ap.connect(m_fifo_model.analysis_imp);

    m_fifo_agent.ap.connect(m_fifo_scoreboard.export_in_agent);
        
    m_fifo_model.analysis_port.connect(m_fifo_scoreboard.export_in_model);
    
  endfunction: connect_phase 
    
`endif //FIFO_ENV_SV