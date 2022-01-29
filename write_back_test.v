`timescale 1ns / 1ps

module write_back_test;

	// Inputs
	reg mem_to_reg;
	reg [31:0] read_data;
	reg [31:0] alu_result;

	// Outputs
	wire [31:0] write_data;

	// Instantiate the Unit Under Test (UUT)
	write_back uut (
		.mem_to_reg(mem_to_reg), 
		.read_data(read_data), 
		.alu_result(alu_result), 
		.write_data(write_data)
	);

	initial begin
		mem_to_reg = 1'b0;
		#1;
		read_data = 32'h00000000;
		alu_result = 32'h00000001;
		#100;
		
		mem_to_reg = 1'b1;
		read_data = 32'h00000000;
		alu_result = 32'h00000001;
	end
      
endmodule

