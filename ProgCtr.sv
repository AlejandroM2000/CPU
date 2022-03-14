// Description: Program Counter (Instruction Fetch) for Processor
// Tested using ProgCtr_tb

module ProgCtr #(parameter L = 10) (
    input                   Reset,             // Reset flag
                            Start,             // Signal to jump to next program
                            Clk,               // Clock that drives PC
                            //Jump,              // Signal to unconditionally jump
                            BOE,               // Signal to conditionally jump
                            IsEqual,           // Signal from ALU
    input [L-1:0]           Target,            // Address to jump to
    output logic [L-1:0]    ProgCtr            // Register that holds the Program Counter
);

logic ever_start;
logic last_start;

always_ff @(posedge Clk) begin
    if (Reset)
        ProgCtr <= 0;                          // Only works for first program, need to add different value for others
    // else if (Jump)
    //     ProgCtr <= Target;                     // Unconditional absolute jump
    else if (BOE && IsEqual)
        ProgCtr <= Target;           // Conditional relative branch (not sure if BOE is relative or absolute)
    else
        ProgCtr <= ProgCtr + 'b1;              // Else move to next instruction

	if (Reset) begin
		ever_start <= '0;
		last_start <= '0;
	end else begin
		last_start <= Start;
		if (Start == '1) begin
			ever_start <= '1;
		end
	end

	if (ever_start == 0) begin
		ProgCtr <= 0;
	end else if (Start == 1) begin
		ProgCtr <= 0;
	end else if ( (last_start == '1) && (Start == '0)) begin
		ProgCtr <= 'd90;           // Set to 90 for now, test when second instruction is added
	end
end

endmodule