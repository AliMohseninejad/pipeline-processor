`timescale 1ns/1ns

module DataMemory
#(
	parameter mem_delay = 0
)
(
	input clk
	,input WE
	,input [31:0] A
	,input [31:0] WD
	,output reg [31:0] RD
	,output reg MemReady
);

	integer i = 0;
	reg [31:0] RAM [0:1023] ;		
	
	always @(A)
		begin
			MemReady = 0;
			for (i = 0 ; i<mem_delay ; i = i + 1)
				 @(posedge clk);
			MemReady = 1;
			RD = RAM [A[11:2]] ;
		end
	always @(posedge clk)
		begin
			if(WE)
				RAM [A[11:2]] = WD;
		end
	

endmodule 