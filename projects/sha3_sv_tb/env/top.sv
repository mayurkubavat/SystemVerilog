`include "test.sv"
module top;

	reg clock;
	
	sha3_if intf(clock);
	
	test test_h;
	
	keccak (.clock(clock),
			.reset(intf.reset),
			.in(intf.in),
			.in_ready(intf.in_ready),
			.byte_num(intf.byte_num),
			.is_last(intf.is_last),
			.buffer_full(intf.buffer_full),
			.out_ready(intf.out_ready),
			.out(intf.out)
			);
	
	initial
	begin
		test_h = new(intf, intf, intf);
		test_h.build_and_run();	
	end
	
	initial
	begin
		clock = 0;
		forever #10 clock = ~clock;
	end
	
endmodule