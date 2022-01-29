`timescale 1ns / 1ps

module reg_file_test;

	// Inputs
	reg clk;
	reg RegWrite;
	reg [4:0] read_reg_1;
	reg [4:0] read_reg_2;
	reg [4:0] write_reg;
	reg [31:0] write_data;

	// Outputs
	wire [31:0] read_data_1;
	wire [31:0] read_data_2;

	// Instantiate the Unit Under Test (UUT)
	reg_file uut (
		.clk(clk), 
		.RegWrite(RegWrite), 
		.read_reg_1(read_reg_1), 
		.read_reg_2(read_reg_2), 
		.write_reg(write_reg), 
		.write_data(write_data), 
		.read_data_1(read_data_1), 
		.read_data_2(read_data_2)
	);

	initial begin
		
		// Writing to zero register.
		clk = 0;
		RegWrite = 1;
		read_reg_1 = 0;
		read_reg_2 = 0;
		write_reg = 0;
		write_data = 32'hAAAAAAAA;
		#100;
		clk = 1;
		#100;
		
		// Writing to register number #1, and reading register number #1 and #2. 
		clk = 0;
		RegWrite = 1;
		read_reg_1 = 5'b00001;
		read_reg_2 = 5'b00010;
		write_reg = 5'b00001;
		write_data = 32'hAAAAAAAA;
		#100;
		clk = 1;
		#100;
        

	end
      
endmodule

