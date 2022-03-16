// Module Name:    TopLevel 
// CSE141L
module TopLevel(		   // you will have the same 3 ports
    input        Reset,	   // init/reset, active high
			     Start,    // start next program
	             Clk,	   // clock -- posedge used inside design
    output logic Ack	   // done flag from DUT
    );

wire [ 9:0] PgmCtr,        // program counter
			PCTarg;
wire [ 8:0] Instruction;   // our 9-bit opcode
wire [ 7:0] ReadA,  ReadB,  ReadC;  // reg_file outputs
wire [ 7:0] InA, InB, InC,	   // ALU operand inputs
            ALU_out;       // ALU result
wire [ 7:0] RegWriteValue, // data in to reg file
            MemWriteValue, // data in to data_memory
	        MemReadValue;  // data out from data_memory
wire        MemWrite,	   // data_memory write enable
	        RegWrEn,	   // reg_file write enable
	        // Zero,          // ALU output = 0 flag
            // Sign,          // ALU output, 1 = negative **Added
            Jump,	       // to program counter: jump 
            BOE,           // **Added 
            isEqual,	   // to program counter: branch enable **changed
			Shift, 
			MovEn, 
            BranchEn,
            LoadInst;
            //StoreInst;
wire [1:0]  TargSel;
logic[15:0] CycleCt;	   // standalone; NOT PC!

// Fetch stage = Program Counter + Instruction ROM
  ProgCtr PC1 (		       // this is the program counter module
	.Reset        (Reset   ) ,  // reset to 0
	.Start        (Start   ) ,  // SystemVerilog shorthand for .grape(grape) is just .grape 
	.Clk          (Clk     ) ,  //  here, (Clk) is required in Verilog, optional in SystemVerilog
	//.Jump         (Jump    ) ,  // jump enable
    .BOE          (BOE     ) ,
    .IsEqual      (isEqual ) ,
	//.BranchRel    (BranchEn) ,  // branch enable
	//.ALU_flag	  (Zero    ) ,  // 
	.Target       (PCTarg  ) ,  // "where to?" or "how far?" during a jump or branch
	.ProgCtr      (PgmCtr  )	   // program count = index to instruction memory
	);					  

// LUT LUT1(.Addr         (TargSel ) ,
//          .Target       (PCTarg  )
//     );

// instruction ROM -- holds the machine code pointed to by program counter
  InstROM #(.W(9)) IR1(
	.InstAddress  (PgmCtr     ) , 
	.InstOut      (Instruction)
	);

// Decode stage = Control Decoder + Reg_file
// Control decoder
  Ctrl Ctrl1 (
	.Instruction  (Instruction) ,  // from instr_ROM
	.BOE	      (BOE   )	,  // to PC
	.RegWrEn      (RegWrEn    )	,  // register file write enable
	.Shift		  (Shift	  ) ,
	.MovEn		  (MovEn      ) ,
	.MemWrEn      (MemWrite   ) ,  // data memory write enable
    .LoadInst     (LoadInst   ) ,  // selects memory vs ALU output as data input to reg_file
    //.StoreInst    (StoreInst  ) ,
    //.TargSel      (TargSel    ) ,  // index into lookup table 
    .Ack          (Ack        )	   // "done" flag
  );

assign RegWriteValue = LoadInst ? MemReadValue : ALU_out;  // 2:1 switch into reg_file
// reg file
	RegFile #(.W(8),.A(2)) RF1 (			  // A(3) makes this 2**3=8 elements deep
		.Clk       (Clk)			  ,
		.Reset     (Reset),
		.WriteEn   (RegWrEn)    , 
		.MovEn	   (MovEn),
		.Shift		(Shift),
		.RaddrA    (Instruction[3:2]),        //concatenate with 0 to give us 4 bits
		.RaddrB    (Instruction[1:0]), 
		.RaddrC	   (Instruction[5:4]),
		.Waddr     (Instruction[5:4]), 	      // mux above
		.DataIn    (RegWriteValue) , 
		.DataOutA  (ReadA        ) , 
		.DataOutB  (ReadB		 ) ,
		.DataOutC  (ReadC        )
	);
/* one pointer, two adjacent read accesses: 
  (sample optional approach)
	.raddrA ({Instruction[5:3],1'b0});
	.raddrB ({Instruction[5:3],1'b1});
*/
    assign InA = ReadA;						  // connect RF out to ALU in
	assign InB = ReadB;	          			  // interject switch/mux if needed/desired
	assign InC = ReadC;
// controlled by Ctrl1 -- must be high for load from data_mem; otherwise usually low
//	assign RegWriteValue = LoadInst? MemReadValue : ALU_out;  // 2:1 switch into reg_file
    ALU ALU1  (
	  .A  (InA),
	  .B  (InB),
	  .C  (InC),
	  .OP      (Instruction[7:6]),
	  .out     (ALU_out),
	  .isEqual (isEqual)
	  //regWriteValue),
	//   .Zero	   (Zero   ),                     // status flag; may have others, if desired
    //   .Sign    (Sign   )
	  );
  
	data_mem DM1(
		.DataAddress  (ReadA)    , 
		.Offset       (ReadB),
		.WriteEn      (MemWrite), 
		.DataIn       (ReadC), 
		.DataOut      (MemReadValue)  , 
		.Clk 		  (Clk)	     ,
		.Reset		  (Reset)
	);
	
/* count number of instructions executed
      not part of main design, potentially useful
      This one halts when Ack is high  
*/
always_ff @(posedge Clk)
  if (Reset)	   // if(start)
  	CycleCt <= 0;
  else if(Ack == 0)   // if(!halt)
  	CycleCt <= CycleCt+16'b1;

endmodule
