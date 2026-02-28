# Synchronous FIFO: UVM Verification
This **synchronous FIFO (First In First Out) buffer** has a size of $2^N$-word $×$ $M$-bit (depth $×$ width).

**Interface Signals**:
* **clk**:        System clock
* **reset_n**:    Active-low synchronous reset
* **re**:         Read enable control signal 
* **we**:         Write enable control signal
* **wd**:         Write data input ($M$ bits)
* **rd**:         Read data output ($M$ bits)
* **full**:       "FIFO is full" status flag
* **empty**:      "FIFO is empty" status flag

**Important internal registers**:
* **w_ptr** (write pointer): Tracks the address for the next write operation
* **r_ptr** (read pointer): Tracks the address for the next read operation

In this project, the FIFO is designed, modeled, and verified using the **SystemVerilog HDVL** and the **Universal Verification Methodology (UVM)**.

The following figures show the **structure of the UVM testbench**.

<img width="621.5" height="508" alt="image" src="https://github.com/user-attachments/assets/68fa79d2-b809-4866-86c3-e43fb40667de" />

<img width="929" height="526" alt="image" src="https://github.com/user-attachments/assets/50851db9-37d1-4cab-8fd3-03c72acc778b" />

<img width="443" height="519" alt="image" src="https://github.com/user-attachments/assets/3845a988-4b2d-4731-aed0-0a91fdc3b36b" />

The following figure shows **UML class diagrams of the UVM tests** used to verify the DUT.

<img width="561" height="311" alt="FIFO drawio" src="https://github.com/user-attachments/assets/4170345b-1b5b-4596-850c-cafaf787e06f" />
