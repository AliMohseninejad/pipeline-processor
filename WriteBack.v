`timescale 1ns/1ns

module WriteBack (
	input clk, reset, RegWM, MemToRegM,
	input [31:0] ReadDataM, ALUOutM, 
	input [4:0] WriteRegM,
	output reg RegWW, reg MemToRegW,
	output reg [31:0] ReadDataW, ALUOutW, 
	output reg [4:0] WriteRegW  
) ;

	always @(posedge clk)
		begin
			if (!reset)
				begin
					RegWW <= RegWM ;	
					MemToRegW <= MemToRegM ;
					ReadDataW <= ReadDataM ;
					ALUOutW <= ALUOutM ;
					WriteRegW <= WriteRegM ;
				end
			else
				begin
					RegWW <= 1'b0 ;	
					MemToRegW <= 1'b0 ;
					ReadDataW <= 32'h00000000 ;
					ALUOutW <= 32'h00000000 ;
					WriteRegW <= 5'b00000 ;
				end
		end

endmodule
