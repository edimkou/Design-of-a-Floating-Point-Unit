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
`define CYCLE 20

module testbench;
parameter NUM = 10;  // This is the number of entries in the input file: number of FP additions 
reg	clk,rst;
reg	[31:0] A;
reg	[31:0] B;   
wire [31:0] out;



integer i, errors;
real fA, fB, fout;
reg [3*32-1:0] fp_InOut[0:NUM-1];  
reg [3*32-1:0] FPVal;
reg [31:0] correctOut;

	initial
		begin
			clk=0;
			rst=0;
			#(`CYCLE) rst = 1;
			#(`CYCLE) rst = 0;
			errors = 0;
			for(i=0;i<NUM;i=i+1)
				begin	
				    FPVal = fp_InOut[i];       // read each entry of the test file
				    A = FPVal[3*32-1:2*32]; 
				    B = FPVal[2*32-1:32]; 
				    correctOut = FPVal[32-1:0]; 
				    
				    #(`CYCLE<<1) $display ("A=%h,B=%h,out=%h, out =%h, correctOut=%h\n",A, B, out,out, correctOut);
				    
				    if (out != correctOut) begin
				        $display ("Error at input %d. Out was %h instead of %h\n", i, out, correctOut);
                        errors = errors + 1;
				    end
				end
			$display ("Num of Errors = %4d\n", errors);
			$finish;
		end
	
	// Open the test file and read the two input operands A and B as well as the correct (expected) output 	
	initial begin
		   $readmemh("fp_InOut.hex", fp_InOut);  // You may have to change the path to the test file
    end
        
	always
		begin
			#(`CYCLE/2) clk=~clk;
		end
		
		// Instantiate the FP Adder 
		fpadd_single DUT(.clk(clk), .reset(rst), .reg_A(A),.reg_B(B), .out(out));
		
endmodule
