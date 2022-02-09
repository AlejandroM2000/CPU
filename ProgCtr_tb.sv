// Test bench for Program Counter

module ProgCtr_tb;

timeunit 1ns/1ps;

bit Reset;
bit Start;
bit Clk;
bit Jump;
bit BOE;
bit IsEqual;
bit  [9:0] Target;
logic [9:0] ProgCtr_o;

ProgCtr uut (
    .Reset(Reset),
    .Start(Start),
    .Clk(Clk),
    .Jump(Jump),
    .BOE(BOE),
    .IsEqual(IsEqual),
    .Target(Target),
    .ProgCtr(ProgCtr_o)
);


initial begin
  // Time 0 values
  Reset = 1'b1;
  Start = '0;
  Clk = '0;
  Jump = '0;
  BOE = '0;
  IsEqual = '0;
  Target = '0;

  // Advance simulation 1 time unit, latch values
  #1 Clk = '1;
  
  // Advance simulation 1 time unit and check results
  #1 Clk = '0;
  $display("Check Reset Behavior");
  assert (ProgCtr_o == 'd0);
  
  Reset = 1'b0;
  
  // Advance to latch values
  #1 Clk = '1;
  
  // Advance and check
  #1 Clk = '0;
  $display("Check that nothing happens before start");
  assert (ProgCtr_o == 'd0);
  Start = '1;
  
  // latch
  #1 Clk = '1;
  
  // Advance, check, prepare next
  #1 Clk = '0;
  $display("check that nothing happened while Start was high");
  assert (ProgCtr_o == 'd0);
  Start = '0;
  
  // latch
  #1 Clk = '1;
  
  // Advance, check, prepare next
  #1 Clk = '0;
  $display("Check that the first Start went to first program");
  assert (ProgCtr_o == 'd4);
  
  // Latch, advance, check, prepare
  #1 Clk = '1;
  #1 Clk = '0;
  $display("Check that Pc advanced by 1");
  assert (ProgCtr_o == 'd5);
  Jump = '1;
  Target = 'd10;
  
  // Latch, advance, check, prepare
  #1 Clk = '1;
  #1 Clk = '0;
  $display("check jump to target 10");
  assert (ProgCtr_o == 'd10);
  Jump = '0;
  BOE = '1;
  IsEqual = '1;
  Target = 'd10;
  
  // Latch, advance, check
  #1 Clk = '1;
  #1 Clk = '0;
  $display("Check relative jump to target 20");
  assert (ProgCtr_o== 'd20);
  
  
end

endmodule