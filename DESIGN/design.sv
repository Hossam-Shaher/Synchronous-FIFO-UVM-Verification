//2**N-word (depth) × M-bit (width) FIFO buffer
//Inputs:
//	clk, reset_n, re (read enable), we (write enable), wd (write data)
//Outputs:
//	rd (read data), full ("FIFO is full" flag), emppty ("FIFO is empty" flag)
//Important internal signals:
//	w_ptr (address of the word at which the next write operation will occur)
//	r_ptr (address of the word at which the next read operation will occur)
//
//	Range of w_ptr and r_ptr: [N:0] bits NOT only [N-1 : 0].
//	Empty condition: 	w_ptr == r_ptr
//	Full condition:		(w_ptr[N-1:0] == r_ptr[N-1:0]) && (w_ptr[N] != r_ptr[N])

module FIFO 
  #(parameter N = 8, M = 4) (
    input wire logic 		clk, 
                        	reset_n, 	//synchronous reset
                        	re, 		//read enable
                        	we, 		//write enable
              logic [M-1:0] wd, 		//write data

    output var logic		empty,
    						full,
              logic [M-1:0] rd 			//read data
  );
  
  logic [M-1:0] fifo [2**N];			//Note that [2**N] is equivalent to [0 : (2**N)-1]
  
  logic [N:0] w_ptr, r_ptr;
  
  always @(posedge clk)
    if(!reset_n) begin
      empty <= 1;
      full 	<= 0;
      w_ptr <= 0; 
      r_ptr	<= 0; 
    end
    else begin
      //write data
      if(we && !full) begin
        fifo[w_ptr] <= wd;
        w_ptr <= w_ptr + 1;
      end
      //read data
      if(re && !empty) begin
        rd <= fifo[r_ptr];
        r_ptr <= r_ptr + 1;
      end
    end
  
  always @(*) begin
    //empty flag
    empty = (r_ptr === w_ptr);
    //full flag
    full = (r_ptr[N-1:0] === w_ptr[N-1:0]) && (r_ptr[N] !== w_ptr[N]);
  end
 
endmodule: FIFO
