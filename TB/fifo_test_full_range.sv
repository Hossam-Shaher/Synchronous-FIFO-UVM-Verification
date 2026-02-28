`ifndef FIFO_TEST_FULL_RANGE_SV
  `define FIFO_TEST_FULL_RANGE_SV

  typedef class fifo_test_random;
  typedef class fifo_sequence_random;
  typedef class fifo_sequence_full_range;
    
  //Full Range Test: Writing to every available address and then reading them back.
  //	Push 2**N item (where 2**N is the FIFO depth). The full flag shall == 1.
  //	Pop all 2**N items. They shall come out in the exact order they went in. The empty flag shall == 1.    
  
  class fifo_test_full_range extends fifo_test_random;

    `uvm_component_utils(fifo_test_full_range)
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
      //You can manipulate nu_repetitions HERE
      nu_repetitions = 4;
      
      fifo_sequence_random::type_id::set_type_override( fifo_sequence_full_range::get_type() );
    endfunction: new

  endclass: fifo_test_full_range

`endif //FIFO_TEST_FULL_RANGE_SV