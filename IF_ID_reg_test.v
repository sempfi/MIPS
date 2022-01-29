`timescale 1ns / 1ps

module IF_ID_reg_test #(parameter PERIOD=100);

	// Inputs
	reg clk;
	reg [31:0] next_pc;
	reg [31:0] instruction;
	reg hit;

	// Outputs
	wire [31:0] next_pc_out;
	wire [31:0] instruction_out;
	wire hit_out;

	// Instantiate the Unit Under Test (UUT)
	IF_ID_reg uut (
		.clk(clk), 
		.next_pc(next_pc), 
		.instruction(instruction), 
		.hit(hit), 
		.next_pc_out(next_pc_out), 
		.instruction_out(instruction_out), 
		.hit_out(hit_out)
	);
	
	always #PERIOD clk=~clk; 

	initial begin
		clk = 1;
		
		next_pc = 32'h0;
		instruction = 32'h00000010;
		hit = 0;
		#PERIOD;

	end
      
endmodule

