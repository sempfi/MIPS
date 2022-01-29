`timescale 1ns / 1ps

module alu_coontrol_test;

	// Inputs
	reg [2:0] alu_op;
	reg [5:0] funct;

	// Outputs
	wire [3:0] alu_cnt;

	// Instantiate the Unit Under Test (UUT)
	alu_control uut (
		.alu_op(alu_op), 
		.funct(funct), 
		.alu_cnt(alu_cnt)
	);

	initial begin
		alu_op = 3'b000;
		funct = 6'b000000;
		#100;
		
		alu_op = 3'b000;
		funct = 6'b000001;
		#100;
		
		alu_op = 3'b011;
		funct = 6'bX;
		#100;
	end
      
endmodule

