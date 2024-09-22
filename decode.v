`timescale 1ns/1ns

module decode (
	input [31:0] PCPlus4F, instrF, 
	input PCSrcD, clk, reset, stallD,
	output reg [31:0] PCPlus4D, instrD
);
	reg useless ;
	always @(posedge clk)
		begin
			if ((!stallD) && (!PCSrcD) && (!reset))
				begin
					PCPlus4D <= PCPlus4F ;
					instrD <= instrF ;	
				end
			else if (stallD)
				begin
					// just doing nothing !!!
					useless <= 1'b0 ;
				end
			else 
				begin
					PCPlus4D <= 32'h00000000 ;
					instrD <= 32'h00000000 ;
				end
		end

endmodule
