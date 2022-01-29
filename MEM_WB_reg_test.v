`timescale 1ns / 1ps

module MEM_WB_reg_test;

	// Inputs
	reg clk;
	reg hit;
	reg [31:0] read_data;
	reg [31:0] alu_result;
	reg [4:0] write_reg;
	reg reg_write;
	reg mem_to_reg;

	// Outputs
	wire [31:0] read_data_out;
	wire [31:0] alu_result_out;
	wire [4:0] write_reg_out;
	wire reg_write_out;
	wire mem_to_reg_out;

	// Instantiate the Unit Under Test (UUT)
	MEM_WB_reg uut (
		.clk(clk), 
		.hit(hit), 
		.read_data(read_data), 
		.alu_result(alu_result), 
		.write_reg(write_reg), 
		.reg_write(reg_write), 
		.mem_to_reg(mem_to_reg), 
		.read_data_out(read_data_out), 
		.alu_result_out(alu_result_out), 
		.write_reg_out(write_reg_out), 
		.reg_write_out(reg_write_out), 
		.mem_to_reg_out(mem_to_reg_out)
	);

	initial begin
		clk = 1;
		hit = 1'b1;
		read_data = 32'h11223344;
		alu_result = 32'h00000000;
		write_reg = 5'b00110;
		reg_write = 1'b1;
		mem_to_reg = 1'b0;
		#100;
		clk = 0;
	end
      
endmodule

