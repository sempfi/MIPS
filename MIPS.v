`timescale 1ns / 1ps

module MIPS (
	input         clk,
	input  [31:0] branch_target,
	output [31:0] write_data_out_write_back
	);
	
	
	// Fetch unit wires.
	reg [31:0] branch_target_in_fetch;
	wire hit;
	wire [31:0] instruction_out_fetch;
	wire [31:0] pc_out_fetch;
	reg pc_src_reg;
	initial pc_src_reg = 1'b0;
	always @(pc_out_fetch) branch_target_in_fetch = pc_out_fetch;
	always @(branch_target) branch_target_in_fetch = branch_target;
	always @(pc_src) pc_src_reg = pc_src;
	
	
	// IF/ID register wires.
	wire [31:0] instruction_out_IF_ID;
	wire [31:0] pc_out_IF_ID;
	
	
	// Decode unit wires.
	wire [31:0] immediate_out_decode;
	wire [31:0] read_data_1_out_decode;
	wire [31:0] read_data_2_out_decode;
	wire [31:0] jump_address_extended_out_decode;
	wire [ 4:0] rt_out_decode;
	wire [ 4:0] rd_out_decode;
	wire [ 5:0] opcode_out_decode;
	
	
	// Control unit wires.
	wire reg_dst_out_control;
	wire alu_src_out_control;
	wire mem_to_reg_out_control;
	wire reg_write_out_control;
	wire mem_read_out_control;
	wire mem_write_out_control;
	wire branch_out_control;
	wire jump_out_control;
	wire [2:0] alu_op_out_control;
	wire [2:0] type_out_control;


	// ID/EX register wires.
	wire reg_dst_out_ID_EX;
	wire alu_src_out_ID_EX;
	wire mem_to_reg_out_ID_EX;
	wire reg_write_out_ID_EX;
	wire mem_read_out_ID_EX;
	wire mem_write_out_ID_EX;
	wire branch_out_ID_EX;
	wire jump_out_ID_EX;
	wire [31:0] read_data_1_out_ID_EX;
	wire [31:0] read_data_2_out_ID_EX;
	wire [31:0] immediate_out_ID_EX;
	wire [31:0] pc_out_ID_EX;
	wire [31:0] jump_address_extended_out_ID_EX;
	wire [ 2:0] alu_op_out_ID_EX;
	wire [ 4:0] rt_out_ID_EX;
	wire [ 4:0] rd_out_ID_EX;
	wire [ 5:0] funct_in_ID_EX;
	wire [ 5:0] funct_out_ID_EX;
	wire [ 2:0] type_out_ID_EX;

	
	// Execute unit wires.
	wire beq_flag_out_execute;
	wire bgt_flag_out_execute;
	wire bge_flag_out_execute;
	wire blt_flag_out_execute;
	wire ble_flag_out_execute;
	wire bne_flag_out_execute;
	wire [31:0] alu_result_out_execute;

	
	// EX/MEM register wires.
	wire [31:0] branch_target_in_EX_MEM;
	wire [31:0] branch_jump_target_in_EX_MEM;
	wire [31:0] branch_target_out_EX_MEM;
	wire [31:0] alu_result_out_EX_MEM;
	wire [2:0] type_out_EX_MEM;
	wire [31:0] read_data_2_out_EX_MEM;
	wire [ 4:0] write_reg_in_EX_MEM;
	wire [ 4:0] write_reg_out_EX_MEM;
	wire mem_to_reg_out_EX_MEM;
	wire reg_write_out_EX_MEM;
	wire mem_read_out_EX_MEM;
	wire mem_write_out_EX_MEM;
	wire branch_out_EX_MEM;
	wire pc_src;
	wire beq_flag_out_EX_MEM;
	wire bgt_flag_out_EX_MEM;
	wire bge_flag_out_EX_MEM;
	wire blt_flag_out_EX_MEM;
	wire ble_flag_out_EX_MEM;
	wire bne_flag_out_EX_MEM;


	// Branch or jump identifiers.
	wire branch_jump;	
	wire branch_inst_flag_out_EX_MEM;


	// Data Memory
	wire [31:0] read_data_out_data_memory;
	wire [31:0] read_data_out_MEM_WB;
	wire [31:0] alu_result_out_MEM_WB;
	wire [ 4:0] write_reg_out_MEM_WB;
	wire reg_write_out_MEM_WB;
	wire mem_to_reg_out_MEM_WB;

	// wire [31:0] write_data_out_write_back;
	
	
	fetch_module MIPS_fetch (
		.branch_target(branch_target),
		.jump_target(branch_target_out_EX_MEM),
		.pc_src(pc_src_reg),
		.clk(clk), 
		.instruction(instruction_out_fetch), 
		.pc(pc_out_fetch), 
		.hit(hit)
	);
	
	IF_ID_reg MIPS_IF_ID_reg (
		.clk(clk), 
		.next_pc(pc_out_fetch), 
		.instruction(instruction_out_fetch), 
		.hit(hit), 
		.next_pc_out(pc_out_IF_ID), 
		.instruction_out(instruction_out_IF_ID)
	);
	 
	
	decode_module MIPS_decode (
		.clk(clk), 
		.instruction(instruction_out_IF_ID),
		.next_pc(pc_out_IF_ID),
		.reg_write(reg_write_out_MEM_WB), 
		.write_reg(write_reg_out_MEM_WB), 
		.write_data(write_data_out_write_back), 
		.opcode(opcode_out_decode), 
		.read_data_1(read_data_1_out_decode), 
		.read_data_2(read_data_2_out_decode), 
		.sign_extended_immediate(immediate_out_decode),
		.jump_address_extended(jump_address_extended_out_decode),
		.rt(rt_out_decode), 
		.rd(rd_out_decode)
   );
	assign funct_in_ID_EX = immediate_out_decode[5:0];


	control_unit MIPS_control (
		.opcode(opcode_out_decode), 
		.reg_dst(reg_dst_out_control), 
		.alu_src(alu_src_out_control), 
		.mem_to_reg(mem_to_reg_out_control), 
		.reg_write(reg_write_out_control), 
		.mem_read(mem_read_out_control), 
		.mem_write(mem_write_out_control), 
		.branch(branch_out_control), 
		.alu_op(alu_op_out_control),
		.type(type_out_control),
		.jump(jump_out_control)
   );
	
	ID_EX_reg MIPS_ID_EX_reg (
		.clk(clk), 
		.hit(hit), 
		.read_data_1(read_data_1_out_decode), 
		.read_data_2(read_data_2_out_decode), 
		.immeadiate(immediate_out_decode), 
		.reg_dst(reg_dst_out_control), 
		.alu_src(alu_src_out_control), 
		.mem_to_reg(mem_to_reg_out_control), 
		.reg_write(reg_write_out_control), 
		.mem_read(mem_read_out_control), 
		.mem_write(mem_write_out_control), 
		.branch(branch_out_control), 
		.alu_op(alu_op_out_control),
		.type(type_out_control),
		.jump(jump_out_control),
		.jump_address_extended(jump_address_extended_out_decode),
		.rt(rt_out_decode), 
		.rd(rd_out_decode), 
		.funct(funct_in_ID_EX), 
		.next_pc(pc_out_IF_ID), 
		.read_data_1_out(read_data_1_out_ID_EX), 
		.read_data_2_out(read_data_2_out_ID_EX), 
		.immeadiate_out(immediate_out_ID_EX),
		.reg_dst_out(reg_dst_out_ID_EX), 
		.alu_src_out(alu_src_out_ID_EX),
		.mem_to_reg_out(mem_to_reg_out_ID_EX), 
		.reg_write_out(reg_write_out_ID_EX), 
		.mem_read_out(mem_read_out_ID_EX), 
		.mem_write_out(mem_write_out_ID_EX), 
		.branch_out(branch_out_ID_EX), 
		.alu_op_out(alu_op_out_ID_EX),
		.type_out(type_out_ID_EX),
		.jump_out(jump_out_ID_EX),
		.jump_address_extended_out(jump_address_extended_out_ID_EX),
		.rt_out(rt_out_ID_EX), 
		.rd_out(rd_out_ID_EX), 
		.funct_out(funct_out_ID_EX), 
		.next_pc_out(pc_out_ID_EX)
   );
	  
	execute_module MIPS_execute (
		.clk(clk), 
		.alu_read_data_1(read_data_1_out_ID_EX), 
		.alu_read_data_2(read_data_2_out_ID_EX), 
		.immediate(immediate_out_ID_EX), 
		.funct(funct_out_ID_EX), 
		.alu_op(alu_op_out_ID_EX),
		.type(type_out_ID_EX),
		.alu_src(alu_src_out_ID_EX), 
		.alu_result(alu_result_out_execute), 
		.beq_flag(beq_flag_out_execute),
		.bgt_flag(bgt_flag_out_execute),
		.bge_flag(bge_flag_out_execute),
		.blt_flag(blt_flag_out_execute),
		.ble_flag(ble_flag_out_execute),
		.bne_flag(bne_flag_out_execute)
   );
	 
	
	wire [31:0] data_reg_write;
	assign branch_target_in_EX_MEM = pc_out_ID_EX + (immediate_out_ID_EX << 2);
	assign branch_jump_target_in_EX_MEM = (jump_out_ID_EX == 1'b1) ? jump_address_extended_out_ID_EX : branch_target_in_EX_MEM;
	assign write_reg_in_EX_MEM = (jump_out_ID_EX == 1'b1 && reg_write_out_ID_EX == 1'b1) ? 5'b11111 : 
										  ((reg_dst_out_ID_EX == 1'b1) ? rd_out_ID_EX : rt_out_ID_EX);
	assign data_reg_write = (jump_out_ID_EX == 1'b1 && reg_write_out_ID_EX == 1'b1) ? pc_out_ID_EX : alu_result_out_execute;
									  
	EX_MEM_reg MIPS_EX_MEM_reg (
		.clk(clk), 
		.hit(hit), 
		.branch_target(branch_jump_target_in_EX_MEM), 
		.beq_flag(beq_flag_out_execute),
		.bgt_flag(bgt_flag_out_execute),
		.bge_flag(bge_flag_out_execute),
		.blt_flag(blt_flag_out_execute),
		.ble_flag(ble_flag_out_execute),
		.bne_flag(bne_flag_out_execute),
		.alu_result(data_reg_write),
		.type(type_out_ID_EX),
		.read_data_2(read_data_2_out_ID_EX), 
		.write_reg(write_reg_in_EX_MEM), 
		.mem_to_reg(mem_to_reg_out_ID_EX), 
		.reg_write(reg_write_out_ID_EX), 
		.mem_read(mem_read_out_ID_EX), 
		.mem_write(mem_write_out_ID_EX), 
		.branch(branch_out_ID_EX),
		.jump(jump_out_ID_EX),
		.branch_target_out(branch_target_out_EX_MEM), 
		.beq_flag_out(beq_flag_out_EX_MEM),
		.bgt_flag_out(bgt_flag_out_EX_MEM),
		.bge_flag_out(bge_flag_out_EX_MEM),
		.blt_flag_out(blt_flag_out_EX_MEM),
		.ble_flag_out(ble_flag_out_EX_MEM),
		.bne_flag_out(bne_flag_out_EX_MEM),
		.alu_result_out(alu_result_out_EX_MEM),
		.type_out(type_out_EX_MEM),
		.read_data_2_out(read_data_2_out_EX_MEM), 
		.write_reg_out(write_reg_out_EX_MEM), 
		.mem_to_reg_out(mem_to_reg_out_EX_MEM), 
		.reg_write_out(reg_write_out_EX_MEM), 
		.mem_read_out(mem_read_out_EX_MEM), 
		.mem_write_out(mem_write_out_EX_MEM), 
		.branch_out(branch_out_EX_MEM),
		.jump_out(jump_out_EX_MEM)
	);
	 
	MUX_3_8 MIPS_select_flag_MUX (
		.in_0(beq_flag_out_EX_MEM), 
		.in_1(bgt_flag_out_EX_MEM), 
		.in_2(bge_flag_out_EX_MEM), 
		.in_3(blt_flag_out_EX_MEM), 
		.in_4(ble_flag_out_EX_MEM), 
		.in_5(bne_flag_out_EX_MEM), 
		.in_6(1'b0), 
		.in_7(1'b0), 
		.select_lines(type_out_EX_MEM), 
		.out(branch_inst_flag_out_EX_MEM)
   );
	
	assign branch_jump = (jump_out_EX_MEM == 1'b1) ? 1'b1 : (branch_out_EX_MEM & branch_inst_flag_out_EX_MEM);
	assign pc_src = branch_out_EX_MEM & branch_inst_flag_out_EX_MEM;


	data_memory MIPS_data_memory (
		.clk(clk), 
		.address(alu_result_out_EX_MEM), 
		.write_data(read_data_2_out_EX_MEM),
		.mem_read(mem_read_out_EX_MEM),
		.mem_write(mem_write_out_EX_MEM),
		.read_data(read_data_out_data_memory)
   );
	
	MEM_WB_reg MIPS_MEM_WB_reg (
		.clk(clk), 
		.hit(hit), 
		.read_data(read_data_out_data_memory), 
		.alu_result(alu_result_out_EX_MEM), 
		.write_reg(write_reg_out_EX_MEM), 
		.reg_write(reg_write_out_EX_MEM), 
		.mem_to_reg(mem_to_reg_out_EX_MEM), 
		.read_data_out(read_data_out_MEM_WB), 
		.alu_result_out(alu_result_out_MEM_WB), 
		.write_reg_out(write_reg_out_MEM_WB), 
		.reg_write_out(reg_write_out_MEM_WB), 
		.mem_to_reg_out(mem_to_reg_out_MEM_WB)
   );
	
	write_back MIPS_write_back (
		.mem_to_reg(mem_to_reg_out_MEM_WB), 
		.read_data(read_data_out_MEM_WB), 
		.alu_result(alu_result_out_MEM_WB), 
		.write_data(write_data_out_write_back)
   );

endmodule
