`timescale 1ns/1ns

module controller
(
	input [5:0] op,
	input [5:0] funct,
	input zero,
	output MemToReg, MemWrite, PCSrc, ALUSrc, RegDst, RegW, SgnZero,
	output [2:0] ALUOP,
	output Branch
	
);
	
	assign MemToReg = (op == 6'b100011) ? 1 : 0 ; // only for 'lw' this is on
	assign MemWrite = (op == 6'b101011) ? 1 : 0 ; // only for 'sw' this is on
	
	assign Branch = (op == 6'b000100) || (op == 6'b000101) ;
	assign PCSrc = (op == 6'b000100) ? zero : (op == 6'b000101) ? (!zero) : 0 ; // 'beq' and 'bne'

	assign ALUSrc = !( (op == 6'b000000) | (op == 6'b000100) | (op == 6'b000101) ) ; // for 'R-type', 'beq' and 'bne' this is off 
	
	assign RegDst = (op == 6'b000000) ; // it is on for 'R-type'

	assign RegW = !( (op == 6'b101011) | (op == 6'b000100) | (op == 6'b000101) ) ; // for 'sw', 'beq' and 'bne' this is off 

	// SgnZero = 0 (zero-extend) for 'andi', 'ori', 'xori'. for the others SgnZero = 1 (sign-extend)
	assign SgnZero = !( (op == 6'b001100) | (op == 6'b001101) | (op == 6'b001110)) ;
	
			// add : 'add', 'addu', 'lw', 'sw', 'addi', 'addiu'
	assign ALUOP = (( (op == 6'b000000)  && ((funct == 6'b100000) || (funct == 6'b100001)) ) || (op == 6'b100011) || (op == 6'b101011) || (op == 6'b001000) || (op == 6'b001001)) ? 3'b000 :
			// sub : 'sub', 'subu', 'beq', 'bne'
				   (( (op == 6'b000000)  && ((funct == 6'b100010) || (funct == 6'b100011)) ) || (op == 6'b000100) || (op == 6'b000101)) ? 3'b001 :
			// and : 'and', 'andi'
				   (( (op == 6'b000000)  && (funct == 6'b100100) ) || (op == 6'b001100)) ? 3'b010 :
			// or : 'or', 'ori'
				   (( (op == 6'b000000)  && (funct == 6'b100101) ) || (op == 6'b001101)) ? 3'b011 :
			// xor : 'xor', 'xori'
				   (( (op == 6'b000000)  && (funct == 6'b100110) ) || (op == 6'b001110)) ? 3'b100 :
			// nor : 'nor'
				   ( (op == 6'b000000)  && (funct == 6'b100111) ) ? 3'b101 :
			// slt : 'slt', 'slti'
				   (( (op == 6'b000000)  && (funct == 6'b101010) ) || (op == 6'b001010)) ? 3'b110 :
			// sltu : 'sltu', 'sltiu'
				   (( (op == 6'b000000)  && (funct == 6'b101011) ) || (op == 6'b001011)) ? 3'b111 : 3'b000 ; 

endmodule
