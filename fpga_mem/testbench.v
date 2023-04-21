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
reg	clk,rst, en;
wire an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0;
wire an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1;
wire [7:0]leds;
wire [31:0] out;

	initial
		begin
			clk=0;
			rst=0;
			en = 0;

			#(`CYCLE);
			rst = 1;
			$display("1SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nout =%h\nen = %b  END SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst, out, en);
			#(`CYCLE);
			rst = 0;
			en=1;

			#(130*`CYCLE)$display("2SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nout =%h\nen = %b  END SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst, out, en); // i = 0

			en = 0;
			#(10*`CYCLE) $display("3SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nout =%h\nen = %b  END SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst, out, en); // i = 0

			en = 1;
			#(10*`CYCLE) $display("4SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nout =%h\nen = %b  END SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst, out, en); // i = 1

			en = 0;
			#(100*`CYCLE) $display("5SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nout =%h\nen = %b  END SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst, out, en); // i = 1

			en = 1;
			#(10*`CYCLE) $display("6SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nout =%h\nen = %b  END SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst, out, en); // i = 2

			en = 1;
			#(10*`CYCLE) $display("7SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nout =%h\nen = %b  END SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst, out, en); // i = 2

			en = 0;
			#(90*`CYCLE) $display("8SYSTEM\n an0= %b,  a0= %b,  b0= %b,  c0= %b,  d0= %b,  e0= %b,  f0= %b,  g0= %b,\n an1= %b,  a1= %b,  b1= %b,  c1= %b,  d1= %b,  e1= %b,  f1= %b,  g1= %b\nclk = %b, rst= %b\nout =%h\nen = %b  END SYSTEM\n", an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0, an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, clk, rst, out, en); // i = 2

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
                       en,
                       leds, 
                       an0,  a0,  b0,  c0,  d0,  e0,  f0,  g0,
                       an1,  a1,  b1,  c1,  d1,  e1,  f1,  g1, out);
		
endmodule
