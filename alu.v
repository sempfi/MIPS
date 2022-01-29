`timescale 1ns / 1ps

module alu (
   input [3:0] alu_cnt, 
	input signed [31:0] input1,
	input signed [31:0] input2,
	input [4:0] shamt,
	output reg signed [31:0] result,
	output reg beq_flag,
	output reg bgt_flag,
	output reg bge_flag,
	output reg blt_flag,
	output reg ble_flag,
	output reg bne_flag
	);
	
	integer i;
	always @(*) begin
		result =	alu_cnt == 4'b0000 	? 	  (input1 + input2)					     :   // ADD
				 	alu_cnt == 4'b0001 	? 	  (input1 - input2)       			     :   // SUB
					alu_cnt == 4'b0010 	? 	  (!input1)               			     :   // NOT
					alu_cnt == 4'b0011   ? 	  (input1 << shamt)       			     :   // SL
					alu_cnt == 4'b0100   ?    (input1 >> shamt)       			     :	// SR
					alu_cnt == 4'b0101   ?    (input1 & input2)      			     :	// AND
					alu_cnt == 4'b0110   ?    (input1 | input2)       			     :	// OR
					alu_cnt == 4'b0111   ?    (input1 < input2 ? 32'b1 : 32'b0)   :	// SLTI
					alu_cnt == 4'b1000   ?    (input1 * input2)                   :	// MUL
					alu_cnt == 4'b1001   ?    (input1 / input2)                   :	// DIV
				   alu_cnt == 4'b1010   ?    ({input1[31], input1[31:1]}):				// SRA
													   32'bX;		
	end
	
	always @(result) begin
		 beq_flag = (result == 32'b0);
		 bne_flag = (result != 32'b0);

		 bgt_flag = (result[31] != 1'b1);
		 blt_flag <= (result[31] == 1'b1);
		 
		 bge_flag <= (beq_flag | bgt_flag);
		 ble_flag <= (beq_flag | blt_flag);
		 
	end
	

endmodule
