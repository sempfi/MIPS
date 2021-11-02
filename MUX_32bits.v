`timescale 1ns / 1ps

module MUX_32bits (
	input [31:0] in_0, in_1,	
	input select_line,
	output reg [31:0] out
	);
	
	always @(*) begin
		case (select_line)
			1'b0 : out <= in_0;
			1'b1 : out <= in_1;
		endcase
	end

endmodule
