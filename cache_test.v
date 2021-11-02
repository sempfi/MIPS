`timescale 1ns / 1ps

module cache_test;

	// Inputs
	reg [127:0] dataline;
	reg [31:0] address;
	reg clk;

	// Outputs
	wire hit;
	wire [31:0] instruction;

	// Instantiate the Unit Under Test (UUT)
	cache uut (
		.dataline(dataline), 
		.address(address), 
		.clk(clk), 
		.hit(hit), 
		.instruction(instruction)
	);

	initial begin
		address = 32'h00000000;
		clk = 0;
		#50
		clk = 1;
		#50
		clk = 0;
		#50
		clk = 1;
		#50
		clk = 0;
		#50
		clk = 1;
		#50
		clk = 0;
		#50
		clk = 1;
		#50
		clk = 0;
		#50
		clk = 1;
		dataline = 128'hafaeadacabaaa9a8a7a6a5a4a3a2a1a0;
		#50;
		clk = 0;
		#50;
		clk = 1;
	end
      
endmodule

