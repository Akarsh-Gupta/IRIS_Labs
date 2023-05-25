module ZeroDetector(
  input wire clk,
  input wire reset,
  input wire sample,
  output reg detection
);

  // Define the states
  parameter [1:0] S0 = 2'b00; // Initial state
  parameter [1:0] S1 = 2'b01; // One zero detected
  parameter [1:0] S2 = 2'b10; // More than one zero detected

  // Define the state register
  reg [1:0] state;

  // Define the next state logic
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= S0;
    else begin
      case (state)
        S0: begin
          if (sample == 1'b0)
            state <= S1;
          else
            state <= S0;
        end
        S1: begin
          if (sample == 1'b0)
            state <= S2;
          else
            state <= S0;
        end
        S2: begin
          if (sample == 1'b0)
            state <= S2;
          else
            state <= S0;
        end
      endcase
    end
  end

  // Define the output logic
  always @(state) begin
    if (state == S2)
      detection = 1'b1;
    else
      detection = 1'b0;
  end

endmodule

// TestBench
module ZeroDetector_Testbench;

  reg clk;
  reg reset;
  reg sample;
  wire detection;

  ZeroDetector dut (
    .clk(clk),
    .reset(reset),
    .sample(sample),
    .detection(detection)
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
    #10;
    reset = 1'b0;
    #5;
    sample = 1'b0; // First sample
    #10;
    sample = 1'b1; // Second sample
    #10;
    sample = 1'b0; // Third sample - Detection should be asserted
    #10;
    sample = 1'b0; // Fourth sample - Detection should still be asserted
    #10;
    sample = 1'b1; // Fifth sample - Detection should be de-asserted
    #10;
    $finish;
  end

endmodule
