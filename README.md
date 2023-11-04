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
	  
````

![Screenshot from 2023-11-03 07-27-36](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/03e7c8b4-0049-451b-897f-41248e68bcf2)



-Create the test-bench using command -      
```` vim tb_fib_seq_calc.v````  
with the code given.

````
module tb_fib_seq_calc ();

  reg clk, rst;
  wire [31:0] out;
  reg [5:0] n; // User input for the desired Fibonacci sequence number (6 bits)
  wire [5:0] counter; // Counter waveform

  fib_seq_calc u0 (
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

![Screenshot from 2023-11-03 07-29-47](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/b6f67c88-7715-4f72-bb04-91c2b2c15b48)



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
![Screenshot from 2023-11-03 07-19-31](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/b5601190-b0c2-463e-a69c-3f3417a48a39)

![Screenshot from 2023-11-03 07-19-39](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/fff07f96-3a64-4ef0-ac17-6a6fa3f80d7c)


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
![Screenshot from 2023-11-03 07-23-22](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/4630c2f2-bb80-4219-a415-59d9c267f9ad)


- To reduce the net file -

````
write_verilog -noattr fib_seq_calc_net.v
!vim fib_seq_calc_net.v
````
![Screenshot from 2023-11-03 07-23-58](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/cc433596-0c8e-4d20-83e3-a4148b96cc6a)


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

<details>
	<summary> Physical Design </summary>

**Physical Design:**  

Physical design in the context of integrated circuits involves the process of transforming a logical design (a high-level description of a circuit) into a physical representation that can be manufactured. This includes tasks like synthesis, floorplanning, placement, routing, design rule checks. The goal is to create an efficient and manufacturable layout while meeting performance, power, and area constraints.

**Tools:**

1. Ngspice:
   - Ngspice is an open-source mixed-level/mixed-signal electronic circuit simulator.
   - It is used for simulating and analyzing analog, digital, and mixed-signal circuits.
   - Ngspice can be used for tasks like transient analysis, AC analysis, and DC analysis of electronic circuits.

2. Magic:
   - Magic is an open-source VLSI layout and design tool.
   - It's used for the physical layout design of integrated circuits.
   - Magic allows designers to create and edit layouts, perform design rule checks, and generate GDSII files for fabrication.

3. OpenLane:
   - OpenLane is an open-source digital ASIC design flow.
   - It automates the process of taking a high-level RTL (Register-Transfer Level) description and transforming it into a manufacturable GDSII file.
   - OpenLane includes several tools and scripts for synthesis, place and route, and other physical design tasks to streamline the ASIC design process.

- in the home directory download the following tools.

**ngspice**

- download the ngspice file tar zip file - "https://sourceforge.net/projects/ngspice/files/"

````
sudo apt-get install libxaw7-dev
tar -zxvf ngspice-41.tar.gz
cd ngspice-41
mkdir release
cd release
../configure  --with-x --with-readline=yes --disable-debug
sudo make
sudo make install
````

**magic** 
````
sudo apt-get install m4
sudo apt-get install tcsh
sudo apt-get install csh
sudo apt-get install libx11-dev
sudo apt-get install tcl-dev tk-dev
sudo apt-get install libcairo2-dev
sudo apt-get install mesa-common-dev libglu1-mesa-dev
sudo apt-get install libncurses-dev
git clone https://github.com/RTimothyEdwards/magic
cd magic
./configure
sudo make
sudo make install
````

**OpenLane**
````
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential python3 python3-venv python3-pip make git

sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot 
# After reboot
docker run hello-world (should show you the output under 'Example Output' in https://hub.docker.com/_/hello-world)

- To install the PDKs and Tools
cd $HOME
git clone https://github.com/The-OpenROAD-Project/OpenLane
cd OpenLane
make
make test
````

**Work-Flow:**

- In the designs folder of the OpenLane, create a folder with the name of your design.

![Screenshot from 2023-11-04 18-07-44](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/cb3da22f-174d-4fa3-9b9a-eb001c059d75)

- In the the folder of your design, create a config.json file and a src folder.

![Screenshot from 2023-11-04 18-08-23](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/c1beac3e-a853-41c4-8526-a3871de654d3)

![Screenshot from 2023-11-04 18-09-58](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/416201e2-6636-402c-8639-f1c69457014a)  

- In the src folder, create a file with verilog file of your design and all the libraries required.

![Screenshot from 2023-11-04 18-08-49](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/41a87763-aba3-49fc-b8ef-45379fa3235a)

- In the OpenLane folder, create a folder pdks and the following files.

```` mkdir pdks ````

![Screenshot from 2023-11-04 18-21-28](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/4bafa0b3-ebe5-4d48-90b5-7cb03a8366c1)


- In the OpenLane folder terminal, type the following commands.

````
make mount
./flow.tcl -interactive
prep -design fib_seq_calc
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs
````
![Screenshot from 2023-11-04 19-06-39](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/4444673c-7ab8-4453-8e23-1c43bbada1ca)

 
**Synthesis**

````
run_synthesis
````

![Screenshot from 2023-11-04 19-08-00](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/4bc76284-6f54-4ba0-9a20-23df6366cd10)

![Screenshot from 2023-11-04 19-09-50](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/1245eef5-a1a6-44d7-80dc-d836f8084a6a)

![Screenshot from 2023-11-04 19-09-58](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/81a560b2-cf9d-4c82-ad43-46c630b19233)


* Flop-Ratio:

- DFRTP = (Number of DFFs with differential reset-to-preset) / (Total number of cells)  

DFRTP = 69 / 576 ≈ 0.1198

- DFSTP = (Number of DFFs with differential set-to-preset) / (Total number of cells)

DFSTP = 1 / 576 ≈ 0.0017

- DFXTP = (Number of DFFs with differential flip-to-preset) / (Total number of cells)

DFXTP = 32 / 576 ≈ 0.0556

**Floorplan**

````
run_floorplan
````
- to we view the design navigate into the terminal

````
magic -T /home/lalith/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read fib_seq_calc.def &
````

![Screenshot from 2023-11-04 19-10-55](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/39ec4376-1a72-4d75-880a-2158f3e06fd5)  
![Screenshot from 2023-11-04 19-12-01](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/b80981b3-d465-40bf-8bf0-14ca99fbff51)
![Screenshot from 2023-11-04 19-12-25](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/464ac5a8-1cbb-4e65-a52d-8cccd62e293b)
![Screenshot from 2023-11-04 19-12-35](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/028cf001-880a-47fd-a383-53f64dbc01da)
![Screenshot from 2023-11-04 19-12-41](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/a8e27f45-6a98-4c2d-ad10-5f75fa498e57)

**Placement**

````
run_placement
````
- to we view the design navigate into the terminal

````
magic -T /home/lalith/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read fib_seq_calc.def &
````
![Screenshot from 2023-11-04 19-15-14](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/a1014af1-e118-4bb8-812e-faae610b7735)
![Screenshot from 2023-11-04 19-16-24](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/297f99f2-8a70-4a4f-9aa4-feef54664457)
![Screenshot from 2023-11-04 19-16-46](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/6ac440fd-d7cf-4417-afb3-c6e7d577f425)
![Screenshot from 2023-11-04 19-16-51](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/8e6dd8de-23c4-4fdc-97c2-d95983fb3201)
![Screenshot from 2023-11-04 19-16-55](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/aa3a6fd6-5fa8-4dc4-91d9-8a625c2ee3a5)

**CTS(Clock Tree Synthesis)**

````
run_cts
````
![Screenshot from 2023-11-04 19-27-07](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/8eaca168-1bbb-44aa-bad1-27fa52944a67)

![Screenshot from 2023-11-04 19-21-44](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/854997d6-2be3-41a7-a15c-36ba5cb2ff2d)

![Screenshot from 2023-11-04 19-21-54](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/4af39e5a-dade-4f97-abac-1dc2bd466b79)

![Screenshot from 2023-11-04 19-22-14](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/25e7191b-d86e-45ee-9f2c-128edec71c50)

![Screenshot from 2023-11-04 19-22-21](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/a7875679-4027-41cc-b590-4b08e9824640)

![Screenshot from 2023-11-04 19-22-38](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/5721868a-c4f1-4f63-83fc-e2e1cb4bdf81)

![Screenshot from 2023-11-04 19-22-45](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/ca854eca-cd2d-4875-89e5-a43733afcba4)

![Screenshot from 2023-11-04 19-23-14](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/62fc09a8-0be4-4977-986a-a351d134837a)

![Screenshot from 2023-11-04 19-23-21](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/8fbac91c-4e51-4989-8f6c-2686871fc3da)

![Screenshot from 2023-11-04 19-23-30](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/4d3fadc2-faca-47e2-8df9-9da87a6f149d)

![Screenshot from 2023-11-04 19-24-06](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/401ba188-eb53-4969-aae0-de5335823ccb)

* Power Report

![Screenshot from 2023-11-04 19-25-18](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/84b56e11-9133-4c54-87a0-6ace5ec29ca4)

* Skew Report

![Screenshot from 2023-11-04 19-25-45](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/000e48b7-43cb-4de1-b55d-c7f7f1e218a2)

* Area Report

![Screenshot from 2023-11-04 19-26-05](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/6afd78b5-938d-4d08-81a3-8d8a310db499)


**Routing** 

````
run_routing
````
- to we view the design navigate into the terminal

````
magic -T /home/lalith/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read fib_seq_calc.def &
````

![Screenshot from 2023-11-04 19-32-35](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/afca3629-c82a-45a4-a105-10160a2dc72f)
![Screenshot from 2023-11-04 19-38-00](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/aedaf47a-2474-4eae-b189-408c0270e6a1)
![Screenshot from 2023-11-04 19-38-15](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/df3f87e0-97f5-45d9-ac8a-fc86429a13f3)
![Screenshot from 2023-11-04 19-38-25](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/93cf825c-9047-4d56-9196-01051a003978)
![Screenshot from 2023-11-04 19-38-30](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/32761fad-89cc-464b-a6ff-2c7d2f019706)
![Screenshot from 2023-11-04 19-38-35](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/410c72dd-c9ab-4947-b784-65abebd92567)
![Screenshot from 2023-11-04 19-38-39](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/73fc364b-d221-45b2-bf56-0f6ab6a64a6d)
![Screenshot from 2023-11-04 19-38-53](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/1c412d93-8c17-4999-886a-a5f2a1a033e6)  

* Final Congestion Report

![Screenshot from 2023-11-04 19-41-19](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/fad8ff67-c603-4bfe-b2de-ac34e79c271f)

* Power Report

![Screenshot from 2023-11-04 19-43-24](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/20df3c2d-2390-413c-ae14-a96305beb9c1)

* Skew Report

![Screenshot from 2023-11-04 19-44-13](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/45ff8580-ec7e-4b61-85d6-02612f13f994)

* Summary Report

![Screenshot from 2023-11-04 19-44-58](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/1e34c1b7-acce-4005-b6da-a1cf90df6390)  

* Area Report

![Screenshot from 2023-11-04 19-45-17](https://github.com/lalithlochanr/pes_fibonacci/assets/108328466/00e64300-3ba6-4967-bd4f-fd43eb480bca)  




**Final Statistics**:

- Area = 113695.336 um2
- Internal Power = 1.46e-03 W
- Switching Power = 7.74e-04
- Leakage Power = 3.84e-09
- Total Power = 2.24e-03

</details>
  


