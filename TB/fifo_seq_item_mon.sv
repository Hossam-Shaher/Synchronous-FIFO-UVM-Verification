`ifndef FIFO_SEQ_ITEM_MON_SV 
  `define FIFO_SEQ_ITEM_MON_SV

  typedef class fifo_seq_item_base;

  class fifo_seq_item_mon extends fifo_seq_item_base;

    `uvm_object_utils(fifo_seq_item_mon)

    //There is no reason to declare the properties of this class as rand

    logic 	empty;
    logic 	full;
    data_t 	rd;
    
    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
      fifo_seq_item_mon item;
      bit status = 1;
      $cast(item, rhs);

      status &= super.do_compare(rhs, comparer);	//In this case, super.do_compre always return 1
      status &= (this.reset_n	=== item.reset_n);
      status &= (this.re 		=== item.re);
      status &= (this.we 		=== item.we);
      status &= (this.wd 		=== item.wd);
      status &= (this.empty 	=== item.empty);
      status &= (this.full 		=== item.full);
      status &= (this.rd 		=== item.rd);

      return status;
    endfunction: do_compare

    function string convert2string;

      convert2string = $sformatf("%0s, empty=%0d, full=%0d, rd=%0b", 
                                  super.convert2string, empty, full, rd);

    endfunction: convert2string

    function new (string name = "");
      super.new(name);
    endfunction: new

  endclass: fifo_seq_item_mon

`endif //FIFO_SEQ_ITEM_MON_SV