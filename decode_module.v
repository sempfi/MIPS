`timescale 1ns / 1ps

module decode_module (
   input clk,
	input [31:0] instruction,
	input [31:0] next_pc,
	input reg_write,
	input [4:0] write_reg,
	input [31:0] write_data,
	output reg [5:0] opcode,
	output [31:0] read_data_1,
	output [31:0] read_data_2,
	output [31:0] sign_extended_immediate,
	output reg [4:0] rt,
	output reg [4:0] rd,
	output [31:0] jump_address_extended
	);
	
	reg [15:0] value;														// The imediate value.
	reg [25:0] jump_address;
	reg [4:0] rs;
	
	
	always @(posedge clk) begin
		opcode <= instruction[31:26];
		rs <= instruction[25:21];
		rt <= instruction[20:16];
		rd <= instruction[15:11];
		value <= instruction[15:0];
		jump_address <= instruction[25:0];
	end		
	
	always @(write_reg) rd = reg_write;
	assign jump_address_extended = {next_pc[31:26], jump_address[25:0]};
	
	reg_file decode_reg_file (
    .clk(clk), 
    .RegWrite(reg_write), 
    .read_reg_1(rs), 
    .read_reg_2(rt), 
    .write_reg(rd), 
    .write_data(write_data), 
    .read_data_1(read_data_1), 
    .read_data_2(read_data_2)
    );
	 
	sign_extend decode_sign_extend (
    .value(value), 
    .sign_extended_value(sign_extended_immediate)
    );

endmodule
