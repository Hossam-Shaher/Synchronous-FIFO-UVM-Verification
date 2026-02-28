`ifndef FIFO_TEST_FULL_FLAG_SV
  `define FIFO_TEST_FULL_FLAG_SV

  typedef class fifo_test_random;
  typedef class fifo_sequence_random;
  typedef class fifo_sequence_full_flag;
  
  //The purpose of this test is to cover the coverage point "full" 
    
  class fifo_test_full_flag extends fifo_test_random;

    `uvm_component_utils(fifo_test_full_flag)
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
      //You can manipulate nu_repetitions HERE
      nu_repetitions = 5;
      
      fifo_sequence_random::type_id::set_type_override( fifo_sequence_full_flag::get_type() );
    endfunction: new

  endclass: fifo_test_full_flag

`endif //FIFO_TEST_FULL_FLAG_SV