interface sha3_if(input logic clock);

	logic reset;
	logic [31:0] in;
	logic [1:0] byte_num;
	logic in_ready;
	logic is_last;
	
	logic buffer_full;
	logic [511:0] out;
	logic out_ready;
	
	clocking wr_cb(@posedge clock);
		output reset;
		output in;
		output byte_num;
		output in_ready;
		output is_last;
	endclocking
	
	clocking wrmon_cb(@posedge clock);
		input reset;
		input in;
		input byte_num;
		input in_ready;
		input is_last;
	endclocking
	
	clocking rdmon_cb(@posedge clock);
		input buffer_full;
		input out_ready;
		input out;
	endclocking
	
	modport WR_BFM(clocking wr_cb);
	
	modport WR_MON(clocking wrmon_cb);
	
	modport RD_MON(clocking rdmon_cb);
	
endinterface: sha3_if