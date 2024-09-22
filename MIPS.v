`timescale 1ns/1ns

module MIPS (
	input clk,reset
) ;

	wire MemToReg,MemWrite,PCSrc,ALUSrc,RegDst,RegW,SgnZero,EqualD,MemReady,MemToRegE,MemToRegM,RegWE,RegWM,RegWW,stallF,stallD,forwardAD,forwardBD,flushE,BranchD ;
	wire [1:0] forwardAE, forwardBE ;
	wire [2:0] ALUOP ;
	wire [4:0] RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW ;
	wire [5:0] op,funct ;

	DataPath dp (clk,reset,MemToReg,MemWrite,PCSrc,ALUSrc,RegDst,RegW,SgnZero,ALUOP,op,funct,EqualD,MemReady,MemToRegE,MemToRegM,RegWE,RegWM,RegWW,stallF,stallD,forwardAD,forwardBD,flushE,forwardAE,forwardBE,RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW) ;
	controller c (op,funct,EqualD,MemToReg,MemWrite,PCSrc,ALUSrc,RegDst,RegW,SgnZero,ALUOP,BranchD) ;
	HazardUnit hu (MemReady,BranchD,MemToRegE,MemToRegM,RegWE,RegWM,RegWW,RsD,RtD,RsE,RtE,WriteRegE,WriteRegM,WriteRegW,stallF,stallD,forwardAD,forwardBD,flushE,forwardAE,forwardBE) ;
endmodule 