`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Dimkou Eleni
// Company: UTH
// Design Name: FPAdder
// Module Name:   Debounder_L2P 
// Project Name: 32 bit Floating Point Unit - Add
// Target Devices: Zedboard
// Tool versions: Vivado 2020.2
//
// Description: 
// This module purse multi-cycle pulse signal (pressed button) to a single-cycle pulse signal.
// If the input signal changes sooner than 0,1secs I assume that it was mechanical noise, debouncing mechanism.
//////////////////////////////////////////////////////////////////////////////////

module Debouncer_L2P(input clk, input rst, input button, output output_signal);
 reg [23:0] cycle_counter;
 reg slow_clock;

    assign output_signal = slow_clock ? button : 0;

    always @(posedge clk)
        begin
            if(rst)
                begin
                    cycle_counter = 0;
                    slow_clock = 0;
                end
            else
                begin
                    cycle_counter = cycle_counter + 1;

                    if (cycle_counter >= 10000000)  // T = 0.1sec = 100.000.000nsec / which is a multiple of the 10 ns clock period of the FPGA
                        begin
                            slow_clock = 1;
                            if(button)
                                begin
                                    cycle_counter = 0;
                                end
                            else
                                begin
                                    cycle_counter = 10000000;
                                end 
                        end
                    else if ((cycle_counter < 10000000) && slow_clock && button) // continuously pressed button
                        begin
                            cycle_counter = 0;
                        end
                    else 
                        begin
                            slow_clock = 0;
                        end
                end
        end

endmodule
