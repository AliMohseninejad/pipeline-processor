`timescale 1ns/1ns

module execution (
	input clk, reset, flushE, MemToRegD, MemWriteD, ALUSrcD, RegDstD, RegWD,
	input [2:0] ALUOPD,
	output reg MemToRegE, reg MemWriteE, reg ALUSrcE, reg RegDstE, reg RegWE,
	output reg [2:0] ALUOPE,
	input [31:0] RD1D, RD2D, SignImmD,
	output reg [31:0] RD1E, RD2E, SignImmE,
	input [4:0] RsD,RtD,RdD,
	output reg [4:0] RsE,RtE,RdE 
) ;

	always @(posedge clk)
		begin
			if (flushE || reset)
				begin
					MemToRegE <= 1'b0 ;
					MemWriteE <= 1'b0 ;
					ALUSrcE <= 1'b0 ;
					RegDstE <= 1'b0 ;
					RegWE <= 1'b0 ;
					ALUOPE <= 3'b000 ;
					RD1E <= 32'h00000000 ;
					RD2E <= 32'h00000000 ;
					SignImmE <= 32'h00000000 ;
					RsE <= 5'b00000 ;
					RtE <= 5'b00000 ;
					RdE <= 5'b00000 ;		
				end
			else
				begin
					MemToRegE <= MemToRegD ;
					MemWriteE <= MemWriteD ;
					ALUSrcE <= ALUSrcD ;
					RegDstE <= RegDstD ;
					RegWE <= RegWD ;
					ALUOPE <= ALUOPD ;
					RD1E <= RD1D ;
					RD2E <= RD2D ;
					SignImmE <= SignImmD ;
					RsE <= RsD ;
					RtE <= RtD ;
					RdE <= RdD ;		
				end
		end

endmodule
