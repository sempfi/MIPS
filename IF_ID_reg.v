`timescale 1ns / 1ps

module IF_ID_reg (
	input clk,
	input [31:0] next_pc,
	input [31:0] instruction,
	input hit,
	output reg [31:0] next_pc_out,
	output reg [31:0] instruction_out
   );
	
	always @(negedge clk) begin
		if (hit == 1'b1) begin
			next_pc_out <= next_pc;
			instruction_out <= instruction;
		end
	end
	
endmodule
