`timescale 1ns / 1ps

module alu_control (
   input [2:0] alu_op,
	input [2:0] type,
	input [5:0] funct,
	output reg [3:0] alu_cnt
	);
	
	
	always @(*) begin
			alu_cnt = alu_op == 3'b000 ? (						// R-Type:
							funct == 6'b000000 ? 4'b0000 :				// ADD
							funct == 6'b000001 ? 4'b0001 :				// SUB
							funct == 6'b000111 ? 4'b0010 : 				// NOT
							funct == 6'b000101 ? 4'b0011 :				// SL
							funct == 6'b000110 ? 4'b0100 :				// SR
							funct == 6'b000010 ? 4'b0101 :				// AND
							funct == 6'b000011 ? 4'b0110 :				//	OR
							funct == 6'b000100 ? 4'b0111 : 				//	SLT
														4'bX) 
					 
					 : alu_op == 3'b001 ? 4'b0001					            // Branch
					 : alu_op == 3'b010 ? 4'b0111					            // SLTI
					 : alu_op == 3'b011 ? (type == 3'b001 ? 4'b1000 :     // MUL
												  type == 3'b010 ? 4'b1001 : 		// DIV
																		 4'b0000)
					 : 4'bX;
	end


endmodule
