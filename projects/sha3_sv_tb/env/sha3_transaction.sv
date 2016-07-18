class sha3_transaction;

	rand logic reset;
	rand logic [31:0] in;
	rand logic [1:0] byte_num;
	rand logic in_ready;
	rand logic is_last;
	
	logic buffer_full;
	logic [511:0] out;
	logic out_ready;
	
	static int trans_id;
	static int no_of_message;
	
	constraint r1{reset dist {1:=1, 0:=100};}
	constraint b_n{if(is_last) -> byte_num == (in.size()%4);}
	constraint i_r{in_ready dist {0:=50, 1:=1};}
	
	function void post_randomize();
		if(is_last)
			no_of_message++;
		this.display("\tRANDOMIZED DATA");
	endfunction
	
	function void display(string message);
		$display("--------------------------------------");
		$display("\tTransaction No. %0d", trans_id);
		$display("\treset = %b\n\tin = %0h\n\tbyte_num = %0d\n\tin_ready = %b\n\tis_last = %b",reset , in, byte_num, in_ready, is_last);
		$display("\t----------------");
		$display("\tbuffer_full = %b\n\tout = %0h\n\tout_ready = %b", buffer_full, out, out_ready);
		$display("--------------------------------------");
	endfunction

endclass: sha3_transaction