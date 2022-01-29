`timescale 1ns / 1ps

module EX_MEM_reg_test;

	// Inputs
	reg clk;
	reg hit;
	reg [31:0] branch_target;
	reg zero;
	reg [31:0] alu_result;
	reg [31:0] read_data_2;
	reg [4:0] write_reg;
	reg mem_to_reg;
	reg reg_write;
	reg mem_read;
	reg mem_write;
	reg branch;

	// Outputs
	wire [31:0] branch_target_out;
	wire zero_out;
	wire [31:0] alu_result_out;
	wire [31:0] read_data_2_out;
	wire [4:0] write_reg_out;
	wire mem_to_reg_out;
	wire reg_write_out;
	wire mem_read_out;
	wire mem_write_out;
	wire branch_out;

	// Instantiate the Unit Under Test (UUT)
	EX_MEM_reg uut (
		.clk(clk), 
		.hit(hit), 
		.branch_target(branch_target), 
		.zero(zero), 
		.alu_result(alu_result), 
		.read_data_2(read_data_2), 
		.write_reg(write_reg), 
		.mem_to_reg(mem_to_reg), 
		.reg_write(reg_write), 
		.mem_read(mem_read), 
		.mem_write(mem_write), 
		.branch(branch), 
		.branch_target_out(branch_target_out), 
		.zero_out(zero_out), 
		.alu_result_out(alu_result_out), 
		.read_data_2_out(read_data_2_out), 
		.write_reg_out(write_reg_out), 
		.mem_to_reg_out(mem_to_reg_out), 
		.reg_write_out(reg_write_out), 
		.mem_read_out(mem_read_out), 
		.mem_write_out(mem_write_out), 
		.branch_out(branch_out)
	);

	initial begin
		clk = 1;
		hit = 1'b1;
		branch_target = 32'h00000004;
		zero =1'b0;
		alu_result = 32'hAA001122;
		read_data_2 = 32'h00000000;
		write_reg = 5'b01000;
		mem_to_reg = 1'b0;
		reg_write = 1'b1;
		mem_read = 1'b0;
		mem_write = 1'b0;
		branch = 1'b0;
		#100;
		clk = 0;
       
	end
      
endmodule

