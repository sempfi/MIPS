`timescale 1ns / 1ps

module pc_reg_test;

	// Inputs
	reg [31:0] next_inst_address;
	reg clk;
	reg hit;

	// Outputs
	wire [31:0] inst_address;

	// Instantiate the Unit Under Test (UUT)
	pc_reg uut (
		.next_inst_address(next_inst_address), 
		.clk(clk), 
		.hit(hit), 
		.inst_address(inst_address)
	);

	initial begin
		hit = 1;
		next_inst_address = 32'haaaaaaaa;
		clk = 0;
		#100;
      clk = 1;
		#100;
		
		next_inst_address = 32'haaaaaa11;
		clk = 0;
		#100;
      clk = 1;
		#100;

	end
      
endmodule

