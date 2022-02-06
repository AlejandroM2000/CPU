module ALU #(parameter W=2, OP=3) (
    input logic      [W-1:0]A,
                            B,
    input logic     [Ops-1:0] OP,
    input logic
    output logic    [W-1:0] out
    output logic            Zero,
                            Sign     


);
    always_comb begin
        case(OP)
            3'b000: out = A + B; // add 
            3'b001: out = {1'b0,A[W-1:1]}; //shift right
            3'b010: out = {A[W-2:0], 1'b0}; //shift left
            3'b011: out = A ^ B;  //XOR
        endcase
    end
            

    assign Zero = !out;
    assign Sign = out[0];
endmodule