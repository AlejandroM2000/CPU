module ALU #(parameter W=8, Ops=3) (
    input logic      [W-1:0]A,
                            B,
	input logic  [1:0]imm,
    input logic     [Ops-1:0] OP,
    output logic    [W-1:0] out,
    output logic            Zero,
                            Sign     


);

    always_comb begin
        case(OP)
            3'b000: out = A + B; // add 
            3'b001: out = A >> B; //shift right
            3'b010: out = A << B; //shift left
            3'b011: out = ^A;  //XOR
		    default: out = 0;
        endcase
    end
            

    assign Zero = !out;
    assign Sign = out[0];
endmodule
