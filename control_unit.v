`timescale 1ns / 1ps

module control_unit (
	input [5:0] opcode,
	output reg reg_dst, 
	output reg alu_src, 
	output reg mem_to_reg, 
	output reg reg_write, 
	output reg mem_read,
	output reg mem_write, 
	output reg branch,
	output reg jump,
	output reg [2:0] alu_op,
	output reg [2:0] type
   );
	
	always @(opcode) begin
		reg_dst <= opcode == 6'b000000 ? 1'b1 : 1'b0;
		
		alu_src <= (opcode == 6'b000100 || 		
					   opcode == 6'b000101 || 
					   opcode == 6'b000111 || 
					   opcode == 6'b001111 || 
					   opcode == 6'b010000 ||
					   opcode == 6'b000001) ? 1'b1 : 1'b0;
		
		mem_to_reg <= opcode == 6'b000100 ? 1'b1 : 1'b0;
		
		reg_write <= (opcode == 6'b000000 || 
						 opcode == 6'b000100 || 
						 opcode == 6'b000111 || 
						 opcode == 6'b001111 || 
						 opcode == 6'b010000 ||
						 opcode == 6'b000001 ||
						 opcode == 6'b001110) ? 1'b1 : 1'b0;
		
		mem_read <= opcode == 6'b000100 ? 1'b1 : 1'b0;
		
		mem_write <= opcode == 6'b000101 ? 1'b1 : 1'b0;
		
		branch <= (opcode == 6'b000110 || 
					  opcode == 6'b001000 ||
					  opcode == 6'b001001 ||
					  opcode == 6'b001010 ||
					  opcode == 6'b001011 ||
					  opcode == 6'b001100) ? 1'b1 : 1'b0;
		
		if (opcode == 6'b000000)	alu_op <= 3'b000;
		else if (opcode == 6'b000100 ||	opcode == 6'b000101 || opcode == 6'b000111 || opcode == 6'b001111 || opcode == 6'b010000)
			alu_op <=  3'b011;
		else if (opcode == 6'b000110 ||											    // beq
					  opcode == 6'b001000 ||											 // bgt
					  opcode == 6'b001001 ||											 // bge
					  opcode == 6'b001010 ||											 // blt
					  opcode == 6'b001011 ||											 // ble
					  opcode == 6'b001100)
						alu_op <= 3'b001;
		else if (opcode == 6'b000001) alu_op <= 3'b010;
		else alu_op <= 3'bX;

		jump <= (opcode == 6'b001101 || opcode == 6'b001110) ? 1'b1 : 1'b0;
		
		type <= (opcode == 6'b000110) ? 3'b000 :   	// beq
				  (opcode == 6'b001000) ? 3'b001 :		// bgt
				  (opcode == 6'b001001) ? 3'b010 :		// bge
				  (opcode == 6'b001010) ? 3'b011 :		// blt
				  (opcode == 6'b001011) ? 3'b100 :		//	ble
				  (opcode == 6'b001100) ? 3'b101 :		//	bnq
				  (opcode == 6'b000111) ? 3'b000 :     // addi
				  (opcode == 6'b001111) ? 3'b001 :		// multi
				  (opcode == 6'b010000) ? 3'b010 :		//	divi

				  3'bX;

	end

endmodule
