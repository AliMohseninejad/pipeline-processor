`timescale 1ns/1ns

module ALU
(
	input [31:0] SrcA,SrcB,
	input [2:0] ALUControl,
	output [31:0] ALUResult
); 
	wire [31:0] W = SrcA + ~SrcB + 32'd1 ;
	
	assign ALUResult = 
			(ALUControl == 3'b000) ? SrcA + SrcB :
			(ALUControl == 3'b001) ? SrcA - SrcB :
			(ALUControl == 3'b010) ? SrcA & SrcB :
			(ALUControl == 3'b011) ? SrcA | SrcB :
			(ALUControl == 3'b100) ? SrcA ^ SrcB :
			(ALUControl == 3'b101) ? ~(SrcA | SrcB) :
			(ALUControl == 3'b110) ? W[31] : (SrcA < SrcB) ;


endmodule 