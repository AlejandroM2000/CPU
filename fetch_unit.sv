// Description: Instrunction fetch unit for processor
// Same as InstFetch from sample code
// Not tested yet


module FetchUnit (
    input               Reset,          // Reset flag, forces PC to 0
                        Start,          // Flag to start next program
                        Clk,            // CPU clock 
                        Jump,           // Unconditional branch (jump) signal
                        BOE,            // Conditional branch (BOE) signal
                        IsEqual,        // Flag from ALU to check if values are equal
    input [9:0]         Target,         // Target address to jump to
    output logic [9:0]  ProgCtr         // Register that holds current PC value
);

    always_ff @( posedge clock ) begin
        if (Reset)
            ProgCtr <= 0;
        else if (Start)
            ProgCtr <= ProgCtr;             // keep value if start flag is high
        else if (Jump)
            ProgCtr <= Target;              // unconditionally jump to target
        else if (BOE && IsEqual)
            ProgCtr <= Target + ProgCtr;    // Only branch if equal
        else   
            ProgCtr <= ProgCtr + 'b1;       // Else just get next instruction
    end
    
endmodule
