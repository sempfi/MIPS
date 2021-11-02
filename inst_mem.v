`timescale 1ns / 1ps

module inst_mem (
	input [31:0] address,
	input clk,
	output reg [127:0] dataline
	);
	
	integer i;	
	reg [2:0] counter;								//	A counter to mimic the delay.  
	reg [7:0] mem [0:1023];							// 8-bit memory with 1024 entries.
	reg [31:0] address_copy;						//	A copy of address for iterating through the instruction memory.
	reg [27:0] address_authentic_bits;			//	A reg to store the top 28 bits we care about.
	
	initial begin
		//	Initializing the counter.
		counter = 2'b00;
		
		//	Initializing the instruction memory by reading the file.
		$readmemh("instruction_memory.txt", mem);
	end


	always @(posedge clk) begin
		
		// Checking whether the top 28-bit have changed or not:
		// 	If true, dumps the loaded values, and starts everything anew;
		//		If not, continues.
		if (address_authentic_bits != address[31:4]) begin
			counter = 2'b00;
			dataline = 128'bX;
		end
      
		//	Checking whether counter has surpassed the value of 5 or not.
		// If not, it increments the value of counter and waits for the next clock, and in so doing, serves the function of a delay.
		else if (counter < 3'b100) begin 
			counter = counter + 1;
		end
		
		else begin
			//	Left-shifting the address by 4 bits, since we only need the top 28 bits. The other 4 bits are zero.
			address_copy = address << 4;
			
			//	Iterating through and reading from the instruction memory and copying the values to dataline.
			// Kepp in mind that: 16 * 8 = 128.
			dataline = 128'b0;
			for (i = 0; i < 16; i = i+1) begin
				dataline = {mem[address_copy+i], dataline[127:8]};
			end
			
			//	Resetting the counter.
			counter = 2'b00;
		end
		
		//	Updating the authentic 28 bits for the next time use.
		address_authentic_bits = address[31:4];
      		
	end

endmodule
