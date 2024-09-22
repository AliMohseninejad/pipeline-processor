`timescale 1ns/1ns

module MemoryRegister (
	input clk, reset, RegWE, MemToRegE, MemWriteE,
	output reg RegWM, reg MemToRegM, reg MemWriteM, 
	input [31:0] ALUOutE, WriteDataE, 
	input [4:0] WriteRegE,
	output reg [31:0] ALUOutM, WriteDataM, 
	output reg [4:0] WriteRegM
) ;

	always @(posedge clk)
		if (!reset)
			begin
				RegWM <= RegWE ;	
				MemToRegM <= MemToRegE ;
				MemWriteM <= MemWriteE ;
				ALUOutM <= ALUOutE ;
				WriteDataM <= WriteDataE ;
				WriteRegM <= WriteRegE ;
			end
		else
			begin
				RegWM <= 1'b0 ;	
				MemToRegM <= 1'b0 ;
				MemWriteM <= 1'b0 ;
				ALUOutM <= 32'd0 ;
				WriteDataM <= 32'd0 ;
				WriteRegM <= 5'd0 ;
			end

endmodule
