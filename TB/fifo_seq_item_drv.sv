`ifndef FIFO_SEQ_ITEM_DRV_SV 
  `define FIFO_SEQ_ITEM_DRV_SV

  typedef class fifo_seq_item_base;

  class fifo_seq_item_drv extends fifo_seq_item_base;

    `uvm_object_utils(fifo_seq_item_drv)

    //add rand properties and soft constraints HERE
    
    constraint default_reset_n {
      soft reset_n dist {1'b1 := 9, 1'b0 := 1};
    }
    
    constraint default_re {
      soft re dist {1'b1 := 7, 1'b0 := 3};
    }
    
    constraint default_we {
      soft we dist {1'b1 := 7, 1'b0 := 3};
    }
    
/*
    function string convert2string;
      convert2string = $sformatf("%0s, . . . ", 
                                 super.convert2string);
    endfunction: convert2string
*/
    function new (string name = "");
      super.new(name);
    endfunction: new

  endclass: fifo_seq_item_drv

`endif //FIFO_SEQ_ITEM_DRV_SV