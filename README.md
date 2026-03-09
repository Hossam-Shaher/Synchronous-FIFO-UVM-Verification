# Synchronous FIFO: UVM Verification
This **synchronous FIFO (First In First Out) buffer** has a size of $2^N$-word $×$ $M$-bit (depth $×$ width).

In this project, the FIFO is designed, modeled, and verified using the **SystemVerilog HDVL** and the **Universal Verification Methodology (UVM)**.

## Design Under Test (DUT)

The following figure shows the synchronous FIFO as a black box.

<img width="580" height="660" alt="FIFO-Page-2 drawio" src="https://github.com/user-attachments/assets/8188fccb-f42e-4351-b93f-5cc09a9c7d0b" />

**Parameters** of the synchronous FIFO are listed in the following table.

Parameter Name | Default Value | Description
:--- | :---: | :---
`N` | 8 | FIFO's depth = $2^N$ word
`M` | 4 | FIFO's width = $M$ bit

**Ports** of the synchronous FIFO are listed in the following table.

Port Name | Width | Direction | Description
:--- | :---: | :---: | :--- 
`clk` | 1 | Input | System clock
`reset_n` | 1 | Input | Active-low synchronous reset 
`we` | 1 | Input | Write enable (control signal) 
`re` | 1 | Input | Read enable (control signal) 
`wd` | $M$ | Input |  Write data 
`rd` | $M$ | Output | Read data 
`full` | 1 | Output | "FIFO is full" status flag 
`empty` | 1 | Output | "FIFO is empty" status flag 

**Important internal registers**:
* `w_ptr` (write pointer): Tracks the address for the next write operation
* `r_ptr` (read pointer): Tracks the address for the next read operation

## UVM Testbench

The following figures show the **structure of the UVM testbench**.

<img width="621.5" height="508" alt="image" src="https://github.com/user-attachments/assets/68fa79d2-b809-4866-86c3-e43fb40667de" />

<img width="929" height="526" alt="image" src="https://github.com/user-attachments/assets/50851db9-37d1-4cab-8fd3-03c72acc778b" />

<img width="443" height="519" alt="image" src="https://github.com/user-attachments/assets/3845a988-4b2d-4731-aed0-0a91fdc3b36b" />

<img width="1832" height="430" alt="image" src="https://github.com/user-attachments/assets/d9224891-c28e-43ad-9662-031bf7b759bd" />

The following figure shows **UML class diagrams of the UVM tests** used to verify the DUT.

<img width="673.2" height="373.2" alt="FIFO drawio" src="https://github.com/user-attachments/assets/4170345b-1b5b-4596-850c-cafaf787e06f" />
