`timescale 1ns / 1ps

module sign_extend_test;

	// Inputs
	reg [15:0] value;

	// Outputs
	wire [31:0] sign_extended_value;

	// Instantiate the Unit Under Test (UUT)
	sign_extend uut (
		.value(value), 
		.sign_extended_value(sign_extended_value)
	);

	initial begin
		value = 16'b0;
		#50;
		
		value = 16'hAAAA;
		#50;
		
		value = 16'h0A01;
	end
      
endmodule

