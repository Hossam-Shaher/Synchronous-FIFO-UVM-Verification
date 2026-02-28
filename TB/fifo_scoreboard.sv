`ifndef FIFO_SCOREBOARD_SV
  `define FIFO_SCOREBOARD_SV

  typedef class fifo_seq_item_mon;

  class fifo_scoreboard extends uvm_scoreboard;
    
    `uvm_component_utils(fifo_scoreboard)
    
    //Expected
    uvm_analysis_export   #(fifo_seq_item_mon) 	export_in_model;		    
    uvm_tlm_analysis_fifo #(fifo_seq_item_mon) 	expected_transactions_fifo;
    
    //Actual
    uvm_analysis_export   #(fifo_seq_item_mon) 	export_in_agent;    		
    uvm_tlm_analysis_fifo #(fifo_seq_item_mon)	actual_transactions_fifo;

    //Counters used in report_phase
    int unsigned mismatch_count  = 0;
    int unsigned leftovers_count = 0;
        
    function new(string name = "", uvm_component parent);
      super.new(name, parent);
    endfunction: new
    
    extern function void build_phase (uvm_phase phase);

    extern function void connect_phase (uvm_phase phase);

    extern task run_phase (uvm_phase phase);

   	extern function void check_phase (uvm_phase phase);

    extern function void report_phase (uvm_phase phase);
    
  endclass: fifo_scoreboard

  /**************************************************************************/    
  /***************************** IMPLEMENTATION *****************************/    
  /**************************************************************************/ 
      
      
  //build_phase
  //-----------
      
  function void fifo_scoreboard:: build_phase (uvm_phase phase);
    super.build_phase(phase);

    export_in_model = new("export_in_model", this);
    export_in_agent = new("export_in_agent", this);

    expected_transactions_fifo  = new("expected_transactions_fifo", this);
    actual_transactions_fifo  	= new("actual_transactions_fifo",  	this);

  endfunction: build_phase

  //connect_phase
  //-------------
      
  function void fifo_scoreboard:: connect_phase (uvm_phase phase);

    export_in_model.connect( expected_transactions_fifo.analysis_export	);
    export_in_agent.connect( actual_transactions_fifo.analysis_export	);

  endfunction: connect_phase
      
  //run_phase
  //---------
      
  task fifo_scoreboard:: run_phase (uvm_phase phase);

    fifo_seq_item_mon  expected_transaction;
    fifo_seq_item_mon  actual_transaction;

    forever begin: forever_blk
      fork
        expected_transactions_fifo.get( expected_transaction );
        actual_transactions_fifo.get(	actual_transaction 	 );
      join
      if ( ! expected_transaction.compare(actual_transaction) ) begin
        `uvm_error( this.get_type_name(), $sformatf( "MISMATCH:: expected_transaction: %s - actual_transaction: %s",
                    								 expected_transaction.convert2string(), actual_transaction.convert2string() ) )  
        mismatch_count++;
      end
    end: forever_blk
    
  endtask: run_phase      
      
  //check_phase
  //-----------
      
  //check that no unaccounted-for data remain in the FIFOs
    
  function void fifo_scoreboard:: check_phase (uvm_phase phase);
    
    fifo_seq_item_mon item;

    if ( actual_transactions_fifo.try_get( item ) ) begin
      `uvm_error( "actual_transactions_fifo", $sformatf("Found a leftover transaction: %s", item.convert2string() ) )
      leftovers_count++;
    end

    if ( expected_transactions_fifo.try_get( item ) ) begin
      `uvm_error( "expected_transactions_fifo", $sformatf("Found a leftover transaction: %s", item.convert2string() ) )
      leftovers_count++;
    end

  endfunction: check_phase

  //report_phase
  //------------
      
  function void fifo_scoreboard:: report_phase (uvm_phase phase);
    if( mismatch_count == 0) begin 
      `uvm_info("SCOREBOARD RESULTS", $sformatf("Mismatches:: PASS; no mismatches") , UVM_NONE)
    end
    else begin
      `uvm_error("SCOREBOARD RESULTS", $sformatf("Mismatches:: ERROR; number of mismatches: %0d", mismatch_count))
    end

    if( leftovers_count == 0) begin 
      `uvm_info("SCOREBOARD RESULTS", $sformatf("Leftovers:: PASS; no leftovers") , UVM_NONE)
    end
    else begin
      `uvm_error("SCOREBOARD RESULTS", $sformatf("Leftovers:: ERROR; number of leftovers (at least): %0d", leftovers_count) )
    end

  endfunction: report_phase

`endif //FIFO_SCOREBOARD_SV