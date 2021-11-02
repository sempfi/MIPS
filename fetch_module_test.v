`timescale 1ns / 1ps

module fetch_module_test #(parameter PERIOD=20);

	// Inputs
	reg [31:0] branch_target;
	reg clk;
	reg pc_src;

	// Outputs
	wire [31:0] instruction;
	wire [31:0] pc;
	wire hit;

	// Instantiate the Unit Under Test (UUT)
	fetch_module uut (
		.branch_target(branch_target), 
		.clk(clk), 
		.pc_src(pc_src), 
		.instruction(instruction), 
		.pc(pc), 
		.hit(hit)
	);

	always #PERIOD clk=~clk; 

	initial begin
		clk = 0;
		branch_target = 32'h00000000;
		pc_src = 0;
	end
      
endmodule

