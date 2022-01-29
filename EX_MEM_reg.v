`timescale 1ns / 1ps

module EX_MEM_reg (
   input clk,
	input hit,
	input beq_flag,
	input bgt_flag,
	input bge_flag,
	input blt_flag,
	input ble_flag,
	input bne_flag,
	input [31:0] branch_target,
	input [31:0] alu_result,
	input [31:0] read_data_2,
	input [ 2:0] type,
	input [ 4:0] write_reg,
	input mem_to_reg,
	input reg_write, 
	input mem_read, 
	input mem_write, 
	input branch,
	input jump,
	output reg beq_flag_out,
	output reg bgt_flag_out,
	output reg bge_flag_out,
	output reg blt_flag_out,
	output reg ble_flag_out,
	output reg bne_flag_out,
	output reg [31:0] branch_target_out,
	output reg [31:0] alu_result_out,
	output reg [31:0] read_data_2_out,
	output reg [ 2:0] type_out,
	output reg [ 4:0] write_reg_out,
	output reg mem_to_reg_out,
	output reg reg_write_out, 
	output reg mem_read_out, 
	output reg mem_write_out, 
	output reg branch_out,
	output reg jump_out
	);
	
	always @(negedge clk) begin
		if (hit == 1'b1) begin
			branch_target_out <= branch_target;
			beq_flag_out <= beq_flag;
			bgt_flag_out <= bgt_flag;
			bge_flag_out <= bge_flag;
			blt_flag_out <= blt_flag;
			ble_flag_out <= ble_flag;
			bne_flag_out <= bne_flag;
			alu_result_out <= alu_result;
			type_out <= type;
			read_data_2_out <= read_data_2;
			write_reg_out <= write_reg;
			mem_to_reg_out <= mem_to_reg; 
			reg_write_out <= reg_write;
			mem_read_out <= mem_read;  
			mem_write_out <= mem_write;
			branch_out <= branch;
			jump_out <= jump;
		end
	end

endmodule
