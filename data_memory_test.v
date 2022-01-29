`timescale 1ns / 1ps

module data_memory_test;

	// Inputs
	reg clk;
	reg [31:0] address;
	reg [31:0] write_data;
	reg mem_read;
	reg mem_write;

	// Outputs
	wire [31:0] read_data;

	// Instantiate the Unit Under Test (UUT)
	data_memory uut (
		.clk(clk), 
		.address(address), 
		.write_data(write_data), 
		.mem_read(mem_read), 
		.mem_write(mem_write), 
		.read_data(read_data)
	);

	initial begin
		clk = 0;
		address = 32'h000000A4;
		write_data = 32'h00000000;
		mem_read = 1'b1;
		mem_write = 1'b1;
		#100;
		clk = 1;
		
	end
      
endmodule

