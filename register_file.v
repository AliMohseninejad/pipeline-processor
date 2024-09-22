`timescale 1ns/1ns

module RegisterFile
(
	input clk,
	input WE3,
	input [4:0] A1,
	input [4:0] A2,
	input [4:0] A3,
	input [31:0] WD3,
	output [31:0] RD1,
	output [31:0] RD2
);

	reg [31:0] reg_file [0:31] ;
	
	assign RD1 = reg_file [A1] ;
	assign RD2 = reg_file [A2] ;
	
	always @(negedge clk)
		begin
			if(WE3)	
				reg_file [A3] = WD3 ;
			reg_file [0] = 32'h00000000 ;
		end


endmodule 