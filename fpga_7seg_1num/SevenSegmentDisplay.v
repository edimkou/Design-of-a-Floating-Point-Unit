`timescale 1ns / 1ps

module SevenSegDisplay(input clk, input rst, input [7:0]DataIn, output reg [7:0]a_to_g);
   reg [3:0]data;
   integer counter;

   always @(posedge clk)
      begin
         if (rst)
            counter = 0;
         else
            begin
               counter = counter +1;
               if (counter == 32)
                  begin
                     data = DataIn[7:4];
                     a_to_g[7] = 1; // first digit
                  end
               else if (counter == 64)
                  begin
                     data = DataIn [3:0];
                     a_to_g[7] = 0; // second digit
                     counter = 0; // reset counter
                  end
            end
      end

   always @(*)
     begin
         case(data)
         4'b0000: a_to_g[6:0] = 7'b1111110;
         4'b0001: a_to_g[6:0] = 7'b0110000;
         4'b0010: a_to_g[6:0] = 7'b1101101;
         4'b0011: a_to_g[6:0] = 7'b1111001;
         4'b0100: a_to_g[6:0] = 7'b0110011;
         4'b0101: a_to_g[6:0] = 7'b1011011;
         4'b0110: a_to_g[6:0] = 7'b1011111;
         4'b0111: a_to_g[6:0] = 7'b1110000;
         4'b1000: a_to_g[6:0] = 7'b1111111;
         4'b1001: a_to_g[6:0] = 7'b1111011;
         4'b1010: a_to_g[6:0] = 7'b1110111;
         4'b1011: a_to_g[6:0] = 7'b0011111;
         4'b1100: a_to_g[6:0] = 7'b1001110;
         4'b1101: a_to_g[6:0] = 7'b0111101;
         4'b1110: a_to_g[6:0] = 7'b1001111;
         4'b1111: a_to_g[6:0] = 7'b1000111;
         default: a_to_g[6:0] = 7'b0000001; // -
      endcase
     end

endmodule
