package sha3_pkg;

	int number_of_transaction;
	
	`include "sha3_transaction.sv"
	`include "sha3_generator.sv"
	`include "sha3_write_bfm.sv"
	`include "sha3_write_monitor.sv"
	`include "sha3_read_monitor.sv"
	`include "sha3_model.sv"
	`include "sha3_scoreboard.sv"
	`include "sha3_environment.sv"
	
endpackage: sha3_pkg