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
  $display("Time 1 ns: Check Reset Behavior");
  $display("This checks that when Reset is high, the PC remains at 0");
  assert (ProgCtr_o == 'd0);
  
  Reset = 1'b0;
  
  // Advance to latch values
  #1 Clk = '1;
  
  // Advance and check
  #1 Clk = '0;
  $display("Time 3 ns: Check that nothing happens before start");
  $display("This checks that the PC remains at 0 if start is not 1");
  assert (ProgCtr_o == 'd0);
  Start = '1;
  
  // latch
  #1 Clk = '1;
  
  // Advance, check, prepare next
  #1 Clk = '0;
  $display("Time 5 ns: Check that nothing happened while Start was high");
  $display("Make sure that first clock posedge when start is high does not increment PC",);
  assert (ProgCtr_o == 'd0);
  Start = '0;
  
  // latch
  #1 Clk = '1;
  
  // Advance, check, prepare next
  #1 Clk = '0;
  $display("Time 7 ns: Check that the first Start went to first program");
  $display("Assuming first program is at PC=4, checks that Start signal sets PC to 4");
  assert (ProgCtr_o == 'd4);
  
  // Latch, advance, check, prepare
  #1 Clk = '1;
  #1 Clk = '0;
  $display("Time 9 ns: Check that Pc advanced by 1");
  $display("Check that PC increments as expected with no other flags are high");
  assert (ProgCtr_o == 'd5);
  Jump = '1;
  Target = 'd10;
  
  // Latch, advance, check, prepare
  #1 Clk = '1;
  #1 Clk = '0;
  $display("Time 11 ns: Check branch to target 10");
  $display("Check that Jump works as expected, by jumping PC from 5 to target 10",);
  assert (ProgCtr_o == 'd10);
  Jump = '0;
  BOE = '1;
  IsEqual = '1;
  Target = 'd10;
  
  // Latch, advance, check
  #1 Clk = '1;
  #1 Clk = '0;
  $display("Time 13 ns: Check relative jump to target 20");
  $display("Check that branch on equal works, by setting relevant flags high, a PC-relative branch to 20 is performed",);
  assert (ProgCtr_o== 'd20);
  
  
end

endmodule