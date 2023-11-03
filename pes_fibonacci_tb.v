module tb_fib_seq_calc ();

  reg clk, rst;
  wire [31:0] out;
  reg [5:0] n; // User input for the desired Fibonacci sequence number (6 bits)
  wire [5:0] counter; // Counter waveform

  fibonacci_counter u0 (
    .clk(clk),
    .rst(rst),
    .n(n), // Connect the n input
    .out(out)
  );

  always #10 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;
    n = 0; // Initialize n to 0

    #20 rst = 0;

    // Test case 1: Calculate Fibonacci for n = 0
    n = 0; // Example: Calculate Fibonacci for n = 0
    #20 
    rst = 0;

    // Wait for the calculation to complete
    #500; // Adjust this as needed

    // Reset the input, output, and counter to zero
    n = 0;
    rst = 1;

    // Wait before starting the next test case
    #100;


    // Test case 2: Calculate Fibonacci for n = 1
    n = 1; // Example: Calculate Fibonacci for n = 1
    #20
    rst = 0;

    // Wait for the calculation to complete
    #500; // Adjust this as needed

    // Reset the input, output, and counter to zero
    n = 0;
    rst = 1;

    // Wait before starting the next test case
    #100;

    // Test case 3: Calculate Fibonacci for n = 2
    n = 2; // Example: Calculate Fibonacci for n = 2
    #20
    rst = 0;

    // Wait for the calculation to complete
    #500; // Adjust this as needed

    // Reset the input, output, and counter to zero
    n = 0;
    rst = 1;

    // Wait before starting the next test case
    #100;


    // Test case 4: Calculate Fibonacci for n = 3
    n = 3; // Example: Calculate Fibonacci for n = 3
    #20
    rst = 0;

    // Wait for the calculation to complete
    #500; // Adjust this as needed

    // Reset the input, output, and counter to zero
    n = 0;
    rst = 1;

    // Wait before starting the next test case
    #100;

    // Test case 5: Calculate Fibonacci for n = 21
    n = 21; // Example: Calculate Fibonacci for n = 21
    #20
    rst = 0;

    // Wait for the calculation to complete
    #500; // Adjust this as needed

    // Reset the input, output, and counter to zero
    n = 0;
    rst = 1;

    // Test case 6: Calculate Fibonacci for n = 45
    n = 45; // Example: Calculate Fibonacci for n = 45
    #20
    rst = 0;

    // Wait for the calculation to complete
    #2000; // Adjust this as needed

    // Reset the input, output, and counter to zero
    n = 0;
    rst = 1;

    // Wait before starting the next test case
    #100;

    // Finish simulation
    $finish;
  end

  initial begin
    $dumpfile("dump_fib_seq_calc.vcd");
    $dumpvars(0);
  end

endmodule
