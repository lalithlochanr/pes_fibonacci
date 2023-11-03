module fib_seq_calc (
  input  clk,
  input  rst,
  input  [5:0] n,          // Input for the desired Fibonacci sequence number (6 bits)
  output wire [31:0] out
);

  // Registers to store the current and previous values of the Fibonacci counter
  reg [31:0] RegA, RegB ;
  reg [5:0] counter;      // Counter to keep track of Fibonacci sequence number
  reg [31:0] par_out;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      RegA <= 32'h1;     // Start RegA with the second value of the Fibonacci series - '1'
      RegB <= 32'h0;     // Start RegB with the first value of the Fibonacci series - '0'
      counter <= 6'b0;   // Reset the counter to zero
     end
    else begin
      if (counter <= n) begin
        RegA <= (RegB == 32'h80000000) ? 32'h1 : (RegA + RegB); // if RegB == 2^31, reset RegA
        RegB <= (RegB == 32'h80000000) ? 32'h0 : RegA;           // if RegB == 2^31, reset RegB
        par_out <=  RegB ; // RegB output stored as par_out
       	counter <= counter + 1; // Increment the counter
        end
      else
	par_out = 32'h0;      // 32'h0 output stored as par_out
    end
  end

  assign out = par_out;

endmodule
