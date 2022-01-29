`timescale 1ns / 1ps

module alu_test;

	// Inputs
	reg [3:0] alu_cnt;
	reg [31:0] input1;
	reg [31:0] input2;
	reg [4:0] shamt;

	// Outputs
	wire [31:0] result;
	wire zero;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.alu_cnt(alu_cnt), 
		.input1(input1), 
		.input2(input2), 
		.shamt(shamt), 
		.result(result), 
		.zero(zero)
	);

	initial begin
		alu_cnt = 4'b0000;
		input1 = 32'h00000000;
		input2 = 32'h00000001;
		shamt = 5'b00000;
		#100;
		
		alu_cnt = 4'b0011;
		input1 = 32'h00000001;
		input2 = 32'h00000001;
		shamt = 5'b00001;
		#100;
		
		alu_cnt = 4'b0101;
		input1 = 32'h00000000;
		input2 = 32'h11111111;
		shamt = 5'b00000;
		#100;
	end
      
endmodule

