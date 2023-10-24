# Fibonacci Sequence Calculator

# Introduction to Fibonacci Sequence

The **Fibonacci sequence** is a series of numbers in which each number (known as a Fibonacci number) is derived by adding the two preceding numbers. The sequence typically starts with 0 and 1. The first few Fibonacci numbers are as follows:  
{0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ...}  

* Each number in the sequence is the sum of the two numbers that precede it. Mathematically, it can be expressed as:
- F(0) = 0  
- F(1) = 1  
- F(n) = F(n-1) + F(n-2) for n > 1

  
## Importance and Application

The Fibonacci sequence has relevance in various fields, including mathematics, computer science, and nature:

1. **Mathematics**: The Fibonacci sequence serves as an example of a recursive sequence and is used in mathematical modeling and research. It has connections to the golden ratio and the Fibonacci spiral.

2. **Computer Science**: Fibonacci numbers are used in algorithms and computer programs, particularly for practicing recursion and dynamic programming. They are also utilized in generating test cases for performance evaluation.

3. **Financial Markets**: In finance, Fibonacci retracement levels are used to predict potential areas of support and resistance in price trends. Traders use these levels for technical analysis.

4. **Nature**: The Fibonacci sequence appears in various natural phenomena, such as the arrangement of leaves on a stem, the spirals in a pinecone or sunflower, and the growth patterns of certain animal populations.

5. **Art and Design**: The Fibonacci sequence and the golden ratio are often applied in art and design to create visually pleasing proportions and compositions.

The Fibonacci sequence's simple yet fascinating properties make it a subject of interest in multiple domains and demonstrate its significance in understanding patterns, algorithms, and natural phenomena.

<details>
  <summary> RTL synthesis & GLS Flow </summary>

## RTL (Register-Transfer Level)

- **Definition**: RTL is a level of abstraction in digital circuit design where the behavior of a circuit is represented using registers and the data transfers between them.
- **Usage**: RTL design is a crucial step in hardware design where the functionality of the digital circuit is described using a register transfer language (HDL) like VHDL or Verilog. It serves as an intermediate representation before synthesis.

## GLS (Gate-Level Simulation)

- **Definition**: GLS is a simulation technique used to verify the logical correctness of a design after synthesis. It operates at the gate-level, taking into account the specific gates and interconnections used in the target technology.
- **Usage**: GLS ensures that the synthesized netlist matches the intended functionality of the RTL description. It's a critical step in the verification process for digital circuits.

## Icarus Verilog (iverilog)

- **Definition**: Icarus Verilog, often referred to as iverilog, is an open-source Verilog simulation and synthesis tool. It is used for compiling and simulating Verilog designs.
- **Usage**: Icarus Verilog is utilized by digital design engineers for simulating and validating RTL designs described in the Verilog hardware description language. It helps in debugging and testing digital circuits.

## Yosys

- **Definition**: Yosys is an open-source framework for RTL synthesis and formal verification. It takes RTL descriptions (in Verilog, for example) and generates gate-level representations for different target technologies.
- **Usage**: Yosys is used for RTL synthesis, which transforms high-level RTL descriptions into gate-level netlists suitable for manufacturing. It also offers formal verification capabilities.

## GTKWave

- **Definition**: GTKWave is an open-source waveform viewer for viewing simulation output. It is used to visualize digital signals and their behavior over time.
- **Usage**: GTKWave is commonly used for analyzing and debugging simulation results from various digital design tools. It provides a graphical representation of signal waveforms, helping designers understand and troubleshoot their circuits.

These tools play crucial roles in digital design, verification, and simulation processes, ensuring the correctness and functionality of digital circuits at different levels of abstraction.  

* Pre-Simulation Synthesis  

- Create the verilog file -  
  ```` fib_seq_calc.v````  
   with the code given.
  
````
	  
````
-Create the test-bench  
```` tb_fib_seq_calc.v````  
with the code given.

````
module tb ();

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
````
























</details>
  


