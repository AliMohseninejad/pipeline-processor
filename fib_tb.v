
`timescale 1ns/1ns

module fib_tb;
   integer file;
   reg clk = 1;
   always @(clk)
      clk <= #5 ~clk;

   reg reset;
   initial begin
      reset = 1;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      #1;
      reset = 0;
   end
   initial
      $readmemh("fibtest.hex", PipeLine.dp.mem.RAM);

   parameter end_pc = 32'h58;
 
   integer i;
   always @(PipeLine.dp.PC)
      if(PipeLine.dp.PC == end_pc) begin
         for(i=0; i<15; i=i+1) begin
            $write("%x ", PipeLine.dp.dm.RAM[i+16]);
            if(((i+1) % 16) == 0)
               $write("\n");
         end
         $stop;
      end
      
   MIPS PipeLine(
      .clk(clk),
      .reset(reset)
   );
	

endmodule
