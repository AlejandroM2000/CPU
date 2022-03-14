module Ctrl (
  input[ 8:0] Instruction,	   // machine code
  output logic Jump     ,
               BranchEn ,
	           RegWrEn  ,	   // write to reg_file (common)
	           MemWrEn  ,	   // write to mem (store only)
	           LoadInst	,	   // mem or ALU to reg_file ?
      	       StoreInst,          // mem write enable
	           Ack,		   // "done w/ program"
  output logic [1:0] TargSel       // Select signal for LUT
  );

assign MemWrEn = Instruction[8:6] == 3'b110;	
assign StoreInst = Instruction[8:6] == 3'b101;  // calls out store specially

//101 and 110 are the only instructions that don't write to a register
//add : 000 , shiftrihgt: 001, Shiftleft: 010, load: 011, XOR: 100, MOV: 111
assign RegWrEn = Instruction[8:7] != 2'b11;  
assign LoadInst = Instruction[8:6] == 3'b011; //load instruction

assign Jump = Instruction[8:6] == 3'b111;

assign BranchEn = &Instruction[8:6];

// route data memory --> reg_file for loads
assign TargSel  = Instruction[5:4];

assign Ack = &Instruction;

endmodule

