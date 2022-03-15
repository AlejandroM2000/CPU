module Ctrl (
  input[ 8:0] Instruction,	   // machine code
  output logic Jump     ,
               BranchEn ,
	           RegWrEn  ,	   // write to reg_file (common)
             MovEn,
	           MemWrEn  ,	   // write to mem (store only)
	           LoadInst	,	   // mem or ALU to reg_file ?
      	     StoreInst,          // mem write enable
	           Ack,		   // "done w/ program"
  output logic [1:0] TargSel       // Select signal for LUT
  );

assign MemWrEn = Instruction[8:6] == 3'b111;	
assign StoreInst = Instruction[8:6] == 3'b111;  // calls out store specially
assign MovEn = Instruction[8:6] == 3'b101;
assign RegWrEn = Instruction[8:7] != 2'b11;  
assign LoadInst = Instruction[8:6] == 3'b011; //load instruction


assign BranchEn = &Instruction[8:6];

// route data memory --> reg_file for loads
assign TargSel  = Instruction[5:4];

assign Ack = &Instruction;

endmodule

