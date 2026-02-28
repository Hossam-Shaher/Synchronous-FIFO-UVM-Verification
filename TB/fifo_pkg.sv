`ifndef FIFO_PKG_SV
  `define FIFO_PKG_SV

  //Timescale
  `timescale 1ns/1ns

  //Macros
  `define N 	8		//FIFO depth = 2**N
  `define M 	4		//FIFO width
  `define CLK 	5ns		//Half cycle

  //Interface
  `include "fifo_if.sv"

  package fifo_pkg;

    //UVM
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    //Globals (enumerations, types, ...)
    `include "fifo_globals.sv"

    //Modeling & Checking
    `include "fifo_model.sv"
    `include "fifo_scoreboard.sv"

    //Sequence items
    `include "fifo_seq_item_base.sv"
    `include "fifo_seq_item_drv.sv"
    `include "fifo_seq_item_mon.sv"

    //Monitor, sequencer, driver
    `include "fifo_monitor.sv"
    `include "fifo_sequencer.sv"
    `include "fifo_driver.sv"

    //Agent, agent configuration object
    `include "fifo_agent_config.sv"
    `include "fifo_agent.sv"

    //Coverage collector
    `include "fifo_coverage_collector.sv"

    //Environment, environment configuration object
    `include "fifo_env_config.sv"
    `include "fifo_env.sv"

    //Sequences
    `include "fifo_sequence_random.sv"
    `include "fifo_sequence_full_range.sv"
    `include "fifo_sequence_full_flag.sv"
    `include "fifo_sequence_empty_flag.sv"

    //Tests
    `include "fifo_test_base.sv"
    `include "fifo_test_random.sv"
    `include "fifo_test_full_range.sv"
    `include "fifo_test_full_flag.sv"
    `include "fifo_test_empty_flag.sv"

  endpackage: fifo_pkg 

`endif //FIFO_PKG_SV