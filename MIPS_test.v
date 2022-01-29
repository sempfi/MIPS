`timescale 1ns / 1ps

module MIPS_test;

	// Inputs
	reg clk;
	reg [31:0] branch_target;

	// Outputs
	wire [31:0] write_data_out_write_back;

	// Instantiate the Unit Under Test (UUT)
	MIPS uut (
		.clk(clk), 
		.branch_target(branch_target),
		.write_data_out_write_back(write_data_out_write_back)
	);
	
	always #10 clk=~clk; 

	initial begin
		clk = 0;
		branch_target = 32'h00000004;
	end
      
endmodule

