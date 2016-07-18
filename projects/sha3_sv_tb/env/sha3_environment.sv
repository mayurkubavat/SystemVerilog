class sha3_environment;

	virtual sha3_if.WR_BFM wr_if;
	virtual sha3_if.WR_MON wrmon_if;
	virtual sha3_if.RD_MON rdmon_if;
	
	sha3_generator gen;
	sha3_write_bfm wr_bfm;
	sha3_write_monitor wr_mon;
	sha3_read_monitor rd_mon;
	sha3_model model;
	sha3_scoreboard sb;
	
	mailbox #(sha3_transaction) gen2wr = new();
	mailbox #(sha3_transaction) wrmon2rm = new();
	mailbox #(sha3_transaction) rm2sb = new();
	mailbox #(sha3_transaction) rdmon2sb = new();
	
	function new(	virtual sha3_if.WR_BFM wr_if,
					virtual sha3_if.WR_MON wrmon_if,
					virtual sha3_if.RD_MON rdmon_if);
		this.wr_if = wr_if;
		this.wrmon_if = wrmon_if;
		this.rdmon_if = rdmon_if;
	endfunction
	
	virtual task build();
		gen = new();
		wr_bfm = new();
		wr_mon = new();
		rd_mon = new();
		model = new();
		sb = new();
	endtask
	
	virtual task start();
		gen.start();
		wr_bfm.start();
		wr_mon.start();
		rd_mon.start();
		model.start();
		sb.start();
	endtask
	
	virtual task stop();
		wait(sb.DONE.triggered);
	endtask: stop
	
	virtual task run();
		start();
		stop();
		sb.report();
	endtask
	
endclass: sha3_environment