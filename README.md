# Design-of-a-Floating-Point-Unit
Design, functional simulation, and implementation (synthesis, placement and routing) of a Floating Point Adder in Verilog using the Xilinx Vivado® toolset. I also, test the design on Zedboard under different configurations.


## Step 1 
In the first step I design and simulate a Floating Point Unit that performs single-precision addition in a single clock cycle. The Floating Point Adder that I developed in this section is a hardware model for the IEEE Standard 754-1985 for single-precision floating point numbers. According to the 754 IEEE standard, a floating-point number contains a sign bit, an exponent, and a mantissa. For the 32-bit standard, the format is illustrated in the figure below.  
![image](https://user-images.githubusercontent.com/77272704/232166908-1a6f1e09-2b40-48f7-8bd8-acdfecb54218.png)  

1. The value of number F is given by the following equation:    
![image](https://user-images.githubusercontent.com/77272704/232166618-a16adb30-1967-4c19-8734-113e67390132.png)   
2. This equation is valid only for:   
![image](https://user-images.githubusercontent.com/77272704/232166669-e1edeb0a-bbc1-49cf-95e0-c7c40bb62770.png)  
  
In my case I assume that the input values to the FP Adder are given so that they satisfy condition (2) and that the addition does not result in underflow or overflow so there is no need to check for these conditions.

## Step 2  
In the second step I design and accomodate the behavioral simulation of a pipelined FP Adder. I expand my design from the step 1 to compute the FP addition in two pipeline stages. I decide to allocate the functionality of the comparison and the adjustment of the exponents,the  appropriately shifting of the mantissa (only if it is necessary) and the addition of the two mantissas (if the 2 inputs have the same signs or a substraction if the 2 inputs have different signs) in the 1st stage. In the second stage is executing the normalazation of the number which is the output from the previous step.

## Step 3
Now I implement the design on the Zedboard board. In this stage I implement some form of I/O using the peripherals available on the Zedboard. The Zedboard provides 8 LEDs that can be used to output 8 (out of the 32) bits of the result. I also use a more sophisticated form of output: the seven segment display which is a peripheral connected to the PMOD ports of the Zedboard depicting a total of 4 digits - 16 bits. Moreover, the 8 least signifcant outputs bits are driven to the onboard LEDs. After this step I implement my hardware system on an FPGA board as shown in the figure bellow after.
![image](https://user-images.githubusercontent.com/77272704/233718140-f227119c-1d4c-41de-8e2c-925113e70bfd.png)  
  
However, besides the Verilog source code I define the design constraints specifying the FPGA  I/O pins which are assigned to the I/O module ports(clk,rst,leds,...). Completing this stage I run synthesis to parse the Verilog code to a gate-level netlist. Finally, I transform the synthesized gate-level netlist into a Xilinx proprietary bitstream that can be downloaded to program the FPGA.  

## Step 4
In this step I add some functionality to the previous step. The main perpuse of this stage is the ability for multiple inputs to the FP Adder and in order to achive that I wrote a Data Memory module in which are instantiated with the input values of my choice. The Data Memory is being read each time the user pressed a Zedboard button. If the user preeses rst an internal read pointer ptr of the Data Memory will move to the beggining, otherwise, it will move to the next entry Mem[ptr] and will provide the corresponding two input FP32 numbers to the FP adder. Also, I construct a module that receives a multi-cycle pulse signal (preesed button) as input and generates a single-cycle pulse signal as output that is stable for 0,1sec, if the input signal changes sooner than o,1secs I assume that it was mechanical noise (debouncing mechanism).    
  
In the figure below is shown the additional hardware of step 4.  
![image](https://user-images.githubusercontent.com/77272704/233723266-3c3b2046-7c39-4c0f-957c-f060237c144f.png)
  
