`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UTH
// Design Name: 
// Module Name:    testbench
// Project Name: Floating Point Adder- testbench
// Target Devices: Zedboard 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define CYCLE 10

module testbench;
parameter NUM = 10;  // This is the number of entries in the input file: number of FP additions
reg	clk,rst;
wire an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0;
wire an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1;
wire [7:0]leds;

	initial
		begin
			clk=0;
			rst=0;

			#(`CYCLE);
			rst = 1;
			 $display("SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nEND SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst);
			#(`CYCLE);
			rst = 0;

			// an 1
			#(32*`CYCLE) $display("SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nEND SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst);

			// an 1
			#(5*`CYCLE) $display("SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nEND SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst);

			// an 0
			#(28*`CYCLE) $display("SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nEND SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst);

			// an 1
			#(32*`CYCLE) $display("SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nEND SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst);

			$finish;
		end

	always
		begin
			#(`CYCLE/2) clk=~clk;
		end

		// Instantiate the FP Adder 
		fpadd_system fpadd_system (
					   clk,
                       rst, 
                       leds, 
                       an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0,
                       an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1);
		
endmodule
