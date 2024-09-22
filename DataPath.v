`timescale 1ns/1ns

module DataPath (
	input clk,reset,MemToReg,MemWrite,PCSrc, ALUSrc, RegDst, RegW, SgnZero,
	input [2:0] ALUOP,
	output [5:0] op,funct,
	output EqualD, MemReady, MemToRegE, MemToRegM, RegWE, RegWM, RegWW,
	input stallF, stallD, forwardAD, forwardBD, flushE,
	input [1:0] forwardAE, forwardBE,
	output [4:0] RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW
) ;

	// Fetch
	wire [31:0] PC0 ;
	wire [31:0] PC ;
	PC_unit PC_build (PC0,clk,reset,PC,stallF) ;
	
	wire [31:0] PCPlus4F ;
	adder adder1 (PC,32'd4,PCPlus4F) ;

	wire [31:0] instrF ;
	InstructionMemory mem (PC,instrF) ;
	
	// * * *
	wire [31:0] PCPlus4D, instrD ;
	decode decode1 (PCPlus4F,instrF,PCSrc,clk,reset,stallD,PCPlus4D,instrD) ; 
	// * * *

	// Decode
	assign op = instrD [31:26] ;
	assign funct = instrD [5:0] ;
	
	wire [31:0] SignImmD ;
	extention extend (instrD[15:0],SgnZero,SignImmD) ;
	
	wire [31:0] shifted_Imm ;
	shift shift1 (SignImmD,shifted_Imm) ;
	
	wire [31:0] PCBranch ;
	adder adder2 (shifted_Imm,PCPlus4D,PCBranch) ;

	MUX #(32) mux1 (PCPlus4F,PCBranch,PCSrc,PC0) ; 
	
	wire [4:0] RdD ;
	assign RsD = instrD[25:21] ;
	assign RtD = instrD[20:16] ;
	assign RdD = instrD[15:11] ;
	
	wire [31:0] ResultW,RD1,RD2,ALUOutM,EQ1,EQ2 ;
	RegisterFile reg_file (clk,RegWW,instrD[25:21],instrD[20:16],WriteRegW,ResultW,RD1,RD2) ;
	
	MUX #(32) muxeq1 (RD1,ALUOutM,forwardAD,EQ1) ;
	MUX #(32) muxeq2 (RD2,ALUOutM,forwardBD,EQ2) ;
	assign EqualD = (EQ1 == EQ2) ;
	
	// * * *
	wire MemWriteE,ALUSrcE,RegDstE ;
	wire [2:0] ALUOPE ;
	wire [31:0] RD1E,RD2E,SignImmE ;
	wire [4:0] RdE ;
	execution execution1 (clk,reset,flushE,MemToReg,MemWrite,ALUSrc,RegDst,RegW,ALUOP,MemToRegE,MemWriteE,ALUSrcE,RegDstE,RegWE,ALUOPE,RD1,RD2,SignImmD,RD1E,RD2E,SignImmE,RsD,RtD,RdD,RsE,RtE,RdE) ;
	// * * *

	// Execution
	MUX #(5) mux3 (RtE,RdE,RegDstE,WriteRegE) ;
	
	wire [31:0] SrcAE, WriteDataE, SrcBE ;
	assign SrcAE = (forwardAE == 2'b00) ? RD1E : (forwardAE == 2'b01) ? ResultW : ALUOutM ;
	assign WriteDataE = (forwardBE == 2'b00) ? RD2E : (forwardBE == 2'b01) ? ResultW : ALUOutM ;
	
	MUX #(32) mux_alu (WriteDataE,SignImmE,ALUSrcE,SrcBE) ;
	
	wire [31:0] ALUOutE ;
	ALU alu_unit (SrcAE,SrcBE,ALUOPE,ALUOutE) ;

	// * * *
	wire MemWriteM ;
	wire [31:0] WriteDataM ;
	MemoryRegister MemoryRegister1 (clk,reset,RegWE,MemToRegE,MemWriteE,RegWM,MemToRegM,MemWriteM,ALUOutE,WriteDataE,WriteRegE,ALUOutM,WriteDataM,WriteRegM) ;
	// * * *

	// Memory
	wire [31:0] ReadDataM ;
	DataMemory #(0) dm (clk,MemWriteM,ALUOutM,WriteDataM,ReadDataM,MemReady) ;  
	
	// * * *
	wire MemToRegW ;
	wire [31:0] ReadDataW,ALUOutW ;
	WriteBack wb (clk,reset,RegWM,MemToRegM,ReadDataM,ALUOutM,WriteRegM,RegWW,MemToRegW,ReadDataW,ALUOutW,WriteRegW) ;
	// * * *

	// WriteBack
	MUX #(32) mux4 (ALUOutW,ReadDataW,MemToRegW,ResultW) ; 




endmodule 