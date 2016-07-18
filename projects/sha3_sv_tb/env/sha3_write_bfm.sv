class sha3_write_bfm;

	virtual sha3_if.WR_BFM wr_if;
	
	mailbox #(sha3_transaction) gen2wrbfm;
	
	sha3_transaction trans_h;
	
	function new(	virtual sha3_if.WR_BFM wr_if,
					mailbox #(sha3_transaction) gen2wrbfm);
		this.wr_if = wr_if;
		this.gen2wrbfm = gen2wrbfm;
		trans_h = new();
	endfunction
	
	virtual task drive();
		@(wr_if.wrbfm_cb);
		wr_if.reset <= trans_h.reset;
		wr_if.in <= trans_h.in;
		wr_if.byte_num <= trans_h.byte_num;
		wr_if.in_ready <= trans_h.in_ready;
		wr_if.is_last <= is_last;
	endtask
	
	virtual task start();
		fork
			forever
			begin
				gen2wrbfm.get(trans_h);
				drive();
			end
		join_none
	endtask
	
endclass: sha3_write_bfm