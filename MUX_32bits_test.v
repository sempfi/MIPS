`timescale 1ns / 1ps

module MUX_32bits_test;

	// Inputs
	reg [31:0] in_0;
	reg [31:0] in_1;
	reg select_line;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	MUX_32bits uut (
		.in_0(in_0), 
		.in_1(in_1), 
		.select_line(select_line), 
		.out(out)
	);

	initial begin
		in_0 = 32'h01234567;
		in_1 = 32'h89ABCDEF;
		select_line = 0;
		#50;
		select_line = 1;
		#50;
		
		in_0 = 32'hA0B9C153;
		in_1 = 32'hAAAAAAAA;
		select_line = 0;
		#50;
		select_line = 1;
		#50;

		in_0 = 32'hD0B7BC27;
		in_1 = 32'h0B61AF23;
		select_line = 0;
		#50;
		select_line = 1;
		#50;	
	end
      
endmodule

