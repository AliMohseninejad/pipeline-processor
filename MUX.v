`timescale 1ns/1ns

module MUX #(
	parameter width = 32
) 
(
	input [width-1:0] a0,a1,
	input select,
	output [width-1:0] s
) ;

	assign s = (select) ? a1 : a0 ;

endmodule

