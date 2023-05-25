module DFF_with_Reset(
  input wire clk,
  input wire reset,
  input wire d,
  output reg q
);

  always @(posedge clk or negedge reset) begin
    if (reset == 1'b0) begin
      q <= 1'b0;   // Reset the output to 0 when reset is asserted
    end
    else begin
      q <= d;      // Update the output with the input value when reset is de-asserted
    end
  end

endmodule


//TestBench
module DFF_with_Reset_Testbench;

  reg clk;
  reg reset;
  reg d;
  wire q;

  // The module is instantiated as dut
  DFF_with_Reset dut (
    .clk(clk),
    .reset(reset),
    .d(d),
    .q(q)
  );

  // Clock generation
  always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end

  // Stimulus generation
  initial begin
    reset = 1'b1;
    d = 1'b0;
    #10;
    reset = 1'b0;
    d = 1'b1;
    #10;
    d = 1'b0;   // The output should remain 0 due to reset
    #10;
    reset = 1'b1;  // Reset is asserted again
    #10;
    reset = 1'b0;  // Reset is de-asserted
    d = 1'b1;     // The output should capture the input value
    #10;
    d = 1'b0;
    #10;
    $finish;
  end

endmodule

