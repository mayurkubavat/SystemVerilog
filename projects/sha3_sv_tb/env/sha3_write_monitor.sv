class sha3_write_monitor;

	virtual sha3_if.WR_MON wrmon_if;
	
	mailbox #(sha3_transaction) gen2rm;
	
	sha3_transaction trans_h;
	sha3_transaction send_h;
	
	function new(	virtual sha3_if.WR_MON wrmon_if,
					mailbox #(sha3_transaction) gen2rm);
		this.wrmon_if = wrmon_if;
		this.gen2rm = gen2rm;
	endfunction
	
	virtual task monitor();
		@(wrmon_if.wrmon_cb);
		trans_h.reset = wrmon_if.reset;
		trans_h.in = wrmon_if.in;
		trans_h.byte_num = wrmon_if.byte_num;
		trans_h.in_ready = wrmon_if.in_ready;
		trans_h.is_last = wrmon_if.is_last;
	endtask
	
	virtual task start();
		fork
			forever
			begin
				monitor();
				send_h = new trans_h;
				gen2rm.put(send_h);
			end
		join_none

endclass: sha3_write_monitor