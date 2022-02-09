module ALU_tb;

timeunit  1ns/1ps;

int width = 8;
int op = 3;

logic [width-1:0]A,
                 B;
logic [op-1:0]OP;
logic [width-1:0] out;
logic             Zero,
                  Sign;    
ALU uut(
    .A(A),
    .B(B),
    .OP(OP),
    .out(out),
    .Zero(Zero),
    .Sign(Sign)
);

initial begin

 INPUTA = 1;
 INPUTB = 1;
 OP= 'b000; // ADD
 test_alu_func; // void function call
 #5;


 INPUTA = 4;
 INPUTB = 2;
 OP= 'b001; // shift right
 test_alu_func; // void function call
 #5;


INPUTA = 1;
 INPUTB = 2;
 OP= 'b010; // shift right
 test_alu_func; // void function call
 #5;

 INPUTA = 5;
 INPUTB = 5;
 OP= 'b011; // XOR
 test_alu_func; // void function call
 #5;
 end

 task test_alu_func;
 begin
   case (op)
  0: expected = INPUTA + INPUTB;  // ADD 
  1: expected = {0,INPUTA[W-1:W-INPUTB];  // RSH
  2: expected = {INPUTA[W-INPUTB:0],0};  // LSH
  3: expected = INPUTA ^ INPUTB;  // XOR
   endcase
   #1; if(expected == OUT)
  begin
   $display("%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, INPUTA,INPUTB,op, Zero);
  end
     else begin $display("%t FAIL! inputs = %h %h, opcode = %b, zero %b",$time, INPUTA,INPUTB,op, Zero);end

 end
 endtask
