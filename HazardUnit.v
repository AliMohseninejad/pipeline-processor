`timescale 1ns/1ns

module HazardUnit (
	input MemReady, BranchD, MemToRegE, MemToRegM, RegWE, RegWM, RegWW,
	input [4:0] RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW,
	output stallF, stallD, forwardAD, forwardBD, flushE, 
	output [1:0] forwardAE, forwardBE 
) ;
	
	// data forwarding
	assign forwardAE = ((RsE != 5'b00000) && (RsE == WriteRegM) && RegWM)? 2'b10 : 
					   ((RsE != 5'b00000) && (RsE == WriteRegW) && RegWW)? 2'b01 : 2'b00 ;
	assign forwardBE = ((RtE != 5'b00000) && (RtE == WriteRegM) && RegWM)? 2'b10 : 
					   ((RtE != 5'b00000) && (RtE == WriteRegW) && RegWW)? 2'b01 : 2'b00 ;

	assign forwardAD = (RsD != 5'b00000) && (RsD == WriteRegM) && RegWM ;
	assign forwardBD = (RtD != 5'b00000) && (RtD == WriteRegM) && RegWM ;

	// stalling
	wire lwstall ;
	assign lwstall = ((RsD == RtE) || (RtD == RtE)) && MemToRegE ;
	
	wire branchstall ;
	assign branchstall = (BranchD && RegWE && (WriteRegE == RsD || WriteRegE == RtD)) ||
						 (BranchD && MemToRegM && (WriteRegM == RsD || WriteRegM == RtD)) ;

	assign stallF = lwstall || branchstall ;
 	assign stallD = lwstall || branchstall ;
	assign flushE = lwstall || branchstall ;

endmodule
