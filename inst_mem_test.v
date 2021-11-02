`timescale 1ns / 1ps

module inst_mem_test;

	// Inputs
	reg [31:0] address;
	reg clk;

	// Outputs
	wire [127:0] dataline;

	// Instantiate the Unit Under Test (UUT)
	inst_mem uut (
		.address(address), 
		.clk(clk), 
		.dataline(dataline)
	);

	initial begin
		address = 32'h00000024;
		clk = 0;
		#50;
		clk = 1;
		#50;
		clk = 0;
		#50;
		clk = 1;
		#50;
		clk = 0;
		#50;
		clk = 1;
		#50;
		clk = 0;
		#50;
		clk = 1;
		#50;
		clk = 0;
		#50;
		clk = 1;
		#50;
		clk = 0;
		#50;
		clk = 1;
		#50;
	end
      
endmodule

