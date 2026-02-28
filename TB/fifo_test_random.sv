`ifndef FIFO_TEST_RANDOM_SV
  `define FIFO_TEST_RANDOM_SV

  typedef class fifo_test_base;
  typedef class fifo_sequence_random;
    
  class fifo_test_random extends fifo_test_base;

    `uvm_component_utils(fifo_test_random)
    
    fifo_sequence_random 	m_fifo_sequence_random;
    int unsigned 			nu_repetitions = 30;	//number of repetitions (used in a repeat loop in run_phase)
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // manipulate properties of m_fifo_env_config HERE
      
      m_fifo_sequence_random = fifo_sequence_random::type_id::create("m_fifo_sequence_random", this);
    endfunction: build_phase 

    task run_phase (uvm_phase phase);
      phase.raise_objection(this, "fifo_test_random", 1);
      #100ns;
      
      repeat (nu_repetitions) begin
        //assert ( m_fifo_sequence_random.randomize() );	//optional... use it if there are rand properties in the sequence
        m_fifo_sequence_random.start(m_fifo_env.m_fifo_agent.m_fifo_sequencer);
      end
   
      #10ns;
      phase.drop_objection(this, "fifo_test_random", 1);
    endtask: run_phase
    
  endclass: fifo_test_random

`endif //FIFO_TEST_RANDOM_SV