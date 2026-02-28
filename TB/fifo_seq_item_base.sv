`ifndef FIFO_SEQ_ITEM_BASE_SV 
  `define FIFO_SEQ_ITEM_BASE_SV

  class fifo_seq_item_base extends uvm_sequence_item;

    `uvm_object_utils(fifo_seq_item_base)
    
    rand logic 	reset_n;
    rand logic 	re;
    rand logic 	we;
    rand data_t wd;
    
    function string convert2string;
      convert2string = $sformatf("reset_n=%0d, re=%0d, we=%0d, wd=%0b", 
                                  reset_n, re, we, wd);
    endfunction: convert2string

    function new (string name = "");
      super.new(name);
    endfunction: new

  endclass: fifo_seq_item_base

`endif //FIFO_SEQ_ITEM_BASE_SV