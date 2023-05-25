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
