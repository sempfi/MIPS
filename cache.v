`timescale 1ns / 1ps

module cache (
	input [127:0] dataline,
	input [31:0] address,
	input clk,
	output reg hit,
	output reg [31:0] instruction
   );
	 
	integer i;
	integer offset, index;
	
	/*	Cache structure: 1 bit valid bit,
							  25 bit tag bits,
							  128 bit dataline.
	*/ 
	reg [153:0] cache_sets [0:7];
	initial begin
		for (i = 0; i < 8; i = i+1)
			cache_sets[i][0] = 0;														//	Setting valid bits to 0.
	end
	
	always @(dataline) begin
		index = address[6:4];															//	Figuring out at which cache set (slot) we should write the dataline.	
		cache_sets[index] = {1'b1, address[31:7], dataline[127:0]};			// Concatenating the values.
	end
	
	always @(posedge clk) begin
		index = address[6:4];
		if (cache_sets[index][153] == 1'b1) begin									//	Checking the valid bit
			if (address[31:7] == cache_sets[index][152:128]) begin			//	Checking the tag bits
				offset = address[3:2];
				case (offset)
					2'b00 : instruction = dataline[31:0];
					2'b01 : instruction = dataline[63:32];
					2'b10 : instruction = dataline[95:64];
					2'b11 : instruction = dataline[127:96];
				endcase
				hit = 1;																		//	The reading is successful and valid.
			end
			else 
				hit = 0;																		//	Tag bits are not the same.
																								//	Stalling the PC_Reg. Waiting for the new dataline.
		end
		else 
			hit = 0;																			//	Cache set is not valid.
																								//	Stalling the PC_Reg. Waiting for the new dataline.
	end
endmodule
