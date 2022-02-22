module ALU_tb;

timeunit  1ns/1ps;

// int width = 8;
// int op = 3;

logic [7:0]A, B;
logic [2:0] OP;
logic [7:0] out;
logic             Zero,
                  Sign;  
logic [7:0] expected;

ALU uut(
    .A(A),
    .B(B),
    .OP(OP),
    .out(out),
    .Zero(Zero),
    .Sign(Sign)
);

initial begin

 A = 1;
 B = 1;
 OP= 'b000; // ADD
 test_alu_func; // void function call
 #5;


 A = 4;
 B = 2;
 OP= 'b001; // shift right
 test_alu_func; // void function call
 #5;


A = 1;
 B = 2;
 OP= 'b010; // shift right
 test_alu_func; // void function call
 #5;

 A = 5;
 B = 5;
 OP= 'b011; // XOR
 test_alu_func; // void function call
 #5;
 end

 task test_alu_func;
 begin
   case (OP)
  0: expected = A + B;  // ADD 
  //1: expected = {0,A[W-1:W-B];  // RSH
  1: expected = A >> 1;
  //2: expected = {A[W-B:0],0};  // LSH
  2: expected = A << 1;
  3: expected = A ^ B;  // XOR
   endcase
   #1; if(expected == out)
  begin
   $display("%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, A,B,OP, Zero);
  end
     else begin $display("%t FAIL! inputs = %h %h, opcode = %b, zero %b",$time, A,B,OP, Zero);
     end

 end
 endtask

endmodule