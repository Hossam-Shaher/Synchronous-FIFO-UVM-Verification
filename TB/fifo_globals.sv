`ifndef FIFO_GLOBALS_SV
  `define FIFO_GLOBALS_SV

  //data type of "wd" (write data) and "rd" (read data)
  typedef logic [`M-1:0] data_t;

  //data type of "fifo_t"
  typedef logic [`M-1:0] fifo_t [2**`N];

  //data type of "w_ptr" and "r_ptr"
  typedef logic [`N:0] ptr_t;

`endif	//FIFO_GLOBALS_SV