`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UTH
// 
// Design Name: 
// Module Name:   fpadd_single 
// Project Name: 32 bit Floating Point Unit - Add
// Target Devices: Zedboard
// Tool versions: Vivado 2020.2
//
// Description: 32-bit FP adder with a single pipeline stage (everything happens in one cycle)
//  The module does not check the input for subnormal and NaN numbers, 
//  and assumes that the two inputs are normal FP32 numbers with 0<exp<255.
//  We also assume that the output does not overflow or undeflow, so there is no need to check for these conditions.
//  An FP32 number has 1 sign bit, 8 exponent bits(biased by 127), and 23 mantissa bits.
//////////////////////////////////////////////////////////////////////////////////
module fpadd_single (input clk,
                     input reset,
                     input [31:0]reg_A, 
                     input [31:0]reg_B,  
					 output reg[31:0] out);
			 
	reg [31:0]A,B,result;
	reg [7:0]exp_diff;
	reg [7:0] exp_a, exp_b;
	reg [23:0]shifted_a, shifted_b;
	reg [7:0] new_exponent;
	reg [24:0]add_mantissas;
	reg [23:0]sub_mantissas;
	reg [23:0]significand_a, significand_b;
	reg [4:0] i, counter;

	// Register the two inputs, and use A and B in the combinational logic.
	always @ (posedge clk or posedge reset)
		begin
			if (reset == 1'b1)
				out <= 32'b0;
			else
				begin
					A <= reg_A;
					B <= reg_B;
					out <= result;
				end
		end

	//Combinational Logic to (a) compare and adjust the exponents,
	//                       (b) shift appropriately the mantissa if necessary,
	//                       (c) add the two mantissas, and
	//                       (d) perform post-normalization.
	//                           Make sure to check explicitly for zero output.
	always@ (*)
		begin
			significand_a = {1'b1, A[22:0]};
			significand_b ={1'b1, B[22:0]};
			exp_a = A[30:23];
			exp_b = B[30:23];

			if (exp_a > exp_b)
				begin
				exp_diff = exp_a - exp_b;
				shifted_b = (significand_b >> exp_diff);
		 		shifted_a = significand_a;
		 		new_exponent = exp_a;
				end
			else
				begin
				exp_diff = exp_b - exp_a;
				shifted_a = (significand_a >> exp_diff); // right shift
				shifted_b = significand_b;
		 		new_exponent = exp_b;
				end

			// If A & B have the same sign the program will execute a addition
			if(A[31] == B[31])
				begin
					// adding the mantissas
					add_mantissas = (shifted_a + shifted_b);

					if(add_mantissas[23:0] == 0)
						begin
							result = 32'b0;
						end
					else if (add_mantissas[24] == 1'b1)  // if A + B overflows
						begin
							result[22:0] = add_mantissas[23:1]; // 24th is hidden bit
							result[30:23] = new_exponent + 1'b1;
							result[31] = A[31];
						end
					else
						begin
							result[22:0] = add_mantissas[22:0];
							result[30:23] = new_exponent;
							result[31] = A[31];
						end
				end

			// If A & B have diff sign the program will execute a substraction
			else if (A[31] != B[31])
				begin
					// sub the mantissas
					if (shifted_a > shifted_b)
						begin
							sub_mantissas =  shifted_a - shifted_b;
							result[31] = A[31];
						end
					else if (shifted_a < shifted_b)
						begin
							sub_mantissas = shifted_b - shifted_a;
							result[31] = B[31];
						end
					else if(shifted_a == shifted_b)
					 	begin
							sub_mantissas = 25'b0;
							result = 32'b0;
						end

					if (sub_mantissas != 0)
						begin
							counter = 0;
							for (i = 23; ((sub_mantissas[i] == 0) && i > 0); i = i-1)
								begin
									counter = counter + 1;
								end
								result[30:23] = (new_exponent - counter);
								result[22:0] = (sub_mantissas[22:0] << counter);
						end
				end
		end
endmodule
