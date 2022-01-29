`timescale 1ns / 1ps

module execute_module_test #(parameter PERIOD=50);

	// Inputs
	reg clk;
	reg [31:0] alu_read_data_1;
	reg [31:0] alu_read_data_2;
	reg [31:0] immediate;
	reg [5:0] funct;
	reg [2:0] alu_op;
	reg alu_src;

	// Outputs
	wire [31:0] alu_result;
	wire zero;

	// Instantiate the Unit Under Test (UUT)
	execute_module uut (
		.clk(clk), 
		.alu_read_data_1(alu_read_data_1), 
		.alu_read_data_2(alu_read_data_2), 
		.immediate(immediate), 
		.funct(funct), 
		.alu_op(alu_op), 
		.alu_src(alu_src), 
		.alu_result(alu_result), 
		.zero(zero)
	);
	
	always #PERIOD clk=~clk; 

	initial begin
		clk = 0;
		
		alu_read_data_1 = 32'h00000000;
		alu_read_data_2 = 32'h00000001;
		immediate = 32'h00000002;
		funct = 6'b000000;
		alu_op = 3'b000;
		alu_src = 0;
		#PERIOD;
		
		alu_read_data_1 = 32'h00000000;
		alu_read_data_2 = 32'h00000001;
		immediate = 32'h00000002;
		funct = 6'b000000;
		alu_op = 3'b000;
		alu_src = 1;
		#PERIOD;
		
	end
      
endmodule

