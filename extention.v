`timescale 1ns/1ns

module extention (
	input [15:0] in,
	input sgn_zero,
	output [31:0] SignImm
) ;

	assign SignImm = (sgn_zero) ? {{16{in[15]}},in} : {16'h0000, in} ;

endmodule 