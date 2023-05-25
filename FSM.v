module ZeroDetector(
  input wire clk,
  input wire reset,
  input wire sample,
  output reg detection
);

  // Define the states
  parameter [1:0] S0 = 2'b00; // Initial state
  parameter [1:0] S1 = 2'b01; // One zero detected

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
            state <= S1;
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
