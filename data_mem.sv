module data_mem #(parameter W=8, A=8)  (
  input                 Clk,
                        Reset,
                        WriteEn,      //High when instruction is a store
  input       [A-1:0]   DataAddress, // A-bit-wide pointer to 256-deep memory 2nd operand
  input       [A-1:0]   Offset,     // 3rd operand
  input       [W-1:0]   DataIn,		 // W-bit-wide data path, also 1st oeprand when the instruction is store
  output logic[W-1:0]   DataOut); // only non empty when it is a load instruction

  logic [W-1:0] Core[2**A];			 // 8x256 two-dimensional array -- the memory itself
									 
  always_comb                        // reads are combinational
    DataOut = Core[DataAddress + Offset];

  always_ff @ (posedge Clk)		 // writes are sequential
/*( Reset response is needed only for initialization (see inital $readmemh above for another choice)
  if you do not need to preload your data memory with any constants, you may omit the if(Reset) and the else,
  and go straight to if(WriteEn) ...
*/
    if(Reset) begin
// you may initialize your memory w/ constants, if you wish
      for(int i=0;i<256;i++)
	      Core[i] <= i;
	end
    else if(WriteEn) 
      Core[DataAddress + Offset] <= DataIn;

endmodule
