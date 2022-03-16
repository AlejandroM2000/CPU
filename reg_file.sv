module RegFile #(parameter W=8, A=2)(		 // W = data path width (leave at 8); A = address pointer width
  input                Clk,
                       Reset,
                       WriteEn,
                       MovEn,
                       Shift,
  input        [A-1:0] RaddrA,				 // address pointers
                       RaddrB,
                        RaddrC,
                       Waddr,
  input        [W-1:0] DataIn,
  output       [W-1:0] DataOutA,			 // showing two different ways to handle DataOutX, for
  output logic [W-1:0] DataOutB,		   //   pedagogic reasons only
  output logic [W-1:0] DataOutC
  );

// W bits wide [W-1:0] and 2**2 registers deep 	 
logic [W-1:0] Registers[4];	             // or just registers[16] if we know A=4 always


// sequential (clocked) writes 
always_ff @ (posedge Clk) begin
  if (Reset) begin
    Registers[0] <= '0;
    Registers[1] <= '0;
    Registers[2] <= '0;
    Registers[3] <= '0;
  end else if (MovEn) begin	   
    Registers[Waddr][3:0] <= {RaddrA, RaddrB};                          
    
  end else if (WriteEn) begin  // works just like data_memory writes
    Registers[Waddr] <= DataIn;
  end
  //end
end

assign      DataOutA = Registers[RaddrA];

always_comb DataOutB = Shift ? {RaddrA, RaddrB} : Registers[RaddrB];    // can read from addr 0, just like ARM

always_comb DataOutC = Registers[RaddrC];

endmodule
