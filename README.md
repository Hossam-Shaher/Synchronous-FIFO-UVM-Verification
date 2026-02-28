# Synchronous FIFO: UVM Verification
This **synchronous FIFO (First In First Out) buffer** has a size of 2**N-word (depth) × M-bit (width).

Its **inputs** are:
* clk
* reset_n
* re (read enable)
* we (write enable)
* wd (write data)

And its **outputs** are:
* rd (read data)
* full ("FIFO is full" flag)
* emppty ("FIFO is empty" flag)

Some **important internal variables** are:
* w_ptr (write pointer); it holds the address of the word at which the next write operation will occur
* r_ptr (read pointer); it holds the address of the word at which the next read operation will occur

In this project, the FIFO is designed, modeled, and verified using the **SystemVerilog HDVL** and the **Universal Verification Methodology (UVM)**.

The following figures show the **structure of the UVM testbench**.

The following figure shows **UML class diagrams of the UVM tests** used to verify the DUT.

