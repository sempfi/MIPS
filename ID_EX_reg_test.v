`timescale 1ns / 1ps

module ID_EX_reg_test #(parameter PERIOD=20);

	// Inputs
	reg clk;
	reg hit;
	reg [31:0] read_data_1;
	reg [31:0] read_data_2;
	reg [31:0] immeadiate;
	reg [9:0] control_signals;
	reg [4:0] rt;
	reg [4:0] rd;
	reg [5:0] funct;
	reg [31:0] next_pc;

	// Outputs
	wire [31:0] read_data_1_out;
	wire [31:0] read_data_2_out;
	wire [31:0] immeadiate_out;
	wire [9:0] control_signals_out;
	wire [4:0] rt_out;
	wire [4:0] rd_out;
	wire [5:0] funct_out;
	wire [31:0] next_pc_out;

	// Instantiate the Unit Under Test (UUT)
	ID_EX_reg uut (
		.clk(clk), 
		.hit(hit), 
		.read_data_1(read_data_1), 
		.read_data_2(read_data_2), 
		.immeadiate(immeadiate), 
		.control_signals(control_signals), 
		.rt(rt), 
		.rd(rd), 
		.funct(funct), 
		.next_pc(next_pc), 
		.read_data_1_out(read_data_1_out), 
		.read_data_2_out(read_data_2_out), 
		.immeadiate_out(immeadiate_out), 
		.control_signals_out(control_signals_out), 
		.rt_out(rt_out), 
		.rd_out(rd_out), 
		.funct_out(funct_out), 
		.next_pc_out(next_pc_out)
	);
	
	always #PERIOD clk=~clk; 

	initial begin
		clk = 1;
		hit = 0;
		read_data_1 = 32'b1;
		read_data_2 = 32'b1;
		immeadiate = 0;
		control_signals = 0;
		rt = 0;
		rd = 0;
		funct = 0;
		next_pc = 0;
		#PERIOD;
		clk = 0;
		#PERIOD;
		
		clk = 1;
		hit = 1;
		read_data_1 = 32'h0;
		read_data_2 = 32'h1;
		immeadiate = 32'h0A1020BB;
		control_signals = 10'b0011001010;
		rt = 0;
		rd = 0;
		funct = 0;
		next_pc = 0;
		#PERIOD;
		clk = 0;
		#PERIOD;

	end
      
endmodule

