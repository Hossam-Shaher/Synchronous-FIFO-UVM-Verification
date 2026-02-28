`ifndef FIFO_SEQUENCE_FULL_RANGE_SV
  `define FIFO_SEQUENCE_FULL_RANGE_SV

  typedef class fifo_seq_item_drv;
  typedef class fifo_sequence_random;

  //Full Range Test: Writing to every available address and then reading them back.
  //	Push 2**N item (where 2**N is the FIFO depth). The full flag shall == 1.
  //	Pop all 2**N items. They shall come out in the exact order they went in. The empty flag shall == 1.
    
  class fifo_sequence_full_range extends fifo_sequence_random;

    `uvm_object_utils(fifo_sequence_full_range)

    function new(string name = "");
      super.new(name);
    endfunction: new

    task body();
            
      //reset
      start_item(item);
      assert( item.randomize() with {
        reset_n == 1'b0;
      } );
      finish_item(item);
      
      //push
      repeat(2**`N) begin
        start_item(item);
        assert( item.randomize() with {
          we == 1'b1;
          re == 1'b0;
          reset_n == 1'b1;
        } );
        finish_item(item);
      end
      
      //pop
      repeat(2**`N) begin
        start_item(item);
        assert( item.randomize() with {
          we == 1'b0;
          re == 1'b1;
          reset_n == 1'b1;
        } );
        finish_item(item);
      end

    endtask: body

  endclass: fifo_sequence_full_range

`endif //FIFO_SEQUENCE_FULL_RANGE_SV