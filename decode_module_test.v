`timescale 1ns / 1ps

module decode_module_test;

	// Inputs
	reg clk;
	reg [31:0] instruction;

	// Outputs
	wire [5:0] opcode;
	wire [31:0] read_data_1;
	wire [31:0] read_data_2;
	wire [31:0] sign_extended_immediate;
	wire [4:0] rt;
	wire [4:0] rd;

	// Instantiate the Unit Under Test (UUT)
	decode_module uut (
		.clk(clk), 
		.instruction(instruction), 
		.opcode(opcode), 
		.read_data_1(read_data_1), 
		.read_data_2(read_data_2), 
		.sign_extended_immediate(sign_extended_immediate), 
		.rt(rt), 
		.rd(rd)
	);

	initial begin
		clk = 0;
		instruction = 32'h00000004;
		#50;
		clk = 1;
		#50;
		clk = 0;
	end
      
endmodule

