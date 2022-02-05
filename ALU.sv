module ALU #(parameter W=8, OP=3) (
    input logic      [W-1:0]InputA,
                            InputB,
    input logic     [Ops-1:0] OP,
    input logic
    output logic    [W-1:0] out     


);
    always_comb begin
        case(OP)
            3'b000: out = InputA + InputB;
            3'b001: out = 
            3'b010: out =
            3'b011: out =
            3'b100: out = 
            3'b101: out =
            3'b110: out =
            3'b111: out =

endmodule