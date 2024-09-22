`timescale 1ns/1ns

module shift (
	input [31:0] not_shifted,
	output [31:0] shifted
) ;

	assign shifted = not_shifted << 2'd2 ;

endmodule 