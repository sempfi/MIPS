`timescale 1ns / 1ps

module MUX_3_8 (
   input in_0,
	input in_1,
	input in_2,
	input in_3,
	input in_4,
	input in_5,
	input in_6,
	input in_7,
	input [2:0] select_lines,
	output reg out
	);
	
	always @(*) begin
		case (select_lines)
			3'b000 : out = in_0;
			3'b001 : out = in_1;
			3'b010 : out = in_2;
			3'b011 : out = in_3;
			3'b100 : out = in_4;
			3'b101 : out = in_5;
			3'b110 : out = in_6;
			3'b111 : out = in_7;
		endcase
	end

endmodule
