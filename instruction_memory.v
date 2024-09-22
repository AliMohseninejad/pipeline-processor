`timescale 1ns/1ns

module InstructionMemory(
	input [31:0] A
	,output [31:0] RD
);

	reg [31:0] RAM [0:1023] ;		
	
//	initial
//		$readmemh("memfile.dat",RAM) ;	

	assign RD = RAM [A[11:2]] ;


endmodule
