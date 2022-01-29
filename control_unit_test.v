`timescale 1ns / 1ps

module control_unit_test;

	// Inputs
	reg [5:0] opcode;

	// Outputs
	wire [9:0] control_signals;

	// Instantiate the Unit Under Test (UUT)
	control_unit uut (
		.opcode(opcode), 
		.control_signals(control_signals)
	);

	initial begin
		opcode = 6'b000000;
		#100;
		opcode = 6'b000100;
	end
      
endmodule

