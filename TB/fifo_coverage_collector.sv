`ifndef FIFO_COVERAGE_COLLECTOR_SV
  `define FIFO_COVERAGE_COLLECTOR_SV

  typedef class fifo_seq_item_mon;
    
  class fifo_coverage_collector extends uvm_subscriber#(fifo_seq_item_mon);
    `uvm_component_utils(fifo_coverage_collector)

    fifo_seq_item_mon 	item;

    covergroup cover_group;
      option.per_instance = 1;

      reset_n : coverpoint item.reset_n {
        option.comment = "reset_n";
      }
      
      re : coverpoint item.re {
        option.comment = "read enable";
      }
      
      we : coverpoint item.we {
        option.comment = "write enable";
      }
      
      empty : coverpoint item.empty {
        option.comment = "empty flag";
      }
      
      full : coverpoint item.full {
        option.comment = "full flag";
      }
      
      re_x_we : cross re, we {
        option.comment = "read enable x write enable";
      }

    endgroup: cover_group

    function new(string name, uvm_component parent);
      super.new(name, parent);
      cover_group = new();
    endfunction: new  

    function void write(fifo_seq_item_mon t);
      item = t;
      cover_group.sample();
    endfunction: write

    function string coverage2string();
      coverage2string  = {
        $sformatf("\n  cover_group:             %.2f%%", cover_group.get_inst_coverage()),
        $sformatf("\n       reset_n:            %.2f%%", cover_group.reset_n.get_inst_coverage()),
        $sformatf("\n       re:                 %.2f%%", cover_group.re.get_inst_coverage()),
        $sformatf("\n       we:                 %.2f%%", cover_group.we.get_inst_coverage()),
        $sformatf("\n       empty:              %.2f%%", cover_group.empty.get_inst_coverage()),
        $sformatf("\n       full:               %.2f%%", cover_group.full.get_inst_coverage()),
        $sformatf("\n       re_x_we:            %.2f%%", cover_group.re_x_we.get_inst_coverage()),
        $sformatf("\n  ======================================"),
        $sformatf("\n  OVERALL Coverage:        %.2f%%", $get_coverage())
      };    
    endfunction: coverage2string

    function void report_phase(uvm_phase phase);
      `uvm_info("COVERAGE", coverage2string(), UVM_NONE)
    endfunction: report_phase

  endclass: fifo_coverage_collector

`endif //FIFO_COVERAGE_COLLECTOR_SV