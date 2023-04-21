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
// Description: 32-bit FP adder with 2 pipeline stages 
//  The module does not check the input for subnormal and NaN numbers, 
//  and assumes that the two inputs are normal FP32 numbers with 0<exp<255.
//  We also assume that the output does not overflow or undeflow, so there is no need to check for these conditions.
//  An FP32 number has 1 sign bit, 8 exponent bits(biased by 127), and 23 mantissa bits.
//////////////////////////////////////////////////////////////////////////////////
module Fpadd_pipe (input clk,
                   input reset,
                   input [31:0]reg_A,
                   input [31:0]reg_B,
                   output reg[31:0] out);
			 
	reg [31:0]A,B;
	wire [31:0]result_pp;
	wire [7:0]new_exponent;
	reg [7:0]new_exponent_pp;
	wire [24:0]add_mantissas;
	reg [24:0]add_mantissas_pp;
	wire [23:0]sub_mantissas;
	reg [23:0]sub_mantissas_pp;
	wire add_flag, sub_flag, sign_result;
	reg add, sub, sign_out;

				     	
	always @ (posedge clk)
		begin
			A <= reg_A;
			B <= reg_B;	
		end

	First_steps First_steps(A, B, sub_mantissas, add_mantissas, new_exponent, sign_result, sub_flag, add_flag);
			
	always @(posedge clk or posedge reset)
		begin
			if (reset == 1'b1)
				begin
					sub_mantissas_pp <= 24'b0;
					add_mantissas_pp <= 25'b0;
					new_exponent_pp <= 8'b0;
					sign_out <= 0;
					add <= 1'b0;
					sub <= 1'b0;
				end
			else
				begin
					sub_mantissas_pp <= sub_mantissas;
					add_mantissas_pp <= add_mantissas;
					new_exponent_pp <= new_exponent;
					sign_out <= sign_result;
					sub <= sub_flag;
					add <= add_flag;
				end	
		end

	normalization normalization(sub_mantissas_pp, add_mantissas_pp, new_exponent_pp, sub, add, sign_out, result_pp);

	always @(*)
		begin
			if (reset == 1'b1)
				begin
					out <= 0;
				end
			else if(clk == 1'b1)
				begin
					out <= result_pp;
				end
		end
endmodule


	 //                       (a) compare and adjust the exponents,
	 //                       (b) shift appropriately the mantissa if necessary,
	 //                       (c) add the two mantissas
module First_steps(input [31:0]A, input [31:0]B, output reg [23:0]sub_mantissas, output reg [24:0]add_mantissas, output reg [7:0]new_exponent, output reg sign_result, output reg sub_flag, output reg add_flag);

	reg [7:0]exp_diff;
	reg [7:0] exp_a, exp_b;
	reg [23:0]shifted_a, shifted_b;
	reg [23:0]significand_a, significand_b;	
			
	always @(*)
		begin
			significand_a = {1'b1, A[22:0]};  
			significand_b = {1'b1, B[22:0]};
			exp_a = A[30:23];
			exp_b = B[30:23];

			// Compare and adjust the exponents by shifting right the significand_num with the smaller exponent 
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

			// control which operation will be executed, 
			// if A and B have diff sign the program will execute a substraction else addition
			sub_flag = (A[31]^B[31]);
			add_flag = (!sub_flag);

			if(add_flag)
				begin
					sign_result = A[31];
					add_mantissas = (shifted_a + shifted_b);
				end
			else if (sub_flag) 
				begin
					if (shifted_a > shifted_b)
						begin
							sub_mantissas =  shifted_a - shifted_b;
							sign_result = A[31];
						end
					else if (shifted_a < shifted_b)
						begin
							sub_mantissas = shifted_b - shifted_a;
							sign_result = B[31];
						end
					else if(shifted_a == shifted_b)
					 	begin
							sub_mantissas = 25'b0;
							sign_result = 1'b0;
						end				
				end
		end
endmodule


module normalization(input [23:0]sub_mantissas_pp, input [24:0]add_mantissas_pp, input [7:0]new_exponent_pp, input sub, input add, input sign_out, output reg [31:0] result_pp);
	reg [4:0] i, counter;

	always @(*)
		begin
			result_pp[31] = sign_out;

			if (sub)
				begin
					if (sub_mantissas_pp != 0)
						begin
							counter = 0;
							for (i = 23; ((sub_mantissas_pp[i] == 0) && (i > 0)); i = i-1) 
								begin
									counter = counter + 1;
								end

							result_pp[30:23] = (new_exponent_pp - counter);
							result_pp[22:0] = (sub_mantissas_pp[22:0] << counter); 
						end
					else
						result_pp = 31'b0;
				end
			if (add)
				begin
					if(add_mantissas_pp[23:0] == 0)
						begin
							result_pp = 31'b0;
						end
					else if (add_mantissas_pp[24] == 1'b1)  // if A + B overflows
						begin
							result_pp[22:0] = add_mantissas_pp[23:1]; // 24th is the hidden bit
							result_pp[30:23] = new_exponent_pp + 1'b1; 
						end
					else
						begin
							result_pp[22:0] = add_mantissas_pp[22:0];
							result_pp[30:23] = new_exponent_pp;
						end	
				end
		end	 
endmodule
