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

* Pre-Simulation   

- Create the verilog file using command  -  
  ```` vim fib_seq_calc.v````  
   with the code given.
  
````
module fibonacci_counter (
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
	  
````

![Screenshot from 2023-10-24 23-33-48](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/c214ab6a-4b33-4d49-b443-ed62de193cea)


-Create the test-bench using command -      
```` vim tb_fib_seq_calc.v````  
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

![Screenshot from 2023-10-24 23-34-06](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/76d421b5-e3eb-4ebe-85f5-7731e94dee70)

* Simulation
  
- Implement this code using iverilog then execute the file and obtain vcd file and obtain the waveform using gtkwave by following the commands
  below.

  ````
  iverilog fib_seq_calc.v tb_fib_seq_calc.v
  ./a.out
  gtkwave dump_fib_seq_calc.vcd
  ````
![Screenshot from 2023-10-24 23-34-34](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/7ff0c345-0293-4b6b-8aa1-0144c0fcc1de)

* Verify the waveform - (the bits represent hexadecimal values!!!!)

![Screenshot from 2023-10-24 23-35-18](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/9f533ff4-8963-43bd-b852-2e21665c732e)

![Screenshot from 2023-10-24 23-35-32](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/dbb21da7-50b3-4bd2-b6e4-1954009ad118)

![Screenshot from 2023-10-24 23-35-43](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/1f267662-d98f-43c8-940a-bd26023fb4f6)

![Screenshot from 2023-10-24 23-35-49](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/aa07a829-5950-4fe9-8ff6-6bd41b388481)

![Screenshot from 2023-10-24 23-36-24](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/9dfcb302-2d43-469c-be20-44bffd6c1646)

![Screenshot from 2023-10-24 23-36-46](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/ab948da8-2df3-4406-96d4-4de6849a28ed)

* RTL (Register-Transfer Level) Synthesis

- Invoke yosys

````
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog fib_seq_calc.v
synth -top fibonacci_counter
````

![Screenshot from 2023-10-24 23-39-34](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/45b5bdc4-cc85-49bd-860c-5dc8b3130b9a)

![Screenshot from 2023-10-24 23-39-47](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/d393a6f0-038e-4798-b51d-a5c20d3800d5)

- For viewing netlist -

````
abc -liberty -lib ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
````
![Screenshot from 2023-10-24 23-42-16](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/befcdd17-04a4-458b-b437-9dfcde5afdfc)

![Screenshot from 2023-10-24 23-42-33](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/2fda4e27-d044-41c0-90f6-9503959346a0)

![Screenshot from 2023-10-24 23-42-50](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/086fbfad-f024-4bd4-8e70-3ae683645d9b)

![Screenshot from 2023-10-24 23-43-00](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/51d74c6e-54b1-40f6-a5e8-c1d8abca7127)

![Screenshot from 2023-10-24 23-44-16](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/c92d28c8-4a2b-4ac1-a7c7-e3d2967bb558)

- To obtain net file -

````
write_verilog fib_seq_calc_net.v
!vim fib_seq_calc_net.v
````
![Screenshot from 2023-10-24 23-45-32](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/b01ba4f1-066b-4bb2-9777-e8cea2c0844f)

- To reduce the net file -

````
write_verilog -noattr fib_seq_calc_net.v
!vim fib_seq_calc_net.v
````

![Screenshot from 2023-10-24 23-46-14](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/811af82c-f577-42fb-befa-ef7799c2725a)

* GLS (Gate Level Simulation)

- we generate the waveform with the netlist file generated.

````
iverilog ../my_lib/verilog_model/primitives.v ../my_lib/verilog_model/sky130_fd_sc_hd.v fib_seq_calc_net.v tb_fib_seq_calc.v
````
![Screenshot from 2023-10-24 23-48-10](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/bc86263b-c348-4882-88ca-19edc657b27f)

- execute the file and obtain the waveform.

````
./a.out
gtkwave dump_fib_seq_calc.vcd
````

![Screenshot from 2023-10-24 23-54-53](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/c79dd18e-049b-4aad-ac4b-473c372f2753)

![Screenshot from 2023-10-24 23-53-38](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/48e3f4d2-8904-40cb-9369-981a6d60f253)


</details>
  


