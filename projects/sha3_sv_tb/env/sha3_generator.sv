class sha3_generator;

	mailbox #(sha3_transaction) gen2wrbfm;
	
	sha3_transaction trans_h;
	sha3_transaction send_h;
	
	function new(mailbox #(sha3_transaction) gen2wrbfm);
		this.gen2wrbfm = gen2wrbfm;
		trans_h = new();
	endfunction
	
	virtual task start();
		fork
			for(int i; i < no_of_transaction; i++)
			begin	
				trans_h.trans_id++;
				assert(trans_h.randomize());
				send_h = new trans_h;
				gen2wrbfm.put(send_h);
			end
		join_none
	endtask

endclass: sha3_generator