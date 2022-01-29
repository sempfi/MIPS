`timescale 1ns / 1ps

module reg_file (
	input clk,
	input RegWrite,
	input  [ 4:0] read_reg_1,
	input  [ 4:0] read_reg_2,
	input  [ 4:0] write_reg,
	input  [31:0] write_data,
	output [31:0] read_data_1,
	output [31:0] read_data_2
   );
	
	integer i;
	integer file;

	reg [31:0] registers [0:31];
	initial begin
		for (i = 0; i < 32; i = i+1)
			registers[i] = i;
	end
	
	assign read_data_1 = registers[read_reg_1];
	assign read_data_2 = registers[read_reg_2];
	
	always @(posedge clk) begin
		if (RegWrite == 1'b1) begin
			if (write_reg == 5'b0)	$display("ERROR: Cannot write to the Zero Register.");
			else registers[write_reg] = write_data;
		end
		else begin end
	end
	
	always @(registers) begin
		file = $fopen("registers.txt","w");
		for (i = 0; i < 32; i = i+1)
			$fwrite(file,"%d: %b\n",i, registers[i]);
		$fclose(file);
	end

endmodule
