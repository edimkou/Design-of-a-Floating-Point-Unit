`timescale 1ns / 1ps
//////////////////////////////////////////////////
// Author: Dimkou Eleni
// Company: UTH
// Design Name: FPAdder-fpga_mem
// Module Name:  fpga_system
// Project Name: Floating Point Adder
// Target Devices: Zedboard 
//////////////////////////////////////////////////

module fpadd_system (input clk,
                     input rst,
                     input en,
                     output [7:0] leds,
                     output an0, output a0, output b0, output c0, output d0, output e0, output f0, output g0,
                     output an1, output a1, output b1, output c1, output d1, output e1, output f1, output g1);

   wire [31:0] fp_out;
   wire [7:0] a_to_g0, a_to_g1;
   wire start_execute;
   wire [31:0]InpA, InpB;

    Debouncer_L2P Debouncer_L2P(clk, rst, en, start_execute);

    DataMemory Mem(clk, rst, start_execute, InpA, InpB);

    Fpadd_pipe Fpadd_pipe(clk, rst, InpA, InpB, fp_out);

 // Instantiate the 7segment display output 0
   SevenSegDisplay SevenSegDisplay0(clk, rst, fp_out[31:24], a_to_g0);

   // Instantiate the 7segment display output 1
   SevenSegDisplay SevenSegDisplay1(clk, rst, fp_out[23:16], a_to_g1);

    assign leds = fp_out[7:0];

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
