# UVM Testbench
This is a categorized list of SV files used to build this testbench.

**Top-level module**
* testbench.sv

**FIFO package**
* fifo_pkg.sv

**Interface**
* fifo_if.sv

**Globals (data types, ...)**
* fifo_globals.sv

**Model & Scoreboard**
* fifo_model.sv
* fifo_scoreboard.sv

**Sequence items**
* fifo_seq_item_base.sv
* fifo_seq_item_drv.sv
* fifo_seq_item_mon.sv

**Sequencer, driver, and monitor**
* fifo_monitor.sv
* fifo_driver.sv
* fifo_sequencer.sv

**Agent and agent configuration object**
* fifo_agent_config.sv
* fifo_agent.sv

**Coverage collector**
* fifo_coverage_collector.sv

**Environment and environment configuration object**
* fifo_env_config.sv
* fifo_env.sv

**Sequences**
* fifo_sequence_random.sv
* fifo_sequence_full_range.sv
* fifo_sequence_full_flag.sv
* fifo_sequence_empty_flag.sv

**Tests**
* fifo_test_base.sv
* fifo_test_random.sv
* fifo_test_full_range.sv
* fifo_test_full_flag.sv
* fifo_test_empty_flag.sv