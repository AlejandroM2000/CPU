module ALU #(parameter W=8, Ops=2) (
    input logic      [W-1:0]A,
                            B,
                            C,
    input logic     [Ops-1:0] OP,
    output logic    [W-1:0] out, 
    output logic            isEqual   
);

    
    always_comb begin
        case(OP)
            2'b00: out = A + B; // add 
            2'b01: out = A >> B; //shift right
            2'b10: out = A << B; // shift left
            // 3'b010: begin
            //         outA < B
            //         out[B] = ^A;
            // end; //shift left
            2'b11: begin  // Incorrect check for opcode XORR
                out = A;
                out[B] = ^A;
            end
        endcase
    end
            

    //assign Zero = !out;
    //assign Sign = out[0];
    assign isEqual = (OP == 2'b10) && (A == C);
endmodule