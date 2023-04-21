`timescale 1ns / 1ps
/*
 -----------------------------------------------------------------------------
 -- File           : fpadd_system.v
 -----------------------------------------------------------------------------
 */ 
 module fpadd_system (input clk,
                      input rst, 
                      // input noisy_level,
                      //input [31:0] InpA,
                      //input [31:0] InpB,
                      output [7:0] leds, 
                      output an0, output a0, output b0, output c0, output d0, output e0, output f0, output g0,
                      output an1, output a1, output b1, output c1, output d1, output e1, output f1, output g1);

   wire [31:0] fp_out;
   wire [7:0] a_to_g0, a_to_g1;

   // Try this addition of FP numbers 
   // 6b64b235 + 6ac49214 = 6ba37d9f 
	   
   // Instantiate the FP adder
   fpadd_single fpadd_single(clk, rst, 32'h6b64b235, 32'h6ac49214, fp_out); // The output is 32 bit and the A and B I will change them.

   assign leds = fp_out[7:0];
   
   // Instantiate the 7segment display output 0 
   SevenSegDisplay SevenSegDisplay0(clk, rst, fp_out[31:24], a_to_g0);

   // Instantiate the 7segment display output 1
   SevenSegDisplay SevenSegDisplay1(clk, rst, fp_out[23:16], a_to_g1);


   assign an0 = a_to_g0[7];
   assign a0 = rst ? 0 : a_to_g0[6];
   assign b0 = rst ? 0 : a_to_g0[5];
   assign c0 = rst ? 0 : a_to_g0[4];
   assign d0 = rst ? 0 : a_to_g0[3];
   assign e0 = rst ? 0 : a_to_g0[2];
   assign f0 = rst ? 0 : a_to_g0[1];
   assign g0 = rst ? 1 : a_to_g0[0];

   assign an1 = a_to_g1[7];
   assign a1 = rst ? 0 : a_to_g1[6];
   assign b1 = rst ? 0 : a_to_g1[5];
   assign c1 = rst ? 0 : a_to_g1[4];
   assign d1 = rst ? 0 : a_to_g1[3];
   assign e1 = rst ? 0 : a_to_g1[2];
   assign f1 = rst ? 0 : a_to_g1[1];
   assign g1 = rst ? 1 : a_to_g1[0];

endmodule
