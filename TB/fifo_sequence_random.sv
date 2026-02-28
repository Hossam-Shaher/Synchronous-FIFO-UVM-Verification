`ifndef FIFO_SEQUENCE_RANDOM_SV
  `define FIFO_SEQUENCE_RANDOM_SV

  typedef class fifo_seq_item_drv;

  class fifo_sequence_random extends uvm_sequence#(fifo_seq_item_drv);

    `uvm_object_utils(fifo_sequence_random)

    fifo_seq_item_drv item;

    function new(string name = "");
      super.new(name);
      item = fifo_seq_item_drv::type_id::create("item"); 
      //Do NOT insert a 2nd actual argument "this", bcz "this" shall be a component
    endfunction: new

    task body();
      start_item(item);
      assert( item.randomize() );
      finish_item(item);    
    endtask: body

  endclass: fifo_sequence_random

`endif //FIFO_SEQUENCE_RANDOM_SV