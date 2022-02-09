module ALU #(parameter W=8, Ops=3) (
    input logic      [W-1:0]A,
                            B,
    input logic     [Ops-1:0] OP,
    output logic    [W-1:0] out,
    output logic            Zero,
                            Sign     


);
    always_comb begin
        case(OP)
            3'b000: out = A + B; // add 
            //3'b001: out = {0,A[W-1:W-B]}; //shift right
				3'b001: out = A >> 1;
            //3'b010: out = {A[W-B:0],0}; //shift left
				3'b010: out = A << 1;
            3'b011: out = A ^ B;  //XOR
				default: out = 0;
        endcase
    end
            

    assign Zero = !out;
    assign Sign = out[0];
endmodule