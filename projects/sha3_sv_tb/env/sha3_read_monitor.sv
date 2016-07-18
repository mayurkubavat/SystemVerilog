class sha3_read_monitor;

	virtual sha3_if.RD_MON rdmon_if;
	
	mailbox #(sha3_transaction) rdmon2sb;
	
	sha3_transaction trans_h;
	sha3_transaction send_h;
	
	function new(	virtual sha3_if.RD_MON rdmon_if,
					mailbox #(sha3_transaction) rdmon2sb);
		this.rdmon_if = rdmon_if;
		this.rdmon2sb = rdmon2sb;
		trans_h = new();
	endfunction
	
	virtual task monitor();
		@(rdmon_if.rdmon_cb);
			trans_h.buffer_full = rdmon_if.buffer_full;
			trans_h.out_ready = rdmon_if.out_ready;
			trans_h.out = rdmon_if.out;
	endtask
	
	virtual task start();
		fork
			forever
			begin
				monitor();
					if(out_ready)
					begin
						send_h = new trans_h;
						rdmon2sb.put(send_h);
					end
			end
		join_none
	endtask
	
endclass: sha3_read_monitor