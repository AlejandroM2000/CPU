// Description: Program Counter (Instruction Fetch) for Processor
// Not tested yet

module ProgCtr #(parameter L = 10) (
    input                   Reset,             // Reset flag
                            Start,             // Unused signal to jump to next program
                            Clk,               // Clock that drives PC
                            Jump,              // Signal to unconditionally jump
                            BOE,               // Signal to conditionally jump
                            IsEqual,           // Signal from ALU, unused so far
    input [L-1:0]           Target,            // Address to jump to
    output logic [L-1:0]    ProgCtr            // Register that holds the Program Counter
);

always_ff @(posedge Clk) begin
    if (Reset)
        ProgCtr <= 0;                          // Only works for first program, need to add different value for others
    else if (Jump)
        ProgCtr <= Target;                     // Unconditional absolute jump
    else if (BOE)
        ProgCtr <= ProgCtr + Target;           // Conditional relative branch (not sure if BOE is relative or absolute)
    else
        ProgCtr <= ProgCtr + 'b1;              // Else move to next instruction
end

endmodule