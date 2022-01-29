`timescale 1ns / 1ps

module data_memory (
   input clk,
	input [31:0] address,
	input [31:0] write_data,
	input mem_read,
	input mem_write,
	output reg [31:0] read_data
	);
	
	integer i;
	reg [7:0] data_mem [0:1023];
	initial begin
		for (i = 0; i < 1024; i = i+1) data_mem[i] = i;
	end
	
	reg [7:0] temp_1, temp_2, temp_3, temp_4;

	always @(posedge clk) begin
		if (mem_write == 1'b1) begin
			data_mem[address+0] = write_data[7:0];
			data_mem[address+1] = write_data[15:8];
			data_mem[address+2] = write_data[23:16];
			data_mem[address+3] = write_data[31:24];
		end
		
		if (mem_read == 1'b1) begin
			temp_1 = data_mem[address + 0];
			temp_2 = data_mem[address + 1];
			temp_3 = data_mem[address + 2];
			temp_4 = data_mem[address + 3];
			read_data = {temp_4, temp_3, temp_2, temp_1};
		end
	end

endmodule
