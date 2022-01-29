`timescale 1ns / 1ps

module fetch_module (
	input [31:0] branch_target,
	input [31:0] jump_target,
	input clk,
	input pc_src,
	output reg [31:0] instruction,
	output [31:0] pc,
	output reg hit
   );
	
	wire [127:0] dataline_wire;
	wire [ 31:0] address;
	wire [ 31:0] loaded_address;
	wire [ 31:0] instruction_wire;
	wire         hit_wire;
		
	initial hit = 1'b1;
	
	MUX_32bits fetch_branch_MUX (
		.in_0(branch_target), 
		.in_1(jump_target), 
		.select_line(pc_src), 
		.out(address)
	);
	
	pc_reg fetch_pc_reg (
		.next_inst_address(address), 
		.clk(clk), 
		.hit(hit), 
		.inst_address(loaded_address)
	);
	
	cache fetch_cache (
		.dataline(dataline_wire), 
		.address(loaded_address), 
		.clk(clk), 
		.hit(hit_wire), 
		.instruction(instruction_wire)
	);
	
	inst_mem fetch_instruction_memory (
		.address(loaded_address), 
		.clk(clk), 
		.dataline(dataline_wire)
	);
	
	assign pc = loaded_address + 4;
	always @(hit_wire) hit <= hit_wire;
	always @(instruction_wire) instruction <= instruction_wire;
	
endmodule
