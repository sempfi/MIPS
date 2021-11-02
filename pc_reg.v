`timescale 1ns / 1ps

module pc_reg (
	input [31:0] next_inst_address,
	input clk,
	input hit,
	output reg [31:0] inst_address
	);
	
	always @(negedge clk) begin
		if (hit == 1'b0) begin end
		else #0.001 inst_address = next_inst_address;
	end

endmodule
