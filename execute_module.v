`timescale 1ns / 1ps

module execute_module (
   input clk,
	input [31:0] alu_read_data_1,
	input [31:0] alu_read_data_2,
	input [31:0] immediate,
	input [5:0] funct,
	input [2:0] alu_op,
	input [2:0] type,
	input alu_src,
	output [31:0] alu_result,
	output beq_flag,
	output bgt_flag,
	output bge_flag,
	output blt_flag,
	output ble_flag,
	output bne_flag
	);
	
	wire [3:0] alu_cnt;
	wire [31:0] input2;
	wire [4:0] shamt;
	assign shamt = immediate[10:6];
	
	alu_control execute_alu_control (
		.alu_op(alu_op),
		.type(type),
		.funct(funct),
		.alu_cnt(alu_cnt)
   );
	 
	MUX_32bits execute_mux (
		.in_0(alu_read_data_2), 
		.in_1(immediate), 
		.select_line(alu_src), 
		.out(input2)
   );

	alu execute_alu (
		.alu_cnt(alu_cnt), 
		.input1(alu_read_data_1), 
		.input2(input2), 
		.shamt(shamt), 
		.result(alu_result), 
		.beq_flag(beq_flag),
		.bgt_flag(bgt_flag),
		.bge_flag(bge_flag),
		.blt_flag(blt_flag),
		.ble_flag(ble_flag),
		.bne_flag(bne_flag)
   );

endmodule
