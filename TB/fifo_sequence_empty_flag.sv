`ifndef FIFO_SEQUENCE_EMPTY_FLAG_SV
  `define FIFO_SEQUENCE_EMPTY_FLAG_SV

  typedef class fifo_seq_item_drv;
  typedef class fifo_sequence_random;

  //The purpose of this sequence is to cover the coverage point "empty"
    
  class fifo_sequence_empty_flag extends fifo_sequence_random;

    `uvm_object_utils(fifo_sequence_empty_flag)

    function new(string name = "");
      super.new(name);
    endfunction: new

    task body();
      
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

  endclass: fifo_sequence_empty_flag

`endif //FIFO_SEQUENCE_EMPTY_FLAG_SV